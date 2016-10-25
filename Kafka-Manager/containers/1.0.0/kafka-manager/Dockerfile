FROM alpine:3.4
MAINTAINER Jeff Kolb
#TO DO - UNINSTALL nodejs? Clean up stuff?
ADD ./*.sh /opt/rancher/bin/
RUN chmod u+x /opt/rancher/bin/*.sh

ENV KM_VERSION=1.3.1.8

RUN apk update && apk upgrade \
	&& apk add -U openjdk8 wget nodejs bash curl \
	&& mkdir -p /tmp \
	&& cd /tmp \
	&& curl -L https://github.com/sequenceiq/docker-alpine-dig/releases/download/v9.10.2/dig.tgz|tar -xzv -C /usr/local/bin/ \
	&& curl -o $KM_VERSION.zip -L https://github.com/Innometrics/kafka-manager/archive/master.zip \
	&& unzip $KM_VERSION.zip \
	&& cd $PWD/$(ls -tr | grep kafka-manager | head -1) \
	&& echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt \
	&& ./sbt clean dist \
	&& unzip  -d /etc ./target/universal/kafka-manager-${KM_VERSION}.zip \
	&& mv /etc/kafka-manager-${KM_VERSION} /etc/kafka-manager \
	&& cd / \
	&& rm -rf /tmp \
	&& rm -rf /root/.ivy2/cache/ \
	&& rm -rf /var/cache/apk/*
	
	# && wget https://github.com/yahoo/kafka-manager/archive/$KM_VERSION.zip \	
	#&& cd /tmp/kafka-manager-$KM_VERSION \	

	#&& wget -O $KM_VERSION.zip https://github.com/Innometrics/kafka-manager/archive/master.zip \
	9000 9000
apk add ca-certificates
update-ca-certificates
ZK_HOSTS 10.42.213.200:2818,10.42.201.25:2181,10.42.130.124:2181
    apk add -U nodejs bash curl
"-Xms256m -Xmx4g"

224f58a76ab4 
224f58a76ab4 
224f58a76ab4 
364a149969af 
364a149969af 
364a149969af 
126bcb7acd42 
126bcb7acd42 
68d6ea8fe83f 
126bcb7acd42 
68d6ea8fe83f 
68d6ea8fe83f 
953158db3d0b 
953158db3d0b 
953158db3d0b 
7d58f531dea7 
7d58f531dea7 
7d58f531dea7 
c22e22148a3c 
c22e22148a3c 
c22e22148a3c 
3c9eae2aa014 
3c9eae2aa014 
3c9eae2aa014 
498c83fc5816 
498c83fc5816 
498c83fc5816 
b8f764b533d1 
b8f764b533d1 
b8f764b533d1 
bc0fafb50f8f 
bc0fafb50f8f 
bc0fafb50f8f 

rancher/os-base            v0.7.0-rc7          