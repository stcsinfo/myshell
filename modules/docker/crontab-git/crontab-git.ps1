Set-Location $PATH\Docker\crontab-git\
$nom_imatge="crontab-git"
$nom_contenidor="crontab-git"
if (docker ps -a | Select-String $nom_contenidor) {
        #Neteja
        Write-Output "Se elimina el container"
        docker rm $nom_contenidor -f
        #
}
docker compose up  -d --build --force-recreate
Set-Location $HOME 