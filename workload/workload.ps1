New-AzDeployment -TemplateFile .\04-workload-main.bicep `
	-DeploymentName "workload-$((Get-Date).ToString("yyyyMMdd-hhmmss"))" -Location 'eastus2'