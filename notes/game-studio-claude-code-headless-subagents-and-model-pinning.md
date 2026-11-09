---
id: game-studio-claude-code-headless-subagents-and-model-pinning
type: reference
domain: agent-ops
status: proposed
summary: "Documented Claude Code facts that matter for agent pipelines: subagent context and limits, model aliases vs pinned IDs, headless -p/--bare behaviour and trust implications, plus OpenCode agents/MCP/plugins notes."
tags: [dept/orchestration]
sources:
  - claim: "Claude Code subagents, model configuration, headless and memory pages"
    ref: src-gs-agent-ops-subagents-headless-evals
    retrieved: 2026-11-08
  - claim: "OpenCode agents, MCP servers and plugins pages"
    ref: src-gs-agent-ops-subagents-headless-evals
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-untrusted-content-and-headless-runs]]"   # headless safety
  - relates-to: "[[game-studio-reproducibility-and-model-pinning]]"   # pinning
  - relates-to: "[[game-studio-agent-permission-controls]]"   # permissions
  - relates-to: "[[game-studio-delegation-boundaries]]"   # delegation
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** vendor documentation as extracted on 2026-11-08; these products change quickly, re-check before acting. Nothing was tested here. Status `proposed`.

- **Subagents:** own context; only a summary returns; a non-fork subagent does not see conversation history (gets its prompt, the delegation message, CLAUDE.md, git status; Explore/Plan skip CLAUDE.md); tool allow/deny lists; if the main session is in bypass/acceptEdits/auto, subagents ignore their own `permissionMode`; defaults 20 concurrent, nesting depth 3.
- **Models:** aliases track the latest and resolve per provider; pinned IDs fix a version; precedence `/model` > `--model` > env > settings; `ANTHROPIC_DEFAULT_*_MODEL` pins what an alias means.
- **Headless:** `claude -p`; `--bare` skips hooks, skills, subagents, plugins, MCP, auto memory and CLAUDE.md (recommended for CI); **without `--bare`, `-p` runs project hooks and connects `.mcp.json` servers with no trust dialog**; `--max-budget-usd` caps spend; `total_cost_usd` is an estimate; check `mcp_server_errors` since a skipped MCP entry does not fail the run; CLAUDE.md is context, not enforcement (use a PreToolUse hook).
- **OpenCode:** agents as Markdown with `mode`, `model`, permissions; `hidden` is visibility, not security; MCP local stdio / remote HTTP, OAuth default, same-name project config replaces the server; plugins can be pinned by exact version or full commit hash.
- **Codex docs:** not usable (404 or third-party); UNV.

## See also
- [[game-studio-untrusted-content-and-headless-runs]] — headless safety
- [[game-studio-reproducibility-and-model-pinning]] — pinning
- [[game-studio-agent-permission-controls]] — permissions
- [[game-studio-delegation-boundaries]] — delegation
