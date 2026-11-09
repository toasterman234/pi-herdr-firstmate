# ZenNotes × Herdr — actual-source integration spike
Date: 2026-11-09  
Tracking: https://github.com/toasterman234/pi-herdr-firstmate/issues/1

## Scope and decision
**Exploration, not implementation approval.** The earlier generic notes mock was rejected because it did not use ZenNotes' actual interface (closed PR #2). This branch preserves source-derived changes made against the genuine ZenNotes shared app core and iPhone shell. **No production ZenNotes, live Herdr runtime, or Mac filesystem was changed.**

## Authoritative sources pinned for the spike
- Shared editor + browser app: https://github.com/ZenNotes/zennotes at commit `44d628b342e6ea7beda7b622f072f26a10332067` (v2.84.0).
- iPhone shell: https://github.com/ZenNotes/zennotesios at commit `71d6daadac4009d7a8a6b0cdde1c946bc7aab4cd`.
- Self-hosted Go backend: https://github.com/ZenNotes/znserver release v2.84.0; Linux amd64 binary SHA-256 `4c30497c487715d10b09654ac773c71c02c327ffb480015f034402e16db3eb48`.
- Existing independent Herdr adapter under assessment: https://github.com/toasterman234/herdr-web . Its browser bridge was not authenticated or connected in this spike.
- GitHub fork attempts through the connected account both returned HTTP 403 / permission denied; upstream repositories were never mutated. The patches live in this repository until a fork/repository authority is available.

## Source artifacts
- `patches/zennotes-core-agent-thread.patch`: actual ZenNotes EditorSelectionToolbar, EditorPane, CommentsPanel; selection bubble adds `@` action; invokes the *existing* anchored comment capture and prepopulates `@pi `.
- `patches/zennotesios-agent-toolbar.patch`: actual iPhone `EditorToolbar.tsx` adds `@` command that emits `zen:add-agent-thread`. This native UI uses an immutable vendored `@zennotes/app-core`: the core patch must be packaged/adopted through the supported boundary before it can work in an iPhone binary.
- `patches/zennotes-web-mobile-shell-spike.patch`: **sandbox-only experimental composition**, mounts the actual iOS MobileShell and CSS over the original web bridge and core. Contains sandbox-specific /vercel paths; not a portable or production-ready deployment patch, and its combined production build exceeded the 4 GB sandbox memory limit (exit 137). Live Vite development did run and was browser-tested. This patch is an investigative artifact, **not approved for direct deployment**.

All three patches were repaired after the initial GitHub tool stdout truncated two of them. A subsequent GitHub read-back showed no truncated content; independent source+patch verification matched every context hunk on all eight upstream files.

## Browser/runtime evidence
An isolated, time-limited Vercel Sandbox was created with the *real* ZenNotes monorepo, genuine iOS MobileShell/CSS, and the official ZnServer 2.84 binary. The temporary sandbox has stopped as configured, and its URL **must not be advertised as a live deployment**.

- Original ZenNotes web app modified with the core patch: `npm run build --workspace @zennotes/web` **passed** (~39s).
- Original iOS source with its toolbar patch: `npm run typecheck` **passed**, `npm run build` **passed**, but still links the upstream vendored app-core rather than patched core. No native iPhone app was produced.
- Real Go server in sandbox with token authentication: `GET /` 200; unauthenticated `GET /api/notes` 401; authenticated `GET /api/notes` 200.
- Actual ZenNotes on Chromium mobile viewport (390 × 844) after auth: `zn-mobile=true`, `#zn-mobile-shell=true`, `.zn-mobile-fab=true`, demo note visible on the original ZenNotes home UI. Screenshot was inspected during the session. **Not a physical iPhone test.**
- Opened actual demo Markdown note in CodeMirror. Selected the passage “Select this text and start an agent thread using the @ action in ZenNotes' native selection toolbar.”. Browser verified `[data-agent-thread-action]` visible in original EditorSelectionToolbar; clicked it, original CommentsPanel appeared with textarea `@pi `. This is the **verified end-to-end selection → anchored draft UI**.
- Submitting/saving a comment was **not** established. A separate automation attempt timed out on an incorrect Playwright button selector; this does not prove a product failure.
- Browser logged web-only Capacitor Keyboard-not-implemented exceptions. These need suppression or capability gating in any supported web composition.
- No real Herdr task/session was created, no event stream received, no cross-device sync established, and no end-to-end iPhone build verified.

## Important blockers / promotion gates
1. Select and authorize a persistent host for actual ZenNotes Go server (filesystem-backed Markdown), a fully authenticated Herdr bridge, and a real deployment. Vercel Serverless and a short-lived Sandbox are not persistent filesystem substitutes.
2. Read current Mac runner state through the existing governed control plane before Mac work. Previously queued run 42538768005 had no authoritative execution result, see https://github.com/toasterman234/github-workflows-control-plane/issues/368 . Do not bypass control-plane approval or submit unrestricted commands.
3. Adopt the patched core into the iOS package via the existing versioned package release boundary, check ABI/runtime compatibility, and verify on physical iPhone.
4. Implement an actual authenticated Herdr adapter with durable request ID, source note path + anchor, session ID, event history/status read-back, and explicit action approvals. Neither a selected `@pi` target nor comment submission authorizes unconditional execution.
5. Implement conflicts and reanchoring, multi-device real-time state/sync and offline recovery, and secure permissions.
6. Test selection, actual saved comment/thread, concurrency, denial cases, live agent output, end-to-end browser/iOS behavior, and deployment status. Request explicit promotion/merge approval.

## State
**Exploration open.** This is a reproducible code and browser-interaction proof, not the finished notes + Herdr product, and not a live hosted preview.
