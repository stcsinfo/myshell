#!/bin/bash
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm repo update
kubectl create namespace nfs-stg
helm install k8s-stg-b15390a-contingut nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=$domain_netapp_old_ba \
--set storageClass.name=k8s-stg-b15390a-contingut \
--set nfs.path=/vol/SV037_NFSSC_STG_Contingut \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=true \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-stg
helm install k8s-stg-b15390a-corporatives nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=$domain_netapp_old_ba \
--set storageClass.name=k8s-stg-b15390a-corporatives \
--set nfs.path=/vol/SV037_NFSSC_STG_Corporatives \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=false \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-stg
helm install k8s-stg-b15390a-exportacions nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=$domain_netapp_old_ba \
--set storageClass.name=k8s-stg-b15390a-exportacions \
--set nfs.path=/vol/SV037_NFSSC_STG_Exportacions \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=false \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-stg
helm install k8s-stg-b15390b-tecnic nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
--set nfs.server=B15390BNFS.$username_ba \
--set storageClass.name=k8s-stg-b15390b-tecnic \
--set nfs.path=/vol/SV037_NFSSC_STG_Tecnic \
--set storageClass.archiveOnDelete=false \
--set storageClass.defaultClass=false \
--set storageClass.reclaimPolicy=Retain \
--namespace nfs-stg
