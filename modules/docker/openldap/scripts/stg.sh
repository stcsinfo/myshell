#!/bin/bash
nom_contenidor="openldap-stg"
check_contenidor=$(sudo docker ps -a | grep "$nom_contenidor" &> /dev/null; echo $?)
if [ $check_contenidor = "0" ]
    then
        #Neteja
        echo "Se elimina el container"
        sudo docker rm $nom_contenidor -f
        #
fi
IMATGE="osixia/phpldapadmin:0.9.0"
docker run --name "$nom_contenidor" \
        -p 5000:443 \
        --env PHPLDAPADMIN_LDAP_HOSTS=$domain_ba_ldappre  \
        --detach $IMATGE


#$IMATGE="dnknth/ldap-ui"
#$nom_contenidor="$nom_contenidor"
#docker run --name "$nom_contenidor" `
#        -p 5000:5000 `
#        --env LDAP_URL=ldap://$domain_ba_ldappre/ `
#        --env BASE_DN=dc=$username_ba_ldap,dc=local `
#        --detach $IMATGE


echo "Visita: https://localhost:5000/"