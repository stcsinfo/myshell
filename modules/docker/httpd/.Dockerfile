#FROM rancher-sic-local.$domain_stg_ba:8090/bcnact/tomcat/8-jdk8
FROM httpd:latest
EXPOSE 80
#EXPOSE 443
###########             SISTEMA
RUN apt update
RUN apt install nano dos2unix -y
###########             COPIES
COPY entrypoint.sh /
#COPY /prestashop/* /tmp/
#COPY web-dump/* /tmp/
###########             SSL
#COPY /ssl/ /tmp/ssl
#COPY /servername/ /tmp/servername
#RUN sh /tmp/servername/servername.sh
#RUN sh /tmp/ssl/ssl.sh
###########             RUNS
RUN rm -rf /var/www/html/*
COPY /images/ /usr/local/apache2/htdocs
#RUN curl --insecure -o vtigercrm.tar.gz -SL https://sourceforge.net/projects/vtigercrm/files/vtiger%20CRM%207.0.1/Core%20Product/vtigercrm7.0.1.tar.gz \
#    && tar -xzf vtigercrm.tar.gz \
#    && rm vtigercrm.tar.gz \
#    && chmod -R 775 vtigercrm \
#    && chown -R www-data:www-data vtigercrm
#RUN echo "Donant permisos www-data a directoris"
#RUN chown -R www-data:www-data /etc/apache2/
#RUN chown -R www-data:www-data /var/www/html/
#RUN chmod -R 755 /var/www/html/
ENTRYPOINT ["/entrypoint.sh"]