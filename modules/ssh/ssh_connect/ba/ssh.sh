#!/bin/bash
echo -e "Connecta a:\n"
echo -e "ap023-stg\n"
echo -e "ap023-pro\n"
echo -e "ap060-stg\n"
echo -e "ap060-pro\n"
echo -e "stcs\n"
read word
case "$word" in
    "ap023-stg") 
        ssh root@172.16.104.111
    ;;
    "ap023-pro") 
        ssh root@172.16.104.11
    ;;
    "ap060-stg") 
        ssh root@172.16.108.11
    ;;
    "ap060-pro") 
        ssh root@172.16.108.12
    ;;
    *)
        echo "No valid"
    ;;
esac