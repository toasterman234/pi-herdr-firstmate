# Setup Plan

## Phase A — baseline (complete)
- Create this isolated repository.
- Record current host and Moshi/Herdr observations.
- Do not modify Central Ops or active fleet state.

## Phase B — readiness (next)
- Use explicit SSH aliases and absolute binaries.
- Install only missing dependencies after recording package/version and rollback.
- Resolve Pi on ZimaOS and Mac mini.
- Confirm Herdr/Moshi persistence after logout/reboot where safe.
- Verify auth and Firstmate repository access independently.

## Phase C — isolated profile
- Create `firstmate-fleet` Pi profile/state paths.
- Install/configure Firstmate under an absolute code root outside Central Ops.
- Set `FM_HOME` to the captain home.
- Keep live state and credentials out of Git.

## Phase D — one-host pilot
- Select one disposable secondmate, preferably ZimaOS or Mac mini after readiness passes.
- Provision a disposable remote home and Herdr session.
- Exercise send/reply, status, disconnect, restart, and cleanup.

## Change procedure
1. Document intended mutation and rollback.
2. Take a configuration/version snapshot where practical.
3. Apply the smallest change on one host.
4. Run a fresh check.
5. Update `findings.md` and `progress.md`.
6. Expand only after acceptance.
