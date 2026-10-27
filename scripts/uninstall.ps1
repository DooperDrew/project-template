<#
.SYNOPSIS
    Clean uninstallation script for %LOCALAPPDATA%\Programs\<ProjectName>.
#>

param()

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ProjectName = (Get-Item $RepoRoot).Name
$InstallDir = Join-Path $env:LOCALAPPDATA "Programs\$ProjectName"

Write-Host "Uninstalling $ProjectName..." -ForegroundColor Yellow

# Terminate running process if active
Get-Process -Name $ProjectName -ErrorAction SilentlyContinue | Stop-Process -Force

# Remove Desktop Shortcut
$DesktopPath = [Environment]::GetFolderPath('Desktop')
$ShortcutPath = Join-Path $DesktopPath "$ProjectName.lnk"
if (Test-Path $ShortcutPath) { Remove-Item $ShortcutPath -Force }

# Remove Installation Directory
if (Test-Path $InstallDir) {
    Remove-Item -Path $InstallDir -Recurse -Force
}

Write-Host "$ProjectName uninstalled cleanly." -ForegroundColor Green
