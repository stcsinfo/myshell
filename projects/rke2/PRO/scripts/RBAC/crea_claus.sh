#!/bin/bash
## Aquest script crea usuari, namespace i claus per usuari que ho treu d'un llistat .txt
## dona acces total al seu namespace.
## Necessari per executar aquest script:
## · Tenir aquest script en qualsevol "pwd"
## · En el mateix path s'ha de tenir un arxiu amb el nom "usuaris.txt"
##     · El format per a cada usuari ha de ser "nom-cognom" o "nomcognom"
#
#
#Crear directori per emmagatzemar les claus
mkdir -p /home/ssi/RBAC
directori=/home/ssi/RBAC
#Inicialitzem variable arxiu amb usuaris.txt
#I variable usuaris amb el contingut del .txt
arxiu="usuaris.txt"
usuaris=$(cat $arxiu)
#Iniciem bucle per recorrer contingut arxiu entrada per entrada
for usuari in $usuaris
do
#Creació directori per usuari
	echo "Configuració de" $usuari
	echo "$usuari"
	mkdir -p $directori/$usuari
#Creacio clau per usuari
	openssl req -new -newkey rsa:4096 -nodes \
		-keyout $directori/$usuari/"$usuari.key" \
		-out $directori/$usuari/"$usuari.csr" \
		-subj "/CN=$usuari/O=BA"
#Creacio yml que conte la clau usuari
	user_request=$(cat $directori/$usuari/"$usuari.csr" | base64 | tr -d '\n')
	touch $directori/$usuari/"$usuari-csr.yaml"
	echo "apiVersion: certificates.k8s.io/v1beta1" >> $directori/$usuari/"$usuari-csr.yaml"
	echo "kind: CertificateSigningRequest" >> $directori/$usuari/"$usuari-csr.yaml"
	echo "metadata:" >> $directori/$usuari/"$usuari-csr.yaml"
	echo "  name: $usuari" >> $directori/$usuari/"$usuari-csr.yaml"
	echo "spec:" >> $directori/$usuari/"$usuari-csr.yaml"
	echo "  groups:" >> $directori/$usuari/"$usuari-csr.yaml"
	echo "  - system:authenticated" >> $directori/$usuari/"$usuari-csr.yaml"
	echo "  request: $user_request" >> $directori/$usuari/"$usuari-csr.yaml"
	echo "  usages:" >> $directori/$usuari/"$usuari-csr.yaml"
	echo "  - client auth" >> $directori/$usuari/"$usuari-csr.yaml"
	kubectl apply -f $directori/$usuari/"$usuari-csr.yaml"
#Output dels csr de k8s
	kubectl get csr | grep $usuari
#Aprovació accés a usuari
	kubectl certificate approve "$usuari"
#Output dels csr de k8s
	kubectl get csr | grep $usuari
#Clau usuari en format base64
	kubectl get csr "$usuari" \
		-o jsonpath='{.status.certificate}' | base64 --decode > $directori/$usuari/"$usuari.crt"
#Clau publica servidor en format base64
	kubectl config view \
		-o jsonpath='{.clusters[0].cluster.certificate-authority-data}' \
		--raw | base64 --decode - > $directori/k8s-formacio-ca-cluster.crt
#Creació kubeconfig usuari
	kubectl config set-cluster $(kubectl config view -o jsonpath='{.clusters[0].name}') \
		--server=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}') \
		--certificate-authority=$directori/k8s-formacio-ca-cluster.crt \
		--kubeconfig=$directori/$usuari/"$usuari-config" --embed-certs
#Creació credencials usuari en K8S
	kubectl config set-credentials $usuari \
		--client-certificate=$directori/$usuari/"$usuari.crt" \
		--client-key=$directori/$usuari/"$usuari.key" \
		--embed-certs --kubeconfig=$directori/$usuari/"$usuari-config"
#Creació context
	kubectl config set-context $usuari \
		--cluster=$(kubectl config view -o jsonpath='{.clusters[0].name}') \
		--namespace=$usuari \
		--user=$usuari \
		--kubeconfig=$directori/$usuari/"$usuari-config"
#Creació namespace
	kubectl create ns $usuari
#Creacio rol tipus admin per al usuari al seu namespace
	kubectl create rolebinding $usuari --namespace=$usuari --clusterrole=admin --user=$usuari
done
echo "El que cal fer ara en el usuari-config generat es:"
echo "  · Modificar entrada server per IP snapt"
echo "  · Establir current context amb el nom del usuari"
echo "cat $directori/$usuari/$usuari-config"