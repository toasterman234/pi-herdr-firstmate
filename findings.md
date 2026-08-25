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
| Host | Verified observations | Unresolved |
|---|---|---|
| `ovhvps` | Herdr 0.8.0, protocol 19, server running; `/home/ubuntu/.local/bin/pi` processes; `moshi-hook serve` running. | Complete Firstmate toolchain, isolated profile, provider auth, version normalization. |
| `zimaos` | Herdr 0.8.2, protocol 20, server running; `moshi-hook serve` running. | Pi executable/launch context not found in current checks; complete toolchain and auth. |
| `macmini` | Local Pi-related services, Moshi hook, Herdr relay, and `herdr-mirror` connections to OVH/ZimaOS observed. | Usable Pi and Herdr CLI/server via the intended SSH account/context; Firstmate toolchain and auth. |

### Architecture conclusion
Moshi does not replace Firstmate or Herdr. The intended layers are:
1. Firstmate: orchestration, durable homes, routing, worktrees, lifecycle.
2. Pi: captain and secondmate agent runtime.
3. Herdr: host-local persistent agent sessions and semantic pane state.
4. `herdr-mirror`: Mac-side remote pane/control projection.
5. Moshi: phone-facing discovery, status, notification, and interaction layer.

### Important risks
- Herdr versions differ between OVH (0.8.0) and ZimaOS (0.8.2); normalize only through an approved, reversible change.
- Non-interactive SSH environments do not expose all interactive PATH entries.
- Mobile connectivity is not directly proven by host shell checks; host-side pairing and mirror evidence is strong but phone-side live state remains an explicit acceptance test.
- Do not treat an active relay or sidecar as proof that the Pi CLI is launchable for Firstmate.
