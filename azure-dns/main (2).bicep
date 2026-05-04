param networkInterfaces_webNic1_name string = 'webNic1'
param networkInterfaces_webNic2_name string = 'webNic2'
param loadBalancers_myLoadBalancer_name string = 'myLoadBalancer'
param publicIPAddresses_myPublicIP_name string = 'myPublicIP'
param virtualNetworks_bePortalVnet_name string = 'bePortalVnet'
param dnszones_wideworldimports6767_com_name string = 'wideworldimports6767.com'
param networkSecurityGroups_bePortalNSG_name string = 'bePortalNSG'
param availabilitySets_portalAvailabilitySet_name string = 'portalAvailabilitySet'

resource availabilitySets_portalAvailabilitySet_name_resource 'Microsoft.Compute/availabilitySets@2025-04-01' = {
  name: availabilitySets_portalAvailabilitySet_name
  location: 'japaneast'
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformUpdateDomainCount: 5
    platformFaultDomainCount: 2
    virtualMachines: []
  }
}

resource dnszones_wideworldimports6767_com_name_resource 'Microsoft.Network/dnszones@2023-07-01-preview' = {
  name: dnszones_wideworldimports6767_com_name
  location: 'global'
  properties: {
    zoneType: 'Public'
  }
}

resource networkSecurityGroups_bePortalNSG_name_resource 'Microsoft.Network/networkSecurityGroups@2025-05-01' = {
  name: networkSecurityGroups_bePortalNSG_name
  location: 'japaneast'
  properties: {
    securityRules: [
      {
        name: 'AllowAll80'
        id: networkSecurityGroups_bePortalNSG_name_AllowAll80.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          description: 'Allow all port 80 traffic'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 101
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

resource publicIPAddresses_myPublicIP_name_resource 'Microsoft.Network/publicIPAddresses@2025-05-01' = {
  name: publicIPAddresses_myPublicIP_name
  location: 'japaneast'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '104.46.217.136'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource virtualNetworks_bePortalVnet_name_resource 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: virtualNetworks_bePortalVnet_name
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
        name: 'bePortalSubnet'
        id: virtualNetworks_bePortalVnet_name_bePortalSubnet.id
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource dnszones_wideworldimports6767_com_name_www 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dnszones_wideworldimports6767_com_name_resource
  name: 'www'
  properties: {
    TTL: 3600
    ARecords: [
      {
        ipv4Address: '10.10.10.10'
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource Microsoft_Network_dnszones_NS_dnszones_wideworldimports6767_com_name 'Microsoft.Network/dnszones/NS@2023-07-01-preview' = {
  parent: dnszones_wideworldimports6767_com_name_resource
  name: '@'
  properties: {
    TTL: 172800
    NSRecords: [
      {
        nsdname: 'ns1-09.azure-dns.com.'
      }
      {
        nsdname: 'ns2-09.azure-dns.net.'
      }
      {
        nsdname: 'ns3-09.azure-dns.org.'
      }
      {
        nsdname: 'ns4-09.azure-dns.info.'
      }
    ]
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource Microsoft_Network_dnszones_SOA_dnszones_wideworldimports6767_com_name 'Microsoft.Network/dnszones/SOA@2023-07-01-preview' = {
  parent: dnszones_wideworldimports6767_com_name_resource
  name: '@'
  properties: {
    TTL: 3600
    SOARecord: {
      email: 'azuredns-hostmaster.microsoft.com'
      expireTime: 2419200
      host: 'ns1-09.azure-dns.com.'
      minimumTTL: 300
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
    targetResource: {}
    trafficManagementProfile: {}
  }
}

resource loadBalancers_myLoadBalancer_name_resource 'Microsoft.Network/loadBalancers@2025-05-01' = {
  name: loadBalancers_myLoadBalancer_name
  location: 'japaneast'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: 'myFrontEndPool'
        id: '${loadBalancers_myLoadBalancer_name_resource.id}/frontendIPConfigurations/myFrontEndPool'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_myPublicIP_name_resource.id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'myBackEndPool'
        id: loadBalancers_myLoadBalancer_name_myBackEndPool.id
        properties: {
          loadBalancerBackendAddresses: [
            {
              name: 'VNetLab_webNic1ipconfig1'
              properties: {}
            }
            {
              name: 'VNetLab_webNic2ipconfig1'
              properties: {}
            }
          ]
        }
      }
    ]
    loadBalancingRules: [
      {
        name: 'myHTTPRule'
        id: '${loadBalancers_myLoadBalancer_name_resource.id}/loadBalancingRules/myHTTPRule'
        properties: {
          frontendIPConfiguration: {
            id: '${loadBalancers_myLoadBalancer_name_resource.id}/frontendIPConfigurations/myFrontEndPool'
          }
          frontendPort: 80
          backendPort: 80
          enableFloatingIP: false
          idleTimeoutInMinutes: 4
          protocol: 'Tcp'
          enableTcpReset: false
          loadDistribution: 'Default'
          disableOutboundSnat: false
          enableConnectionTracking: false
          backendAddressPool: {
            id: loadBalancers_myLoadBalancer_name_myBackEndPool.id
          }
          backendAddressPools: [
            {
              id: loadBalancers_myLoadBalancer_name_myBackEndPool.id
            }
          ]
        }
      }
    ]
    probes: [
      {
        name: 'myHealthProbe'
        id: '${loadBalancers_myLoadBalancer_name_resource.id}/probes/myHealthProbe'
        properties: {
          protocol: 'Tcp'
          port: 80
          intervalInSeconds: 15
          numberOfProbes: 2
          probeThreshold: 1
          noHealthyBackendsBehavior: 'AllProbedDown'
        }
      }
    ]
    inboundNatRules: []
    outboundRules: []
    inboundNatPools: []
  }
}

resource loadBalancers_myLoadBalancer_name_myBackEndPool 'Microsoft.Network/loadBalancers/backendAddressPools@2025-05-01' = {
  name: '${loadBalancers_myLoadBalancer_name}/myBackEndPool'
  properties: {
    loadBalancerBackendAddresses: [
      {
        name: 'VNetLab_webNic1ipconfig1'
        properties: {}
      }
      {
        name: 'VNetLab_webNic2ipconfig1'
        properties: {}
      }
    ]
  }
  dependsOn: [
    loadBalancers_myLoadBalancer_name_resource
  ]
}

resource networkSecurityGroups_bePortalNSG_name_AllowAll80 'Microsoft.Network/networkSecurityGroups/securityRules@2025-05-01' = {
  name: '${networkSecurityGroups_bePortalNSG_name}/AllowAll80'
  properties: {
    description: 'Allow all port 80 traffic'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: 'Internet'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 101
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_bePortalNSG_name_resource
  ]
}

resource virtualNetworks_bePortalVnet_name_bePortalSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_bePortalVnet_name}/bePortalSubnet'
  properties: {
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_bePortalVnet_name_resource
  ]
}

resource Microsoft_Network_dnszones_A_dnszones_wideworldimports6767_com_name 'Microsoft.Network/dnszones/A@2023-07-01-preview' = {
  parent: dnszones_wideworldimports6767_com_name_resource
  name: '@'
  properties: {
    TTL: 3600
    targetResource: {
      id: publicIPAddresses_myPublicIP_name_resource.id
    }
    trafficManagementProfile: {}
  }
}

resource networkInterfaces_webNic1_name_resource 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: networkInterfaces_webNic1_name
  location: 'japaneast'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_webNic1_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_bePortalVnet_name_bePortalSubnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          loadBalancerBackendAddressPools: [
            {
              id: loadBalancers_myLoadBalancer_name_myBackEndPool.id
            }
          ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_bePortalNSG_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_webNic2_name_resource 'Microsoft.Network/networkInterfaces@2025-05-01' = {
  name: networkInterfaces_webNic2_name
  location: 'japaneast'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_webNic2_name_resource.id}/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.5'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_bePortalVnet_name_bePortalSubnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          loadBalancerBackendAddressPools: [
            {
              id: loadBalancers_myLoadBalancer_name_myBackEndPool.id
            }
          ]
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_bePortalNSG_name_resource.id
    }
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}
