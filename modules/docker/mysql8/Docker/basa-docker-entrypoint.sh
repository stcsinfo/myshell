#!/bin/bash
#-----------------------------------------------------------------
#Còpia arxius configuració
cp  /tmp/entorns/$BCNACT_ENTORN/db.cnf /etc/mysql/conf.d/db.cnf -f
cp  /tmp/entorns/General/general.cnf /etc/mysql/conf.d/general.cnf -f
#Còpia certificats i permisos
mkdir -p /etc/mysql/ssl
cp /tmp/entorns/$BCNACT_ENTORN/ca.crt /etc/mysql/ssl/
cp /tmp/entorns/$BCNACT_ENTORN/cert.crt /etc/mysql/ssl/
cp /tmp/entorns/$BCNACT_ENTORN/key.key /etc/mysql/ssl/
chown -R mysql:mysql /etc/mysql/ssl/
chmod -R 700 /etc/mysql/ssl/
#Permisos per servei
chown -R mysql:mysql /var/run/mysqld/
chmod -R 700 /var/run/mysqld/
#Inici servei
/entrypoint.sh mysqld