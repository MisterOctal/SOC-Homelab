param virtualMachines_vm_windows_honeypot_name string = 'vm-windows-honeypot'
param disks_vm_windows_honeypot_OsDisk_1_CHANGE_DISK_HASH_HERE_externalid string = '/subscriptions/CHANGE_SUBSCRIPTION_ID_HERE/resourceGroups/CHANGE_RESOURCE_GROUP_HERE/providers/Microsoft.Compute/disks/vm-windows-honeypot_OsDisk_1_CHANGE_DISK_HASH_HERE'
param networkInterfaces_vm_windows_honeypot_CHANGE_NIC_ID_HERE_externalid string = '/subscriptions/CHANGE_SUBSCRIPTION_ID_HERE/resourceGroups/CHANGE_RESOURCE_GROUP_HERE/providers/Microsoft.Network/networkInterfaces/vm-windows-honeypot_CHANGE_NIC_ID_HERE'

resource virtualMachines_vm_windows_honeypot_name_resource 'Microsoft.Compute/virtualMachines@2025-11-01' = {
  name: virtualMachines_vm_windows_honeypot_name
  location: 'malaysiawest'
  zones: [
    '1'
  ]
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_windows_honeypot_name}_OsDisk_1_CHANGE_DISK_HASH_HERE'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: disks_vm_windows_honeypot_OsDisk_1_CHANGE_DISK_HASH_HERE_externalid
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'vm-windows-hone'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByPlatform'
          automaticByPlatformSettings: {
            rebootSetting: 'IfRequired'
          }
          assessmentMode: 'ImageDefault'
          enableHotpatching: true
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
      adminUsername: 'labadmin'
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_windows_honeypot_CHANGE_NIC_ID_HERE_externalid
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}