#Get the report of the DVswitch

$dcs= get-datacenter
foreach($dc in $dcs)
{
$dc| Get-VDSwitch| select @{n="datacenter";e={$dc.name}},name,mtu,version,@{n="portgroups";e={($_|get-vdportgroup).name}}
}