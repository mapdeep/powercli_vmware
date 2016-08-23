#DRS rules, vm & host groups export

Write-Host " This script will export the DRS rules & groups of a cluster to JSON"
$vcenter= Read-Host ("Enter Target Vcenter name ")
$cred= Get-Credential -Message "enter the credentials to login vcenter"
$cluster = (Read-Host "Enter Target Cluster name ")
#connect to vcenter with the specified credentials
Connect-VIServer $vcenter -Credential ($cred)

#retrive the specified cluster
$outputfile="C:\Temp\Report_"+$cluster+"_DRS_"+(Get-Date -Format yyyy-MMM-dd-HHmm) + ".json" 


#export the DRS rules and group info to JSON

Get-Cluster $cluster |Export-DrsRule -path $outputfile

if ($?)
{
Write-Host " please check output at :" $outputfile
}
else{Write-Host "please check the imput values and run again"}

Disconnect-VIServer $vcenter -Confirm:$false