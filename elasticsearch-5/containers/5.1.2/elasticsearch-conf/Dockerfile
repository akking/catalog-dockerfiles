#FROM rawmind/alpine-monit:0.5.20-2
#MAINTAINER Raul Sanchez <rawmind@gmail.com>
## monit configuration scripts
#
## Set environment
#ENV SERVICE_NAME=traefik \
#    SERVICE_HOME=/opt/traefik \
#    SERVICE_VERSION=v1.1.2 \
#    SERVICE_USER=traefik \
#    SERVICE_UID=10001 \
#    SERVICE_GROUP=traefik \
#    SERVICE_GID=10001 \
#    SERVICE_URL=https://github.com/containous/traefik/releases/download
#ENV SERVICE_RELEASE=${SERVICE_URL}/${SERVICE_VERSION}/traefik_linux-amd64 \
#    PATH=${PATH}:${SERVICE_HOME}/bin 
#
## Download and install traefik
#RUN mkdir -p ${SERVICE_HOME}/bin ${SERVICE_HOME}/etc ${SERVICE_HOME}/log ${SERVICE_HOME}/certs ${SERVICE_HOME}/acme && \
#    apk add --no-cache libcap  && \
#    cd ${SERVICE_HOME}/bin && \
#    curl -jksSL "${SERVICE_RELEASE}" -O && \
#    mv traefik_linux-amd64 traefik && \
#    touch ${SERVICE_HOME}/etc/rules.toml && \
#    chmod +x ${SERVICE_HOME}/bin/traefik && \
#    addgroup -g ${SERVICE_GID} ${SERVICE_GROUP} && \
#    adduser -g "${SERVICE_NAME} user" -D -h ${SERVICE_HOME} -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER} 
#ADD root /
#RUN chmod +x ${SERVICE_HOME}/bin/*.sh && \
#    chown -R ${SERVICE_USER}:${SERVICE_GROUP} ${SERVICE_HOME} /opt/monit && \
#    setcap 'cap_net_bind_service=+ep' ${SERVICE_HOME}/bin/traefik
#
#USER $SERVICE_USER
#WORKDIR $SERVICE_HOME


FROM busybox

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /confd
RUN chmod +x /confd

ADD ./conf.d /etc/confd/conf.d
ADD ./templates /etc/confd/templates
ADD ./run.sh /run.sh
ADD ./dockerentry.sh /dockerentry.sh
RUN chown 105:108 /dockerentry.sh
RUN chown 105:108 /run.sh
VOLUME /data/confd
VOLUME /opt/rancher/bin
VOLUME /usr/share/elasticsearch/config
ENTRYPOINT ["/dockerentry.sh"]
CMD ["--backend", "rancher", "--prefix", "/2015-07-25"]
