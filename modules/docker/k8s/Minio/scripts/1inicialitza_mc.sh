#!/bin/bash
#Binari
echo "Accions per binari"
mkdir /root/mc/
cp -rfv $CI_PROJECT_DIR/$DIR_MINIO/mc/mc /root/mc/
chmod +x /root/mc/mc
export PATH=$PATH:/root/mc/
#Configuració .mc
echo "Accions per arxius configuració"
cp -rfv $CI_PROJECT_DIR/$DIR_MINIO/.mc /root/
#Comanda comprovació per veure si mc es troba iniciat correctament
echo "Comprovació"
mc admin info pro