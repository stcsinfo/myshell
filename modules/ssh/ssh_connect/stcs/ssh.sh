#!/bin/bash
echo -e "Connecta a:\n"
echo -e "master0\n"
echo -e "master1\n"
echo -e "master2\n"
echo -e "mind1\n"
echo -e "stcs\n"
read word
case "$word" in
    "master0") 
        ssh k8s-master0.$domain_srv_stcs
    ;;
    "master1") 
        ssh k8s-master1.$domain_srv_stcs
    ;;
    "master2") 
        ssh k8s-master2.$domain_srv_stcs
    ;;
    "mind1") 
        ssh mind1.$domain_srv_stcs
    ;;
    "stcs") 
        ssh $domain_pro_stcs
    ;;
    *)
        echo "No valid"
    ;;
esac