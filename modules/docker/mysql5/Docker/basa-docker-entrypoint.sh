#!/bin/bash
#-----------------------------------------------------------------
#-- Aqui podem modificar els arxius compilats de l'aplicació depenent de l'entorn on estigem.
#-- Es important disposar de tot el necessari o a l'imatge o al nostre repo$
cp  /tmp/entorns/$BCNACT_ENTORN/db.cnf /etc/mysql/conf.d/db.cnf -f
cp  /tmp/entorns/General/general.cnf /etc/mysql/conf.d/general.cnf -f
#chmod 600 /etc/mysql/conf.d -f
#-----------------------------------------------------------------
/entrypoint.sh mysqld