targetScope = 'subscription'

@allowed([
  'demo'
  'prod'
  'dev'
])
param environment string

param workloadname string = 'bicep'
param location string = 'eastus2'
param deploySuffix string = utcNow()
param dateCreatedValue string = utcNow('yyyy-MM-dd')

// Naming convention from https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming
var baseName = '${workloadname}-${environment}-${location}-01'

var tags = {
  'date-lastest-deployment': dateCreatedValue
  'date-created': '2021-09-15'
  purpose: 'demo'
  lifetime: 'short'
}

// TODO: Figure out a way to preserve date-created (output might indicate if new deployment, then add tag?)
var tagsIfNew = {
  'date-created': dateCreatedValue
}

resource workloadRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${baseName}'
  location: location
  tags: tags
}

module appSvcModule './04-workload-appsvc.bicep' = {
  // Name of the deployment. If not unique, will override an existing deployment
  name: 'app-${deploySuffix}'
  scope: workloadRg
  params: {
    moduleLocation: location
    environment: environment
    baseResourceName: baseName
    tags: tags
    // Using default value for deployAppInsights parameter
  }
}

module sqlModule '04-workload-sql.bicep' = {
  name: 'sql-${deploySuffix}'
  scope: workloadRg
  params: {
    location: location
    baseResourceName: baseName
    tags: tags
    tagsIfNew: tagsIfNew
  }
}
