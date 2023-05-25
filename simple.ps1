New-AzResourceGroupDeployment -ResourceGroupName 'rg-bicep-demo-eastus2-01' -TemplateFile .\01-simple.bicep `
	-DeploymentName "simple-$((Get-Date).ToString("yyyyMMdd-hhmmss"))"