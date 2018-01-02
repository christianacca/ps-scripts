param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $NuGetApiKey
)

$ErrorActionPreference = 'Stop'
$params = @{
    Repository  = 'PSGallery'
    Path        = "$PSScriptRoot\..\src\Register-MyGetPSRepository.ps1"
    NuGetApiKey = $NuGetApiKey
}
Publish-Script @params
