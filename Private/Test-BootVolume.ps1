function Test-BootVolume {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter
    )
    $Disk = Get-Partition -DriveLetter $DriveLetter -ErrorAction SilentlyContinue |
        Get-Disk -ErrorAction SilentlyContinue
    if ($Disk -and $Disk.IsBoot) {
        return $true
    }
    return $false
}