ARG DOCKER_REGISTRY_CACHE
ARG IMATGE_APLICACIO
FROM $DOCKER_REGISTRY_CACHE/$IMATGE_APLICACIO
EXPOSE 8080
COPY Docker/basa-docker-entrypoint.sh /basa-docker-entrypoint.sh
#-------------------------------------------------
COPY Docker/PreparaImatge.sh /
COPY Docker/setenv.sh /opt/liferay/tomcat/bin/setenv.sh
USER root
RUN . /PreparaImatge.sh
RUN chown liferay:liferay /opt/liferay/tomcat/bin/setenv.sh && dos2unix /opt/liferay/tomcat/bin/setenv.sh
#-------------------------------------------------
#COPY src/???? /???/???
COPY RELEASE.txt /etc
ENTRYPOINT [ "bash" ]
CMD [ "/basa-docker-entrypoint.sh" ]
