param location string = 'westeurope'

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
  zones:[
    '1'
  ]
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
