param virtualMachines_vm_elk_analysis_name string = 'vm-elk-analysis'
param disks_vm_elk_analysis_OsDisk_1_CHANGE_DISK_HASH_HERE_externalid string = '/subscriptions/CHANGE_SUBSCRIPTION_ID_HERE/resourceGroups/CHANGE_RESOURCE_GROUP_HERE/providers/Microsoft.Compute/disks/vm-elk-analysis_OsDisk_1_CHANGE_DISK_HASH_HERE'
param networkInterfaces_vm_elk_analysis_CHANGE_NIC_ID_HERE_externalid string = '/subscriptions/CHANGE_SUBSCRIPTION_ID_HERE/resourceGroups/CHANGE_RESOURCE_GROUP_HERE/providers/Microsoft.Network/networkInterfaces/vm-elk-analysis_CHANGE_NIC_ID_HERE'

resource virtualMachines_vm_elk_analysis_name_resource 'Microsoft.Compute/virtualMachines@2025-11-01' = {
  name: virtualMachines_vm_elk_analysis_name
  location: 'malaysiawest'
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_vm_elk_analysis_name}_OsDisk_1_CHANGE_DISK_HASH_HERE'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          id: disks_vm_elk_analysis_OsDisk_1_CHANGE_DISK_HASH_HERE_externalid
        }
        deleteOption: 'Delete'
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm_elk_analysis_name
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
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
          id: networkInterfaces_vm_elk_analysis_CHANGE_NIC_ID_HERE_externalid
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