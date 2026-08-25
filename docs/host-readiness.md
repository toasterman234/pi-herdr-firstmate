# Host Readiness

Last verified: 2026-08-25. These results are from direct non-interactive SSH checks, including explicit absolute binary probes.

| Host | Pi | Herdr | Moshi hook | Required tools | Readiness |
|---|---|---|---|---|---|
| OVH VPS (`ovhvps`) | `/home/ubuntu/.local/bin/pi` 0.84.1; running processes observed | `/home/ubuntu/.local/bin/herdr` 0.8.0, protocol 19, server running | `/home/ubuntu/.local/bin/moshi-hook` 0.3.0, running | Full Firstmate detector toolchain; jq 1.6; gh 2.4.0 | Ready for isolated provisioning; auth open |
| ZimaOS (`zimaos`) | `/DATA/bcharney234/.nvm/versions/node/v24.18.0/bin/pi` 0.82.1; installed before this phase | `/DATA/bcharney234/.local/bin/herdr` 0.8.2, protocol 20, server running | `/DATA/bcharney234/.local/bin/moshi-hook` 0.3.0, running | Full Firstmate detector toolchain; jq 1.7.1; gh 2.98.0 | Ready for isolated provisioning; auth open |
| Mac mini (`macmini`) | `/opt/homebrew/bin/pi` 0.73.1; running process observed | `/opt/homebrew/bin/herdr` 0.8.2, protocol 20, server running | `/opt/homebrew/opt/moshi-hook/bin/moshi-hook` 0.3.1, running | Full Firstmate detector toolchain; jq 1.8.2; gh 2.98.0 | Ready for isolated provisioning; npm environment warning/auth open |

## Moshi evidence

- Mac `moshi-hook` reports `paired=true` and is running.
- OVH and ZimaOS have running `moshi-hook serve` processes.
- Mac `herdr-mirror daemon` has active SSH control connections to `ovhvps` and `zimaos`.
- Live phone connectivity must be verified as a user-facing acceptance test; shell evidence alone cannot prove the phone's current connection.

## Required next checks

1. Verify a harmless Pi launch/exit under each intended account.
2. Verify provider authentication and repository access without exposing secrets.
3. Create an isolated Firstmate code root on the selected captain only.
4. Compare Herdr versions and plan normalization if required.
5. Keep the Mac npm environment warning from leaking into the Firstmate launch context.
