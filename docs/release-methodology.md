# Release, Packaging & Multi-Channel Distribution Methodology

> Status: **CANONICAL RELEASE GUIDE**  
> Purpose: Standardized semantic versioning, artifact packaging, package manager manifest generation, and GitHub Releases pipeline.

---

## 1. Semantic Versioning (SemVer)
- **MAJOR (`X.0.0`):** Breaking architectural changes, protocol alterations, backwards-incompatible config migrations, or graduating to production `1.0.0`.
- **MINOR (`0.X.0`):** Backwards-compatible features, UX enhancements, installers, or new hardware models.
- **PATCH (`0.X.Y`):** Bug fixes, translations, timing tuning.

---

## 2. Single Source of Truth for the Version
`{{e.g. root Cargo.toml [workspace.package] version / package.json version}}`. All packaging scripts (`scripts/package-release.ps1`, `scripts/generate-manifests.ps1`, `scripts/install.ps1`) read the version dynamically from there and never hardcode it.

---

## 3. Multi-Channel Distribution Standard (Zero-Build User Experience)
Every release milestone MUST provide pre-built, zero-elevation distribution channels so end users never have to compile from source:
1. **Portable Release Archive (`.zip` on GitHub Releases):** Produced by `scripts/package-release.ps1`, containing compiled release binaries, localization files (`locales/`), documentation (`README.md`, `user-guide.md`, `LICENSE`), and setup scripts.
2. **Guided Setup Wizard (`setup.cmd` / `scripts/setup-wizard.ps1`):** Zero-elevation installer (with `-Silent` and `-NoGui` modes) that installs into `%LOCALAPPDATA%\Programs\<AppName>`, creates Start Menu and Desktop shortcuts, configures `HKCU\...\Run` logon autostart, and registers in Windows **Installed apps** (`HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\<AppName>`).
3. **User-Space CLI Installer & Uninstaller (`scripts/install.ps1` & `scripts/uninstall.ps1`):** Supports `-Silent` and `-PurgeData` flags.
4. **Package Manager Manifests (`scripts/generate-manifests.ps1`):** Automatically calculates the `.zip` SHA-256 hash and generates:
   - **Microsoft WinGet (`1.9.0`):** `packaging/winget/manifests/<first-letter>/<Publisher>/<Package>/<Version>/`
   - **Scoop:** `packaging/scoop/<app>.json`

> **Documentation Parity Rule:** Whenever packaging or installation capabilities are added or updated, `README.md` (`## 📥 Installation & Distribution Options`) and `docs/user-guide.md` (`## 2. Installation & Setup` + `## 6. Uninstallation`) MUST be updated in the same commit to document all 4 installation channels (WinGet, Scoop, Guided Setup Wizard, Portable ZIP).

---

## 4. Official 5-Step Release Procedure (Lead Agent Only)
1. Bump the version in the single source of truth + write the `CHANGELOG.md` entry (+ update `README.md` and `docs/user-guide.md` links).
2. Run the full verification gate (formatting, strict linter, automated test suite, release build).
3. Package the portable `.zip` and generate WinGet/Scoop manifests:
   ```powershell
   .\scripts\package-release.ps1 -Version "X.Y.Z"
   .\scripts\generate-manifests.ps1 -Version "X.Y.Z"
   ```
4. `git commit -m "release: vX.Y.Z"` → `git tag -a vX.Y.Z -m "Release vX.Y.Z"` → `git push origin main --tags`.
5. Publish to GitHub Releases:
   - Automated via `.github/workflows/release.yml` on tag push (`v*`).
   - Or manually via GitHub CLI:
     ```bash
     gh release create vX.Y.Z "dist/<App>-vX.Y.Z-windows-x64.zip" --title "vX.Y.Z" --notes-file release-notes.md --latest
     ```
   Build artifacts (`target/`, `dist/`) go to GitHub Releases, **never into git**.

---

## 5. Pre-Release Checklist
- [ ] Clean working tree (`git status`).
- [ ] NFR budgets measured for this version (see `docs/06-qa-and-validation.md`).
- [ ] Real-environment QA status listed in the release notes (`Pass` / `Pending`).
- [ ] No hardcoded UI strings; translations complete.
- [ ] Portable `.zip` archive verified to contain executables, `locales/`, `setup.cmd`, `install.ps1`, `uninstall.ps1`, and `user-guide.md`.
- [ ] SHA-256 checksums verified.

---

## 6. Hotfix
Ship a patch version through the same pipeline and flag the defective release on GitHub Releases.
