#!/bin/bash
echo -e "============ SV011 OpenLDAP ================\n"
echo -e "dev\n"
echo -e "stg\n"
echo -e "pro\n"
read word
case "$word" in
    "dev") 
        "$project_path"/modules/docker/openldap/scripts/dev.sh
    ;;
    "stg") 
        "$project_path"/modules/docker/openldap/scripts/stg.sh
    ;;
    "pro") 
        "$project_path"/modules/docker/openldap/scripts/pro.sh
    ;;
    *)
        echo "No valid"
    ;;
esac