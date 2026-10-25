# AGENTS.md — Mandatory Operating Guidelines for AI Agents

> You are working on **{{PROJECT_NAME}}** ({{REPO_URL}}).
> These rules are binding for every agent and every conversation in this repository.

## 1. Mission
{{ONE_PARAGRAPH_MISSION}}

## 2. Mandatory reading order (before any implementation)
1. `docs/01-vision.md`: problem, principles, non-goals
2. `docs/02-requirements.md`: requirement IDs (F…, NFR-…) and budgets
3. `docs/03-architecture.md`: components, boundaries, key designs
4. `docs/04-ux.md`: UI/UX spec (if present)
5. `docs/05-roadmap.md`: **the single source of truth for tasks**
6. `docs/<spike>-findings.md`: verified ground truth from M0 spikes. Don't contradict or guess beyond it.
7. `docs/decisions/`: ADRs. Changing a decision requires a new ADR.
8. `docs/lessons-learned.md` and `CHANGELOG.md`: history and pitfalls to avoid

## 3. Continuous Learning & Self-Correction Rule
Whenever the user corrects, redirects, or clarifies a requirement:
- **Do not silently apply the change.**
- You MUST explicitly formulate the takeaway as a rule and propose writing it into `docs/lessons-learned.md` (or `AGENTS.md` if binding).
- This ensures that lessons learned in one chat session immediately persist for all subsequent sessions.

## 4. Roles (multi-agent)
- **Lead agent (sole committer):** the only one allowed to `git commit`, `git push`, tag, release, or close issues.
  Plans parallel work, reviews worker output, runs the verification gate, and syncs docs.
- **Worker agents (`project-worker`):** work in isolated branch workspaces on **disjoint files**. **Forbidden:** `git commit`, `git push`,
  `git checkout main`, closing issues. They deliver results via the completion report in §8.
- Worker role names follow `<Tier>-<Domain>-<Milestone>` (e.g. `T1-Core-M1`).

## 5. Complexity tiers & model selection
| Tier | Scope | Model |
|---|---|---|
| T1 Lean | pure logic, schemas, tests, i18n, docs, scripts | `flash_lite` / `flash` |
| T2 Moderate | UI, IPC, standard platform APIs | `flash` / `pro` |
| T3 Critical | {{CRITICAL_AREAS e.g. concurrency, security, hot paths, hardware}} | `pro` / `inherit` |

Fallback order: `inherit` → `pro` → `flash` → `flash_lite`. Every fallback **must** be logged in
`docs/model-fallback-log.md`, and a review task for it goes into the hardening milestone.

## 6. Task lifecycle
**Before:** find the task in the roadmap, restate the task + tier + target files + acceptance criteria, and check that `git status` is clean. Ensure toolchain PATH is initialized.
**During:** respect the hard rules (§7). Unverified assumptions are marked 🔬 and probed, not guessed. Decouple headless tests from physical QA (keep manual QA as Pending).
**Gate (must pass before finishing):**
```
{{VERIFICATION_GATE_COMMANDS}}
```
**After (lead only):** tick the roadmap box (date + commit), add a CHANGELOG entry, update docs/ADRs if the design changed,
add any lesson to `docs/lessons-learned.md`, commit (`M<x>.<y>: <summary>`), push, and update the issue.

## 7. Hard rules
{{PROJECT_HARD_RULES — performance budgets, safety constraints, forbidden techniques, security rules}}
- **Claims follow evidence:** Never claim a test, benchmark, or QA item passed without having run it. Hardware/manual QA stays `Pending` until the user confirms.
- **Keep claims in docs factual:** Avoid marketing language ("pioneering", "zero bugs") in technical specs while QA is pending.
- **Environment resiliency:** Prepend `$env:USERPROFILE\.cargo\bin` (or relevant toolchain) in PowerShell commands to guard against PATH omissions.
- **Test concurrency:** Tests touching global OS resources (pipes, sockets, registry, hooks) must use unique names and timeout protection to prevent test hangs.
- User-facing strings go through i18n files. Don't hardcode UI text.
- Files are UTF-8. Never commit build artifacts (e.g. `dist/`, `target/`); releases go to GitHub Releases.

## 8. Worker completion report (required format)
```markdown
### WORKER COMPLETION REPORT: <Role>
- Task: <ID + description>
- Model used: <model> (fallback? yes/no + reason)
- Files created/modified: <list>
- Verification: <each gate command: PASS/FAIL, test counts>
- Decisions & rationale: <numbered>
- Open issues / risks / follow-ups: <list>
```

## 9. Escalation
If reality contradicts the docs (tests, hardware, external API behaviour): **stop**, report the evidence to the user,
propose a probe, and update the docs only after the user agrees.

## 10. Build & run
{{BUILD_RUN_COMMANDS}}
