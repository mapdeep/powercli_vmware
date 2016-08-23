$vcenter= Read-Host ("Enter Target Vcenter name ")
$cred= Get-Credential -Message "enter the credentials to login vcenter"
Connect-VIServer $vcenter -Credential $cred

$outpref = "C:\temp\"+$vcenter
$outsuf=(Get-Date -Format yyyy-MMM-dd-HHmm) + ".csv" 

$datacenters= get-datacenter
foreach ($dc in $datacenters)
{
#$dc=get-datacenter -name $datacenter
Get-Folder -Type HostAndCluster -Location $dc|where-object name -ne "host" | %{$_|select @{n="datacenter";e={$dc.name}},name,parent,type,@{n="Cluster";e={(get-cluster -location $_ |Select -ExpandProperty name) -join "," }},@{n="Hosts";e={(get-vmhost -location $_ |Select -ExpandProperty name) -join "," }}} |  Export-CSV -Path ($outpref +"_HostAndCluster_Folder_"+$outsuf) -Append -NoTypeInformation -UseCulture

Get-Folder -Type Datastore -Location $dc|where-object name -ne "datastore" |%{$_| select @{n="datacenter";e={$dc.name}},name,parent,type,@{n="Datastores";e={(get-Datastore -location $_ Select -ExpandProperty name) -join "," }},@{n="Datastore_cluster";e={(Get-DatastoreCluster -location $_|Select -ExpandProperty name) -join "," }}}|  Export-CSV -Path ($outpref +"_Datastore_Folder_"+$outsuf) -Append -NoTypeInformation -UseCulture

Get-Folder -Type network -Location $dc|where-object name -ne "network" | %{$_|select @{n="datacenter";e={$dc.name}},name,parent,type,@{n="VDS";e={(Get-VDSwitch -location $_|Select -ExpandProperty name) -join "," }}}|  Export-CSV -Path ($outpref +"_Network_Folder_"+$outsuf) -Append -NoTypeInformation -UseCulture

}

Disconnect-VIServer $vcenter -Confirm:$false