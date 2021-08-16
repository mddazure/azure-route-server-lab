param location string = 'westeurope'

param Spoke1v4AddressRange string = '10.1.0.0/16'
param Spoke1VMSubnetv4AddressRange string = '10.1.0.0/24'
param Spoke1GatewaySubnetv4AddressRange string = '10.1.254.0/24'
param Spoke1AzureBastionSubnetv4AddressRange string = '10.1.255.0/24'
param Spoke1GWASN int = 100

param Spoke2v4AddressRange string = '10.2.0.0/16'
param Spoke2VMSubnetv4AddressRange string = '10.2.0.0/24'
param Spoke2GatewaySubnetv4AddressRange string = '10.2.254.0/24'
param Spoke2AzureBastionSubnetv4AddressRange string = '10.2.255.0/24'
param Spoke2GWASN int = 200

param Hubv4AddressRange string = '10.0.0.0/16'
param HubRouteServerSubnetv4AddressRange string = '10.0.0.0/24'
param HubVMSubnetv4AddressRange string = '10.0.1.0/24'
param HubCSRSubnetv4AddressRange string = '10.0.253.0/24'
param HubGatewaySubnetv4AddressRange string = '10.0.254.0/24'
param HubsubnetBastionRange string = '10.0.255.0/24'
param HubCSRPrivateIPv4 string = '10.0.253.4'
param HubCSRASN int = 64000
param HubGWASN int = 300

@secure()
param tunnelKey string = 'Routeserver2021'

param adminUsername string = 'AzureAdmin'
@secure()
param adminPassword string = 'Routeserver-2021'

//public IP prefixes
resource prefixIpV4 'Microsoft.Network/publicIPPrefixes@2020-11-01' = {
  name: 'prefixIpV4'
  location: location
  sku:{
    name: 'Standard'
    tier: 'Regional'
  }
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
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource Spoke1BastionPubIpV4 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Spoke1BastionPubIpV4'
  location: location
  sku:{
    name: 'Standard'
  }
  properties:{
    publicIPAllocationMethod: 'Static' 
    publicIPAddressVersion: 'IPv4'
    publicIPPrefix: {
      id: prefixIpV4.id
    }
  }
}
resource Spoke2BastionPubIpV4 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Spoke2BastionPubIpV4'
  location: location
  sku:{
    name: 'Standard'
  }

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
resource Spoke1VPNGWPubIpV41 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Spoke1VPNGWPubIpV41'
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
resource Spoke2VPNGWPubIpV41 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: 'Spoke2VPNGWPubIpV41'
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
        addressPrefix: HubsubnetBastionRange
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
      {
        name: 'GatewaySubnet'
        properties:{
          addressPrefix: Spoke1GatewaySubnetv4AddressRange
        }
      } 
      {
        name: 'AzureBastionSubnet'
        properties:{
          addressPrefix: Spoke1AzureBastionSubnetv4AddressRange
        }
      } 
    ]      
  } 
}
resource Spoke2 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: 'Spoke2'
  location: location
  properties:{
    addressSpace:{
      addressPrefixes:[
        Spoke2v4AddressRange
       
      ]
    }
    subnets:[
      {
      name: 'VMSubnet'
      properties:{
        addressPrefix: Spoke2VMSubnetv4AddressRange
        networkSecurityGroup: {
          id: nsg.id
          }
        }
      }
      {
        name: 'GatewaySubnet'
        properties:{
          addressPrefix: Spoke2GatewaySubnetv4AddressRange
        }
      } 
      {
        name: 'AzureBastionSubnet'
        properties:{
          addressPrefix: Spoke2AzureBastionSubnetv4AddressRange
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
resource Spoke1Bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: 'Spoke1Bastion'
  dependsOn:[
    Spoke1
  ]
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConf'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','Spoke1','AzureBastionSubnet')
          } 
          publicIPAddress: {
            id: Spoke1BastionPubIpV4.id
          }
        }
      }
    ]
  }
}
resource Spoke2Bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: 'Spoke2Bastion'
  dependsOn:[
    Spoke2
  ]
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipConf'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','Spoke2','AzureBastionSubnet')
          } 
          publicIPAddress: {
            id: Spoke2BastionPubIpV4.id
          }
        }
      }
    ]
  }
}
//PEERINGS
/*resource spoke1hub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-08-01' = {
  name: 'spoke1-hub'
  parent: Spoke1
  properties:{
    remoteVirtualNetwork:{
      id:Hub.id
    }
  }
}*/
//RouteServer
resource RouteServer 'Microsoft.Network/virtualHubs@2021-02-01' = {
  name: 'RouteServer'
  dependsOn: [
    HubVPNGW
  ]
  location: location
  properties: {
    sku: 'Standard'
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
module Spoke2VM 'vm.bicep' = {
  name: 'Spoke2VM'
  dependsOn:[
    Spoke1
  ]
  params:{
    vmName:'Spoke2VM'
    adminPw:adminPassword
    adminUser:adminUsername
    location:location
    subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets','Spoke2','VMSubnet')
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
    ]
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    enableBgp: true
    bgpSettings:{
      asn: HubGWASN
    }
    enablePrivateIpAddress: false
    activeActive: false
    gatewayDefaultSite: null
    sku:{
      name: 'VpnGw1AZ'
      tier: 'VpnGw1AZ'
    }
  }
}
resource Spoke1VPNGW 'Microsoft.Network/virtualNetworkGateways@2021-02-01'= {
  name: 'Spoke1VPNGW'
  location: location
  dependsOn:[
    Spoke1
  ]
  properties:{
    ipConfigurations: [
      {
      name: 'ipconfig1'
      properties: {
        privateIPAllocationMethod: 'Dynamic'
        subnet: {
          id: resourceId('Microsoft.Network/virtualNetworks/subnets','Spoke1','GatewaySubnet')
          }
        publicIPAddress: {
          id: Spoke1VPNGWPubIpV41.id
          }
        }
      }
    ]
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    enableBgp: true
    bgpSettings:{
      asn: Spoke1GWASN
    }
    enablePrivateIpAddress: false
    activeActive: false
    gatewayDefaultSite: null
    sku:{
      name: 'VpnGw1AZ'
      tier: 'VpnGw1AZ'
    }
  }
}
resource Spoke2VPNGW 'Microsoft.Network/virtualNetworkGateways@2021-02-01'= {
  name: 'Spoke2VPNGW'
  location: location
  dependsOn:[
    Spoke2
  ]
  properties:{
    ipConfigurations: [
      {
      name: 'ipconfig1'
      properties: {
        privateIPAllocationMethod: 'Dynamic'
        subnet: {
          id: resourceId('Microsoft.Network/virtualNetworks/subnets','Spoke2','GatewaySubnet')
          }
        publicIPAddress: {
          id: Spoke2VPNGWPubIpV41.id
          }
        }
      }
    ]
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    enableBgp: true
    bgpSettings:{
      asn: Spoke2GWASN
    }
    enablePrivateIpAddress: false
    activeActive: false
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
    bgpSettings:{
      asn: HubCSRASN
      bgpPeeringAddress: HubCSRPrivateIPv4
    }
  }
}
//Connections
resource connectionS2HubGW 'Microsoft.Network/connections@2021-02-01' = {
  name: 'connectionS2HubGW'
  location: location
  dependsOn:[
    HubVPNGW
    Spoke2VPNGW
  ]
  properties:{
    virtualNetworkGateway1:{
      properties:{}
      id: HubVPNGW.id
    }
    virtualNetworkGateway2:{
      properties:{}
      id:Spoke2VPNGW.id
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
    Spoke2VPNGW
  ]
  properties:{
    virtualNetworkGateway1:{
      properties:{}
      id:Spoke2VPNGW.id
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
    Spoke1VPNGW
    csr
  ]
  properties:{
    virtualNetworkGateway1:{
      properties:{}
      id:Spoke1VPNGW.id
    }
    localNetworkGateway2:{
      properties:{}
      id:lngCSR.id
    }
    connectionType: 'IPsec'
    sharedKey:tunnelKey
  }
}
//outputs
output Spoke1VPNGWPubIpV41 string = Spoke1VPNGWPubIpV41.properties.ipAddress
output csrPubIpV4 string = csrPubIpV4.properties.ipAddress
output HubCSRPrivateIPv4 string = HubCSRPrivateIPv4
output  HubCSRASN int = HubCSRASN
output  HubGWASN int = HubGWASN
output  Spoke1GWASN int = Spoke1GWASN
output  Spoke2GWASN int = Spoke2GWASN
