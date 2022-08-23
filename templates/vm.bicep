param vmName string
param adminUser string
@secure()
param adminPw string
param location string
param subnetId string
var imagePublisher = 'MicrosoftWindowsServer'
var imageOffer = 'WindowsServer'
var imageSku = '2022-Datacenter'
//var imageId = '/subscriptions/0245be41-c89b-4b46-a3cc-a705c90cd1e8/resourceGroups/image-gallery-rg/providers/Microsoft.Compute/galleries/mddimagegallery/images/windows2019-networktools/versions/2.0.0'

resource nicPubIP 'Microsoft.Network/networkInterfaces@2020-08-01' = {
  name: '${vmName}-nic'
  location: location
  properties:{
    ipConfigurations: [
      {
        name: 'ipv4config0'
        properties:{
          primary: true
          privateIPAllocationMethod: 'Dynamic'
          privateIPAddressVersion: 'IPv4'
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}
resource vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile:{
      vmSize: 'Standard_DS2_v2'
    }
    storageProfile:  {
      imageReference: {
        //id: imageId
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
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
resource ext 'Microsoft.Compute/virtualMachines/extensions@2020-12-01' = {
  name: 'ext'
  parent: vm
  location: location
  properties:{
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.9'
    autoUpgradeMinorVersion: true
    protectedSettings:{}
    settings: {
        commandToExecute: 'powershell -ExecutionPolicy Unrestricted Add-WindowsFeature Web-Server; powershell -ExecutionPolicy Unrestricted Add-Content -Path "C:\\inetpub\\wwwroot\\Default.htm" -Value $($env:computername)'
    }
  }  
}

