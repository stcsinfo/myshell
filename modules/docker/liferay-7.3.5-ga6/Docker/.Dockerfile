ARG DOCKER_REGISTRY_CACHE
ARG IMATGE_APLICACIO
FROM $DOCKER_REGISTRY_CACHE/$IMATGE_APLICACIO
EXPOSE 8080
#-------------------------------------------------
#-- Arguments del sistema després del FROM --
#-------------------------------------------------
#ARG DIR_SIC
#ARG DIR_CREA_IMATGE
#----------------Per treballar en local-----------
COPY Docker/basa-docker-entrypoint.sh /basa-docker-entrypoint.sh
#----------------Configuracions imatge------------
COPY Docker/PreparaImatge.sh /
COPY Docker/setenv.sh /opt/liferay/tomcat/bin/setenv.sh
COPY Docker/catalina.sh /opt/liferay/tomcat/bin/catalina.sh
COPY Docker/portal-log4j-ext.xml /opt/liferay/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/portal-log4j-ext.xml
COPY Docker/portal-ext.properties /opt/liferay
USER root
RUN . /PreparaImatge.sh
RUN chown liferay:liferay /opt/liferay/tomcat/bin/setenv.sh && dos2unix /opt/liferay/tomcat/bin/setenv.sh
RUN chown liferay:liferay /opt/liferay/tomcat/bin/catalina.sh && dos2unix /opt/liferay/tomcat/bin/catalina.sh
RUN chown liferay:liferay /opt/liferay/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/portal-log4j-ext.xml && dos2unix /opt/liferay/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/portal-log4j-ext.xml
RUN chown liferay:liferay /opt/liferay/portal-ext.properties && dos2unix /opt/liferay/portal-ext.properties
#-------------------------------------------------
COPY RELEASE.txt /etc
ENTRYPOINT [ "sh" ]
CMD [ "/basa-docker-entrypoint.sh" ]
