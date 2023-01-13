Set-Location $PATH\Docker\k6\
$nom_contenidor="k6"
if (docker ps -a | Select-String $nom_contenidor) {
        #Neteja
        Write-Output "Se elimina el container"
        docker rm $nom_contenidor -f
        #
}
Write-Host "Serveis per analitzar"
Get-ChildItem .\scripts
$entorn = Read-Host "Seleccioneu el que voleu fer"
$IMATGE="loadimpact/k6:latest"
docker run -it --name "$nom_contenidor" `
        -v $PWD\:/mnt/local $IMATGE `
        run /mnt/local/scripts/$entorn/$entorn.js `
        #--out csv=/mnt/local/scripts/$entorn/$entorn.csv
Set-Location $HOME 