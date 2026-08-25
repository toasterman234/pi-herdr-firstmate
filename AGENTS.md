# Project Operating Guide

## Scope
This repository documents and coordinates the isolated Pi + Herdr + Firstmate evaluation. It is not the Central Ops repository and must not modify Central Ops state by default.

## Required behavior
- Read `task_plan.md`, `progress.md`, and `findings.md` before continuing multi-phase work.
- Keep facts, assumptions, and open questions distinct.
- Run commands from the documented project or explicit host contexts; use absolute paths where possible.
- Update documentation after each meaningful discovery or change.
- Never commit secrets, tokens, SSH keys, pairing data, session logs, or private host configuration.
- Prefer additive, reversible host changes. Record rollback before applying mutations.
- Verify every claim with a command run in the current phase.

## Isolated defaults
```sh
export PI_CODING_AGENT_DIR="$HOME/.pi/firstmate-fleet"
export PI_CODING_AGENT_SESSION_DIR="$PI_CODING_AGENT_DIR/sessions"
export FM_HOME="$HOME/.firstmate/captain"
```

These are examples only until Phase 3 is explicitly executed.
