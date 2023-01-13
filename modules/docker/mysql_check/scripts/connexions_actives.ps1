Write-Host "Dades connexió"
$USUARI = Read-Host "Usuari a utilizar"; Write-Host "$USUARI";
$CADENA_CONNEXIO = Read-Host "Nom DNS/IP a utilizar"; Write-Host "$CADENA_CONNEXIO";
$PORT = Read-Host "Port a utilizar"; Write-Host "$PORT";
docker exec -it $nom_contenidor mysql -u $USUARI -h $CADENA_CONNEXIO -P $PORT -p -e "SELECT IFNULL(usr,'All Users') user,IFNULL(hst,'All Hosts') host,COUNT(1) Connections
FROM
(
    SELECT user usr,LEFT(host,LOCATE(':',host) - 1) hst
    FROM information_schema.processlist
    WHERE user NOT IN ('system user','root')
) A GROUP BY usr,hst WITH ROLLUP;"


