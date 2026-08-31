function Test-SystemVolume {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter
    )
    $DriveLetter = $DriveLetter.Trim().ToUpperInvariant()
    $SystemDrive = $Env:SystemDrive.Trim(':').ToUpperInvariant()
    if ($DriveLetter -eq $SystemDrive) {
        return $true
    }
    return $false
}