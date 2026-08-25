# Host Readiness

Last verified: 2026-08-25. These results are from direct host/process/path checks and should be repeated from the intended Firstmate launch context.

| Host | Pi | Herdr | Moshi hook | Readiness |
|---|---|---|---|---|
| OVH VPS (`ovhvps`) | Running `/home/ubuntu/.local/bin/pi` processes observed | 0.8.0, protocol 19, server running | Running | Partial; toolchain/auth/profile still open |
| ZimaOS (`zimaos`) | Not found in current checks | 0.8.2, protocol 20, server running | Running | Partial; Pi launchability/toolchain/auth open |
| Mac mini (`macmini`) | Related Pi services observed; CLI launchability unresolved | Herdr server/CLI via intended SSH context unresolved; relay and mirror active | Running locally | Partial; intended SSH runtime unresolved |

## Moshi evidence

- Mac `moshi-hook` reports `paired=true` and is running.
- OVH and ZimaOS have running `moshi-hook serve` processes.
- Mac `herdr-mirror daemon` has active SSH control connections to `ovhvps` and `zimaos`.
- Live phone connectivity must be verified as a user-facing acceptance test; shell evidence alone cannot prove the phone's current connection.

## Required next checks

1. Resolve each host's non-interactive PATH and exact Pi binary.
2. Verify `pi --version` and a harmless launch/exit under the intended account.
3. Verify `herdr --version` and `herdr status --json` under the same context.
4. Check `jq`, `treehouse`, `tasks-axi`, Git, and Firstmate dependencies.
5. Verify provider authentication and repository access without exposing secrets.
6. Compare Herdr versions and plan normalization if required.
