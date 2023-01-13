ARG  DOCKER_REGISTRY_CACHE
ARG IMATGE_BASEDEDADES
FROM $DOCKER_REGISTRY_CACHE/$IMATGE_BASEDEDADES
#Port
EXPOSE 26257
#System
RUN cp -r -f /usr/share/zoneinfo/Europe/Madrid /etc/localtime && ls -la /etc/localtime
#BASA_DOCKER
COPY Docker/basa-docker-entrypoint.sh /basa-docker-entrypoint.sh
#RUN dos2unix /basa-docker-entrypoint.sh
RUN chmod +x /basa-docker-entrypoint.sh
ENTRYPOINT [ "/basa-docker-entrypoint.sh" ]
#ENTRYPOINT [ "/cockroach/cockroach.sh" ]
#CMD [ "start-single-node" ]