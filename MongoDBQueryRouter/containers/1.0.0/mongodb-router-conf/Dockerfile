FROM alpine:3.4
MAINTAINER Jeff Kolb

ADD ./*.sh /opt/rancher/bin/
RUN chmod u+x /opt/rancher/bin/*.sh

# install dig and jq
RUN apk add -U alpine-sdk bind-tools \
    && curl -L https://github.com/cloudnautique/giddyup/releases/download/v0.8.0/giddyup -o /opt/rancher/bin/giddyup \
    && chmod u+x /opt/rancher/bin/* \
    && apk del alpine-sdk \
    && rm -rf /var/cache/apk/* \
    && rm -rf /bind-9.10.2/

VOLUME /opt/rancher/bin
