#Get report of the HA admission control

Get-Cluster -name hoprb7 | Sort-Object -Property Name | ForEach-Object {
  $Cluster = $_
  $Cluster | Select-Object -Property Name,HAEnabled,HAAdmissionControlEnabled,
  @{N="AdmissionControlPolicy";E={$_.ExtensionData.Configuration.Dasconfig.AdmissionControlPolicy.GetType().Name}}, @{N="FailoverLevel";E={$_.ExtensionData.Configuration.Dasconfig.AdmissionControlPolicy.FailoverLevel}},@{N="CpuFailoverResourcesPercent";E={$_.ExtensionData.Configuration.Dasconfig.AdmissionControlPolicy.CpuFailoverResourcesPercent}},@{N="MemoryFailoverResourcesPercent";E={$_.ExtensionData.Configuration.Dasconfig.AdmissionControlPolicy.MemoryFailoverResourcesPercent}}, DrsEnabled,DrsMode,DrsAutomationLevel 
  #| Export-CSV -Path "$($Cluster.Name).csv" -NoTypeInformation -UseCulture
}