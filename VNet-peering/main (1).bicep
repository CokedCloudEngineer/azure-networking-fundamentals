param virtualMachines_vm1_name string = 'vm1'
param virtualMachines_vm2_name string = 'vm2'
param publicIPAddresses_vm1_ip_name string = 'vm1-ip'
param publicIPAddresses_vm2_ip_name string = 'vm2-ip'
param virtualNetworks_vm1_vnet_name string = 'vm1-vnet'
param virtualNetworks_vm2_vnet_name string = 'vm2-vnet'
param networkInterfaces_vm1301_z1_name string = 'vm1301_z1'
param networkInterfaces_vm2864_z1_name string = 'vm2864_z1'
param networkSecurityGroups_vm1_nsg_name string = 'vm1-nsg'
param networkSecurityGroups_vm2_nsg_name string = 'vm2-nsg'

resource networkSecurityGroups_vm1_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_vm1_nsg_name
  location: 'japaneast'
  properties: {
    securityRules: []
  }
}

resource networkSecurityGroups_vm2_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_vm2_nsg_name
  location: 'japaneast'
  properties: {
    securityRules: []
  }
}

resource publicIPAddresses_vm1_ip_name_resource 'Microsoft.Network/publicIPAddresses@2025-05-01' = {
  name: publicIPAddresses_vm1_ip_name
  location: 'japaneast'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
  ]
  properties: {
    ipAddress: '20.243.24.150'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource publicIPAddresses_vm2_ip_name_resource 'Microsoft.Network/publicIPAddresses@2025-05-01' = {
  name: publicIPAddresses_vm2_ip_name
  location: 'japaneast'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
  ]
  properties: {
    ipAddress: '40.115.216.135'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource virtualMachines_vm1_name_resource 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: virtualMachines_vm1_name
  location: 'japaneast'
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
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm1_name}_disk1_bb0d2166530a4b70a66f592ea2d9630e'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_vm1_name}_disk1_bb0d2166530a4b70a66f592ea2d9630e'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm1_name
      adminUsername: 'useradmin'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm1301_z1_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
  }
}

resource virtualMachines_vm2_name_resource 'Microsoft.Compute/virtualMachines@2025-04-01' = {
  name: virtualMachines_vm2_name
  location: 'japaneast'
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
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2025-datacenter-g2'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm2_name}_disk1_d09015c755b4403fbd2dd4cf7dab5ac7'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_vm2_name}_disk1_d09015c755b4403fbd2dd4cf7dab5ac7'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm2_name
      adminUsername: 'azureuser2'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm2864_z1_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
  }
}

resource virtualNetworks_vm1_vnet_name_resource 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: virtualNetworks_vm1_vnet_name
  location: 'japaneast'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'subnet1'
        id: virtualNetworks_vm1_vnet_name_subnet1.id
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'vnet2-to-vnet1'
        id: virtualNetworks_vm1_vnet_name_vnet2_to_vnet1.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vm2_vnet_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vm2_vnet_name_resource 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: virtualNetworks_vm2_vnet_name
  location: 'japaneast'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'subnet2'
        id: virtualNetworks_vm2_vnet_name_subnet2.id
        properties: {
          addressPrefix: '10.1.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'vnet2-vnet1'
        id: virtualNetworks_vm2_vnet_name_vnet2_vnet1.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vm1_vnet_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
        }
        type: 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings'
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vm1_vnet_name_subnet1 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_vm1_vnet_name}/subnet1'
  properties: {
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vm1_vnet_name_resource
  ]
}

resource virtualNetworks_vm2_vnet_name_subnet2 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_vm2_vnet_name}/subnet2'
  properties: {
    addressPrefix: '10.1.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vm2_vnet_name_resource
  ]
}

resource virtualNetworks_vm1_vnet_name_vnet2_to_vnet1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-05-01' = {
  name: '${virtualNetworks_vm1_vnet_name}/vnet2-to-vnet1'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vm2_vnet_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vm1_vnet_name_resource
  ]
}

resource virtualNetworks_vm2_vnet_name_vnet2_vnet1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-05-01' = {
  name: '${virtualNetworks_vm2_vnet_name}/vnet2-vnet1'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vm1_vnet_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vm2_vnet_name_resource
  ]
}

resource networkInterfaces_vm1301_z1_name_resource 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: networkInterfaces_vm1301_z1_name
  location: 'japaneast'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm1301_z1_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vm1_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_vm1_vnet_name_subnet1.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_vm1_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_vm2864_z1_name_resource 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: networkInterfaces_vm2864_z1_name
  location: 'japaneast'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm2864_z1_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.1.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vm2_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_vm2_vnet_name_subnet2.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_vm2_nsg_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
