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

### Remaining host uncertainties
- ZimaOS Pi is not installed or not discoverable for the intended account; do not proceed as a Pi secondmate until resolved.
- `treehouse` and `tasks-axi` are absent from all three checked PATHs; determine whether they are Firstmate prerequisites, bundled tools, or optional integrations before installing anything.
- `gh` is not available on the remote hosts; GitHub access may use SSH or a host-specific credential mechanism, but it is not yet verified.
- Provider authentication is not yet independently verified on each host.
- No Firstmate code root was found on OVH or ZimaOS; the Mac result is the project repository itself, not evidence of a Firstmate checkout.

### Architecture conclusion
Moshi does not replace Firstmate or Herdr. The intended layers are:
1. Firstmate: orchestration, durable homes, routing, worktrees, lifecycle.
2. Pi: captain and secondmate agent runtime.
3. Herdr: host-local persistent agent sessions and semantic pane state.
4. `herdr-mirror`: Mac-side remote pane/control projection.
5. Moshi: phone-facing discovery, status, notification, and interaction layer.

### Important risks
- Herdr versions differ between OVH (0.8.0) and ZimaOS/Mac (0.8.2); normalize only through an approved, reversible change.
- Non-interactive SSH environments do not expose all interactive PATH entries.
- Mobile connectivity is not directly proven by host shell checks; host-side pairing and mirror evidence is strong but phone-side live state remains an explicit acceptance test.
- Do not treat an active relay or sidecar as proof that the Pi CLI is launchable for Firstmate.
