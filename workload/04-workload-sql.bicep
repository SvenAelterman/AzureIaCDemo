param baseResourceName string
param location string
param tags object = {}
param tagsIfNew object = {}

resource sql 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: 'sql-${baseResourceName}'
  location: location
  properties: {
    administratorLogin: 'dbadmin'
    // TODO: Get from Key Vault
    administratorLoginPassword: 'sfdlKj32228'
  }
  tags: tags
}

resource db 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: '${sql.name}/sqldb-${baseResourceName}'
  location: location
  tags: tags
  // TODO: Add size
}

// TODO: Deploy DB?

output sqlFqdn string = sql.properties.fullyQualifiedDomainName
