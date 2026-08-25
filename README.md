# Pi + Herdr + Firstmate Fleet

A staged evaluation and operations repository for a distributed Firstmate fleet using Pi, Herdr, Moshi, and SSH-reachable hosts.

## Objective
Evaluate a Firstmate captain and remote secondmates across:

- OVH VPS: compute/persistent host
- ZimaOS: local-services/infrastructure host
- Mac mini: Moshi and Herdr-mirror control bridge

The project is deliberately isolated from the existing Central Ops/Pi deployment. No fleet cutover is implied.

## Current status
**Phase 1 — documentation scaffold and GitHub publication.** Host provisioning has not been performed by this repository.

See:

- [`docs/architecture.md`](docs/architecture.md)
- [`docs/host-readiness.md`](docs/host-readiness.md)
- [`docs/setup-plan.md`](docs/setup-plan.md)
- [`docs/evaluation-plan.md`](docs/evaluation-plan.md)
- [`docs/operations-and-recovery.md`](docs/operations-and-recovery.md)
- [`task_plan.md`](task_plan.md)
- [`findings.md`](findings.md)
- [`progress.md`](progress.md)

## Safety
Do not place credentials or live pairing material here. Use local ignored files and host secret stores. All host mutations must be separately planned, reversible, and verified.
