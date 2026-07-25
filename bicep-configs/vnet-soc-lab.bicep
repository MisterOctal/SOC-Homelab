param virtualNetworks_vnet_soc_lab_name string = 'vnet-soc-lab'
param networkSecurityGroups_nsg_analysis_externalid string = '/subscriptions/CHANGE_SUBSCRIPTION_ID_HERE/resourceGroups/CHANGE_RESOURCE_GROUP_HERE/providers/Microsoft.Network/networkSecurityGroups/nsg-analysis'
param networkSecurityGroups_nsg_target_externalid string = '/subscriptions/CHANGE_SUBSCRIPTION_ID_HERE/resourceGroups/CHANGE_RESOURCE_GROUP_HERE/providers/Microsoft.Network/networkSecurityGroups/nsg-target'

resource virtualNetworks_vnet_soc_lab_name_resource 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: virtualNetworks_vnet_soc_lab_name
  location: 'malaysiawest'
  properties: {
    addressSpace: {
      addressPrefixes: [
        'CHANGE_IP_SUBNET_HERE'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'snet-analysis'
        id: virtualNetworks_vnet_soc_lab_name_snet_analysis.id
        properties: {
          addressPrefixes: [
            'CHANGE_IP_SUBNET_HERE'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_analysis_externalid
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'snet-target'
        id: virtualNetworks_vnet_soc_lab_name_snet_target.id
        properties: {
          addressPrefixes: [
            'CHANGE_IP_SUBNET_HERE'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_target_externalid
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_soc_lab_name_snet_analysis 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_soc_lab_name}/snet-analysis'
  properties: {
    addressPrefixes: [
      'CHANGE_IP_SUBNET_HERE'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_analysis_externalid
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_soc_lab_name_resource
  ]
}

resource virtualNetworks_vnet_soc_lab_name_snet_target 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_soc_lab_name}/snet-target'
  properties: {
    addressPrefixes: [
      'CHANGE_IP_SUBNET_HERE'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_target_externalid
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vnet_soc_lab_name_resource
  ]
}