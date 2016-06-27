# create a csv or txt file with name  "datastores.txt" with the header as datastore and the datastore names
#this script will unmount the datastores &detaches
$csv = Import-Csv c:\datastores.txt
foreach ($d in $csv)
{
#$d = read-host " datastore"

$d1 = Get-Datastore -name $d.datastore

			if (-not $d1) {
			Write-Host "No Datastore defined as input"
			Exit
		}
Foreach ($ds in $d1) {
			$hostviewDSDiskName = $ds.ExtensionData.Info.vmfs.extent[0].Diskname
			if ($ds.ExtensionData.Host) {
				$attachedHosts = $ds.ExtensionData.Host
				Foreach ($VMHost in $attachedHosts) {
					$hostview = Get-View $VMHost.Key
					$StorageSys = Get-View $HostView.ConfigManager.StorageSystem
					Write-Host "Unmounting VMFS Datastore $($DS.Name) from host $($hostview.Name)..."
					$StorageSys.UnmountVmfsVolume($DS.ExtensionData.Info.vmfs.uuid);
					$devices = $StorageSys.StorageDeviceInfo.ScsiLun
					Foreach ($device in $devices) {
						if ($device.canonicalName -eq $hostviewDSDiskName) {
					$LunUUID = $Device.Uuid
							Write-Host "Detaching LUN $($Device.CanonicalName) from host $($hostview.Name)..."
							$StorageSys.DetachScsiLun($LunUUID);
							}
							}
				}
			}
		}
	}
