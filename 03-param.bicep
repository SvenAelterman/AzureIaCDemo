param allowPublicAccess bool = false

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
param sku string = 'Standard_LRS'

@allowed([
  'eastus2'
  'eastus'
  'westus'
  'centralus'
])
param location string = 'eastus2'

resource mystorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'satest540564035'
  kind: 'StorageV2'
  sku: {
    name: sku
  }
  location: location
  properties: {
    allowBlobPublicAccess: allowPublicAccess
  }
}
