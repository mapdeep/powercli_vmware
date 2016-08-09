#get Virtual machine portgroup info

$clusters=Get-cluster

foreach ($cluster in $clusters)
{
$cluster | get-vm | select @{N='Cluster';E={$cluster.Name}}, name , @{n="portgroup";e={($_|Get-VirtualPortGroup).name}},@{n="VLanID";e={($_|Get-VirtualPortGroup).VLanID}}
}