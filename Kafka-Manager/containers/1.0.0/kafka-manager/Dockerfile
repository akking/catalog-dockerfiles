FROM alpine:3.4
MAINTAINER Jeff Kolb

ADD ./*.sh /opt/rancher/bin/
RUN chmod u+x /opt/rancher/bin/*.sh
KM_VERS=1.3.1.8
# install dig and jq
RUN apk add -U alpine-sdk bind-tools\
    #&& curl ftp://ftp.isc.org/isc/bind9/9.11.0/bind-9.11.0.tar.gz|tar -xzv \
    #&& cd bind-9.11.0 \
    #&& CFLAGS="-static" ./configure --without-openssl --disable-symtable \
    #&& make \
    && cp ./usr/bin/dig /opt/rancher/bin/ \
    && curl -L https://github.com/cloudnautique/giddyup/releases/download/v0.8.0/giddyup -o /opt/rancher/bin/giddyup \
    && chmod u+x /opt/rancher/bin/* \
    #&& rm -rf /bind-9.10.2/ \
	&& wget https://github.com/yahoo/kafka-manager/archive/$KM_VERS.zip \
	&& unzip $KM_VERS.zip \
	&& apk add -U bash \
	&& echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> /kafka-manager-$KM_VERS/build.sbt \
	&& apk add --no-cache openjdk8-jre \
	&& cd /kafka-manager-$KM_VERS \
	&& ./sbt clean dist \
	&& apk del alpine-sdk bind-tools \
    && rm -rf /var/cache/apk/*

	
	

VOLUME /opt/rancher/bin


FROM centos:7

MAINTAINER Clement Laforet <sheepkiller@cultdeadsheep.org>

RUN yum update -y && \
    yum install -y git wget unzip which && \
    yum clean all

ENV JAVA_MAJOR=8 \
    JAVA_UPDATE=101 \
    JAVA_BUILD=13

RUN wget -nv --no-cookies --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR}u${JAVA_UPDATE}-b${JAVA_BUILD}/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm" -O /tmp/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm && \
     yum localinstall -y /tmp/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm && \
     rm -f /tmp/jdk-${JAVA_MAJOR}u${JAVA_UPDATE}-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk1.8.0_${JAVA_UPDATE} \
    ZK_HOSTS=localhost:2181 \
    KM_VERSION=1.3.1.6 \
    KM_REVISION=6cf43e383377a6b37df4faa04d9aff515a265b30 \
    KM_CONFIGFILE="conf/application.conf"

ADD start-kafka-manager.sh /kafka-manager-${KM_VERSION}/start-kafka-manager.sh

RUN mkdir -p /tmp && \
    cd /tmp && \
    git clone https://github.com/yahoo/kafka-manager && \
    cd /tmp/kafka-manager && \
    git checkout ${KM_REVISION} && \
    echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
    ./sbt clean dist && \
    unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
    rm -fr /tmp/* /root/.sbt /root/.ivy2 && \
    chmod +x /kafka-manager-${KM_VERSION}/start-kafka-manager.sh

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000
ENTRYPOINT ["./start-kafka-manager.sh"]
