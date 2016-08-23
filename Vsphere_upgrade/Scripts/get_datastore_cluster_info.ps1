# Get report of Datastore Cluster

$vcenter= Read-Host ("Enter Target Vcenter name ")
$cred= Get-Credential -Message "enter the credentials to login vcenter"
Connect-VIServer $vcenter -Credential $cred
$outputfile="C:\Temp\"+$vcenter+"_Datastore_Cluster_"+(Get-Date -Format yyyy-MMM-dd-HHmm) + ".csv" 


foreach($dsc in Get-DatastoreCluster){
  $dsc |Select @{N='DSC';E={$_.Name}},@{N='SdrsAutomationLevel';E={$_.SdrsAutomationLevel}},@{N='IOLoadBalanceEnabled';E={$_.IOLoadBalanceEnabled}},@{N='Datastores';E={( $_|Get-Datastore|select -ExpandProperty name) -join ","}}| Export-CSV -Path $outputfile -Append -NoTypeInformation -UseCulture
}

Disconnect-VIServer $vcenter -Confirm:$false