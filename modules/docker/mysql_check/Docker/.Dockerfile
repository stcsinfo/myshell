ARG DOCKER_REGISTRY_CACHE
ARG IMATGE_APLICACIO
FROM alpine:3.11
RUN apk update && apk add mariadb-client dos2unix -f
COPY Docker/basa-docker-entrypoint.sh /
RUN dos2unix /basa-docker-entrypoint.sh
ENTRYPOINT ["/basa-docker-entrypoint.sh"]