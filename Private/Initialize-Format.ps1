function Initialize-Format {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^[A-Za-z]$')]
        [String]$DriveLetter,

        [Parameter(Mandatory = $true)]
        [ValidateSet("exFAT", "NTFS")]
        [String]$FileSystem,

        [String]$Name,

        [Switch]$Full
    )
    $Name = $Name.ToUpper()
    if ($FileSystem -eq "exFAT") {
        if ($Name.length -gt 11) {
            Write-Warning "You cannot enter more than 11 characters for the label in the exFat format."
        }
    }
    try {
        Format-Volume -DriveLetter $DriveLetter -FileSystem $FileSystem -NewFileSystemLabel $Name -Full:$Full -ErrorAction Stop | Out-Null
        Write-Verbose "Format completed successfully."
    }   catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}
