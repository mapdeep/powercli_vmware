$Results = ForEach ($DRSRule in $DRSRules)
     {
    "" | Select-Object -Property @{N="Cluster";E={(Get-View -Id $DRSRule.Cluster.Id).Name}},
    @{N="Name";E={$DRSRule.Name}},
    @{N="Enabled";E={$DRSRule.Enabled}},
    @{N="DRS Type";E={$DRSRule.Type}}, 
    @{N="VMs";E={$VMIds=$DRSRule.VMIds -split "," 
      $VMs = ForEach ($VMId in $VMIds) 
        { 
        (Get-View -Id $VMId).Name
        } 
      $VMs -join ","}}
     }