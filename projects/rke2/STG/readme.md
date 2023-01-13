# Entorn STG


## Directoris

1. config: conté arxius necessaris configuració rke2

2. Kubeconfig: conté arxius Kubeconfig generats a instal·lació i amb RBAC

3. scripts: conté arxius per manipular entorn rke2 i RBAC

Abans d'executar els scripts s'ha de fer dos2unix als .sh per garantir la correcte formatació.
També s'ha de fer dos2unix als arxius als arxius del directori config/
Fer chown per ssi a tot /home/ssi/* 

## Scripts master

	actualitza_rancher.sh - versió rancher
	actualitza_rke2.sh - versió rke2
	master.sh - inicia instal·lació master
	registry.sh - instal·la registre
	uninstall.sh - neteja el host de rke2
	volums_nfs.sh - instal·la volum nfs com storage class

## Scripts worker

	actualitza_rke2.sh - versió rke2
	worker.sh - inicia instal·lació worker
	uninstall.sh - neteja el host de rke2

## RBAC

	crea_claus.sh - crea claus RBAC
	elimina_usuari - elimina credencial RBAC

## Comandes per seguir logs instal·lació

	journalctl -u rke2-server -f
	systemctl status rke2-server.service