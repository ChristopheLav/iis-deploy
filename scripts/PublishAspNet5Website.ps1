##-----------------------------------------------------------------------
## <copyright file="PublishAspNet5Website.ps1">(c) Pinnula. All rights reserved.</copyright>
## <version>1.3.0</version>
##-----------------------------------------------------------------------
#
# This script publish a website with MSDeploy utility - so MSDeploy is required.
#
# This script require param $packOutput: directory of deployment package/files
# This script require param $deployUrl: URL of MSDeploy service
# This script require param $websiteName: name of target website on IIS
# This script require param $deployUserName: name of user used by MSDeploy
# This script require param $deployUserPassword: password of user used by MSDeploy


##-----------------------------------------------------------------------
## Changelog
##-----------------------------------------------------------------------
#
# 1.3.0 [18/06/2019]
#   - using mandatory and validate script parameters attribute
#   - rework parameters strategy to delete environment variables and use script parameters
#   - remove unused buildConfiguration parameter
#   - remove unused CUSTOM_DEPLOYCONFIGURATION parameter
#
# 1.2.0 [08/03/2017]
#	- no more needed a specific version of Visual Studio for working
#
# 1.1.5 [03/11/2016]
#	- fix typo error in check/error message
#
# 1.1.4 [13/07/2016]
#   - update publish script path for support .NET Core 1.0 RTM
#
# 1.1.3 [22/05/2016]
#   - add rule for skip 'logs' and 'data folders during publish
#   - enable 'EnableMSDeployAppOffline' mode
#
# 1.1.2 [20/05/2016]
#   - update publish script path for support .NET Core 1.0 RC2
#
# 1.1.1 [17/05/2016]
#   - fix publish tools path after upgrade Core Web Tools to RC2 (may 2016 release)
#
# 1.1.0 [12/05/2016]
#   - update logic: it's now used by Release Management directly with good initialize context
#
# 1.0.1 [13/12/2015]
#   - added skip files rule for Bing and Google webmaster verification files
#
# 1.0.0 [02/08/2015] 
#   - initial release


# Enable -Verbose option
[CmdletBinding()]

# Global script params
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

# Deploy Websie with MSDeploy
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
