#!/bin/ash
getHosts () {
#List of ZK instance IPs to use as hosts
LINK_METADATA="http://rancher-metadata/latest/self/service/links/"
MASTER_STERVICE=$(curl -s $LINK_METADATA)
ZK_LINK=$(curl -s $LINK_METADATA$MASTER_STERVICE)
ZKHOSTLIST=""
for i in $(dig A $ZK_LINK +short); do
ZKHOSTLIST="$ZKHOSTLIST,$i"
done
export ZK_HOSTS=${ZKHOSTLIST:1}
}
export KM_HOME="/etc/kafka-manager/bin"
getHosts
echo "Launching Kafka Manager with these ZK hosts $ZK_HOSTS out of $KM_HOME"
