$repoName = 'christianacca-ps'
$repoNameAlias = 'aliased-repo'

Describe 'Register-MyGetPSRepository' {
    BeforeEach {
        Unregister-PSRepository $repoName -EA 'SilentlyContinue'
        Unregister-PSRepository $repoNameAlias -EA 'SilentlyContinue'  
    }

    AfterEach {
        Unregister-PSRepository $repoNameAlias -EA 'SilentlyContinue'
    }

    It '-FeedName can be used to register the PSRepository under a different name' {
        # when
        & $PSScriptRoot\..\src\Register-MyGetPSRepository.ps1 -Name $repoNameAlias -FeedName $repoName

        # then
        Get-PSRepository $repoNameAlias -EA Ignore | Should -Not -BeNullOrEmpty
    }
    
    It 'Should register repository' {
        # when
        & $PSScriptRoot\..\src\Register-MyGetPSRepository.ps1 $repoName

        # then
        Get-PSRepository $repoName -EA Ignore | Should -Not -BeNullOrEmpty
    }
}