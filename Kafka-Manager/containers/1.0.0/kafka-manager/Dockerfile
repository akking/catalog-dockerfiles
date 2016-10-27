FROM alpine:3.4
MAINTAINER Jeff Kolb <jeff.kolb@intlfcstone.com>
#TO DO - UNINSTALL nodejs? Clean up stuff?
ADD ./*.sh /opt/rancher/bin/
RUN chmod u+x /opt/rancher/bin/*.sh

ENV JAR=/usr/lib/jvm/java-1.8-openjdk/bin/jar
ENV KM_VERSION=1.3.1.8
ENV ZK_HOSTS=""

RUN apk update && apk upgrade \
	&& apk add -U openjdk8 nodejs bash curl \
	&& mkdir -p /tmp \
	&& cd /tmp \
	&& curl -L https://github.com/sequenceiq/docker-alpine-dig/releases/download/v9.10.2/dig.tgz|tar -xzv -C /usr/local/bin/ \
	&& curl -sL https://github.com/Innometrics/kafka-manager/archive/master.zip|$JAR -xvf /dev/stdin \
	&& cd $PWD/$(ls -tr | grep kafka-manager | head -1) \
	&& chmod +x sbt \
	&& echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt \
	&& ./sbt clean dist \
	&& unzip -d /etc $PWD/$(ls -tr target/universal/*.zip | head -n1) \
	&& mv /etc/kafka-manager-${KM_VERSION} /etc/kafka-manager \
	&& cd / \
	&& rm -rf /tmp \
	&& rm -rf /root/.ivy2/cache \
	&& ln -s /etc/kafka-manager/bin/kafka-manager /bin/kafka-manager \
	&& KM_HOME="/etc/kafka-manager/bin" \
	&& source ./getzkhosts.sh

HOSTNAME_TO_ADVERTISE=http://rancher-metadata/latest/self/host/hostname
WORKDIR /opt/rancher/bin
EXPOSE 9000 
ENTRYPOINT ["./start-kafka-manager.sh"]
