Set-Location $PATH\Docker\mysql_check\
$nom_imatge="mysql_check"
$nom_contenidor="mysql_check"
if (docker ps -a | Select-String $nom_contenidor) {
        #Neteja
        Write-Output "Se elimina el container"
        docker rm $nom_contenidor -f
        #
}
#
#
docker build --rm -t $nom_imatge -f $PWD\Docker\.Dockerfile .
docker run -d -it --name "$nom_contenidor" $nom_imatge
#
do
{
	Write-Host "============ Funcionalitats ================"

	Write-Host "   1: Connecta"
	Write-Host "   2: Info_usuaris"
        Write-Host "   3: Connexions actives"
	Write-Host "   q: Sortida ."
	$entrada = Read-Host "Seleccioneu el que voleu fer"
	switch ($entrada) {
		1 {."$PATH\Docker\mysql_check\scripts\connectar.ps1"}
		2 {."$PATH\Docker\mysql_check\scripts\info_usuari.ps1"}
                3 {."$PATH\Docker\mysql_check\scripts\connexions_actives.ps1"}
                'q'
                {
                        Set-Location $HOME 
                        Clear-Host
                        return
                }
		}
    pause
    Set-Location $HOME 
}
until ($input -eq 'q')
#
if (docker ps -a | Select-String $nom_contenidor) {
        #Neteja
        Write-Output "Se elimina el container"
        docker rm $nom_contenidor -f
        #
}
Set-Location $HOME 