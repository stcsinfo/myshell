Set-Location $PATH\Docker\passbolt-cli\
$DOCKER_REGISTRY_CACHE = "docker.io"
$IMATGE_APLICACIO = "debian:buster"
docker login $DOCKER_REGISTRY_CACHE
$nom_imatge="passbolt-cli"
$nom_contenidor="passbolt-cli"
if (docker ps -a | Select-String $nom_contenidor) {
        #Neteja
        Write-Output "Se elimina el container"
        docker rm $nom_contenidor -f
        #
}
docker build --rm -t $nom_imatge -f $PWD\.Dockerfile .
docker run -it --name "$nom_contenidor" $nom_imatge
#Neteja
        Write-Output "Se elimina el container"
        docker rmi -f $nom_imatge
        docker container rm $nom_contenidor
#
Set-Location $HOME 