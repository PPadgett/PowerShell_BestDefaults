[CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
SupportsShouldProcess=$false, 
PositionalBinding=$false,
HelpUri = 'https://technet.microsoft.com/en-us/library/bb613488(v=vs.85).aspx and https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.host/start-transcript?view=powershell-5.1',
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


<#
.Synopsis
   Setup PowerShell Profile for current user and enalbe "Start-Transcript" as defaulf for powershell console.
.DESCRIPTION
   Meant to be an example script for people new to PowerShell will setup PowerShell Profiles and Enable "Start-Trnscript". Also to be used as an example script to help teach novice script some baisc best practices and scripting. If you notice some best practices messsing within the script, please fill free to updated.
.EXAMPLE
   Set-BestDefaults

.NOTES
   This is a communety project, fill free to make it even better.
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
                  HelpUri = 'https://technet.microsoft.com/en-us/library/bb613488(v=vs.85).aspx and https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.host/start-transcript?view=powershell-5.1',
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
        #Select the Profile location Default Script
        $ShellProfileObject = $PROFILE.Split('\')[-1]
        #Check to see if "DailyLog" folder is created under PowerShell Profile is already created (True/False) Value
        $DailyLogFolder = (Test-Path ($profile.TrimEnd($ShellProfileObject) + 'DailyLog'))
        #Create daily log name to be used with setting up Powershell transcripting
        $DailyLogName = "PowerShellDailyTranscript_" + "$(Get-Date -UFormat %Y-%m-%d)" + ".log"
        

        ############################
        # Display Script Variables #
        ############################

        Write-Verbose "PowerShellProfile Value equals $($PowerShellProfile)"
        Write-Verbose "DailyLogFolder Value equals $($DailyLogFolder)"
        Write-Verbose "DailyLogName Value equals $($DailyLogName)"
        Write-Verbose "Shell Profile Object equals $($ShellProfileObject)"
        
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
            } 
            #Creates DailyLog folder if it does not already exist
            if ($DailyLogFolder -ne $true) {
                Write-Verbose "Attempting to create DailyLog folder for User: $($env:USERNAME)"
                New-Item -Path ($profile.TrimEnd($ShellProfileObject) + 'DailyLog') -ItemType Directory -Force                
            }
            #Enabled Transcripting within user PowerShell Profile if it does not already exist
            Write-Verbose "Attempting to enable Transcripting for User: $($env:USERNAME)"
            if ((Get-Content $profile) -ne "Start-Transcript -Path $($profile.TrimEnd($ShellProfileObject) + 'DailyLog\' + $DailyLogName + ' -Append -IncludeInvocationHeader')") 
            {
                Write-Verbose "Attempting to add transcript command to $($profile)"
                Add-Content -Path $profile -Value "Start-Transcript -Path $($profile.TrimEnd($ShellProfileObject) + 'DailyLog\' + $DailyLogName + ' -Append -IncludeInvocationHeader')"                
            }
        }
    }
    End
    {
        Write-Verbose "PowerShell Profile Enabled: $(Test-Path ($profile))"
        Write-Verbose "Created DailyLog Folder: $(Test-Path ($profile.TrimEnd($ShellProfileObject) + 'DailyLog'))"
        Write-Verbose "PowerShell Transcript Enabled: $((Get-Content $profile) -eq "Start-Transcript -Path $($profile.TrimEnd($ShellProfileObject) + 'DailyLog\' + $DailyLogName + ' -Append -IncludeInvocationHeader')")"
    }
}

##############
# Run Script #
##############
Set-BestDefaults -PwshHomePath $PwshHomePath