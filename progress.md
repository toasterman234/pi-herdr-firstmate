# Progress

## 2026-08-25

- Received approval to create and publish the separate project.
- Confirmed `~/pi-herdr-firstmate` did not exist.
- Confirmed target GitHub repository did not exist.
- Inspected Central Ops status; did not modify it.
- Confirmed GitHub CLI authentication for `toasterman234`.
- Initialized a new local Git repository at `/Users/bencharney/pi-herdr-firstmate` on branch `main`.
- Created the initial planning and findings records.
- Added the README, operating guide, architecture, readiness, setup, evaluation, recovery, configuration examples, and doctor script.
- Ran `./scripts/doctor.sh`; documentation/configuration presence checks and `git diff --check` passed.
- Committed the scaffold as `ff50004` (`Scaffold Firstmate fleet evaluation project`).
- Created and published GitHub repository `https://github.com/toasterman234/pi-herdr-firstmate`.
- Verified the remote default branch is `main` and the local branch tracks `origin/main` with a clean status.

### Phase 2 progress
- Ran direct non-interactive SSH inventory on `ovhvps`, `zimaos`, and `macmini`.
- Verified Pi versions where present: OVH 0.84.1 and Mac 0.73.1.
- Verified Herdr status on all three: OVH 0.8.0/protocol 19; ZimaOS and Mac 0.8.2/protocol 20; all servers report running and compatible.
- Verified Moshi binaries/hooks: OVH and ZimaOS 0.3.0; Mac 0.3.1; active hook processes observed.
- Confirmed ZimaOS has no discoverable Pi binary or running Pi process in the intended account context.
- Confirmed `jq` is available on ZimaOS and Mac but absent from OVH PATH; `treehouse`, `tasks-axi`, and `gh` were absent from all three remote PATHs.
- Verified the Firstmate repository is publicly reachable with `git ls-remote`.
- Updated `findings.md` and `docs/host-readiness.md` with evidence and blockers.

### Next
- Resolve ZimaOS Pi launchability and identify the status of `treehouse`/`tasks-axi` from Firstmate's actual requirements before installing anything.
