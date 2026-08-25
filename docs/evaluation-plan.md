# Evaluation Plan

## Acceptance gates

### Gate 1 — host launchability
For every intended host, prove the exact account can launch Pi, Herdr, and required Firstmate tools in a non-interactive SSH command.

### Gate 2 — isolated captain
Prove Firstmate can start with the dedicated Pi profile and `FM_HOME` without reading or changing Central Ops state.

### Gate 3 — one remote secondmate
Prove a disposable secondmate can receive a task, produce a correlated reply, and leave durable state.

### Gate 4 — recovery
Test SSH disconnect, remote Herdr restart, captain restart, remote host outage, and retry/reconciliation behavior.

### Gate 5 — mobile control
From Moshi, verify discovery, workspace/pane visibility, agent status, notification, and any approval flow used by the pilot.

## Evidence to capture
- Commands and sanitized outputs in `findings.md`.
- Version matrix and host readiness updates.
- Firstmate/Herdr session identifiers without secrets.
- Expected versus observed behavior for each scenario.
- Recovery time and manual intervention required.

## Stop conditions
Stop and reassess if a test would overwrite existing state, if host identity is ambiguous, if credentials would be copied into the repo, or if a failure cannot be reversed safely.
