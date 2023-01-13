# Openldap

	Ubuntu 20 con aliases
	Certificat 
		- Canvi cada any vs self-signed
	No es poden fer consultes del DIT sense identificar
	Les configs es realitzen amb ldif files
	No es pot consultar tot el DIT per defecte - * read *
	Habilitat log
	L'usuari AP032PRE és un inetOrgperson
	La recuperació de backup s'ha fet de person a inetOrgperson

URLs

- https://ubuntu.com/server/docs/service-ldap

Requisits:

Entrada a DNS servidors:

- Domini servidors	
	- slapd-stg-master.$domain_srv_ba [172.16.133.51]
	- slapd-stg-slave.$domain_srv_ba [172.16.133.55]	

- Domini entorn (haproxy)
	- sv011-slapd.$domain_stg_ba [172.16.200.131]

### Eliminar al acabar proves

	echo -n "password" > ~/pwdAdmin
	chmod 600 ~/pwdAdmin


### Comandes gestió

	#Busca un cn en concreto
	dapsearch -x -H ldap://localhost -D cn=admin,dc=$username_ba_ldap,dc=local -y ~/pwdAdmin -b dc=$username_ba_ldap,dc=local -s sub -x "cn=02530657J" -LLL


	#Cambia password de un cn
	ldappasswd -H ldapi:/// -x -D "cn=admin,dc=$username_ba_ldap,dc=local" -W -S cn=02530657J,ou=UsuarisRegistrats,ou=extern,dc=$username_ba_ldap,dc=local


## Part1	- Instal·lació bàsica

	sudo apt install slapd ldap-utils
	sudo dpkg-reconfigure slapd		-		$username_ba_ldap.local
	sudo nano /etc/ldap/ldap.conf
	sudo usermod -a -G openldap ssi
	sudo usermod -a -G openldap syslog
	sudo service slapd restart

	ll /usr/lib/ldap/
	ll /etc/ldap/schema/
	ll /etc/ldap/slapd.d/
	ll /var/lib/ldap/
	ll /var/run/slapd/ 

Els clients han de disposar de

```
sudo apt-get install ldap-utils
```

	Configuració slapd:
	sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config dn
	
	Configuració DIT:
	ldapsearch -x -LLL -H ldap:/// -y ~/pwdAdmin -D cn=admin,dc=$username_ba_ldap,dc=local -b dc=$username_ba_ldap,dc=local dn
	
	Retorna tot:
	ldapsearch -x -b "dc=$username_ba_ldap,dc=local" -H ldap://slapd-stg-master.$domain_srv_ba
	Informacio usuari admin
	ldapsearch -x -b "cn=admin,dc=$username_ba_ldap,dc=local" -H ldap://slapd-stg-master.$domain_srv_ba

	ldapsearch -x -y ~/pwdAdmin -D "cn=admin,dc=$username_ba_ldap,dc=local" "(objectclass=*)"
	ldapsearch -x -y ~/pwdAdmin -D "cn=admin,dc=$username_ba_ldap,dc=local" "(objectclass=*)" -b "cn=admin,dc=$username_ba_ldap,dc=local"
	**La password per admin és la de sistemes


## Part2 - Logs
	
	Com a root:
	ldapsearch -Y external -H ldapi:/// -b cn=config "(objectClass=olcGlobal)" olcLogLevel -LLL > /etc/ldap/slapdlog.ldif
	nano /etc/ldap/slapdlog.ldif
	
	Com usuari:
	sudo ldapmodify -Y external -H ldapi:/// -f /etc/ldap/slapdlog.ldif
	sudo chown root:openldap /etc/ldap/slapdlog.ldif
	sudo chmod 660 /etc/ldap/slapdlog.ldif
	sudo ldapsearch -Y external -H ldapi:/// -b cn=config "(objectClass=olcGlobal)" olcLogLevel
	sudo nano /etc/rsyslog.d/10-slapd.conf
	sudo service rsyslog restart
	ldapsearch -Y external -H ldapi:/// -b dc=$username_ba_ldap,dc=local
	sudo tail -f /var/log/slapd.log


## Part3 - Schemas

	sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config dn
	ldapsearch -x -H ldap://localhost -D cn=admin,dc=$username_ba_ldap,dc=local -y ~/pwdAdmin -b dc=$username_ba_ldap,dc=local -LLL
	
## Part4 - OU + 

	*Crear arxius .ldif abans
	sudo chown root:openldap /etc/ldap/*.ldif
	sudo chmod 660 /etc/ldap/*.ldif
	ldapmodify -a -x -H ldap://localhost -y ~/pwdAdmin -D cn=admin,dc=$username_ba_ldap,dc=local -W -f /etc/ldap/extern.ldif
	ldapmodify -a -x -H ldap://localhost -y ~/pwdAdmin -D cn=admin,dc=$username_ba_ldap,dc=local -W -f /etc/ldap/extern.UsuariBindServeis.ldif
	ldapmodify -a -x -H ldap://localhost -y ~/pwdAdmin -D cn=admin,dc=$username_ba_ldap,dc=local -W -f /etc/ldap/extern.UsuarisRegistrats.ldif

## Part5 - Usuaris
	
	*Crear arxius .ldif abans
	sudo chown root:openldap /etc/ldap/*.ldif
	sudo chmod 660 /etc/ldap/*.ldif
	
	*Es pot deixar en text pla o be emprar "slappasswd -s password" per generar el hash y encriptar
	
	sudo ldapmodify -a -x -H ldap://localhost -y ~/pwdAdmin -D cn=admin,dc=$username_ba_ldap,dc=local -W -f /etc/ldap/user-ap032PRE.ldif
	
	Passwords NO text pla, pero SENSE ENCRIPTAR (si no es fa "slappasswd -s password")
	
	ldapsearch -x -H ldap://localhost -D cn=AP032PRE,ou=UsuarisBindServeis,ou=extern,dc=$username_ba_ldap,dc=local -W -b ou=UsuarisBindServeis,ou=extern,dc=$username_ba_ldap,dc=local
	
## Part6 - Accés anonim
	
		ldapsearch -x -H ldap://172.16.133.51 -b dc=$username_ba_ldap,dc=local
		ldapsearch -x -H ldap://172.16.133.51 -D cn=AP032PRE,ou=UsuarisBindServeis,ou=extern,dc=$username_ba_ldap,dc=local -w Doraemon23 -b dc=$username_ba_ldap,dc=local -LLL
		sudo nano /etc/ldap/anon.ldif
		sudo nano /etc/ldap/anon2.ldif
		sudo chown root:openldap /etc/ldap/*.ldif
		sudo chmod 660 /etc/ldap/*.ldif
		sudo ldapmodify -Y external -H ldapi:/// -f /etc/ldap/anon.ldif
		sudo ldapmodify -Y external -H ldapi:/// -f /etc/ldap/anon2.ldif
		ldapsearch -x -H ldap://172.16.133.51 -b dc=$username_ba_ldap,dc=local
		ldapsearch -x -H ldap://172.16.133.51 -D cn=AP032PRE,ou=UsuarisBindServeis,ou=extern,dc=$username_ba_ldap,dc=local -w Doraemon23 -b dc=$username_ba_ldap,dc=local -LLL
		
		*Es prohibeix accés anonim, però qualsevol usuari pot llegir de qualsevol ou
		
		
## Part7 - ACL's

		Consultar estat ACLs
			sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config '(olcDatabase={-1}frontend)' olcAccess
			sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config '(olcDatabase={0}config)' olcAccess
			sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config '(olcDatabase={1}mdb)' olcAccess
			
		delete permissions to read * (to * by * read)

		PRIMER CAL FER CONSULTA!!
		sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config '(olcDatabase={1}mdb)' olcAccess

		SI CAL ELIMINAR ALGUNA ENTRADA...
		**sudo ldapmodify -Y external -H ldapi:/// -y ~/pwdAdmin -f /etc/ldap/delete_read.ldif**

		sudo ldapmodify -Y external -H ldapi:/// -y ~/pwdAdmin -f /etc/ldap/acl-ap032pre.ldif

## Part8 - TLS

https://ubuntu.com/server/docs/service-ldap-with-tls

Install the gnutls-bin and ssl-cert packages:

	sudo apt install gnutls-bin ssl-cert

Create a private key for the Certificate Authority:

	sudo certtool --generate-privkey --bits 4096 --outfile /etc/ssl/private/$username_ba_ldap.pem

sudo nano /etc/ssl/ca.info

Create the self-signed CA certificate:

	sudo certtool --generate-self-signed \
	--load-privkey /etc/ssl/private/$username_ba_ldap.pem \
	--template /etc/ssl/ca.info \
	--outfile /usr/local/share/ca-certificates/$username_ba_ldap.crt

Run
	
	sudo update-ca-certificates

Key for server:
	
	sudo certtool --generate-privkey \
	--bits 2048 \
	--outfile /etc/ldap/slapd-stg-master_slapd_key.pem
		
sudo nano /etc/ssl/slapd-stg-master.info

Create the server’s certificate:

		sudo certtool --generate-certificate \
		--load-privkey /etc/ldap/slapd-stg-master_slapd_key.pem \
		--load-ca-certificate /etc/ssl/certs/$username_ba_ldap.pem \
		--load-ca-privkey /etc/ssl/private/$username_ba_ldap.pem \
		--template /etc/ssl/slapd-stg-master.info \
		--outfile /etc/ldap/slapd-stg-master_slapd_cert.pem

Adjust permissions and ownership:

- sudo chgrp openldap /etc/ldap/slapd-stg-master_slapd_key.pem
- sudo chmod 0640 /etc/ldap/slapd-stg-master_slapd_key.pem	

sudo nano certinfo.ldif

	sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif


If you need access to LDAPS (LDAP over SSL), then you need to edit /etc/default/slapd and include ldaps:/// in SLAPD_SERVICES like below:

	SLAPD_SERVICES="ldap:/// ldapi:/// ldaps:///"
	And restart slapd with: sudo systemctl restart slapd.


Verificar que en /etc/ldap/ldap.conf es modificar el .crt (el client ha de tenir la mateixa config)

	# TLS certificates (needed for GnuTLS)
	TLS_CACERT      /etc/ldap/slapd-stg-master_slapd_cert.pem
	#Configuració base
	BASE    dc=$username_ba_ldap,dc=local
	URI     ldap://slapd-stg-master.$domain_srv_ba ldaps://slapd-stg-master.$domain_srv_ba ldap://slapd-stg-slave.$domain_srv_ba ldaps://slapd-stg-slave.$domain_srv_ba

sudo systemctl restart slapd

TestStartTLS
	
	ldapsearch -x -ZZ -H ldap://slapd-stg-master.$domain_srv_ba -W -D cn=admin,dc=$username_ba_ldap,dc=local -b dc=$username_ba_ldap,dc=local dn

Test LDAPS

	ldapsearch -x -LLL -H ldaps://slapd-stg-master.$domain_srv_ba:636 -W -D cn=admin,dc=$username_ba_ldap,dc=local -b dc=$username_ba_ldap,dc=local dn


## Certificate for replica

mkdir slave-ssl; cd slave-ssl

	sudo certtool --generate-privkey \
	--bits 2048 \
	--outfile slapd-stg-slave_slapd_key.pem


sudo nano slapd-stg-slave.info

	sudo certtool --generate-certificate \
	--load-privkey slapd-stg-slave_slapd_key.pem \
	--load-ca-certificate /etc/ssl/certs/$username_ba_ldap.pem \
	--load-ca-privkey /etc/ssl/private/$username_ba_ldap.pem \
	--template slapd-stg-slave.info \
	--outfile slapd-stg-slave_slapd_cert.pem

cp /etc/ssl/certs/$username_ba_ldap.pem .
sudo chown ssi:ssi *

scp -r ldap02-ssl user@consumer:/path


### On slave side

		sudo cp slapd-stg-slave_slapd_cert.pem slapd-stg-slave_slapd_key.pem /etc/ldap
		sudo chgrp openldap /etc/ldap/slapd-stg-slave_slapd_key.pem
		sudo chmod 0640 /etc/ldap/slapd-stg-slave_slapd_key.pem
		sudo cp $username_ba_ldap.pem /usr/local/share/ca-certificates/$username_ba_ldap.crt
		sudo update-ca-certificates


nano certinfo.ldif

	sudo ldapmodify -Y EXTERNAL -H ldapi:/// -f certinfo.ldif

If you need access to LDAPS (LDAP over SSL), then you need to edit /etc/default/slapd and include ldaps:/// in SLAPD_SERVICES like below:

	sudo nano /etc/default/slapd
	SLAPD_SERVICES="ldap:/// ldapi:/// ldaps:///"

And restart slapd with: sudo systemctl restart slapd.

Verificar que en /etc/ldap/ldap.conf es modificar el .crt (el client ha de tenir la mateixa config)

	# TLS certificates (needed for GnuTLS)
	TLS_CACERT      /etc/ldap/slapd-stg-slave_slapd_cert.pem
	#Configuració base
	BASE    dc=$username_ba_ldap,dc=local
	URI     ldap://slapd-stg-slave.$domain_srv_ba ldaps://slapd-stg-slave.$domain_srv_ba ldap://slapd-stg-master.$domain_srv_ba ldaps://slapd-stg-master.$domain_srv_ba

sudo systemctl restart slapd


TestStartTLS
	
	ldapsearch -x -ZZ -H ldap://slapd-stg-slave.$domain_srv_ba -W -D cn=admin,dc=$username_ba_ldap,dc=local -b dc=$username_ba_ldap,dc=local dn

Test LDAPS

	ldapsearch -x -LLL -H ldaps://slapd-stg-slave.$domain_srv_ba:636 -W -D cn=admin,dc=$username_ba_ldap,dc=local -b dc=$username_ba_ldap,dc=local dn

## Merge certificat

Cal fer un merge dels certificats generats per tal de que els servidors connectin entre ells per TLS.
Els clients també necessiten el/s certificat per connectar-se a les diferents màquines.

Per cada node el primer cert que es manté és el propi. Ex: per master, primer el cert de master i després el de slave.

Per al client és necessari modificar /etc/ldap/ldap.conf i ficar el cert al directori:

	cp slapd-stg-master_slapd_cert.pem /etc/ldap/



## Replicator

- https://ubuntu.com/server/docs/service-ldap-replication

### Provider side

nano replicator.ldif

	sudo ldapmodify -a -x -H ldap://localhost -D cn=admin,dc=$username_ba_ldap,dc=local -W -f replicator.ldif


Check acl

	sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config '(olcDatabase={1}mdb)' olcAccess

nano replicator-acl-limits.ldif

	sudo ldapmodify -Y external -H ldapi:/// -W -f replicator-acl-limits.ldif

```
	nano provider_sync.ldif
	sudo -u openldap mkdir /var/lib/ldap/accesslog
	sudo ldapmodify -Y external -H ldapi:/// -W -f provider_sync.ldif
```

### Consumer side

nano consumer_sync.ldif

	sudo ldapmodify -Y external -H ldapi:/// -W -f consumer_sync.ldif


Check

	ldapwhoami -x -ZZ -D cn=replicator,dc=$username_ba_ldap,dc=local -W -h slapd-stg-master.$domain_srv_ba

Monitor

	ldapsearch -z1 -LLL -x -s base -D cn=admin,dc=$username_ba_ldap,dc=local -W -b dc=$username_ba_ldap,dc=local contextCSN



















