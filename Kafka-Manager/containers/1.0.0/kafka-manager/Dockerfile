FROM anapsix/alpine-java:jdk8
MAINTAINER Jeff Kolb

ADD ./*.sh /opt/rancher/bin/
RUN chmod u+x /opt/rancher/bin/*.sh

ENV KM_VERSION=1.3.1.8

RUN apk add --no-cache wget \
	&& mkdir -p /tmp \
	&& cd /tmp \
	&& wget https://github.com/yahoo/kafka-manager/archive/$KM_VERSION.zip \
	&& unzip $KM_VERSION.zip \
	&& cd /tmp/kafka-manager-$KM_VERSION \
	&& echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt \
	&& ./sbt clean dist \
	&& unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip \
	&& cp /kafka-manager-${KM_VERSION}/bin/kafka-manager /bin \
	&& cd / \
	&& rm -ef /tmp

