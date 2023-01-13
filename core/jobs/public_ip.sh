#!/bin/bash
#init
meter=0
max=1
old_ip=0.0.0.0
#Inicio while y condicion, reloj
while [ $meter -lt 1 ]
do
	#Espera 60 segundos
	sleep 1
	#echo "Running $meter time"
	#echo $old_ip
	#Se suma el meter
	meter=$(( meter+1 ))
	#Condicion para resetear cada minuto el meter a 0 y hacer
	#buble infinito
	#y comprobar si la IP es diferente
	#Primero se pone el valor actual de la ip dinamica
	real_ip=$( curl -s ifconfig.me )
	#Cada 6 vueltas (valor de max) hara un "echo running"
	#Contando con el sleep, es 1 minuto
	if [ $meter -eq $max ]
	then
		if [ "$real_ip" != "$old_ip" ]
		then
			echo "\nPublic IP: $real_ip"
			echo "\nPublic IP: $real_ip" > /$HOME/public_ip.txt
			old_ip=$real_ip
		fi
		#echo "Running..."
		#Se resetea la variable meter a  0 para hacer inicio
		meter=$(( 0 ))
	fi
done
