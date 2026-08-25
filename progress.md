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

### Installation progress
- Audited the current Firstmate `main` toolchain requirements and backend requirements.
- Installed Firstmate npm tools (`tasks-axi`, `quota-axi`, `gh-axi`, `chrome-devtools-axi`, `lavish-axi`) on OVH, ZimaOS, and Mac mini.
- Confirmed Pi was already installed on ZimaOS at `/DATA/bcharney234/.nvm/versions/node/v24.18.0/bin/pi` version 0.82.1; the initial install attempt stopped safely on an existing-file collision.
- Installed Treehouse v2.0.1 from Firstmate's checksum-pinned official installer on all three hosts.
- Installed official no-mistakes v1.57.0 on all three hosts; this satisfies Firstmate's 1.31.2 minimum, unlike the npm package version.
- Installed GitHub CLI: OVH apt package 2.4.0, ZimaOS verified official v2.98.0 Linux amd64 archive with checksum into user-local bin, Mac Homebrew 2.98.0.
- Installed OVH jq 1.6; ZimaOS and Mac already had jq.
- Ran Firstmate's read-only/local-only `fm-bootstrap.sh` detector with `FM_BACKEND=herdr` and isolated temporary `FM_HOME` on all three hosts; no missing-tool lines were emitted and all exited successfully.
- No Firstmate captain/secondmate homes were created and no existing Herdr/Moshi services were restarted.
- Noted OVH apt's pending kernel update; no reboot performed.
- The local Pi preflight was attempted but failed because Docker/Redis is unavailable locally; this is unrelated to host installation.

### Phase 2/3 completion
- Verified public Git access to both the Firstmate repository and this project repository from OVH, ZimaOS, and Mac mini.
- Verified GitHub CLI auth without exposing credentials: ZimaOS is authenticated as `toasterman234`; OVH has no active GitHub login; Mac mini has an invalid stored token.
- Verified harmless Pi `--help` launch/exit with isolated state paths on OVH, ZimaOS, and Mac mini. Mac was run through `/opt/homebrew/bin/pi` to avoid the pre-existing NVM npmrc warning.
- Selected OVH as the initial captain host because it has Pi, Herdr, the complete toolchain, and can host the isolated captain without touching Central Ops.
- Created isolated OVH Firstmate code root: `/home/ubuntu/firstmate-fleet/firstmate`.
- Created isolated captain home: `/home/ubuntu/.firstmate/captain`.
- Created isolated Pi profile/session paths: `/home/ubuntu/.pi/firstmate-fleet` and `/home/ubuntu/.pi/firstmate-fleet/sessions`.
- Ran isolated `fm-bootstrap.sh` with `FM_BACKEND=herdr`, `FM_BOOTSTRAP_NETWORK=skip`, and verified the home markers and Pi help output.
- No live secondmate was provisioned, no watcher was armed, and no existing Central Ops/Pi/Herdr/Moshi state was changed.

### Phase 4 readiness progress
- Ran `fm-remote-doctor.sh --fix` on the isolated OVH Firstmate root. It installed/reloaded the Linux `dev.firstmate.remote-job` worker, started the dedicated Herdr `fm-remote` session, and created the Firstmate-owned `fm-remote-entrypoint.sh` symlink.
- Re-ran the doctor in check mode; all remote-secondmate checks passed, including worker probe, Herdr server, and entrypoint link.
- Confirmed ZimaOS has Pi, tasks-axi, and quota-axi under NVM, but non-interactive SSH does not load NVM. A pilot route must use Firstmate's composed remote PATH or an explicit NVM environment; no ZimaOS mutation was made in this step.
- No remote secondmate was provisioned yet. No GitHub login flow was attempted because OVH has no usable existing credential and Mac's stored token is invalid; repairing those requires a new interactive authorization.

### Follow-up pilot progress
- Created the isolated ZimaOS Firstmate checkout at `/DATA/bcharney234/firstmate-fleet/firstmate` and isolated readiness home at `/DATA/bcharney234/.firstmate/remote-readiness`.
- Ran ZimaOS bootstrap plus `fm-remote-doctor.sh --fix` and a check pass. The composed child PATH found the NVM-installed runtime and Firstmate tools; the Linux worker, `fm-remote` Herdr session, and fixed entrypoint all passed.
- The provisioning SSH command timed out only after both doctor passes had reported success. A fresh post-timeout verification then passed: the isolated checkout, entrypoint, Linux worker/probe, Herdr `fm-remote`, and required tools remain healthy.

### Next
- Verify the ZimaOS isolated checkout, worker, Herdr `fm-remote`, and entrypoint after the timeout.
- Validate the OVH captain's actual interactive Pi trust/extension path.
- Create and fill one disposable secondmate charter, then provision only that ZimaOS route.
- Provisioned one disposable no-projects ZimaOS remote secondmate at `/DATA/bcharney234/.firstmate/secondmates/zimaos-pilot`; the captain route records the remote root/home and the command reported `projects=0`.
- Verified the remote home contains `.fm-secondmate-home`, `.fm-secondmate-parent`, `AGENTS.md`, and isolated Firstmate state. No production project clone was created.
- Attempted the disposable Pi secondmate launch through the real remote route. The Herdr endpoint was created but immediately died because the remote worker invoked Pi with Node `v20.20.2`, while ZimaOS Pi's installed undici dependency requires the Node 24 runtime where Pi is installed. No send/reply or teardown test was run against a live agent.
- Added and verified an explicit `/DATA/bcharney234/.local/bin/node` wrapper for the Node 24 binary; restored the temporary SSH rc mutation after testing. The remote worker environment resolves the wrapper as Node `v24.18.0` and Pi `0.82.1`.
- Captured the actual Herdr `fm-remote` pane. The Pi command uses the NVM Pi path, but its `#!/usr/bin/env node` shebang resolves Node `v20.20.2` inside the Herdr pane, causing the same undici crash. The remaining defect is Herdr pane PATH inheritance, not remote worker PATH discovery.
- Exercise send/reply and teardown before adding any other host.
