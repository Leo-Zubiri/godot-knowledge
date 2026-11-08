---
id: game-studio-session-lifecycle
type: pattern
domain: game-studio
status: proposed
summary: Keep session memory in a short overwritten checkpoint file plus a rotated narrative, compact proactively, and reload state after compaction or a crash.
sources:
  - claim: "Reference session-state file, compaction thresholds, crash recovery, session-start behaviour"
    ref: src-gs-ccgs-safety-and-session
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-token-efficient-workflows]]"   # files as memory saves context
  - relates-to: "[[game-studio-agent-orchestration]]"   # portable instruction base
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


## Pattern (documented; **adopt** the file, **adapt** the hooks)
- A living `active.md`-style file is the real memory: a short checkpoint (current task, next step, blockers, in-progress files, open questions; ~25 lines, overwritten) above a free-form narrative archived by a script past ~200 lines.
- Compact at natural breakpoints and around 60–70% context; clear between unrelated tasks; before compaction preserve state reference, modified files, decisions, test outcomes, open questions; after compaction or crash, reread the state file.
- The reference reloads state through a session-start hook; its release notes show that long skills lost later steps after compaction (v1.1.3) — evidence that critical steps should live in files, not only in context.

## For us (proposal)
Plain Markdown is portable across Claude Code, Codex and OpenCode; automatic reload via hooks is Claude-specific, so also instruct agents in AGENTS.md to read the checkpoint at start. Thresholds are the project's guidance, not measured.

## See also
- [[game-studio-token-efficient-workflows]]
- [[game-studio-agent-orchestration]] — portable instruction base
