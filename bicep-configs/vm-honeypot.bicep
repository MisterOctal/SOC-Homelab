@secure()
param extensions_enablevmAccess_username string

@secure()
param extensions_enablevmAccess_password string

@secure()
param extensions_enablevmAccess_ssh_key string

@secure()
param extensions_enablevmAccess_reset_ssh string

@secure()
param extensions_enablevmAccess_remove_user string

@secure()
param extensions_enablevmAccess_expiration string
param virtualMachines_vm_honeypot_name string = 'vm-honeypot'
param disks_vm_honeypot_OsDisk_1_CHANGE_DISK_HASH_HERE_externalid string = '/subscriptions/CHANGE_SUBSCRIPTION_ID_HERE/resourceGroups/CHANGE_RESOURCE_GROUP_HERE/providers/Microsoft.Compute/disks/vm-honeypot_OsDisk_1_CHANGE_DISK_HASH_HERE'
param networkInterfaces_vm_honeypot_CHANGE_NIC_ID_HERE_externalid string = '/subscriptions/CHANGE_SUBSCRIPTION_ID_HERE/resourceGroups/CHANGE_RESOURCE_GROUP_HERE/providers/Microsoft.Network/networkInterfaces/vm-honeypot_CHANGE_NIC_ID_HERE'

resource virtualMachines_vm_honeypot_name_resource 'Microsoft.Compute/virtualMachines@2025-11-01' = {
  name: virtualMachines_vm_honeypot_name
  location: 'malaysiawest'
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2als_v2'
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
        name: '${virtualMachines_vm_honeypot_name}_OsDisk_1_CHANGE_DISK_HASH_HERE'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: disks_vm_honeypot_OsDisk_1_CHANGE_DISK_HASH_HERE_externalid
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm_honeypot_name
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/labadmin/.ssh/authorized_keys'
              keyData: 'CHANGE_SSH_KEY_HERE'
            }
          ]
        }
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
          id: networkInterfaces_vm_honeypot_CHANGE_NIC_ID_HERE_externalid
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

resource virtualMachines_vm_honeypot_name_enablevmAccess 'Microsoft.Compute/virtualMachines/extensions@2025-11-01' = {
  parent: virtualMachines_vm_honeypot_name_resource
  name: 'enablevmAccess'
  location: 'malaysiawest'
  properties: {
    autoUpgradeMinorVersion: true
    publisher: 'Microsoft.OSTCExtensions'
    type: 'VMAccessForLinux'
    typeHandlerVersion: '1.5'
    settings: {}
    protectedSettings: {
      username: extensions_enablevmAccess_username
      password: extensions_enablevmAccess_password
      ssh_key: extensions_enablevmAccess_ssh_key
      reset_ssh: extensions_enablevmAccess_reset_ssh
      remove_user: extensions_enablevmAccess_remove_user
      expiration: extensions_enablevmAccess_expiration
    }
  }
}