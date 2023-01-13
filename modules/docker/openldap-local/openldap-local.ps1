Set-Location $PATH\Docker\openldap-local\
$nom_contenidor="openldap-local"
if (docker ps -a | Select-String $nom_contenidor) {
        #Neteja
        Write-Output "Se elimina el container"
        docker rm $nom_contenidor -f
        #
}
docker compose up -d --build --force-recreate
Write-Host "Visita: https://localhost:389/"
Set-Location $HOME 