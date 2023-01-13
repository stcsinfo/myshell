Set-Location $PATH\Docker\k8s\
$nom_imatge="k8s"
$nom_contenidor="k8s"
if (docker ps -a | Select-String $nom_contenidor) {
        #Neteja
        Write-Output "Se elimina el container"
        docker rm $nom_contenidor -f
        #
}
#Creació de la imatge
docker build --rm -t $nom_imatge -f $PATH/Docker/k8s/Docker/Dockerfile/.Dockerfile .
#Càrrega del contenidor
docker run -d -it --name "$nom_contenidor" `
        -v $PWD/Files/YML:/mnt/YML `
        -v $PWD/Files/IAM:/mnt/IAM `
        -v $PWD/Docker/scripts/yml:/mnt/scripts/yml `
        -v $PWD/Help:/mnt/help `
        -v $PWD/Docker/scripts/sistema:/mnt/scripts/sistema `
        -v $PWD/tmp:/trash `
        -v $PWD/Kubeconfig:/root/.kube  $nom_imatge
#exec
docker exec -it $nom_contenidor /bin/bash
Set-Location $HOME 