$datacenters= get-datacenter

foreach ($dc in $datacenters)
{
#$dc=get-datacenter -name $datacenter

Get-Folder -Type HostAndCluster -Location $dc|where-object name -ne "host" | select @{n="datacenter";e={$dc.name}},name,parent,type
Get-Folder -Type Datastore -Location $dc|where-object name -ne "datastore" | select @{n="datacenter";e={$dc.name}},name,parent,type
Get-Folder -Type network -Location $dc|where-object name -ne "network" | select @{n="datacenter";e={$dc.name}},name,parent,type
<#
$folders =Get-Folder -Type HostAndCluster -Location $dc

foreach ($folder in $folders)
{
if ($folder.name -ne "host")
{
$folder |select @{n="datacenter";e={$dc.name}},name,parent,type,@{n="Hosts";e={get-vmhost -location $_ }}

}

}
#>

}