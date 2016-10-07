#!/bin/bash
DIG=/opt/rancher/bin/dig

function cluster_init {
	sleep 10
	MYIP=$(ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1 |  sed -n 2p)
	SERVERIPS=$($DIG A $MONGO_SERVICE_NAME +short)
	SERVERIPS=($(echo $SERVERIPS))
	mongo --eval "printjson(rs.initiate())" --quiet    #Initiate the replica set
	# Determine which instances are already members of the replica set
	SETMEMBERS=($(mongo --eval 'rs.status().members.forEach( function(f) {print( f.name )})' --quiet))
	# SETMEMBERS is a string - make it an array
	SETHOSTS=($(echo ${SETMEMBERS[@]%:*}))
	# List of IPs missing from the replica set
	MISSINGSERVERS=()
	for i in ${SERVERIPS[@]}; do
		skip=
		for j in ${SETHOSTS[@]%:*}; do 
			CHECKIP=$(echo $($DIG A $j +short))
			echo "checking $CHECKIP"
		sleep 3
		[[ $i == $CHECKIP ]] && { skip=1; break; }
		done
	[[ -n $skip ]] || MISSINGSERVERS+=("$i")
	done
	
	for member in ${MISSINGSERVERS[@]}; do
		if [ $member != $MYIP ]
		then 
			MONGOHOSTNAME=$(mongo $member:27017 --eval "db.hostInfo().system.hostname" --quiet):27017
			echo "adding $MONGOHOSTNAME"
			mongo --eval "printjson(rs.add('$MONGOHOSTNAME'))" --quiet
		fi
	done
}

function find_master {
	$DIG A $MONGO_SERVICE_NAME +short > ips.tmp
	for IP in $(cat ips.tmp); do
		IS_MASTER=`mongo --host $IP --eval "printjson(db.isMaster())" | grep 'ismaster'`
		if echo $IS_MASTER | grep "true"; then
			return 0
		fi
	done
	return 1
}
# Script starts here
# wait for mongo to start
while [ `$DIG A $MONGO_SERVICE_NAME +short | wc -l` -lt 3 ]; do
	echo 'mongo instances are less than 3.. waiting!'
	sleep 5
done

# Wait until all services are up
sleep 10
find_master
if [ $? -eq 0 ]; then
	echo 'Master is already initated.. nothing to do!'
else
	echo 'Initiating the cluster!'
	cluster_init
fi
