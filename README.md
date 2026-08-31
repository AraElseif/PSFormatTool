# PSFormatTool

A PowerShell module for automating secure volume formatting on Windows.

## Description

PSFormatTool is a PowerShell module that provides automated functionality for formatting disk volumes. It includes security validations to protect the operating system volume and boot volume, preventing accidental formatting of critical drives.

## Requirements

- **PowerShell:** 5.1 or higher
- **Compatible Editions:** Desktop and Core
- **Operating System:** Windows
- **Permissions:** Administrator privileges

## Installation

### From local repository

```powershell
# Copy the module to the PowerShell modules folder
Copy-Item -Path ".\PSFormatTool" -Destination "$PROFILE\..\Modules\" -Recurse

# Import the module
Import-Module PSFormatTool
```

### Verify Installation

```powershell
Get-Module PSFormatTool
Get-Command -Module PSFormatTool
```

## Usage

### New-FormatVolume

Formats a specified volume with the indicated file system.

#### Syntax

```powershell
New-FormatVolume -DriveLetter <String> -FileSystem <String> [-Name <String>] [-Force] [-WhatIf] [-Confirm] [-Verbose]
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| **DriveLetter** | String | Yes | Drive letter to format (A-Z). Example: `D` |
| **FileSystem**  | String | Yes | File system to use: `NTFS` or `exFAT` |
| **Name**        | String | No | New label for the volume |
| **Force**       | Switch | No | Bypasses the protection checks for the system and boot volume. Use with caution |
| **WhatIf**      | Switch | No | Shows what would happen if the command is executed without running it |
| **Confirm**     | Switch | No | Prompts for confirmation before formatting |
| **Verbose**     | Switch | No | Displays detailed informational messages |

#### Examples

```powershell
# Format drive D: to NTFS
New-FormatVolume -DriveLetter D -FileSystem NTFS

# Format drive E: to exFAT with a new name
New-FormatVolume -DriveLetter E -FileSystem exFAT -Name "BackupDrive"

# Force formatting even though the drive is protected by the system/boot checks
New-FormatVolume -DriveLetter E -FileSystem NTFS -Force

# See what would happen when formatting (without executing)
New-FormatVolume -DriveLetter F -FileSystem NTFS -WhatIf

# Format with prior confirmation
New-FormatVolume -DriveLetter G -FileSystem NTFS -Confirm -Verbose
```

## Features

**Security Validation**
- Protects the operating system volume
- Protects the boot volume
- Verifies partition type
- Allows explicit bypass with `-Force` when the user wants to override the safety protections

**Multiple File Systems**
- Compatible with NTFS
- Compatible with exFAT

**Interactive Confirmation**
- Requests confirmation before formatting
- Displays detailed volume information

**Support for Advanced Operations**
- Compatibility with `-WhatIf`
- Compatibility with `-Confirm`
- Compatibility with `-Verbose`

**Robust Error Handling**
- Complete input validation
- Clear error messages

## Security Notes

**WARNING**: This module formats volumes, deleting all data.

- **Backup important data** before using
- The module includes protections to prevent formatting system drives
- **Verify the correct drive** before executing the command
- It is recommended to use `-WhatIf` first for preview
- `-Force` bypasses the system/boot protections intentionally and should be used only when you are sure about the target volume
- Requires **administrator permissions**

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for the complete version history and changes.

### Version 0.1.1 (2026-08-31)

- Private `Initialize-Format` function to perform volume formatting
- Improved support for `-Verbose`, `-WhatIf`, and `-Confirm`

### Version 0.1.0 (2026-08-30)

- Initial release
- Public `New-FormatVolume` function
- Built-in security validations
- Module manifest and project structure

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

**AraElseif**

GitHub: [AraElseif/PSFormatTool](https://github.com/AraElseif/PSFormatTool)

```bash
git clone https://github.com/AraElseif/PSFormatTool.git
```

## Support and Contributions

To report issues, suggestions, or contributions, please contact the author.

## Status and Warnings

**Status:** In development (Beta)  
**Compatibility:** PowerShell 5.1+, PowerShell Core  
**Last Updated:** 2026-08-31
