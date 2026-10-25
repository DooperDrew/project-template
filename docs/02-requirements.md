# 02 — Requirements

> Status: **DRAFT**. Priority: **M**ust / **S**hould / **C**ould.
> 🔬 = depends on a Milestone 0 spike; it isn't verified yet.

## Functional requirements

### F1 — {{Feature name}} (M)
- F1.1 {{Testable statement}}
- F1.2 {{Testable statement}}
- F1.3 **Fallback:** {{what happens if the 🔬 assumption turns out false}}

### F2 — {{Feature name}} 🔬 (S)
- F2.1 …

## Non-functional requirements

### Performance (hard budget, verified in the hardening milestone)
| ID | Metric | Budget | How it's measured |
|---|---|---|---|
| NFR-P1 | {{e.g. idle RAM}} | {{≤ 10 MB}} | {{tool/test}} |
| NFR-P2 | {{e.g. idle CPU}} | {{0%, event-driven}} | |
| NFR-P3 | {{e.g. hot-path latency}} | {{< 0.1 ms}} | {{benchmark test}} |

### Safety, security & compatibility
- NFR-S1 {{e.g. no admin rights, no injection}}
- NFR-S2 {{e.g. graceful failure: no stuck state on crash}}
- NFR-S3 {{e.g. no network / no telemetry}}

### Quality
- NFR-Q1 Core logic is pure and unit-tested.
- NFR-Q2 Logging is off by default; a debug toggle exists.
