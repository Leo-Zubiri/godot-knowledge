---
id: game-studio-agent-audit-and-recovery
type: reference
domain: agent-ops
status: proposed
summary: "Documented audit and recovery features of Claude Code (OpenTelemetry, hooks that fail open on timeout, checkpoints that miss Bash-only changes and most subagent edits) and what Codex/OpenCode leave unread."
tags: [dept/orchestration]
sources:
  - claim: "Claude Code monitoring, hooks and checkpointing pages; OpenCode snapshots setting"
    ref: src-gs-agent-ops-permissions-hooks-recovery
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-session-lifecycle]]"   # session memory and recovery
  - relates-to: "[[game-studio-path-scoped-safety]]"   # hooks as warn-only controls
  - relates-to: "[[game-studio-agent-permission-controls]]"   # sandbox and permissions
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** official documentation as read on 2026-11-08 (paraphrased extractions by research subagents). Vendor and platform pages change quickly: re-check before acting. Fees and defaults are recorded as the page wrote them; nothing was tested here. Status `proposed`; not legal advice.


- **Telemetry (Claude Code):** OpenTelemetry is off until `CLAUDE_CODE_ENABLE_TELEMETRY=1`; metrics (sessions, tokens by type, cost, edit decisions) and events (prompts, tool results/decisions, API requests/errors); prompts and tool details are redacted by default; a repo's `.claude/settings.json` **cannot** enable telemetry or set its destination; traces are beta.
- **Hooks:** exit code 2 blocks, exit 1 does not; **a PreToolUse hook that times out does not block unless configured**; the `if` filter is best-effort — use permissions for hard allow/deny; hooks run with user privileges.
- **Checkpoints/rewind:** one per prompt, 100 most recent kept, `/rewind` restores code and/or conversation, snapshots deleted after about 30 days by default; **changes made only by Bash are not tracked, subagent edits usually are not restored, symlinks and hard links are skipped**; the docs say to use Git as the real history.
- OpenCode has a `snapshots` setting used by undo/revert; its logs, telemetry and share pages, and Codex's logs/OTel/resume, were **not read**.

## For our workflow (interpretation)
Keep Git as the recovery mechanism (commit before risky agent runs); do not depend on rewind for Bash-made or subagent-made changes; make safety hooks fail closed where the product allows; record tool usage for audit.

## See also
- [[game-studio-session-lifecycle]] — session memory and recovery
- [[game-studio-path-scoped-safety]] — hooks as warn-only controls
- [[game-studio-agent-permission-controls]] — sandbox and permissions
