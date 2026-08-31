function Test-Volume {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Switch]$Force
    )
    $DriveLetter = $DriveLetter.Trim().Substring(0, 1).ToUpperInvariant()
    $GetVolume = Get-Volume -DriveLetter $DriveLetter -ErrorAction SilentlyContinue
    if (-not $GetVolume) {
        return $false
    }
    if (-not $Force -and (Test-SystemVolume -DriveLetter $DriveLetter)) {
        return $false
    }
    if (-not $Force -and (Test-BootVolume -DriveLetter $DriveLetter)) {
        return $false
    }
    if (-not (Test-PartitionType -DriveLetter $DriveLetter)) {
        return $false
    }
    Write-Verbose "Volume successfully tested."
    return $true
}