param vmName string
param adminUser string
@secure()
param adminPw string
param location string
param subnetId string
param pubIpv4Id string
param privateIPv4 string
param bootstUri string


resource nicPubIP 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: '${vmName}-nic'
  location: location
  properties:{
    enableIPForwarding: true
    ipConfigurations: [
      {
        name: 'ipv4config0'
        properties:{
          primary: true
          privateIPAllocationMethod: 'Static'
          privateIPAddressVersion: 'IPv4'
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: pubIpv4Id
          }
          privateIPAddress: privateIPv4          
        }
      }
    ]
  }
}
resource vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmName
  location: location
  plan:{
    name: '16_12_5-byol'
    publisher: 'cisco'
    product: 'cisco-csr-1000v'
  }
  properties: {
    hardwareProfile:{
      vmSize: 'Standard_DS2_v2'
    }
    storageProfile:  {
      imageReference: {
        publisher: 'cisco'
        offer: 'cisco-csr-1000v'
        sku: '16_12_5-byol'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'      
        }
      }
      osProfile:{
        computerName: vmName
        adminUsername: adminUser
        adminPassword: adminPw
        linuxConfiguration: {
          patchSettings: {
            patchMode: 'ImageDefault'
          }
        }
      }
      diagnosticsProfile: {
        bootDiagnostics: {
          enabled: true
          storageUri: bootstUri
        }
      }
      networkProfile: {
        networkInterfaces: [
        {
          id: nicPubIP.id
        }
      ]
    }
  }
}
