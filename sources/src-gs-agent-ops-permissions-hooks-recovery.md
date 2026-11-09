---
id: src-gs-agent-ops-permissions-hooks-recovery
type: source
domain: game-studio
source:
  url: "https://code.claude.com/docs/en/permissions"
  urls:
    - "https://code.claude.com/docs/en/permissions"
    - "https://code.claude.com/docs/en/sandboxing"
    - "https://code.claude.com/docs/en/hooks"
    - "https://code.claude.com/docs/en/security"
    - "https://code.claude.com/docs/en/checkpointing"
    - "https://code.claude.com/docs/en/monitoring-usage"
    - "https://learn.chatgpt.com/docs/agent-approvals-security"
    - "https://opencode.ai/docs/permissions/"
    - "https://opencode.ai/docs/config/"
  title: "Agent permission, sandbox, hooks, security, checkpointing and telemetry documentation (Claude Code, Codex, OpenCode)"
  retrieved: 2026-11-08
  version: "Claude Code docs show versions per feature only; Codex and OpenCode pages show no version; OpenAI Codex docs now redirect to learn.chatgpt.com"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; not re-read by the main agent. Fees, prices, shares, deadlines and product defaults are recorded *only as the page wrote them on that date* and change; items marked UNV/unverified were not read on an official page (404, blocked, search-snippet only). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **Claude Code permissions (read to ~100k chars):** rules evaluated deny, then ask, then allow; first match decides (specificity irrelevant). Manual mode reads freely in the working directory and asks for Bash, edits and web; auto mode (classifier) is the default for interactive sessions; `bypassPermissions` skips prompts and is for containers/VMs only; `dontAsk` auto-denies prompts; managed settings can disable bypass and auto mode. Scopes: user, project, local, managed (managed cannot be overridden). Bash rules match command text only and are not a security boundary; Read/Edit deny rules do not cover a script that opens files itself.
- **Claude Code sandbox:** only the Bash sandbox is OS-enforced (bubblewrap on Linux/WSL2, Seatbelt on macOS); **off by default**; native Windows not sandboxed; Read/Edit/Write, MCP servers, hooks and WebFetch run outside the sandbox; sandbox failures can be retried with `dangerouslyDisableSandbox` (disable via `allowUnsandboxedCommands: false`).
- **Claude Code hooks (~100k chars):** events include PreToolUse, PostToolUse, PermissionRequest, PreCompact, SubagentStop, ConfigChange; exit code 2 blocks, exit 1 does not; a PreToolUse hook that times out does **not** block unless `onFailure: "block"`; the `if` filter is best-effort (use permissions for hard allow/deny); hooks run with user privileges.
- **Claude Code security:** manual mode asks before non-read-only actions; network commands like `curl` are not auto-approved; the working-directory boundary is a prompt (an approved Bash command can write anywhere the user can); `.mcp.json` servers get their own approval prompt but **`-p` sessions show neither the trust nor the MCP prompt**; Anthropic reviews connectors but does not security-audit or manage any MCP server; VMs or dev containers recommended for untrusted content; no system is immune.
- **Claude Code checkpointing:** one checkpoint per prompt, 100 most recent kept, `/rewind` restores code and/or conversation, survives resume, snapshots deleted after ~30 days by default; **limits:** changes made only by Bash are not tracked, subagent edits usually not restored, symlinks/hard links skipped; docs say to use Git as the real history. "Summarize" compresses like a targeted `/compact` (original messages stay in the transcript).
- **Claude Code OpenTelemetry (~100k chars):** off until `CLAUDE_CODE_ENABLE_TELEMETRY=1`; metrics (sessions, tokens by type, cost USD, code-edit decisions) and events (user_prompt, tool_result, tool_decision, api_request, api_error…); prompts and tool details redacted by default; repo `.claude/settings.json` cannot enable telemetry or set its destination; traces beta; `claude_code.safety_event` needs v2.1.307+.
- **Codex (learn.chatgpt.com):** two layers — sandbox mode (read-only, workspace-write [default for trusted folders], danger-full-access) and approval policy (on-request, never, granular, untrusted retired); sandbox is OS-enforced (Seatbelt on macOS, bwrap+seccomp on Linux, Windows sandbox; may fail inside containers blocking namespaces); network off by default; `.git`, `.agents`, `.codex`, `.aws` stay read-only in workspace-write; web search defaults to a cached index; treat web results as untrusted. Config profiles, logs, OTel and resume pages not read (UNV).
- **OpenCode:** allow/ask/deny with the last matching rule winning, no match means ask; base policy allows everything, asks before `.env`, no rule asks for `external_directory` by default; configured `deny` rules always enforced including non-interactive; **no sandbox described** (shell runs with host user authority); config precedence global, project, `/etc/opencode`, managed MDM; `snapshots` true/false used by undo/revert; `update: disable|notify|auto` (default notify). Logs, OTel, share pages and prompt-injection guidance not found (UNV).
