<#
.SYNOPSIS
    Builds, stages, and packages a release archive with SHA-256 checksums.

.DESCRIPTION
    Standardized release packaging script for Project Kickstart repositories.
    Builds release targets, stages binaries and documentation, creates a portable .zip,
    and computes the SHA-256 hash for distribution manifests.

.PARAMETER Version
    The semantic version string (e.g. "0.1.0"). If omitted, attempts to parse from project metadata.

.PARAMETER SkipBuild
    If specified, skips the compilation/build step and only packages existing artifacts.
#>

param(
    [string]$Version = "",
    [switch]$SkipBuild = $false
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$RepoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

# Detect project version if not provided
if ([string]::IsNullOrWhiteSpace($Version)) {
    if (Test-Path (Join-Path $RepoRoot "package.json")) {
        $Pkg = Get-Content (Join-Path $RepoRoot "package.json") -Raw | ConvertFrom-Json
        $Version = $Pkg.version
    } elseif (Test-Path (Join-Path $RepoRoot "Cargo.toml")) {
        $CargoToml = Get-Content (Join-Path $RepoRoot "Cargo.toml") -Raw
        if ($CargoToml -match 'version\s*=\s*"([^"]+)"') { $Version = $Matches[1] }
    }
}

if ([string]::IsNullOrWhiteSpace($Version)) {
    $Version = "0.1.0"
    Write-Warning "Could not detect version automatically. Defaulting to v$Version."
}

$ProjectName = (Get-Item $RepoRoot).Name
Write-Host "=== Packaging $ProjectName v$Version ===" -ForegroundColor Cyan

# 1. Build release target if not skipped
if (-not $SkipBuild) {
    Write-Host "Running release build..." -ForegroundColor Yellow
    # Uncomment / adapt the build command for your stack:
    # cargo build --workspace --release
    # npm run build
    # dotnet publish -c Release
}

# 2. Stage release files
$DistDir = Join-Path $RepoRoot "dist"
$StageDir = Join-Path $DistDir "$ProjectName-v$Version-windows-x64"
$ZipPath = Join-Path $DistDir "$ProjectName-v$Version-windows-x64.zip"

if (Test-Path $StageDir) { Remove-Item -Path $StageDir -Recurse -Force }
if (Test-Path $ZipPath) { Remove-Item -Path $ZipPath -Force }

New-Item -ItemType Directory -Path $StageDir -Force | Out-Null

# Copy documentation and licenses
Copy-Item (Join-Path $RepoRoot "README.md") $StageDir -ErrorAction SilentlyContinue
Copy-Item (Join-Path $RepoRoot "LICENSE") $StageDir -ErrorAction SilentlyContinue
Copy-Item (Join-Path $RepoRoot "CHANGELOG.md") $StageDir -ErrorAction SilentlyContinue

# Copy built binaries (customize for your project output)
# Copy-Item (Join-Path $RepoRoot "target\release\*.exe") $StageDir -ErrorAction SilentlyContinue

# 3. Create portable archive
Write-Host "Creating archive: $ZipPath" -ForegroundColor Yellow
Compress-Archive -Path "$StageDir\*" -DestinationPath $ZipPath -Force

# 4. Compute SHA-256 hash
$Hash = (Get-FileHash -Path $ZipPath -Algorithm SHA256).Hash.ToUpperInvariant()
$HashFile = "$ZipPath.sha256"
Set-Content -Path $HashFile -Value "$Hash  $([System.IO.Path]::GetFileName($ZipPath))" -Encoding utf8

Write-Host "=== Release Package Ready ===" -ForegroundColor Green
Write-Host "Archive: $ZipPath"
Write-Host "SHA-256: $Hash"
