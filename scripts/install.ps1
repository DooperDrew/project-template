<#
.SYNOPSIS
    Zero-elevation user-level installer script for Windows.

.DESCRIPTION
    Installs the application into %LOCALAPPDATA%\Programs\<ProjectName> without requiring
    administrator privileges, and optionally creates Desktop and Start Menu shortcuts.
#>

param(
    [switch]$NoShortcuts = $false,
    [switch]$AddToPath = $false
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ProjectName = (Get-Item $RepoRoot).Name
$InstallDir = Join-Path $env:LOCALAPPDATA "Programs\$ProjectName"

Write-Host "Installing $ProjectName to $InstallDir..." -ForegroundColor Cyan

if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

# Copy binaries and assets
# Adapt this to copy from release build or current directory:
Get-ChildItem -Path $RepoRoot -Filter "*.exe" | ForEach-Object {
    Copy-Item $_.FullName -Destination $InstallDir -Force
}

# Create shortcuts if not disabled
if (-not $NoShortcuts) {
    $WshShell = New-Object -ComObject WScript.Shell
    $DesktopPath = [Environment]::GetFolderPath('Desktop')
    $Shortcut = $WshShell.CreateShortcut((Join-Path $DesktopPath "$ProjectName.lnk"))
    $Shortcut.TargetPath = (Join-Path $InstallDir "$ProjectName.exe")
    $Shortcut.WorkingDirectory = $InstallDir
    $Shortcut.Save()
}

Write-Host "$ProjectName installation complete!" -ForegroundColor Green
