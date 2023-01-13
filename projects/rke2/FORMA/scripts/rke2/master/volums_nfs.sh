#!/bin/bash
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm repo update
kubectl create namespace nfs-formacio
#Aquest és per contingut de les webs
helm install k8s-formacio-b15390a-contingut nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=$domain_netapp_old_ba \
--set storageClass.name=k8s-formacio-b15390a-contingut \
--set nfs.path=/vol/SV054_NFSSC_FORMACIO_Contingut \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=true \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-formacio