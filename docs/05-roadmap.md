# 05 — Roadmap

> The single source of truth for tasks. Each task fits in **one conversation** (or one worker).
> Tick boxes with `(YYYY-MM-DD, <commit>)`. Don't start a milestone before the previous **Exit** is met.
> ⇉ = can run in parallel with the other ⇉ tasks in the same milestone (disjoint files).

## M0 — Spikes 🔬 (decision gate)
- [ ] M0.1 Project skeleton + verification gate working locally (and in CI if applicable).
- [ ] M0.2 ⇉ Probe/prototype for {{unknown #1}}.
- [ ] M0.3 ⇉ Probe/prototype for {{unknown #2}}.
- [ ] M0.4 User runs the probes in the real environment; results go into `docs/{{spike}}-findings.md`.
- [ ] M0.5 Resolve the 🔬 items in requirements/architecture and record any design change as an ADR.
**Exit:** every 🔬 item resolved or has an accepted fallback.

## M1 — Skeleton
- [ ] M1.1 ⇉ {{}}
- [ ] M1.2 ⇉ {{}}
**Exit:** {{measurable}}

## M2 — Core logic
- [ ] M2.1 {{}}
**Exit:** {{}}

## M3 — Integrations / platform

## M4 — UI

## M5 — Hardening & verification
- [ ] M5.1 Measure every NFR budget and record the results in `docs/06-qa-and-validation.md`.
- [ ] M5.2 Soak / edge-case tests.
- [ ] M5.3 Audit any code produced by fallback models (see `docs/model-fallback-log.md`).
- [ ] M5.4 Real-environment QA run by the user (manual matrix).

## M6 — Packaging & release
- [ ] M6.1 Release script + artifact.
- [ ] M6.2 User guide + known limitations.
- [ ] M6.3 First release following `docs/release-methodology.md`.

## M7 — Retrospective
- [ ] M7.1 Run the `project-retrospective` skill and feed the lessons back into the kit.
