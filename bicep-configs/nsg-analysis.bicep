param networkSecurityGroups_nsg_analysis_name string = 'nsg-analysis'

resource networkSecurityGroups_nsg_analysis_name_resource 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: networkSecurityGroups_nsg_analysis_name
  location: 'malaysiawest'
  properties: {
    securityRules: [
      {
        name: 'Admin-Access'
        id: networkSecurityGroups_nsg_analysis_name_Admin_Access.id
        properties: {
          description: 'This rule allows the lab administrator to access resources inside this subnet'
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
        name: 'Honeypot-Log-Ingestion'
        id: networkSecurityGroups_nsg_analysis_name_Honeypot_Log_Ingestion.id
        properties: {
          description: 'Allows the honeypot to send data to logstash beat port.'
          protocol: 'TCP'
          sourcePortRange: '*'
          sourceAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '5044'
            '9200'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_nsg_analysis_name_Admin_Access 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_analysis_name}/Admin-Access'
  properties: {
    description: 'This rule allows the lab administrator to access resources inside this subnet'
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
    networkSecurityGroups_nsg_analysis_name_resource
  ]
}

resource networkSecurityGroups_nsg_analysis_name_Honeypot_Log_Ingestion 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_analysis_name}/Honeypot-Log-Ingestion'
  properties: {
    description: 'Allows the honeypot to send data to logstash beat port.'
    protocol: 'TCP'
    sourcePortRange: '*'
    sourceAddressPrefix: 'CHANGE_IP_SUBNET_HERE'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '5044'
      '9200'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_analysis_name_resource
  ]
}