# Release & Versioning

## SemVer
- **MAJOR:** breaking changes (APIs, protocols, config format) or graduating to 1.0.
- **MINOR:** backward-compatible features.
- **PATCH:** fixes, translations, tuning.

## Single source of truth for the version
{{e.g. root Cargo.toml [workspace.package] version / package.json version}}. Scripts read it from there and never hardcode it.

## Release procedure (lead agent only, with user approval)
1. Bump the version + write the CHANGELOG entry (+ README badge).
2. Run the full verification gate.
3. Build the release artifact with `{{scripts/package-release}}`.
4. `git commit` → `git tag -a vX.Y.Z` → `git push origin main --tags`.
5. `gh release create vX.Y.Z <artifact> --notes-file <notes>`. Artifacts go to GitHub Releases, **never into git**.

## Pre-release checklist
- [ ] Clean working tree.
- [ ] NFR budgets measured for this version (see QA doc).
- [ ] Real-environment QA status listed in the release notes (Pass / Pending).
- [ ] No hardcoded UI strings; translations complete.
- [ ] Artifact contents verified.

## Hotfix
Ship a patch version through the same pipeline and flag the bad release on GitHub.
