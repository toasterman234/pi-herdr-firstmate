# Architecture

## Layered model

```text
Phone / Moshi
      |
Mac mini: Moshi hook + Herdr + herdr-mirror
      |                         |
      | SSH mirror              | SSH mirror
      v                         v
OVH: Herdr + Pi             ZimaOS: Herdr + Moshi hook
      |                         |
      +------ Firstmate captain/remote-secondmate protocol ------+
```

The diagram is conceptual: Firstmate orchestration and Herdr pane mirroring are separate control paths.

## Responsibilities

| Layer | Responsibility |
|---|---|
| Firstmate | Captain/secondmate coordination, durable homes, routing, worktrees, lifecycle, recovery policy. |
| Pi | Agent runtime on each host. |
| Herdr | Host-local persistent sessions, workspaces, panes, and agent-aware state. |
| SSH | Transport and remote command/session access. |
| herdr-mirror | Mac-side projection/control of remote Herdr panes. |
| Moshi | Mobile discovery, status, notifications, interaction, and approvals where supported. |

Moshi improves human access to the fleet but does not replace Firstmate orchestration or Herdr persistence.

## Target isolation

```text
Pi profile: firstmate-fleet
Pi state:    ~/.pi/firstmate-fleet
Sessions:    ~/.pi/firstmate-fleet/sessions
Captain:     ~/.firstmate/captain
Captain session: fm-captain
```

The paths are planned defaults, not yet activated.
