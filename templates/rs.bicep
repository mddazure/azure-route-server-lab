param location string

param Branch1v4AddressRange string
param Branch1VMSubnetv4AddressRange string
param Branch1GatewaySubnetv4AddressRange string
param Branch1AzureBastionSubnetv4AddressRange string
param Branch1GWASN int

param Branch2v4AddressRange string
param Branch2VMSubnetv4AddressRange string
param Branch2GatewaySubnetv4AddressRange string
param Branch2AzureBastionSubnetv4AddressRange string
param Branch2GWASN int

param Spoke1v4AddressRange string
param Spoke1VMSubnetv4AddressRange string

param Hubv4AddressRange string
param HubRouteServerSubnetv4AddressRange string
param HubVMSubnetv4AddressRange string
param HubCSRSubnetv4AddressRange string
param HubGatewaySubnetv4AddressRange string
param HubSubnetBastionRange string
param HubCSRLoopbackIPv4 string
param HubCSRPrivateIPv4 string
param HubCSRASN int
param HubGWASN int

param storagePrefix string

param tunnelKey string 

param adminUsername string

param adminPassword string 

//public IP prefixes
resource prefixIpV4 'Microsoft.Network/publicIPPrefixes@2020-11-01' = {
  name: 'prefixIpV4'
  location: location
  sku:{
    name: 'Standard'
    tier: 'Regional'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties: {
    prefixLength: 28
    publicIPAddressVersion: 'IPv4'
  }
}
// public IPs from prefixes
resource csrPubIpV4 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'csrPubIpV4'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource HubBastionPubIpV4 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'HubBastionPubIpV4'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource Branch1BastionPubIpV4 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Branch1BastionPubIpV4'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource Branch2BastionPubIpV4 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Branch2BastionPubIpV4'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource HubVPNGWPubIpV41 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'HubVPNGWPubIpV41'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource HubVPNGWPubIpV42 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'HubVPNGWPubIpV42'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource Branch1VPNGWPubIpV41 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Branch1VPNGWPubIpV41'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource Branch1VPNGWPubIpV42 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Branch1VPNGWPubIpV42'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource Branch2VPNGWPubIpV41 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Branch2VPNGWPubIpV41'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource Branch2VPNGWPubIpV42 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Branch2VPNGWPubIpV42'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource RouteServerPubIPV4 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'RouteServerPubIPV4'
  location: location
  sku:{
    name: 'Standard'
  }
  zones:[
    '1'
    '2'
    '3'
  ]
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
// VNETs
resource Hub 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'Hub'
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        Hubv4AddressRange       
      ]
    }
    subnets:[
      {
      name: 'VMSubnet'
      properties:{
        addressPrefix:  HubVMSubnetv4AddressRange
        networkSecurityGroup: {
          id: nsg.id
        }
        
      }
    }     
    {
      name: 'GatewaySubnet'
      properties:{
        addressPrefix: HubGatewaySubnetv4AddressRange
      }
    }
    {
      name: 'RouteServerSubnet'
      properties:{
        addressPrefix: HubRouteServerSubnetv4AddressRange
      }
    }
    {
      name: 'AzureBastionSubnet'
      properties:{
        addressPrefix: HubSubnetBastionRange
      }
    }
    {
      name: 'CSRsubnet'
      properties:{
        addressPrefix: HubCSRSubnetv4AddressRange
        networkSecurityGroup: {
          id: nsg.id
        }
      }
    }
  
    ]
  }
}
resource Branch1 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'Branch1'
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        Branch1v4AddressRange
       
      ]
    }
    subnets:[
      {
      name: 'VMSubnet'
      properties:{
        addressPrefix: Branch1VMSubnetv4AddressRange
        networkSecurityGroup: {
          id: nsg.id
          }
        }
      }
      {
        name: 'GatewaySubnet'
        properties:{
          addressPrefix: Branch1GatewaySubnetv4AddressRange
        }
      } 
      {
        name: 'AzureBastionSubnet'
        properties:{
          addressPrefix: Branch1AzureBastionSubnetv4AddressRange
        }
      } 
    ]      
  } 
}
resource Branch2 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'Branch2'
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        Branch2v4AddressRange
       
      ]
    }
    subnets:[
      {
      name: 'VMSubnet'
      properties:{
        addressPrefix: Branch2VMSubnetv4AddressRange
        networkSecurityGroup: {
          id: nsg.id
          }
        }
      }
      {
        name: 'GatewaySubnet'
        properties:{
          addressPrefix: Branch2GatewaySubnetv4AddressRange
        }
      } 
      {
        name: 'AzureBastionSubnet'
        properties:{
          addressPrefix: Branch2AzureBastionSubnetv4AddressRange
        }
      } 
    ]      
  } 
}
resource Spoke1 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'Spoke1'
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        Spoke1v4AddressRange
       
      ]
    }
    subnets:[
      {
      name: 'VMSubnet'
      properties:{
        addressPrefix: Spoke1VMSubnetv4AddressRange
        networkSecurityGroup: {
          id: nsg.id
          }
        }
      } 
    ]      
  } 
}
//NSG
resource nsg 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: 'nsg'
  location: location
  properties:{
    securityRules: [
      {
        name: 'allow80in'
        properties:{
          priority: 150
          direction: 'Inbound'
          protocol: 'Tcp'
          access: 'Allow'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '80'
          }
      }
      {
        name: 'allowRDPin'
        properties:{
          priority: 110
          direction: 'Inbound'
          protocol: 'Tcp'
          access: 'Allow'
          sourceAddressPrefix: '217.122.185.32'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '3389'
         }
        }
        {
         name: 'allowSSHin'
         properties:{
         priority: 120
         direction: 'Inbound'
         protocol: 'Tcp'
         access: 'Allow'
         sourceAddressPrefix: '217.122.185.32'
         sourcePortRange: '*'
         destinationAddressPrefix: '*'
         destinationPortRange: '22'
         }
      }
    ]
  }
}
//Bastion - remove comments to deploy Bastion, takes a while
resource hubBastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: 'HubBastion'
  dependsOn:[
    Hub
  ]
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConf'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','Hub','AzureBastionSubnet')
          } 
          publicIPAddress: {
            id: HubBastionPubIpV4.id
          }
        }
      }
    ]
  }
}
resource Branch1Bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: 'Branch1Bastion'
  dependsOn:[
    Branch1
  ]
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConf'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','Branch1','AzureBastionSubnet')
          } 
          publicIPAddress: {
            id: Branch1BastionPubIpV4.id
          }
        }
      }
    ]
  }
}
resource Branch2Bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: 'Branch2Bastion'
  dependsOn:[
    Branch2
  ]
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConf'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','Branch2','AzureBastionSubnet')
          } 
          publicIPAddress: {
            id: Branch2BastionPubIpV4.id
          }
        }
      }
    ]
  }
}
//PEERINGS
resource spoke1hub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = {
  name: 'spoke1-hub'
  dependsOn:[
    Hub
    Spoke1
    HubVPNGW
  ]
  parent: Spoke1
  properties:{
    remoteVirtualNetwork:{
      id:Hub.id
    }
    allowForwardedTraffic: true
    allowVirtualNetworkAccess: true
    useRemoteGateways: true
  }
}
resource hubspoke1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = {
  name: 'hub-spoke1'
  dependsOn:[
    Hub
    Spoke1
    HubVPNGW
  ]
  parent: Hub
  properties:{
    remoteVirtualNetwork:{
      id:Spoke1.id
    }
    allowForwardedTraffic: true
    allowVirtualNetworkAccess: true
    allowGatewayTransit: true
  }
}
//RouteServer
resource RouteServer 'Microsoft.Network/virtualHubs@2021-02-01' = {
  name: 'RouteServer'
  dependsOn: [
    HubVPNGW
    RouteServerPubIPV4
  ]
  location: location
  properties: {
    sku: 'Standard'
    allowBranchToBranchTraffic: true
  }
}
resource rsIpConfig 'Microsoft.Network/virtualHubs/ipConfigurations@2021-02-01' ={
  name: 'RouteServer/rsIpConfig'
  dependsOn:[
    RouteServer
    Hub
  ] 
  properties:{
    subnet:{
      id: resourceId('Microsoft.Network/virtualNetworks/subnets','Hub','RouteServerSubnet')
    }
    publicIPAddress: {
      id: resourceId('Microsoft.Network/publicIPAddresses','RouteServerPubIPV4')
    }
  }
}
resource rsBgpConn 'Microsoft.Network/virtualHubs/bgpConnections@2021-02-01' = {
  name: 'RouteServer/rsBgpConn'
  dependsOn:[
    rsIpConfig
  ]
  properties: {
    peerAsn: HubCSRASN
    peerIp: HubCSRPrivateIPv4
  }
}
//Storage account for boot diagnostics
resource bootst 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: '${storagePrefix}${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  resource blob 'blobServices@2021-04-01' = {
    name: 'default'
  }
}
//VMs
module csr 'csr.bicep' = {
  name: 'csr'
  dependsOn:[
    Hub
  ]
  params:{
    vmName: 'csr'
    adminPw: adminPassword
    adminUser: adminUsername
    location: location
    subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets','Hub','CSRsubnet')
    pubIpv4Id: csrPubIpV4.id
    privateIPv4: HubCSRPrivateIPv4
    bootstUri: bootst.properties.primaryEndpoints.blob
  }
}

module HubVM 'vm.bicep' = {
  name: 'HubVM'
  dependsOn:[
    Hub
  ]
  params:{
    vmName:'HubVM'
    adminPw:adminPassword
    adminUser:adminUsername
    location:location
    subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets','Hub','VMSubnet')
  }
}
module Branch1VM 'vm.bicep' = {
  name: 'Branch1VM'
  dependsOn:[
    Branch1
  ]
  params:{
    vmName:'Branch1VM'
    adminPw:adminPassword
    adminUser:adminUsername
    location:location
    subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets','Branch1','VMSubnet')
  }
}
module Branch2VM 'vm.bicep' = {
  name: 'Branch2VM'
  dependsOn:[
    Branch2
  ]
  params:{
    vmName:'Branch2VM'
    adminPw:adminPassword
    adminUser:adminUsername
    location:location
    subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets','Branch2','VMSubnet')
  }
}
module Spoke1VM 'vm.bicep' = {
  name: 'Spoke1VM'
  dependsOn:[
    Spoke1
  ]
  params:{
    vmName:'Spoke1VM'
    adminPw:adminPassword
    adminUser:adminUsername
    location:location
    subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets','Spoke1','VMSubnet')
  }
}
//VPN Gateways
resource HubVPNGW 'Microsoft.Network/virtualNetworkGateways@2021-02-01'= {
  name: 'HubVPNGW'
  location: location
  dependsOn:[
    Hub
  ]
  properties:{
    ipConfigurations: [
      {
      name: 'ipconfig1'
      properties: {
        privateIPAllocationMethod: 'Dynamic'
        subnet: {
          id: resourceId('Microsoft.Network/virtualNetworks/subnets','Hub','GatewaySubnet')
          }
        publicIPAddress: {
          id: HubVPNGWPubIpV41.id
          }
        }
      }
      {
        name: 'ipconfig2'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','Hub','GatewaySubnet')
            }
          publicIPAddress: {
            id: HubVPNGWPubIpV42.id
            }
          }
        }
    ]
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    enableBgp: true
    bgpSettings:{
      asn: HubGWASN
    }
    enablePrivateIpAddress: false
    activeActive: true
    gatewayDefaultSite: null
    sku:{
      name: 'VpnGw1AZ'
      tier: 'VpnGw1AZ'
    }
  }
}
resource Branch1VPNGW 'Microsoft.Network/virtualNetworkGateways@2021-02-01'= {
  name: 'Branch1VPNGW'
  location: location
  dependsOn:[
    Branch1
  ]
  properties:{
    ipConfigurations: [
      {
      name: 'ipconfig1'
      properties: {
        privateIPAllocationMethod: 'Dynamic'
        subnet: {
          id: resourceId('Microsoft.Network/virtualNetworks/subnets','Branch1','GatewaySubnet')
          }
        publicIPAddress: {
          id: Branch1VPNGWPubIpV41.id
          }
        }
      }
      {
        name: 'ipconfig2'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','Branch1','GatewaySubnet')
            }
          publicIPAddress: {
            id: Branch1VPNGWPubIpV42.id
            }
          }
        }
    ]
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    enableBgp: true
    bgpSettings:{
      asn: Branch1GWASN
    }
    enablePrivateIpAddress: false
    activeActive: true
    gatewayDefaultSite: null
    sku:{
      name: 'VpnGw1AZ'
      tier: 'VpnGw1AZ'
    }
  }
}
resource Branch2VPNGW 'Microsoft.Network/virtualNetworkGateways@2021-02-01'= {
  name: 'Branch2VPNGW'
  location: location
  dependsOn:[
    Branch2
  ]
  properties:{
    ipConfigurations: [
      {
      name: 'ipconfig1'
      properties: {
        privateIPAllocationMethod: 'Dynamic'
        subnet: {
          id: resourceId('Microsoft.Network/virtualNetworks/subnets','Branch2','GatewaySubnet')
          }
        publicIPAddress: {
          id: Branch2VPNGWPubIpV41.id
          }
        }
      }
      {
        name: 'ipconfig2'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','Branch2','GatewaySubnet')
            }
          publicIPAddress: {
            id: Branch2VPNGWPubIpV42.id
            }
          }
        }
    ]
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    enableBgp: true
    bgpSettings:{
      asn: Branch2GWASN
    }
    enablePrivateIpAddress: false
    activeActive: true
    gatewayDefaultSite: null
    sku:{
      name: 'VpnGw1AZ'
      tier: 'VpnGw1AZ'
    }
  }
}
//Local Network Gateway
resource lngCSR 'Microsoft.Network/localNetworkGateways@2021-02-01' = {
  name: 'lngCSR'
  location: location
  dependsOn:[
    csrPubIpV4
  ]
  properties:{
    gatewayIpAddress: csrPubIpV4.properties.ipAddress
    localNetworkAddressSpace: {
      addressPrefixes:[
        '${HubCSRLoopbackIPv4}/32'
      ]
    }
    bgpSettings:{
      asn: HubCSRASN
      bgpPeeringAddress: HubCSRLoopbackIPv4
    }
  }
}
//Connections
resource connectionS2HubGW 'Microsoft.Network/connections@2021-02-01' = {
  name: 'connectionS2HubGW'
  location: location
  dependsOn:[
    HubVPNGW
    Branch2VPNGW
  ]
  properties:{
    virtualNetworkGateway1:{
      properties:{}
      id: HubVPNGW.id
    }
    virtualNetworkGateway2:{
      properties:{}
      id:Branch2VPNGW.id
    }
    connectionType: 'Vnet2Vnet'
    enableBgp: true
    sharedKey: tunnelKey
  }
} 
resource connectionHubS2GW 'Microsoft.Network/connections@2021-02-01' = {
  name: 'connectionHubS2GW'
  location: location
  dependsOn:[
    HubVPNGW
    Branch2VPNGW
  ]
  properties:{
    virtualNetworkGateway1:{
      properties:{}
      id:Branch2VPNGW.id
    }
    virtualNetworkGateway2:{
      properties:{}
      id: HubVPNGW.id
    }
    connectionType: 'Vnet2Vnet'
    enableBgp: true
    sharedKey: tunnelKey
  }
}
resource connectionS1HubCSR 'Microsoft.Network/connections@2021-02-01' = {
  name: 'connectionS1HubCSR'
  location: location
  dependsOn: [
    Branch1VPNGW
    csr
  ]
  properties:{
    virtualNetworkGateway1:{
      properties:{}
      id:Branch1VPNGW.id
    }
    localNetworkGateway2:{
      properties:{}
      id:lngCSR.id
    }
    connectionType: 'IPsec'
    sharedKey:tunnelKey
    enableBgp: true
  }
}
//outputs
output Branch1VPNGWPubIpV41 string = Branch1VPNGWPubIpV41.properties.ipAddress
output Branch1VPNGWPubIpV42 string = Branch1VPNGWPubIpV42.properties.ipAddress
output csrPubIpV4 string = csrPubIpV4.properties.ipAddress
output HubCSRPrivateIPv4 string = HubCSRPrivateIPv4
output  HubCSRASN int = HubCSRASN
output  HubGWASN int = HubGWASN
output  Branch1GWASN int = Branch1GWASN
output  Branch2GWASN int = Branch2GWASN
