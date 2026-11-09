# ZenNotes × Herdr — isolated mobile UX spike (2026-11-09)

Tracking issue: https://github.com/toasterman234/pi-herdr-firstmate/issues/1

This is an **exploration/staging artifact, not a ZenNotes fork or Herdr integration**. The proof runs as a minimal dependency-free mobile-first PWA to validate selection → exact quoted highlight → anchored thread → draft task UX, without mutating production systems.

## Scope / non-capabilities
- Select text in a note (read mode) to Highlight, Start Thread, or Create Task.
- Anchors persist as {noteId, quote, startOffset, endOffset, hash}; uniquely matched quotes can re-anchor after minor edits. Ambiguous/removed quotes remain in thread records but do not render as misleading highlights.
- Draft threads and messages persist to localStorage only. A message beginning @pi or @codex chooses the target **without executing it**.
- A disconnected agent pane is deliberately truthful. There are no remote credentials, terminal commands, or server APIs.
- Browser storage is not encrypted, cloud-synced, or appropriate for sensitive data. Reset/eviction removes it.

## Real implementation gate
1. Verify Herdr runtime host, daemon/API and authentication via governed control plane; latest runner attempt is queued, issue https://github.com/toasterman234/github-workflows-control-plane/issues/368.
2. Integrate the selected UX with actual ZenNotes app-core editor and .zennotes/comments rather than replacing it with this simple DOM viewer.
3. Implement a permissioned bridge: request id, note id + anchor, desired agent, approved action, idempotent dispatch, session id, event log, acknowledgment, and read-back. Never publicly expose unauthenticated herdr-web localhost bridge.
4. Add multi-device realtime storage and eventual reconciliation; test offline queue.
5. Test iOS selection handles, accessibility and dynamic safe area on physical iPhone.
6. Promotion to production requires distinct approval and real Herdr event proof.

## Manual acceptance
- Open preview on iPhone Safari.
- Long-press/select a sentence → action bar → Highlight.
- Select another sentence → Start thread → type @pi investigate this → Save draft; verify that status remains Draft / disconnected.
- Switch Threads tab → reopen; return to note; highlight still visible.
- Create Task from selected text; toggle checkbox.
- Edit note and verify unique matching quoted anchors rebase, ambiguous anchors are not falsely applied.
- Refresh and verify local drafts persist on same browser.
- No claim of live dispatch or sync.
