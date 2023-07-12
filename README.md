# PowerShell Profile Setup Script

This PowerShell script, `Set-BestDefaults`, sets up a PowerShell profile for the current user and enables "Start-Transcript" as default for PowerShell console.

The script is useful for people new to PowerShell and can also serve as an example script to teach novice scripts some basic best practices in scripting.

## Getting Started

To run the script, just use the following command in the PowerShell terminal:

```powershell
Set-BestDefaults -PwshHomePath $PwshHomePath
```

### Prerequisites

This script requires no special prerequisites and should run on any system with PowerShell installed.

## How it Works

When the `Set-BestDefaults` command is run, it performs the following actions:

1. Checks whether a PowerShell profile is already created for the current user.
2. If no profile exists, it creates one.
3. It then checks for a `DailyLog` folder under the user's PowerShell profile. If the folder doesn't exist, it creates it.
4. Finally, it enables transcripting within the user's PowerShell profile, if it doesn't already exist.

The script also displays verbose logging, making it easier to understand what the script is doing and troubleshoot any potential issues.

## Community Contributions

This script is a community project. If you notice any best practices missing within the script, please feel free to update it and make it even better.

## Further Help

For additional details on how this script works, please refer to the following resources:

- [Windows PowerShell Profiles](https://technet.microsoft.com/en-us/library/bb613488(v=vs.85).aspx)
- [Start-Transcript Cmdlet](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.host/start-transcript?view=powershell-5.1)
