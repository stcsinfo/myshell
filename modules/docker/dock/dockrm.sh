#!/bin/bash
num_imatges_docker=$(sudo docker images | wc -l)
#echo $((num_imatges_docker-1))
if [ $num_imatges_docker -gt 1 ]
    then
    echo '\033[1;36m' "Eliminar containers.." '\e[1;37m'
    sudo docker rm $(sudo docker ps -a -q) -f
fi
if [ $num_imatges_docker -gt 1 ]
    then
    echo '\033[1;36m' "Eliminar imatges.." '\e[1;37m'
    sudo docker rmi $(sudo docker images -a -q) -f
fi
echo '\033[1;36m' "Eliminar volums..." '\e[1;37m'
sudo docker volume prune --force
echo '\033[1;36m' "Eliminar xarxes..." '\e[1;37m'
sudo docker network prune --force
echo '\033[1;36m' "Docker prune..." '\e[1;37m'
sudo docker system prune -a --volumes -f 