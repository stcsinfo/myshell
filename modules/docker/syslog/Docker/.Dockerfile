ARG DOCKER_REGISTRY_CACHE
ARG IMATGE_APLICACIO
FROM $DOCKER_REGISTRY_CACHE/$IMATGE_APLICACIO
#RUN apk update && apk add git dos2unix curl nano -f
#RUN apt update; apt upgrade -y
#RUN apt install crontab dos2unix curl nano -y
COPY Docker/basa-docker-entrypoint.sh /
#COPY Docker/root /etc/crontabs/root
#RUN dos2unix /basa-docker-entrypoint.sh
#RUN dos2unix /etc/crontabs/root
ENTRYPOINT ["/basa-docker-entrypoint.sh"]