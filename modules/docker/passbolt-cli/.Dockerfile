FROM debian:buster
RUN apt update && apt-get install git sudo dos2unix curl nano -y
COPY basa-docker-entrypoint.sh /
RUN dos2unix /basa-docker-entrypoint.sh
RUN git clone https://github.com/passbolt/passbolt_cli.git
COPY keys/passbolt_private.asc /passbolt_cli/app/config
COPY keys/passbolt_public.asc /passbolt_cli/app/config
ENTRYPOINT ["/basa-docker-entrypoint.sh"]