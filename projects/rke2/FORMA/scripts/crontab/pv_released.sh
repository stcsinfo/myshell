#!/bin/bash
#CRONTAB
#0 0 * * * sh /home/ssi/FORMA/scripts/crontab/pv_released.sh
kubectl get pv -n formacio -o custom-columns=NAME:.metadata.name,CLAIM:.spec.claimRef.name,STATUS:.status.phase | grep Released
kubectl get pv -n formacio -o custom-columns=NAME:.metadata.name,CLAIM:.spec.claimRef.name,STATUS:.status.phase | grep Released > released.txt
releaseds=$(awk '{print $1}' released.txt)
for released in $releaseds
do
    echo "Eliminat $released"
    kubectl delete pv -n formacio $released
done