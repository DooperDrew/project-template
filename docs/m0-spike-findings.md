# M0 Spike Findings & Technical Ground Truth

> Status: **DRAFT / TEMPLATE**  
> Purpose: Documents empirical findings from Milestone 0 diagnostic spikes.  
> Rule: **Claims Follow Evidence.** Do not write assumptions or marketing assertions here. Record only verified outputs from running diagnostic probes on real target systems.

---

## 1. Executive Summary
- **Spikes Executed:**
  - Spike M0.2: `{{Unknown #1 e.g., Native OS API discovery or external protocol compatibility}}`
  - Spike M0.3: `{{Unknown #2 e.g., Concurrency latency or memory budget proof}}`
- **Primary De-risked Items:**
  - `{{Item 1}}`
  - `{{Item 2}}`

---

## 2. Spike Findings & Empirical Evidence

### Spike M0.2: {{Title of Spike 1}}
- **Hypothesis / Question:** {{What was uncertain? e.g., Does Windows allow raw HID reads without elevation?}}
- **Probe Implementation:** Located in `{{path/to/probe or scratch script}}`
- **Methodology & Command Run:**
  ```powershell
  {{command run by user or agent}}
  ```
- **Observed Empirical Output:**
  ```text
  {{paste actual terminal / benchmark / log output}}
  ```
- **Architectural Impact:**
  - ✅ **Confirmed:** `{{What was verified to work}}`
  - ⚠️ **Quirks / Constraints Discovered:** `{{E.g., requires specific flags or permissions}}`
  - ❌ **Rejected Assumptions:** `{{What failed or proved impossible, requiring fallback}}`

---

### Spike M0.3: {{Title of Spike 2}}
- **Hypothesis / Question:** {{What was uncertain?}}
- **Probe Implementation:** Located in `{{path/to/probe}}`
- **Methodology & Command Run:**
  ```powershell
  {{command}}
  ```
- **Observed Empirical Output:**
  ```text
  {{output}}
  ```
- **Architectural Impact:**
  - ✅ **Confirmed:** `{{Finding}}`

---

## 3. Decision Gate Resolution

Review against the 🔬 items in [`docs/02-requirements.md`](02-requirements.md) and [`docs/03-architecture.md`](03-architecture.md):

| Spike Item | Requirement Affected | Ground Truth Result | Architectural Decision |
|---|---|---|---|
| M0.2 | F1.3 / NFR-P1 | PASS / FAIL / MODIFIED | Recorded in ADR-0001 |
| M0.3 | F2.1 | PASS / FAIL / MODIFIED | Recorded in ADR-0002 |

> **Milestone 0 Exit Criteria:** All 🔬 spike items are empirically verified or assigned an accepted fallback before Milestone 1 begins.
