FROM alpine:3.4
MAINTAINER Jeff Kolb
#TO DO - UNINSTALL nodejs
ADD ./*.sh /opt/rancher/bin/
RUN chmod u+x /opt/rancher/bin/*.sh

ENV KM_VERSION=1.3.1.8

RUN apk update && apk upgrade \
    && apk add -U openjdk8 wget nodejs bash curl \
	&& mkdir -p /tmp \
	&& cd /tmp \
	&& curl -L https://github.com/sequenceiq/docker-alpine-dig/releases/download/v9.10.2/dig.tgz|tar -xzv -C /usr/local/bin/ \
	&& wget -O $KM_VERSION.zip https://github.com/Innometrics/kafka-manager/archive/master.zip \
	&& unzip $KM_VERSION.zip \
	&& cd $PWD/$(ls -tr | grep kafka-manager | head -1) \
	&& echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt \
	&& ./sbt clean dist \
	&& unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip \
	&& mv /kafka-manager-${KM_VERSION} /etc/kafka-manager \
	&& cd / \
	&& rm -rf /tmp \
	&& rm -rf /var/cache/apk/*
	
	# && wget https://github.com/yahoo/kafka-manager/archive/$KM_VERSION.zip \	
	#&& cd /tmp/kafka-manager-$KM_VERSION \	
9000 9000

ZK_HOSTS 10.42.213.200:2818,10.42.201.25:2181,10.42.130.124:2181
