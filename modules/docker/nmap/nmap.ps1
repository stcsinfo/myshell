Set-Location $PATH\Docker\nmap\
$nom_contenidor="nmap"
do
{
	Write-Host "============ Funcionalitats ================"
	Write-Host "   1: scan_up_nodes"
	Write-Host "   q: Sortida ."
	$script= Read-Host "Seleccioneu el que voleu fer"
	switch ($script) {
		1 {$script="scan_up_nodes"}
                'q'
                {
                   Clear-Host
                   return
                }
		default{"No Match Found"}
		}
        $IMATGE="securecodebox/nmap"
        docker run -it --name "$nom_contenidor" `
                -v $PWD\:/mnt/local $IMATGE `
                /bin/sh "/mnt/local/scripts/$script.sh"
        if (docker ps -a | Select-String $nom_contenidor) {
                #Neteja
                Write-Output "Se elimina el container"
                docker rm $nom_contenidor -f
                #
        }
        Set-Location $HOME 
    pause
}
until ($script -eq 'q')