---
id: game-studio-agent-permission-controls
type: reference
domain: agent-ops
status: proposed
summary: "What Claude Code, Codex and OpenCode document about permissions and sandboxing, separating OS-enforced controls from advisory ones; product-specific names change fast."
tags: [dept/orchestration]
sources:
  - claim: "Permission modes, sandboxing, security, hooks and scopes of Claude Code; Codex sandbox/approvals; OpenCode permissions"
    ref: src-gs-agent-ops-permissions-hooks-recovery
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-path-scoped-safety]]"   # deny-lists and protected paths
  - relates-to: "[[game-studio-mcp-spec-requirements]]"   # protocol leaves enforcement to hosts
  - relates-to: "[[game-studio-agent-audit-and-recovery]]"   # audit and rewind
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** official documentation as read on 2026-11-08 (paraphrased extractions by research subagents). Vendor and platform pages change quickly: re-check before acting. Fees and defaults are recorded as the page wrote them; nothing was tested here. Status `proposed`; not legal advice.


| | Claude Code | OpenAI Codex | OpenCode |
|---|---|---|---|
| Rules | deny → ask → allow, first match wins; scopes user/project/local/managed | sandbox mode + approval policy | allow/ask/deny, last match wins; no match = ask |
| Defaults | manual mode asks for Bash/edits/web; auto mode (classifier) default for interactive sessions; `bypassPermissions` only for containers/VMs | workspace-write for trusted folders; network off | base policy allows everything, asks before `.env`; `external_directory` not asked by default |
| **OS-enforced** | only the **Bash sandbox** (bubblewrap on Linux/WSL2, Seatbelt on macOS); **off by default**; native Windows unsandboxed | yes (Seatbelt, bwrap+seccomp, Windows sandbox); may fail in containers blocking namespaces | **no sandbox described**; shell runs with host user authority |
| Advisory | Bash rules match command text only and are not a security boundary; Read/Edit deny rules do not cover a script opening files itself; Read/Edit/Write, MCP servers, hooks and WebFetch run **outside** the sandbox | `.git`, `.agents`, `.codex`, `.aws` read-only in workspace-write | configured `deny` always enforced, including non-interactive; directory inference from command text is best effort |

Portable lessons (documented practice): deny-first rules; a real OS sandbox for shell execution; treat prompt-level rules as advisory; use containers/VMs for untrusted content. Defaults and names are product-specific and version-dependent; Codex docs now redirect to learn.chatgpt.com. Codex config profiles, logs and resume, and OpenCode's other pages were **not read**.

## See also
- [[game-studio-path-scoped-safety]] — deny-lists and protected paths
- [[game-studio-mcp-spec-requirements]] — protocol leaves enforcement to hosts
- [[game-studio-agent-audit-and-recovery]] — audit and rewind
