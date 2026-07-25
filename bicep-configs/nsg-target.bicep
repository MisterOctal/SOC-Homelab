param networkSecurityGroups_nsg_target_name string = 'nsg-target'

resource networkSecurityGroups_nsg_target_name_resource 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: networkSecurityGroups_nsg_target_name
  location: 'malaysiawest'
  properties: {
    securityRules: [
      {
        name: 'Admin-Access'
        id: networkSecurityGroups_nsg_target_name_Admin_Allow_Access.id
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'CHANGE_IP_ADDRESS_HERE'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'AllowLogstashElasticsearch'
        id: networkSecurityGroups_nsg_target_name_AllowLogstashElasticsearch.id
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
          destinationAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
          access: 'Allow'
          priority: 100
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '5044'
            '9200'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'HoneypotOutboundSecurity'
        id: networkSecurityGroups_nsg_target_name_HoneypotOutboundSecurity.id
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Deny'
          priority: 110
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Honeypots'
        id: networkSecurityGroups_nsg_target_name_Honeypots.id
        properties: {
          description: 'Expose honeypot bait ports to internet'
          protocol: 'TCP'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '22'
            '23'
            '3389'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Uptime-Kuma-ICMP'
        id: networkSecurityGroups_nsg_target_name_Uptime_Kuma_ICMP.id
        properties: {
          protocol: 'ICMP'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 130
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_nsg_target_name_Admin_Allow_Access 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_target_name}/Admin-Allow-Access'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: 'CHANGE_IP_ADDRESS_HERE'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_target_name_resource
  ]
}

resource networkSecurityGroups_nsg_target_name_AllowLogstashElasticsearch 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_target_name}/AllowLogstashElasticsearch'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    sourceAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
    destinationAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
    access: 'Allow'
    priority: 100
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '5044'
      '9200'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_target_name_resource
  ]
}

resource networkSecurityGroups_nsg_target_name_HoneypotOutboundSecurity 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_target_name}/HoneypotOutboundSecurity'
  properties: {
    protocol: '*'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Deny'
    priority: 110
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_target_name_resource
  ]
}

resource networkSecurityGroups_nsg_target_name_Honeypots 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_target_name}/Honeypots'
  properties: {
    description: 'Expose honeypot bait ports to internet'
    protocol: 'TCP'
    sourcePortRange: '*'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
    access: 'Allow'
    priority: 120
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '22'
      '23'
      '3389'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_target_name_resource
  ]
}

resource networkSecurityGroups_nsg_target_name_Uptime_Kuma_ICMP 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_target_name}/Uptime-Kuma-ICMP'
  properties: {
    protocol: 'ICMP'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 130
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_target_name_resource
  ]
}