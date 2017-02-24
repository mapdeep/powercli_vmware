Write-Host " "
do {
 $TempDir = [System.IO.Path]::GetTempPath()
  [int]$userMenuChoice = 0
  while ( $userMenuChoice -lt 1 -or $userMenuChoice -gt 11) {
    Write-Host "Select the Action Below"
    Write-Host
    Write-Host "1. Connect UCS "
    Write-Host "2. Get UCS Status "
    Write-Host "3. List service Profile "
	Write-Host "4. List UCS Blades "
	Write-Host "5. Launch KVM Session "
	Write-Host "6. Launch GUI Session "
	Write-Host "7. List UCS faults "
	Write-Host "9. ADD Vlan"
	Write-Host "10. Disconnect UCS "
    #Write-Host "10. Quit and Exit"
	#Write-Host "10. Quit and Exit"
	#test git
	Write-Host

    [int]$userMenuChoice = Read-Host "Please choose an option"

    switch ($userMenuChoice) {
      1{
		$ucsdom = read-host " Enter user Domain"
		$cred = Get-Credential "ucs-AD\adm_"
		Connect-Ucs $ucsdom -Credential $cred
		}
      	  
	  2{ Get-UcsStatus }
	  3{Get-UcsServiceProfile -Type instance | select name,PnDn,operstate,HostFwPolicyName | ft -auto | Out-String }
	  4{get-ucsblade | ft -Property Model, ServerId, Operability,Availability, OperPower, AssignedToDn -auto |Out-String}
	  5{$blade = read-host "Enter the blade PnDn (eg 1/3) :"   
	     Start-UcsKvmSession -Blade $blade }
	  6{Start-UcsGuiSession}
	  7{Get-UcsFault | Where { $_.Severity -ne "cleared" } | Select-Object Dn, Severity, Descr, Created | Sort Created -Descending |ft -auto |Out-File  -width 350 $TempDir\Faults_out.txt;Invoke-Item $TempDir\Faults_out.txt }
	   9{$vname = read-host " Vlan Name"
		 $vid   = read-host " Vlan ID"
	     Get-UcsLanCloud | Add-UcsVlan -Name $vname -Id $vid
	    }
      10{
		Disconnect-Ucs
		exit
		}
      default {Write-Host "Nothing selected"}
    }
  }
} while ( $userMenuChoice -ne 11 )

#Get-UcsFault | Where { $_.Severity -ne "cleared" } | Select-Object Dn, Severity, Descr, Created | Sort Created -Descending |ft -auto |Out-File  -width 350 $TempDir\Faults_out.txt;Invoke-Item $TempDir\Faults_out.txt

# TempDir = [System.IO.Path]::GetTempPath()
# {Backup-Ucs -Ucs $UcsConnection -Type $Type -PathPattern ($BackupFolder + '\${ucs}-${yyyy}${MM}${dd}-${HH}${mm}' + "-$Type.xml")
<#
Process-Backup full-state
			Process-Backup config-logical 
			Process-Backup config-system
			Process-Backup config-all
			
			#>
#ConvertTo-HTML -Head "<style type='text/css'>BODY{background-color:#f0f0f0;}TH,TD{border-width: 1px;padding: 10px;border-style: solid;border-color: black;border-collapse: collapse;}</style>" 

