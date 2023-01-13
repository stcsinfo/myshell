clear
cyan; echo  "Docker"  ;nocolor  
echo  " "
echo  "Crear/cargar container - php:7.2-apache es nombre_repo:tag (docker images)"    
echo  " docker run -it debian"
echo  " docker run --rm --publish 8080:80 --detach --name apache php:7.2-apache"
echo  " "
cyan; echo  "Gestión Containers" ;nocolor
echo  " "
cyan; echo  " Abrir terminal bash en el container"  ;nocolor  
echo  "  docker exec -it apache /bin/bash"
echo  " "
cyan; echo  " Copiar archivo desde host a dentro del container"   ;nocolor 
echo  "  docker cp index.html 4f950f3d6c81:/srv/www/htdocs/index.html"
echo  " "
cyan; echo  " Entrypoint sempre"   ;nocolor 
echo  "  ENTRYPOINT ["tail", "-f", "/dev/null"]"
cyan; echo  " Helm"    ;nocolor
echo  "  helm install nexus nexus-repository-manager-34.1.0.tgz -n nexus -f values.yaml"
echo  "  helm delete nexus -n nexus"