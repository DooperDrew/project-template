<#
.SYNOPSIS
    Generates WinGet and Scoop package manifests for release distribution.

.PARAMETER Version
    The semantic release version (e.g. "0.1.0").

.PARAMETER ZipPath
    Path to the packaged release archive (.zip). If omitted, looks in dist/.
#>

param(
    [string]$Version = "",
    [string]$ZipPath = "",
    [string]$Publisher = "Contributors",
    [string]$RepoUrl = "https://github.com/OWNER/REPO"
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$RepoRoot = Split-Path -Parent $PSScriptRoot
$ProjectName = (Get-Item $RepoRoot).Name

if ([string]::IsNullOrWhiteSpace($Version)) {
    if (Test-Path (Join-Path $RepoRoot "package.json")) {
        $Version = (Get-Content (Join-Path $RepoRoot "package.json") -Raw | ConvertFrom-Json).version
    } elseif (Test-Path (Join-Path $RepoRoot "Cargo.toml")) {
        $CargoToml = Get-Content (Join-Path $RepoRoot "Cargo.toml") -Raw
        if ($CargoToml -match 'version\s*=\s*"([^"]+)"') { $Version = $Matches[1] }
    }
}

if ([string]::IsNullOrWhiteSpace($Version)) { $Version = "0.1.0" }

if ([string]::IsNullOrWhiteSpace($ZipPath)) {
    $ZipPath = Join-Path $RepoRoot "dist\$ProjectName-v$Version-windows-x64.zip"
}

if (-not (Test-Path $ZipPath)) {
    Write-Warning "Archive not found at $ZipPath. Generating manifests with placeholder SHA-256."
    $Sha256 = "0000000000000000000000000000000000000000000000000000000000000000"
} else {
    $Sha256 = (Get-FileHash -Path $ZipPath -Algorithm SHA256).Hash.ToUpperInvariant()
}

$ReleaseUrl = "$RepoUrl/releases/download/v$Version/$ProjectName-v$Version-windows-x64.zip"
$PackagingDir = Join-Path $RepoRoot "packaging"

# 1. WinGet Manifest
$WingetDir = Join-Path $PackagingDir "winget\manifests\$Version"
New-Item -ItemType Directory -Path $WingetDir -Force | Out-Null

$InstallerYaml = @"
# yaml-language-server: `$schema=https://aka.ms/winget-manifest.installer.1.6.0.schema.json
PackageIdentifier: $Publisher.$ProjectName
PackageVersion: $Version
InstallerLocale: en-US
Platform:
  - Windows.Desktop
MinimumOSVersion: 10.0.17763.0
InstallerType: zip
NestedInstallerType: portable
InstallModes:
  - silent
  - interactive
Commands:
  - $ProjectName
Installers:
  - Architecture: x64
    InstallerUrl: $ReleaseUrl
    InstallerSha256: $Sha256
ManifestType: installer
ManifestVersion: 1.6.0
"@
Set-Content -Path (Join-Path $WingetDir "$Publisher.$ProjectName.installer.yaml") -Value $InstallerYaml -Encoding utf8

# 2. Scoop Manifest
$ScoopDir = Join-Path $PackagingDir "scoop"
New-Item -ItemType Directory -Path $ScoopDir -Force | Out-Null

$ScoopJson = @"
{
    "version": "$Version",
    "description": "$ProjectName application",
    "homepage": "$RepoUrl",
    "license": "MIT",
    "architecture": {
        "64bit": {
            "url": "$ReleaseUrl",
            "hash": "$Sha256"
        }
    },
    "bin": "$ProjectName.exe",
    "checkver": "github",
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "$RepoUrl/releases/download/v`$version/$ProjectName-v`$version-windows-x64.zip"
            }
        }
    }
}
"@
Set-Content -Path (Join-Path $ScoopDir "$ProjectName.json") -Value $ScoopJson -Encoding utf8

Write-Host "Generated package manifests for v$Version in $PackagingDir" -ForegroundColor Green
