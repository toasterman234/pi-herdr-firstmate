# Findings

## Baseline — 2026-08-25

### Existing workspace
- Existing Central Ops checkout: `/Users/bencharney/central-ops`.
- It has substantial unrelated staged/uncommitted history and must not be used for this project.
- Existing Central Ops planning files remain authoritative for Central Ops and are not copied into this repository.

### Local tooling and authentication
- GitHub CLI is installed and authenticated as `toasterman234` with repository/workflow scopes.
- Existing Central Ops profile tooling is in `central-ops/tools/manage-profile.py` and `central-ops/tools/generate-pi-profile-snapshot.py`; this project will reference the convention without changing those files.
- Existing Central Ops `.pi/settings.json` contains the `pi-stately` package; this project will use a separate profile directory.

### Host observations

### Phase 2 direct SSH verification — 2026-08-25
All checks below were run through non-interactive `ssh <alias>`, using explicit absolute paths where PATH was incomplete.

| Host | Pi | Herdr | Moshi | Required tools | Status |
|---|---|---|---|---|---|
| `ovhvps` | `/home/ubuntu/.local/bin/pi` → 0.84.1; running Pi processes observed | `/home/ubuntu/.local/bin/herdr` → 0.8.0; protocol 19; server running | `/home/ubuntu/.local/bin/moshi` and `moshi-hook` → 0.3.0; hook running | Git 2.34.1; `jq`, `treehouse`, `tasks-axi`, `gh` absent | Partial |
| `zimaos` | No Pi binary found in probed paths; no Pi process observed | `/DATA/bcharney234/.local/bin/herdr` → 0.8.2; protocol 20; server running | `/DATA/bcharney234/.local/bin/moshi` and `moshi-hook` → 0.3.0; hook running | Git 2.48.1; jq 1.7.1; `treehouse`, `tasks-axi`, `gh` absent | Blocked for Pi secondmate |
| `macmini` | `/opt/homebrew/bin/pi` → 0.73.1; running Pi process observed | `/opt/homebrew/bin/herdr` → 0.8.2; protocol 20; server running | `/opt/homebrew/bin/moshi` → 0.3.1; hook running | Git 2.39.5; jq 1.7.1; `treehouse`, `tasks-axi`, `gh` absent in SSH PATH | Partial |

Non-interactive PATHs omit installed user-local/Homebrew binaries on OVH, ZimaOS, and Mac; all future launch commands must use explicit paths or a controlled environment file.

### Installation and post-install verification — 2026-08-25

Installed without overwriting existing Herdr/Moshi services:

| Host | Changes | Verified result |
|---|---|---|
| `ovhvps` | Firstmate npm tools, Treehouse v2.0.1, GitHub CLI 2.4.0, jq 1.6; no-mistakes binary installer v1.57.0 | Full toolchain present; Herdr and Pi preserved. |
| `zimaos` | Used existing NVM Node 24.18.0 and existing Pi 0.82.1; installed Firstmate npm tools, Treehouse v2.0.1, no-mistakes v1.57.0, GitHub CLI 2.98.0 user-local | Full runtime/toolchain present; Herdr and Moshi preserved. |
| `macmini` | Installed Firstmate npm tools, Treehouse v2.0.1, no-mistakes v1.57.0, GitHub CLI 2.98.0; preserved existing Homebrew Pi/Herdr | Full runtime/toolchain present; NVM emits an existing npmrc prefix warning. |

The Firstmate `fm-bootstrap.sh` detector was run in read-only/local-only mode with `FM_BACKEND=herdr` and an isolated temporary `FM_HOME` on all three hosts. It emitted no missing-tool lines and exited successfully on each host.

### Authentication and isolated provisioning — 2026-08-25

- Public `git ls-remote` access to both `kunchenguid/firstmate` and `toasterman234/pi-herdr-firstmate` passed from OVH, ZimaOS, and Mac mini.
- `gh auth status` is host-specific: ZimaOS is authenticated as `toasterman234` with repo-capable scopes; OVH has no logged-in GitHub host; Mac mini's stored `toasterman234` token is invalid. No token values were printed or stored in this repository.
- Harmless Pi `--help` launch/exit passed with isolated temporary state on all three hosts. The Mac check used `/opt/homebrew/bin/pi` directly to avoid the existing NVM npmrc prefix warning.
- OVH was selected as the initial captain host. The isolated Firstmate code root is `/home/ubuntu/firstmate-fleet/firstmate`; the captain home is `/home/ubuntu/.firstmate/captain`; the Pi profile is `/home/ubuntu/.pi/firstmate-fleet` with sessions below it.
- Isolated OVH `fm-bootstrap.sh` ran with `FM_BACKEND=herdr`, `FM_BOOTSTRAP_NETWORK=skip`, and `FM_BOOTSTRAP_DETECT_ONLY=1` verification passed. The home contains only Firstmate-generated bootstrap markers/config at this point.

### Phase 4 readiness — 2026-08-25

- OVH `fm-remote-doctor.sh --fix` repaired the automatable remote-secondmate prerequisites: the Linux `dev.firstmate.remote-job` worker, its tool probe, the dedicated Herdr `fm-remote` session, and the Firstmate-owned `/home/ubuntu/.local/bin/fm-remote-entrypoint.sh` link.
- A subsequent OVH doctor check reported `ok: remote second-mate readiness confirmed on this host` for every required check.
- ZimaOS has Pi, tasks-axi, and quota-axi under `/DATA/bcharney234/.nvm/versions/node/v24.18.0/bin`; bare non-interactive SSH does not expose Node, so direct execution of those shims fails until the NVM bin directory is included. Firstmate's composed remote PATH is expected to address this; it has not yet been proven through `fm-on.sh`.

### Remaining host uncertainties
- OVH and Mac provider/GitHub authentication must be repaired or explicitly deferred before operations requiring authenticated forge access; no new authorization flow was attempted.
- The isolated captain has not yet been launched interactively through Pi's trust/extension path; only the harmless CLI help path is verified.
- No live secondmate was provisioned and no watcher was armed.
- No Firstmate code root was created on ZimaOS or Mac; this remains intentional until the disposable pilot host is selected.
- The Mac NVM environment has a pre-existing npm `globalconfig`/prefix conflict warning; the explicit Homebrew launch path avoids it.
- OVH apt reported a pending kernel update (`5.15.0-190-generic`) while the running kernel remains `5.15.0-186-generic`; no reboot was performed.
- Local Pi preflight remains blocked by an unrelated Docker/Redis requirement; this does not affect the host-local toolchain detector result.

### Architecture conclusion
Moshi does not replace Firstmate or Herdr. The intended layers are:
1. Firstmate: orchestration, durable homes, routing, worktrees, lifecycle.
2. Pi: captain and secondmate agent runtime.
3. Herdr: host-local persistent agent sessions and semantic pane state.
4. `herdr-mirror`: Mac-side remote pane/control projection.
5. Moshi: phone-facing discovery, status, notification, and interaction layer.

### Important risks
- Herdr versions differ between OVH (0.8.0) and ZimaOS/Mac (0.8.2); normalize only through an approved, reversible change.
- `no-mistakes` must be installed from its official binary installer; the npm package version 0.51.3 is below Firstmate's 1.31.2 floor. Official v1.57.0 is now installed on all three hosts.
- Non-interactive SSH environments do not expose all interactive PATH entries.
- Mobile connectivity is not directly proven by host shell checks; host-side pairing and mirror evidence is strong but phone-side live state remains an explicit acceptance test.
- Do not treat an active relay or sidecar as proof that the Pi CLI is launchable for Firstmate.
