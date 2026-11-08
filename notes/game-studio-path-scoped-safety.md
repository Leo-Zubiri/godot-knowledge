---
id: game-studio-path-scoped-safety
type: pattern
domain: game-studio
status: proposed
summary: Combine a hard deny-list for destructive operations with path-aware validators; treat warn-only hooks as advisory and back critical checks with CI.
sources:
  - claim: "Reference permission deny-list, hook triggers and blocking vs warning behaviour, stated limits"
    ref: src-gs-ccgs-safety-and-session
    retrieved: 2026-11-08
related:
  - relates-to: "[[gs-adr-mcp-optional]]"   # MCP/GUI servers are another arbitrary-code surface
  - relates-to: "[[game-studio-godot-integration]]"   # Godot-specific protected paths
  - relates-to: "[[game-studio-agent-orchestration]]"   # instructions are advisory
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


## What the reference does (documented, not run by us)
- **Hard control:** a deny-list in the permission config (forced recursive delete, force push, hard reset, forced clean, `sudo`, loose `chmod`, reading/editing `.env`); a tiny allow-list; default prompting mode.
- **Validators (hooks):** run on commit/push, on writes to protected or registry files, on reads of large docs, after asset writes, and at subagent stop. Almost all only **warn**; one (large-file read guard) refuses. Subagent start/stop hooks keep an audit log.
- **Stated limits:** hooks do not run in every tool, so skills re-run the checks; one hook is Windows-only; the async stop hook can be cancelled in non-interactive mode; pre-compact output is ignored.

## Proposal for us
- **adopt** the deny-list idea, extended with Godot specifics (protect `project.godot`, `.godot/`, import metadata) and our isolated-workspace rule.
- **adapt** warn-only hooks: make a *small* set of checks blocking and also run them in CI (the reference has no CI), so Codex/OpenCode get the same outcome.
- **reference-only** subagent audit logging (Claude events); **reject** desktop-notification hooks.
- Hooks are a Claude Code feature; portable controls are shell scripts + CI + review of Git diffs.

## See also
- [[game-studio-agent-orchestration]] — advisory vs enforced
- [[gs-adr-mcp-optional]] — MCP/GUI servers are another arbitrary-code surface
- [[game-studio-godot-integration]] — Godot-specific protected paths
