#!/bin/bash
echo "Nom usuari a eliminar"
read usuari
echo "Eliminar role usuari"
kubectl delete rolebinding $usuari --namespace $usuari
#echo "Revocat certificat usuari"
kubectl delete csr $usuari
echo "Eliminar NS"
kubectl delete namespace $usuari
echo "Eliminar directori i claus usuari"
rm -rf /home/ssi/claus_k8s/$usuari/
##
##