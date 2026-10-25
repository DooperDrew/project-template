---
name: "🤖 Agent Implementation Task"
about: Structured implementation task designed for GitHub Copilot Agent or autonomous worker subagents
title: "[Task]: "
labels: ["agent-task", "enhancement"]
assignees: []
---

## 🎯 Task Objective & Scope
<!-- A clear 1-2 sentence description of what needs to be implemented and why -->

## 📊 Complexity Tier & Target
- **Complexity Tier:** Tier 1 (Lean) | Tier 2 (Moderate) | Tier 3 (Complex / Critical)
- **Target Module / Package:** `src/core` | `crates/core` | `packages/...`
- **Target Files (Explicit Ownership):**
  - `path/to/target/file`
  - `path/to/test/file`

## 🛡️ Architectural & Performance Invariants
<!-- Specify any critical constraints (check all that apply) -->
- [ ] **Pure Logic:** Core logic isolated from side effects, 100% unit-tested.
- [ ] **Performance Budgets:** Comply with non-functional budgets defined in `docs/02-requirements.md`.
- [ ] **Safety & Invariants:** Any unsafe or privileged operations must have documented invariants.
- [ ] **Localization:** User-facing strings must reside in i18n / localization files.
- [ ] **Claims Follow Evidence:** Never claim a test or benchmark passed without running it.

## 📝 Implementation Instructions
<!-- Step-by-step guidance for the coding agent -->
1. 
2. 
3. 

## ✅ Verifiable Acceptance Criteria
<!-- Checkboxes that can be verified mechanically -->
- [ ] Unit tests added covering all new logic, branches, and error cases.
- [ ] Code formatting and style checks pass cleanly.
- [ ] Strict linter / static analysis produces zero warnings or errors.
- [ ] Full test suite passes 100%.
- [ ] Production build succeeds.

## 🔄 Sole Committer Protocol Reminder
> **Note for AI Agents:** Deliver your changes via a **Draft Pull Request** on branch `task/<issue-id>-<description>`. Do not commit directly to `main` or attempt to close this issue. The Lead Agent (Antigravity) will review, run the integration verification gate, and merge.
