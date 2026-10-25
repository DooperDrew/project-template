# Operating Rules & Instructions for GitHub Copilot

> **Repository:** `{{REPO_URL}}`  
> **Role of GitHub Copilot:** Worker Subagent / Fast Draft Implementer  
> **Lead Orchestrator & Sole Committer:** Antigravity (Local Lead Agent)

Whenever working on this repository — whether via Copilot Agent, Copilot in VS Code / IDE, or GitHub Pull Request review — you MUST strictly comply with the guidelines, architecture, performance budgets, and Sole Committer protocol defined below and in [`AGENTS.md`](../AGENTS.md).

---

## 1. Division of Labor & Sole Committer Protocol

This project enforces a strict **Hub-and-Spoke (Lead Orchestrator & Worker)** multi-agent model:

```
[ User / Product Owner ]  ──► [ Lead Agent (Antigravity) ]
                                      │
        ┌─────────────────────────────┴─────────────────────────────┐
        ▼                                                           ▼
 Project Docs & Issue Prep                                  Verification & Quality Gate
(Tasks, Complexity Tiers, Owned Files)                      (Runs tests, audits budgets, merges)
        │                                                           ▲
        ▼                                                           │
 [ GitHub Issue #N (agent_task) ]                                   │
        │                                                           │
        ▼                                                           │
[ GitHub Copilot Agent ] ──────────( Draft Pull Request )───────────┘
```

### Copilot Responsibilities & Boundaries:
- **Fast Draft Implementer:** Consume bounded, self-contained GitHub Issues created from `.github/ISSUE_TEMPLATE/agent_task.yml`, generate scaffolding, implement core logic, create UI views, and write comprehensive unit tests.
- **Draft Pull Requests Only:** Work strictly on dedicated feature branches (`task/<issue-id>-<description>`) and submit **Draft Pull Requests**.
- **PROHIBITED:**
  - ❌ Never execute `git push origin main` or attempt to commit directly to `main`.
  - ❌ Never merge pull requests into `main`.
  - ❌ Never close GitHub Issues.
  - Only the Lead Agent (Antigravity) is authorized to run the final release gate, merge branches to `main`, update project tracking, and close issues.

---

## 2. Architecture & Module Separation Boundaries

To allow parallel development across multiple agents without merge conflicts:
1. **Disjoint Module Boundaries:**
   - Independent tasks must touch disjoint files. Check the **Target Files & Ownership** section of your assigned GitHub Issue.
   - Do not edit files outside your assigned ownership scope without explicit instruction.
2. **Pure Core Logic vs. Platform/IO:**
   - Keep business logic pure, deterministic, and isolated from OS / network / disk I/O.
   - Platform-dependent integrations, hardware hooks, and UI layers must depend on core logic, never the reverse.
3. **Zero Hardcoded Strings:**
   - All user-facing UI text, error messages, and labels must go through localization / i18n dictionaries.

---

## 3. Non-Negotiable Performance & Safety Budgets

Every contribution by Copilot MUST respect the non-functional requirements defined in [`docs/02-requirements.md`](../docs/02-requirements.md):

1. **Performance Budgets (NFR-P):**
   - Strictly adhere to specified latency, CPU, and memory budgets.
   - For hot paths or event hooks: avoid heap allocations, blocking locks, and synchronous I/O.
2. **Safety & Invariants (NFR-S):**
   - Avoid undefined behavior, unhandled errors, or unwrap operations on fallible calls.
   - Any unsafe, native, or privileged operations must include explicit explanatory comments documenting preconditions and invariants.
3. **Claims Follow Evidence Rule:**
   - Mark automated unit, integration, and invariant tests as **PASS** only when verified by the verification gate.
   - Never mark physical hardware, third-party cloud credentials, or manual QA as passed without empirical proof. Keep manual QA rows marked **`Pending`**.

---

## 4. Verification Gate & Environment Hygiene

### Toolchain PATH Resiliency:
Never assume standard toolchains (`cargo`, `npm`, `python`, `uv`, `go`) are globally present in subshell `$env:PATH`. On Windows, always ensure your execution environment initializes the required toolchain paths.

### Verification Gate (Must Pass 100% Locally):
Before submitting a Draft PR or marking an implementation complete, run the project verification gate:
```bash
# 1. Format verification
# 2. Strict linter / static analysis (warnings treated as errors)
# 3. Full automated test suite
# 4. Release / production build
```

---

## 5. Draft PR Submission Checklist

When opening your Draft Pull Request:
- [ ] PR title formatted as `task/<issue-id>: <concise description>`
- [ ] Base branch is set to `main`
- [ ] PR marked as **Draft**
- [ ] PR description links the originating issue (`Closes #N`)
- [ ] All verification gate commands pass cleanly
- [ ] No files outside the assigned ownership scope were touched
