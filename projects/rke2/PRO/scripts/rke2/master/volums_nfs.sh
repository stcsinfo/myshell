#!/bin/bash
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm repo update
kubectl create namespace nfs-pro
#Aquest és per contingut de les webs
helm install k8s-pro-contingut nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=$domain_netapp_ba \
--set storageClass.name=k8s-pro-contingut \
--set nfs.path=/SV037_NFSSC_PRO_Contingut \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=true \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-pro
#Aquest és per retencions de 5 anys
helm install k8s-pro-corporatives nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=$domain_netapp_ba \
--set storageClass.name=k8s-pro-corporatives \
--set nfs.path=/SV037_NFSSC_PRO_Corporatives \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=false \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-pro
#Aquest és per dumps 
helm install k8s-pro-exportacions nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=$domain_netapp_ba \
--set storageClass.name=k8s-pro-exportacions \
--set nfs.path=/SV037_NFSSC_PRO_Exportacions \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=false \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-pro
#Aquest és per aplicacions de K8S i altres
helm install k8s-pro-tecnic nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=$domain_netapp_ba \
--set storageClass.name=k8s-pro-tecnic \
--set nfs.path=/SV037_NFSSC_PRO_Tecnic \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=false \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-pro
#Minio
helm install k8s-pro-minio nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=$domain_netapp_ba \
--set storageClass.name=k8s-pro-minio \
--set nfs.path=/SV037_NFSSC_PRO_Minio \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=false \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-pro