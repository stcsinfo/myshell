#!/bin/bash
nom_contenidor="openldap-dev"
check_contenidor=$(sudo docker ps -a | grep "$nom_contenidor" &> /dev/null; echo $?)
if [ $check_contenidor = "0" ]
    then
        #Neteja
        echo "Se elimina el container"
        sudo docker rm $nom_contenidor -f
        #
fi
IMATGE="osixia/phpldapadmin:0.9.0"
$nom_contenidor="$nom_contenidor"
docker run --name "$nom_contenidor" \
        -p 4000:443 \
        --env PHPLDAPADMIN_LDAP_HOSTS=172.16.133.51 \
        --detach $IMATGE


#$IMATGE="dnknth/ldap-ui"
#$nom_contenidor="$nom_contenidor"
#docker run --name "$nom_contenidor" `
#        -p 5000:5000 `
#        --env LDAP_URL=ldap://$domain_ba_ldappre/ `
#        --env BASE_DN=dc=$username_ba_ldap,dc=local `
#        --detach $IMATGE


echo "Visita: https://localhost:4000/"