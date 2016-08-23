#Import DRS rules, vm\host groups

Write-Host " This script will Import the DRS rules & vm/host groups from JSON"
$vcenter= Read-Host ("Enter Vcenter name ")
$cred= Get-Credential -Message "enter the credentials to login vcenter"

$importfile= Read-Host ("Specify the path of the JSON file to be imported")

#connect to vcenter with the specified credentials
Connect-VIServer $vcenter -Credential ($cred)

#import JSON

Import-DrsRule -Path $importfile

if ($?)
{
Write-Host " Import successfull "
}
else{Write-Host "please check if the cluster exisis"}

Disconnect-VIServer $vcenter -Confirm:$false