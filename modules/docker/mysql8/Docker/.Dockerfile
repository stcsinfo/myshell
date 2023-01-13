ARG  DOCKER_REGISTRY_CACHE
ARG IMATGE_BASEDEDADES
FROM $DOCKER_REGISTRY_CACHE/$IMATGE_BASEDEDADES
#Port
EXPOSE 3306
#System
RUN apt-get update
RUN apt-get install dos2unix -y
RUN cp -r -f /usr/share/zoneinfo/Europe/Madrid /etc/localtime && ls -la /etc/localtime
#BASA_DOCKER
COPY Docker/basa-docker-entrypoint.sh /basa-docker-entrypoint.sh
RUN dos2unix /basa-docker-entrypoint.sh
COPY entorns /tmp/entorns
RUN dos2unix /basa-docker-entrypoint.sh && dos2unix /tmp/entorns/**/*.* && chmod +x /basa-docker-entrypoint.sh
CMD [ "/basa-docker-entrypoint.sh" ]