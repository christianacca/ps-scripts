
<#PSScriptInfo

.VERSION 1.0.0

.GUID 4ae6bc3a-1d9f-4d93-ae28-59543bd78e4e

.AUTHOR christianacca

.COMPANYNAME 

.COPYRIGHT 

.TAGS 

.LICENSEURI https://github.com/christianacca/ps-scripts/blob/master/LICENSE

.PROJECTURI https://github.com/christianacca/ps-scripts

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


.PRIVATEDATA 

#>

<#
.SYNOPSIS 
    Register a PSRepository with MyGet as the source
 
.DESCRIPTION 
    Register a PSRepository with MyGet as the source.

.PARAMETER Name
    The name of the PSRepository 

.PARAMETER FeedName
    The name of MyGet feed that should be used as the source for this repository.
    Defaults to -Name
#>
[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $Name,

    [ValidateNotNullOrEmpty()]
    [string] $FeedName = $Name
)
    
begin {
    Set-StrictMode -Version 'Latest'
    $callerEA = $ErrorActionPreference
    $ErrorActionPreference = 'Stop'
}
    
process {
    try {
        if (Get-PSRepository -Name $Name -EA SilentlyContinue) {
            Write-Verbose "PS Repository '$Name' already registed on '$($env:COMPUTERNAME)'... nothing to do"
            return
        }
            
        Write-Verbose "PS Repository '$Name' not found on '$($env:COMPUTERNAME)'... registering now"    
        $repo = @{
            Name                  = $Name
            SourceLocation        = "https://www.myget.org/F/$FeedName/api/v2"
            ScriptSourceLocation  = "https://www.myget.org/F/$FeedName/api/v2/"
            PublishLocation       = "https://www.myget.org/F/$FeedName/api/v2/package"
            ScriptPublishLocation = "https://www.myget.org/F/$FeedName/api/v2/package/"
            InstallationPolicy    = 'Trusted'
        }
        Register-PSRepository @repo
    }
    catch {
        Write-Error -ErrorRecord $_ -EA $callerEA
    }
}