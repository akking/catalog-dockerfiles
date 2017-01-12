FROM websphere-liberty

MAINTAINER Jamie Coleman <jlcoleman@uk.ibm.com>


COPY 9.0.1.0-IBM-MQ-Java-InstallRA.jar / 
COPY sender.war /opt/ibm/wlp/usr/servers/defaultServer/dropins/
	
RUN installUtility install --acceptLicense defaultServer
RUN installUtility install --acceptLicense adminCenter-1.0
RUN installUtility install --acceptLicense wmqjmsclient-2.0 
RUN java -jar 9.0.1.0-IBM-MQ-Java-InstallRA.jar --acceptLicense /


EXPOSE 9080 9443
