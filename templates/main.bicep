param rgName string = 'ars-lab'

param location string = 'swedencentral'

param branch1v4AddressRange string = '10.1.0.0/16'
param branch1VMSubnetv4AddressRange string = '10.1.0.0/24'
param branch1GatewaySubnetv4AddressRange string = '10.1.254.0/24'
param branch1AzureBastionSubnetv4AddressRange string = '10.1.255.0/24'
param branch1GWASN int = 100

param branch2v4AddressRange string = '10.2.0.0/16'
param branch2VMSubnetv4AddressRange string = '10.2.0.0/24'
param branch2GatewaySubnetv4AddressRange string = '10.2.254.0/24'
param branch2AzureBastionSubnetv4AddressRange string = '10.2.255.0/24'
param branch2GWASN int = 200

param spoke1v4AddressRange string = '10.3.0.0/16'
param spoke1VMSubnetv4AddressRange string = '10.3.0.0/24'

param hubv4AddressRange string = '10.0.0.0/16'
param hubRouteServerSubnetv4AddressRange string = '10.0.0.0/24'
param hubVMSubnetv4AddressRange string = '10.0.1.0/24'
param hubCSRSubnetv4AddressRange string = '10.0.253.0/24'
param hubGatewaySubnetv4AddressRange string = '10.0.254.0/24'
param hubSubnetBastionRange string = '10.0.255.0/24'
param hubCSRLoopbackIPv4 string = '1.1.1.1'
param hubCSRPrivateIPv4 string = '10.0.253.4'
param hubCSRASN int = 64000
param hubGWASN int = 300

param storagePrefix string = 'bootst'

param tunnelKey string = 'Routeserver2021'

param adminUsername string = 'AzureAdmin'

param adminPassword string = 'Routeserver-2021'

targetScope = 'subscription'
 
resource arsRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module rsLab 'rs.bicep' = {
  name: 'rsLab'
  scope: arsRg
  params:{
    location:  location

    Branch1v4AddressRange: branch1v4AddressRange
    Branch1VMSubnetv4AddressRange: branch1VMSubnetv4AddressRange
    Branch1GatewaySubnetv4AddressRange:branch1GatewaySubnetv4AddressRange
    Branch1AzureBastionSubnetv4AddressRange: branch1AzureBastionSubnetv4AddressRange
    Branch1GWASN: branch1GWASN
   
    Branch2v4AddressRange: branch2v4AddressRange
    Branch2VMSubnetv4AddressRange: branch2VMSubnetv4AddressRange
    Branch2GatewaySubnetv4AddressRange: branch2GatewaySubnetv4AddressRange
    Branch2AzureBastionSubnetv4AddressRange: branch2AzureBastionSubnetv4AddressRange
    Branch2GWASN: branch2GWASN
    
    Spoke1v4AddressRange: spoke1v4AddressRange
    Spoke1VMSubnetv4AddressRange: spoke1VMSubnetv4AddressRange
   
    Hubv4AddressRange: hubv4AddressRange
    HubRouteServerSubnetv4AddressRange: hubRouteServerSubnetv4AddressRange
    HubVMSubnetv4AddressRange: hubVMSubnetv4AddressRange
    HubCSRSubnetv4AddressRange: hubCSRSubnetv4AddressRange
    HubGatewaySubnetv4AddressRange: hubGatewaySubnetv4AddressRange
    HubSubnetBastionRange: hubSubnetBastionRange
    HubCSRLoopbackIPv4: hubCSRLoopbackIPv4
    HubCSRPrivateIPv4:hubCSRPrivateIPv4
    HubCSRASN: hubCSRASN
    HubGWASN: hubGWASN
    
   storagePrefix: storagePrefix
   
    tunnelKey: tunnelKey
   
    adminUsername: adminUsername
   
    adminPassword: adminPassword

  }
  
}
