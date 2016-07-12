$vcenters=import-csv c:\vcenters.txt
$cred = get-credential
foreach($vcenter in  $vcenters.name)
{
connect-viserver $vcenter -Credential $cred


Get-VIPermission|%{ $_| select @{N="Vcenter";E={$vcenter}}, role,Principal } | Where-Object -Property Principal -Like "CORP\svc_intiguavc"

Disconnect-VIServer $vcenter -Confirm:$false
}