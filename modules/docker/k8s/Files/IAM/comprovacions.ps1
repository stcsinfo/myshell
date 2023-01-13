$max=Get-ChildItem /home/ssi/buckets -Recurse -File | Measure-Object | %{$_.Count}
$max=$max-1
$contador = 0
Do {
  $nom_bucket = Get-Content -Path "/home/ssi/llistat_buckets"
  $bucket_actual = $nom_bucket[$contador]
  if (mc admin user list pro | grep $bucket_actual) {
    $quota = Get-Content -Path /home/ssi/buckets/$bucket_actual/quota
    $tipus_quota = Get-Content -Path /home/ssi/buckets/$bucket_actual/tipus_quota
    Write-Host "Accions per: $bucket_actual"
      ###BUCKETS###
        Write-Host "Creant bucket"
        mc mb pro/$bucket_actual
      ###AFEGIR POLICY###
        Write-Host "Afegir policy"
        mc admin policy add pro "$bucket_actual-bucket-policy" /home/ssi/buckets/$bucket_actual/$bucket_actual-bucket-policy
      ###ASSIGNAR POLICY###
        Write-Host "Assignació policy"
        mc admin policy set pro "$bucket_actual-bucket-policy" user=$bucket_actual
      ###ASSIGNAR QUOTA###
        Write-Host "Assignació quota"
        mc admin bucket quota pro/$bucket_actual --$tipus_quota $quota
  } else {
    Write-Host "Usuari $bucket_actual no existeix, no es poden realitzar accions."
  }
    $contador++
} While ($contador -le $max)