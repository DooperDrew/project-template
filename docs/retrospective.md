# Milestone Retrospective & Continuous Improvement

> **Scope:** Milestone Review (e.g. M0 → v0.1.0)  
> **Purpose:** Mines git history, agent transcripts, and issue tracking to evaluate engineering velocity, what worked, root causes of failures, and promote durable lessons into operating guidelines.

---

## 1. Project Milestone Timeline

| Phase | Description | Key Commits | Conversations / Sessions |
|---|---|---|---|
| **Definition (M0)** | Specs, architecture, spikes, verification gate | `commit_hash` | Lead session |
| **Skeleton & Core (M1-M2)** | Pure domain logic, unit tests, module boundaries | `commit_hash` | Worker subagents |
| **Integrations & UI (M3-M4)** | OS APIs, IPC, UI views, state management | `commit_hash` | Worker subagents |
| **Hardening & QA (M5)** | NFR budget measurements, edge cases, soak tests | `commit_hash` | Lead + QA matrix |
| **Release & Docs (M6)** | Packaging scripts, manifests, user guide | `commit_hash` | Lead session |

---

## 2. What Worked (Empirical Evidence)

- **Spec-First Pipeline:** Having clear requirements and budgets in `docs/` before implementation prevented architectural drift and scope creep.
- **Sole Committer Protocol:** Keeping git commit and push authority exclusively with the Lead Agent eliminated merge conflicts across concurrent workers.
- **Disjoint Module Scoping:** Structuring modules (`core`, `platform`, `ui`) as independent directories enabled parallel worker subagents to make disjoint commits.
- **Automated Verification Gate:** Requiring formatting, linting, tests, and release build to pass on every change caught regressions immediately.

---

## 3. What Went Wrong & Friction Points

| # | Friction / Failure Mode | Root Cause | Preventive Rule Adopted |
|---|---|---|---|
| 1 | Subshell PATH missing required toolchain | Worker shells did not inherit full environment variables | Added explicit `$env:PATH` initialization rule to `AGENTS.md` |
| 2 | Parallel worker API signature drift | Two workers edited consumer and producer simultaneously | Enforced frozen interfaces before spawning parallel workers |
| 3 | Premature claims of QA completion | QA claimed as passed without empirical execution | Established strict **Claims Follow Evidence** protocol |

---

## 4. Multi-Agent Velocity & Token Economics

- **Total Agent Sessions:** `{{Number}}` (Interactive Lead: `{{N}}`, Worker Subagents: `{{N}}`, Cloud Copilot tasks: `{{N}}`)
- **Complexity Tier Distribution:**
  - Tier 1 (Lean - Flash/Lite): `{{N}}%`
  - Tier 2 (Moderate - Pro/Sonnet): `{{N}}%`
  - Tier 3 (Critical - Opus/Pro): `{{N}}%`
- **Token Efficiency Gain:** Routing T1/boilerplate tasks to lighter models saved an estimated `~70-80%` in token consumption compared to running single-model sessions.

---

## 5. Promoted Lessons Learned

List lessons promoted to:
1. **Repository Rules ([`AGENTS.md`](../AGENTS.md)):** `{{Project-specific rules}}`
2. **Global Methodology ([`docs/lessons-learned.md`](lessons-learned.md)):** `{{Generic engineering rules}}`
