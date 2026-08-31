<#
.SYNOPSIS
    Formats a disk volume with the specified file system.

.DESCRIPTION
    The New-FormatVolume function provides a safe and interactive way to format disk volumes on Windows systems.
    It includes built-in security validations to prevent accidental formatting of critical system drives
    (OS drive or boot drive). The function supports NTFS and exFAT file systems.

    This function requires administrator privileges and supports -Confirm and -WhatIf parameters for safe preview
    and confirmation before executing the format operation.

.PARAMETER DriveLetter
    Specifies the drive letter of the volume to format. Must be a single letter from A to Z.
    The letter will be automatically converted to uppercase.

    The function validates that the specified volume:
    - Exists and is recognized by the system
    - Is not the operating system volume
    - Is not the boot volume
    - Can be formatted

    Examples: D, E, F, G (case-insensitive)

.PARAMETER FileSystem
    Specifies the file system to apply during formatting. Currently supports:
    - NTFS: Windows default file system with advanced features
    - exFAT: Lightweight file system compatible with Windows, Mac, and Linux

.PARAMETER Name
    Optional. Specifies a Name (label) for the volume after formatting.
    If not provided, the volume will be left without a label.

.PARAMETER Force
    Optional. Bypasses the safety checks for system and boot volume protections.
    Use this only when you explicitly want to proceed despite the protections.
    The function still validates that the target volume exists and is a valid formatting target.

.EXAMPLE
    PS C:\> New-FormatVolume -DriveLetter D -FileSystem NTFS

    Formats drive D: to NTFS file system. The system will prompt for confirmation before proceeding.

.EXAMPLE
    PS C:\> New-FormatVolume -DriveLetter E -FileSystem exFAT -Name "Backup"

    Formats drive E: to exFAT and assigns the label "Backup" to the volume.

.EXAMPLE
    PS C:\> New-FormatVolume -DriveLetter F -FileSystem NTFS -WhatIf

    Preview what would happen if drive F: were formatted to NTFS without actually formatting it.

.EXAMPLE
    PS C:\> New-FormatVolume -DriveLetter G -FileSystem NTFS -Confirm -Verbose

    Formats drive G: to NTFS with explicit confirmation prompt and verbose output showing detailed information
    about the operation being performed.

.INPUTS
    None. You cannot pipe objects to New-FormatVolume.

.OUTPUTS
    None. The function does not produce output objects. It performs the formatting operation and returns on success,
    or throws a terminating error if validation fails or the operation is cancelled.

.NOTES
    Author: AraElseif
    Version: 0.1.1
    Requires: Administrator privileges
    Requirements: PowerShell 5.1 or higher

    IMPORTANT SECURITY WARNING:
    - This function DELETES ALL DATA on the specified volume
    - Always backup important data before running this function
    - Use -WhatIf first to preview the operation
    - Use -Confirm to get an interactive prompt before formatting
    - The function includes protections against formatting system and boot drives
    - Verify the correct drive letter before executing the command

.LINK
    Get-Volume
    Format-Volume
    Get-Disk

#>
function New-FormatVolume {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Parameter(Mandatory = $true)]
        [ValidateSet("exFAT", "NTFS")]
        [String]$FileSystem,

        [String]$Name,

        [Switch]$Force
    )
    $DriveLetter = $DriveLetter.Trim().Substring(0, 1).ToUpperInvariant()
    $DiskInfo = Get-Volume -DriveLetter $DriveLetter -ErrorAction SilentlyContinue
    if ($Force) {
        Write-Warning "-Force has been enabled. System and boot volume protections will be bypassed."
    }
    if (-not (Test-Volume -DriveLetter $DriveLetter -Force:$Force)) {
        throw "The indicated volume is not recognized, is not a valid formatting target, or cannot be formatted."
    }
    if ($PSCmdlet.ShouldProcess("Volume $($DiskInfo.FileSystemLabel) - $($DiskInfo.DriveLetter) - $($DiskInfo.DriveType)", "All data will be deleted for a new format.")) {
        try {
            Initialize-Format `
                -DriveLetter $DriveLetter `
                -Filesystem $FileSystem `
                -Name $Name
        } catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}