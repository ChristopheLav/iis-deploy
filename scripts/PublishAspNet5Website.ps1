[CmdletBinding()]

param(
	[Parameter(Mandatory=$true)]
	[ValidateScript( {Test-Path -Path $PSItem -IsValid})]
	[string]$packOutput, 
	
	[Parameter(Mandatory=$true)]
	[string]$deployUrl,

	[Parameter(Mandatory=$true)]
	[string]$websiteName,

	[Parameter(Mandatory=$true)]
	[string]$deployUserName,
	
	[Parameter(Mandatory=$true)]
	[string]$deployUserPassword
)

Write-Host "Deployment starting..."

$publishProperties = @{'WebPublishMethod'='MSDeploy';
                        'MSDeployServiceUrl'=$deployUrl;
                        'DeployIisAppPath'=$websiteName;
                        'Username'=$deployUserName;
                        'Password'=$deployUserPassword;
						'SkipExtraFilesOnServer'=$false;
						'EnableMSDeployAppOffline'=$true;
						'ExcludeFiles'=@(
							@{'objectname'='filePath';'absolutepath'='.*google.*\.html'},
							@{'objectname'='filePath';'absolutepath'='.*BingSiteAuth\.xml'},
							@{'objectname'='filePath';'absolutepath'='logs\\.*'},
							@{'objectname'='dirPath';'absolutepath'='logs'},
							@{'objectname'='filePath';'absolutepath'='data\\.*'},
							@{'objectname'='dirPath';'absolutepath'='data'}
						)}


$publishScript = Join-Path (Split-Path $MyInvocation.MyCommand.Path) 'default-publish.ps1'

. $publishScript -publishProperties $publishProperties -packOutput $packOutput

Write-Host "Deployment ending"
