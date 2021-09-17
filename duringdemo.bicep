resource storageAccount2 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'sademo238792'
  location: 'eastus2'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {}
}
