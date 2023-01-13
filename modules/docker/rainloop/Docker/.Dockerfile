ARG  DOCKER_REGISTRY_CACHE
ARG IMATGE_BASE
FROM $DOCKER_REGISTRY_CACHE/$IMATGE_BASE
EXPOSE 80
RUN apt update;
RUN apt upgrade -y;
RUN apt install nano unzip curl php php-curl php-dom php-xml -y;
COPY Docker/rainloop-install.sh /rainloop-install.sh
COPY Docker/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
RUN chmod +x /rainloop-install.sh
WORKDIR /usr/local/apache2/htdocs/
CMD [ "/docker-entrypoint.sh" ]
ENTRYPOINT [ "/bin/bash" ]