function Test-Volume {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Switch]$Force
    )
    $GetVolume = Get-Volume -DriveLetter $DriveLetter -ErrorAction SilentlyContinue
    if (-not $GetVolume) {
        Write-Warning "The selected volume '$Driveletter' is not recognized."
        return $false
    }
    if (-not $Force -and (Test-SystemVolume -DriveLetter $DriveLetter)) {
        Write-Warning "The selected volume contains an installed operating system and cannot be formatted."
        return $false
    }
    if (-not $Force -and (Test-BootVolume -DriveLetter $DriveLetter)) {
        Write-Verbose "The selected volume contains a bootable system and cannot be formatted."
        return $false
    }
    if (-not (Test-PartitionType -DriveLetter $DriveLetter)) {
        Write-Verbose "The volume contains a type of recovery, boot, or backup partition and cannot be formatted."
        return $false
    }
    Write-Verbose "Volume successfully tested."
    return $true
}