function Test-PartitionType {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter
    )
    $PartitionType = Get-Partition -DriveLetter $DriveLetter | foreach-Object {$_.Type -eq "Basic"} -ErrorAction SilentlyContinue
    if (!($PartitionType)) {
        return $false
    }
    return $true
}