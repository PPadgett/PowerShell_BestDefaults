BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Set-BestDefaults Tests" {

    # You can use Mock to intercept calls to cmdlets/functions and define their behaviour in the scope of a Describe block. 
    # In this case, we are avoiding actual calls to New-Item and Add-Content cmdlets for test isolation and to avoid side-effects
    Mock New-Item { return $null } 
    Mock Add-Content { return $null }

    # Start tests
    Context "When running Set-BestDefaults" {
        It "Creates the PowerShell profile if it doesn't exist" {
            # Arrange
            Mock Test-Path { return $false } -ParameterFilter { $Path -eq $profile }
            # Act
            Set-BestDefaults
            # Assert
            Assert-MockCalled New-Item -ParameterFilter { $Path -eq $profile -and $ItemType -eq "File" } -Exactly -Times 1 -Scope It
        }

        It "Creates DailyLog folder if it doesn't exist" {
            # Arrange
            $DailyLogFolderPath = $profile.TrimEnd($ShellProfileObject) + 'DailyLog'
            Mock Test-Path { return $false } -ParameterFilter { $Path -eq $DailyLogFolderPath }
            # Act
            Set-BestDefaults
            # Assert
            Assert-MockCalled New-Item -ParameterFilter { $Path -eq $DailyLogFolderPath -and $ItemType -eq "Directory" } -Exactly -Times 1 -Scope It
        }

        It "Adds transcript command to the profile" {
            # Arrange
            Mock Get-Content { return $null }
            $DailyLogName = "PowerShellDailyTranscript_" + "$(Get-Date -UFormat %Y-%m-%d)" + ".log"
            $transcriptCommand = "Start-Transcript -Path $($profile.TrimEnd($ShellProfileObject) + 'DailyLog\' + $DailyLogName + ' -Append -IncludeInvocationHeader')"
            # Act
            Set-BestDefaults
            # Assert
            Assert-MockCalled Add-Content -ParameterFilter { $Path -eq $profile -and $Value -eq $transcriptCommand } -Exactly -Times 1 -Scope It
        }
    }
}

