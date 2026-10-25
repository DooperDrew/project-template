# 06 — QA & Validation

## Verification levels
1. **Automated unit/invariant tests:** run by the gate on every change.
2. **Automated budget/soak tests:** the NFR budgets (latency, memory, concurrency).
3. **Real-environment QA:** manual, run by the user on real hardware/accounts/devices.
4. **System edge cases:** permissions, sleep/resume, network loss, upgrades.

> A QA row is **Pass** only with evidence (date, environment, who ran it). Until then it stays **Pending**.
> Releases list which rows are still Pending.

## NFR budget results
| ID | Budget | Measured | Date / commit | Method |
|---|---|---|---|---|
| NFR-P1 | | | | |

## Real-environment test matrix
| Test ID | Area | Procedure | Expected | Result | Date / env / tester |
|---|---|---|---|---|---|
| QA-01 | {{}} | {{}} | {{}} | Pending | |

## Edge cases
| Test ID | Invariant | Procedure | Expected | Result |
|---|---|---|---|---|
| QA-SYS-01 | {{}} | {{}} | {{}} | Pending |

## Incident protocol
Any discrepancy: check the findings docs → if it's new, write a probe report + open an issue labelled `bug` → add a regression test.
