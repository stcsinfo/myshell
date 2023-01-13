Write-Host "Dades connexió"
$USUARI = Read-Host "Usuari a utilizar"; Write-Host "$USUARI";
$CADENA_CONNEXIO = Read-Host "Nom DNS/IP a utilizar"; Write-Host "$CADENA_CONNEXIO";
$PORT = Read-Host "Port a utilizar"; Write-Host "$PORT";
$usuari_consulta = Read-Host "Usuari del que es vol la info: "; Write-Host "$usuari_consulta";
docker exec -it $nom_contenidor mysql -u $USUARI -h $CADENA_CONNEXIO -P $PORT -p -e "SHOW GRANTS for '$usuari_consulta';"