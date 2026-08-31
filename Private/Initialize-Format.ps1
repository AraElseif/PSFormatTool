function Initialize-Format {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Parameter(Mandatory = $true)]
        [ValidateSet("exFAT", "NTFS")]
        [String]$FileSystem,

        [String]$Name
    )
    $DriveLetter = $DriveLetter.Trim().Substring(0, 1).ToUpperInvariant()
    $Name = $Name.ToUpper()
    if ($FileSystem -eq "exFAT") {
        if ($Name.length -gt 11) {
            throw "You cannot enter more than 11 characters for the label in the exFat format."
        }
    }
    try {
        Format-Volume -DriveLetter $DriveLetter -FileSystem $FileSystem -NewFileSystemLabel $Name -ErrorAction Stop | Out-Null
        Write-Verbose "Format completed successfully."
    }   catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}
