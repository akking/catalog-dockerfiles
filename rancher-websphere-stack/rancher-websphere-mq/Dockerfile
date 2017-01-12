FROM ibmcom/mq

# Add user account to use with IBM MQ Explorer
# Username/Password mqexplorer/lemme$ee

ENV LICENSE=accept
ENV MQ_QMGR_NAME=QM1

RUN useradd mqexplorer -G mqm \
        && echo mqexplorer:lemme$ee | chpasswd
EXPOSE 1414
