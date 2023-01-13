Set-Location $PATH\Docker\passbolt\
$nom_imatge="passbolt"
$nom_contenidor="passbolt"
Write-Host "Cal assegurar que no hi han dades antigues"
docker rm passbolt-passbolt-1 --force
docker rm passbolt-db-1 --force
docker volume rm passbolt_database_volume
docker volume rm passbolt_gpg_volume
docker volume rm passbolt_jwt_volume
sudo docker compose up  -d --build --force-recreate
sleep 40
."$PATH\Docker\passbolt\admin-user.ps1"
Set-Location $HOME 