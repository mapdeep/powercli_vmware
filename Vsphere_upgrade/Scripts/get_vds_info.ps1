#Get the report of the DVswitch

$vcenter= Read-Host ("Enter Target Vcenter name ")
$cred= Get-Credential -Message "enter the credentials to login vcenter"
Connect-VIServer $vcenter -Credential $cred
$outputfile="C:\Temp\"+$vcenter+"_VDS_Portgroup_"+(Get-Date -Format yyyy-MMM-dd-HHmm) + ".csv" 


$dcs= get-datacenter
foreach($dc in $dcs)
{
$dc| Get-VDSwitch| select @{n="datacenter";e={$dc.name}},name,mtu,version,@{n="portgroups";e={($_|get-vdportgroup|select -ExpandProperty name) -join ","}}| Export-CSV -Path $outputfile -Append -NoTypeInformation -UseCulture
}

Disconnect-VIServer $vcenter -Confirm:$false