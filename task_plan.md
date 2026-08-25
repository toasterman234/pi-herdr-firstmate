# Pi + Herdr + Firstmate Fleet Plan

## Goal
Evaluate and, only after staged verification, operate a Firstmate fleet with an isolated Pi profile, Herdr host sessions, Moshi mobile access, and hosts on OVH VPS, ZimaOS, and Mac mini. Preserve the existing Central Ops/Pi deployment and avoid fleet cutover.

## Current phase
**Phase 1 — project scaffold and publication** (in progress)

## Phases
- [ ] Phase 1: Scaffold repository, capture baseline, verify docs, publish GitHub repository.
- [ ] Phase 2: Verify host toolchains and non-interactive launch contexts.
- [ ] Phase 3: Provision isolated Pi profile and Firstmate captain home.
- [ ] Phase 4: Pilot one disposable remote secondmate.
- [ ] Phase 5: Exercise routing, disconnect, restart, outage, and recovery scenarios.
- [ ] Phase 6: Add remaining hosts only after pilot acceptance.
- [ ] Phase 7: Document operations, backups, monitoring, and rollback; decide whether to operationalize.

## Guardrails
- Never modify the existing Central Ops checkout or its Pi profile for this project.
- Use explicit paths and host aliases; do not rely on interactive shell PATH.
- Do not cut over existing workloads.
- Do not store credentials, tokens, pairing secrets, or private keys in this repository.
- Every host mutation gets a reversible procedure and a fresh verification check.
- Git commits and GitHub publication are allowed for this explicitly approved project; no changes are committed in Central Ops.

## Decisions
| Date | Decision | Reason |
|---|---|---|
| 2026-08-25 | New repo is `~/pi-herdr-firstmate`, GitHub target `toasterman234/pi-herdr-firstmate`. | Isolate planning and operations from tangled Central Ops changes. |
| 2026-08-25 | Keep Firstmate orchestration distinct from Herdr/Moshi presentation. | Firstmate owns routing/lifecycle; Herdr owns sessions; Moshi is mobile access. |
| 2026-08-25 | Start with one disposable remote secondmate. | Reduce blast radius and prove lifecycle/recovery before expansion. |

## Error log
| Attempt | Error | Resolution |
|---|---|---|
| 1 | RLM unavailable: Ax dependency missing in extension directory. | Fell back to inline plan; no project files were affected by the failed call. |

## Acceptance criteria for Phase 1
- Repository exists locally with a clean, coherent scaffold.
- Baseline host facts and uncertainties are documented with verification date.
- Isolated profile and Firstmate paths are documented but not activated.
- Local validation passes.
- GitHub repository is published and the remote is verified.
