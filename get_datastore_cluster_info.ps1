# Get report of Datastore Cluster
foreach($dsc in Get-DatastoreCluster){
  Get-Datastore -Location $dsc |
  Select @{N='DSC';E={$dsc.Name}},@{N='SdrsAutomationLevel';E={$dsc.SdrsAutomationLevel}},@{N='IOLoadBalanceEnabled';E={$dsc.IOLoadBalanceEnabled}},Name,CapacityGB,@{N='FreespaceGB';E={[math]::Round($_.FreespaceGB,2)}}
}
