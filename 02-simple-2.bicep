resource mystorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'satest540564035'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  location: 'eastus2'
  properties: {
    allowBlobPublicAccess: true
  }
}
