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
                  SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  HelpUri = 'http://www.microsoft.com/',
                  ConfirmImpact='Medium')]
    [Alias(sbd)]
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
        [Alias("PHP")] 
        $PwshHomePath = $env:HOMEPATH
    )

    Begin
    {
        ########################
        # Set Script variables #
        ########################

        #Check to see if "PowerShell Profile" is already created (True/False) Value
        $PowerShellProfile = Test-path $profile
        #Check to see if "DailyLog" folder is created under PowerShell Profile is already created (True/False) Value
        $DailyLogFolder = Test-Path $profile.TrimEnd('Microsoft.PowerShellISE_profile.ps1') + "DailyLog"
        #Create daily log name to be used with setting up Powershell transcripting
        $DailyLogName = "PowerShellDailyTranscript_" + "$(Get-Date -UFormat %Y-%m-%d)" + ".log"
        
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
                New-item -path $profile -type file -force
            } 
        }
    }
    End
    {
    }
}