# Operations and Recovery

## Safety boundaries
- This project is not a replacement for the existing Central Ops/Pi setup.
- Never use `git add .` in any related repository.
- Never copy provider credentials, Moshi pairing data, SSH keys, or live session logs into this repo.
- Keep captain and secondmate homes separate from existing homes.

## Recovery principles
- Prefer stopping the pilot captain/secondmate over restarting unrelated host services.
- Preserve logs and state before destructive cleanup.
- Re-run status checks after every restart.
- If a host is unavailable, pause routing rather than recreating durable homes blindly.

## Planned rollback records
Before each host mutation, add a dated section containing:

- host and account
- current version/configuration
- exact mutation
- reversal command
- verification command
- observed result

## Operationalization prerequisites
- login/reboot persistence tested
- backups and retention defined
- monitoring/alerting defined
- least-privilege accounts and SSH host-key policy reviewed
- documented captain restart and host outage procedures
- explicit decision that the pilot is safe to expand
