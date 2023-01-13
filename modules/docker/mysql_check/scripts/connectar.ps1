Write-Host "Dades connexió"
$USUARI = Read-Host "Usuari a utilizar"; Write-Host "$USUARI";
$CADENA_CONNEXIO = Read-Host "Nom DNS/IP a utilizar"; Write-Host "$CADENA_CONNEXIO";
$PORT = Read-Host "Port a utilizar"; Write-Host "$PORT";
docker exec -it $nom_contenidor mysql -u $USUARI -h $CADENA_CONNEXIO -P $PORT -p