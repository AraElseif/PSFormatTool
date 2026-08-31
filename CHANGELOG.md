# Changelog

All notable changes to PSFormatTool are documented in this file.

## [Unreleased]

Changes planned for the next release.

## [0.1.0] - 2026-08-30

### Added

- A `New-FormatVolume` public function that starts the workflow.
- Private `Test-Volume` function that controls volume validation.
- Private function `Test-SystemVolume` to check if you have an operating system installed.
- Private function `Test-BootVolume` to check if it has boot.
- Private function `Test-PartitionType` to check the partition type.
- Protection for the drive containing the operating system.
- Support for the `exFAT` and `NTFS` file systems.

### Documentation

- Added `README` file.
- Added project license.
- Added `.psd1` module manifest.
- Added `.psm1` module file.
- Added public folder.
- Added private folder.

## [0.1.1] - 2026-08-31

### Added

- Private 'Initialize-Format' function to perform volume formatting.
- Support for `-Verbose`, `-WhatIf`, and `-Confirm`.
- Added character control for exFAT format name.
