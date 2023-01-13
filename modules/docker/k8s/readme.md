# K8S admninistration

## Sobre el projecte

Requisits

    · VPN
    · Docker

Executar run.ps1 per iniciar projecte en local

Accions que permet el projecte:

    · Gestionar clusters amb "kubectl"
    · Gestionar Minio amb "mc"

## Estructura directoris

    · Docker - arxius amb .yml del projecte (CICD), .Dockerfile i altres per iniciar màquina local
    · Documentacio - directori amb imatges per la documentació
    · Files - arxius IAM/YAML per desplegar a K8S (no fa còpia dins de la màquina, crea un volum)
    · Help - arxius per comandes
    · Kubeconfig - arxius relacionats amb la configuració de Kubeconfig
    · Minio - arxius relacionats amb la configuració de MinioMC

## Comandes

Per tal de llistar les comandes preconfigurades cal executar "comandes"

![Imatge](/Documentacio/comandes.png)