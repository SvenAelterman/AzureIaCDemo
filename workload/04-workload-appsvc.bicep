param baseResourceName string
param moduleLocation string
@allowed([
  'demo'
  'prod'
  'dev'
])
param environment string
param deployAppInsights bool = true
param tags object = {}

// Prefix convention from https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations
var webAppName = 'app-${baseResourceName}'
var appSvcPlanName = 'plan-${baseResourceName}'
var workspaceName = 'log-${baseResourceName}'
var appInsightsName = 'appi-${baseResourceName}'

resource appSvcPlan 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: appSvcPlanName
  location: moduleLocation
  sku: {
    name: 'S1'
    capacity: 1
  }
  properties: {}
  tags: tags
}

resource webApp 'Microsoft.Web/sites@2021-01-15' = {
  name: webAppName
  location: moduleLocation
  properties: {
    // Reference to the App Service Plan above
    serverFarmId: appSvcPlan.id
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'test'
          value: 'value'
        }
      ]
    }
  }
  tags: tags
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = if (deployAppInsights) {
  name: workspaceName
  location: moduleLocation
  tags: tags
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = if (deployAppInsights) {
  name: appInsightsName
  location: moduleLocation
  kind: 'string'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: workspace.id
  }
  tags: tags
}

resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01' = {
  name: '${webApp.name}/web'
  properties: {
    repoUrl: 'https://github.com/SvenAelterman/AzureWebApp'
    branch: 'demo-complete'
    isManualIntegration: true
  }
}

output appUrl string = webApp.properties.hostNames[0]
