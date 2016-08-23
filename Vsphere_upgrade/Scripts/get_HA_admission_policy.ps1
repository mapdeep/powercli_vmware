#Get report of the HA admission control

$vcenter= Read-Host ("Enter Target Vcenter name ")
$cred= Get-Credential -Message "enter the credentials to login vcenter"
Connect-VIServer $vcenter -Credential $cred
$outputfile="C:\Temp\"+$vcenter+"_HA_Admission_Policy_"+(Get-Date -Format yyyy-MMM-dd-HHmm) + ".csv" 

Get-Cluster| Sort-Object -Property Name | ForEach-Object {
  $_ | Select-Object -Property Name,HAEnabled,HAAdmissionControlEnabled,
  @{N="AdmissionControlPolicy";E={$_.ExtensionData.Configuration.Dasconfig.AdmissionControlPolicy.GetType().Name}}, @{N="FailoverLevel";E={$_.ExtensionData.Configuration.Dasconfig.AdmissionControlPolicy.FailoverLevel}},@{N="CpuFailoverResourcesPercent";E={$_.ExtensionData.Configuration.Dasconfig.AdmissionControlPolicy.CpuFailoverResourcesPercent}},@{N="MemoryFailoverResourcesPercent";E={$_.ExtensionData.Configuration.Dasconfig.AdmissionControlPolicy.MemoryFailoverResourcesPercent}}, DrsEnabled,DrsMode,DrsAutomationLevel | Export-CSV -Path $outputfile -Append -NoTypeInformation -UseCulture
}

Disconnect-VIServer $vcenter -Confirm:$false