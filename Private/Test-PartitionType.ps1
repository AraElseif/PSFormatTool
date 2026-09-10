function Test-PartitionType {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter
    )
    $Partition = Get-Partition -DriveLetter $DriveLetter
    $ProtectedPartitionTypes = @('System', 'Recovery', 'Reserved')
    if ($Partition.Type -in $ProtectedPartitionTypes) {
        return $false
    }
    return $true
}