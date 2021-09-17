New-AzResourceGroupDeployment -ResourceGroupName 'rg-bicep-demo-eastus2-01' -TemplateFile .\03-param.bicep `
	-DeploymentName "simple-$((Get-Date).ToString("yyyyMMdd-hhmmss"))"