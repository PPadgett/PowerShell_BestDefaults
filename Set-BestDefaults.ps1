<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Set-BestDefaults 
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$false, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [Alias('sbd')]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$false, 
                   ValueFromPipeline=$false,
                   ValueFromPipelineByPropertyName=$false, 
                   ValueFromRemainingArguments=$false, 
                   Position=0,
                   ParameterSetName='Parameter Set 1')]
        [Alias('PHP')] 
        $PwshHomePath = $env:HOMEPATH
    )

    Begin
    {
        ########################
        # Set Script variables #
        ########################

        #Check to see if "PowerShell Profile" is already created (True/False) Value
        $PowerShellProfile = (Test-path $profile)
        #Check to see if "DailyLog" folder is created under PowerShell Profile is already created (True/False) Value
        $DailyLogFolder = (Test-Path ($profile.TrimEnd('Microsoft.PowerShellISE_profile.ps1') + 'DailyLog'))
        #Create daily log name to be used with setting up Powershell transcripting
        $DailyLogName = "PowerShellDailyTranscript_" + "$(Get-Date -UFormat %Y-%m-%d)" + ".log"

        ############################
        # Display Script Variables #
        ############################

        Write-Verbose "PowerShellProfile Value equals $($PowerShellProfile)"
        Write-Verbose "DailyLogFolder Value equals $($DailyLogFolder)"
        Write-Verbose "DailyLogName Value equals $($DailyLogName)"
        
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("$($env:COMPUTERNAME)", "Setup PowerShell Profile & Transcripting"))
        {
            ######################################
            # Setup Best Defualts for PowerShell #
            ######################################

            #Creates PowerShell Profile if it does not already exist
            if ($PowerShellProfile -ne $true) {
                Write-Verbose "Attempting to create PowerShell profile for User: $($env:USERNAME)"
                New-item -path $profile -ItemType File -Force
                
                #Creates DailyLog folder if it does not already exist
                if ($DailyLogFolder -ne $true) {
                    Write-Verbose "Attempting to create DailyLog folder for User: $($env:USERNAME)"
                    New-Item -Path ($profile.TrimEnd('Microsoft.PowerShellISE_profile.ps1') + 'DailyLog') -ItemType Directory -Force

                    #Enabled Transcripting within user PowerShell Profile if it does not already exist
                    Write-Verbose "Attempting to enable Transcripting for User: $($env:USERNAME)"
                    if ((Get-Content $profile) -ne "Start-Transcript -Path $($profile.TrimEnd('Microsoft.PowerShellISE_profile.ps1') + 'DailyLog\' + $DailyLogName + ' -Append -IncludeInvocationHeader')") 
                    {
                        Write-Verbose "Attempting to add transcript command to $($profile)"
                        Add-Content -Path $profile-Value "Start-Transcript -Path $($profile.TrimEnd('Microsoft.PowerShellISE_profile.ps1') + 'DailyLog\' + $DailyLogName + ' -Append -IncludeInvocationHeader')"
                    }
                }
            } 
        }
    }
    End
    {
        Write-Verbose "PowerShell Profile Enabled: $(Test-Path ($profile))"
        Write-Verbose "Created DailyLog Folder: $(Test-Path ($profile.TrimEnd('Microsoft.PowerShellISE_profile.ps1') + 'DailyLog'))"
        Write-Verbose "PowerShell Transcript Enabled: $((Get-Content $profile) -eq "Start-Transcript -Path $($profile.TrimEnd('Microsoft.PowerShellISE_profile.ps1') + 'DailyLog\' + $DailyLogName + ' -Append -IncludeInvocationHeader')")"
    }
}

##############
# Run Script #
##############
Set-BestDefaults -Verbose