#!/bin/bash
echo "Per quina xarxa es vol fer l'escaneig? ex: 192.168.1.0/24"
read xarxa
nmap -sn $xarxa