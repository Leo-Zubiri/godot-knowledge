---
id: game-studio-untrusted-content-and-headless-runs
type: concept
domain: game-studio
status: proposed
summary: "Treat tool outputs and fetched content as untrusted (vendor guidance), and remember that headless `-p` runs show no trust or MCP approval prompts."
tags: [dept/orchestration]
sources:
  - claim: "Prompt-injection mitigation guidance: tool_result blocks, untrusted-content policy, least privilege, screening"
    ref: src-gs-agent-ops-models-injection-cost
    retrieved: 2026-11-08
  - claim: "Claude Code security page: -p sessions show neither the trust nor the MCP prompt; Codex: web results untrusted"
    ref: src-gs-agent-ops-permissions-hooks-recovery
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-review-modes-and-verdicts]]"   # approval gates
  - relates-to: "[[game-studio-agent-permission-controls]]"   # controls that apply
  - relates-to: "[[game-studio-mcp-spec-requirements]]"   # consent and annotations
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** official documentation as read on 2026-11-08 (paraphrased extractions by research subagents). Vendor and platform pages change quickly: re-check before acting. Fees and defaults are recorded as the page wrote them; nothing was tested here. Status `proposed`; not legal advice.


- **Vendor guidance (Anthropic):** distinguish direct and indirect injection; put untrusted content only in `tool_result` blocks and label its source; state an untrusted-content policy in the system prompt; JSON-encode third-party strings; never place your own instructions in tool results; apply least privilege and sandboxed tools; screen tool outputs with a small model; red-team the agent. The page gives no failure rates.
- **Codex:** web results are untrusted; prompt injection can make an agent fetch and follow untrusted instructions; network is off by default.
- **Claude Code:** `.mcp.json` servers have their own approval prompt, **but `-p` (headless) sessions show neither the trust prompt nor the MCP prompt**; Anthropic does not security-audit MCP servers; VMs or dev containers are recommended for untrusted content.
- **For us (interpretation):** in CI or headless runs the human approval gate is *absent*, so restrict tools by allow-lists, run in a container, and never let fetched asset descriptions, README files or tool output drive actions. Human review of Git diffs stays the real gate.
- Grader/eval tips from the Anthropic eval page (specific criteria, automated grading, a different model as grader) feed [[game-studio-skill-eval-design]].

## See also
- [[game-studio-review-modes-and-verdicts]] — approval gates
- [[game-studio-agent-permission-controls]] — controls that apply
- [[game-studio-mcp-spec-requirements]] — consent and annotations
