---
id: game-studio-agent-eval-and-context-guidance
type: reference
domain: agent-ops
status: proposed
summary: "Anthropic engineering guidance on tools, evals (pass@k vs pass^k, read transcripts) and context engineering (compaction, notes, condensed subagent returns), as read on 2026-11-08."
tags: [dept/orchestration]
sources:
  - claim: "Writing tools for agents, Demystifying evals, Effective context engineering"
    ref: src-gs-agent-ops-subagents-headless-evals
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-skill-eval-design]]"   # skill evals
  - relates-to: "[[benchmark-leakage-assertions]]"   # leakage
  - relates-to: "[[game-studio-token-efficient-workflows]]"   # tokens
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** vendor documentation as extracted on 2026-11-08; these products change quickly, re-check before acting. Nothing was tested here. Status `proposed`.

- **Tools:** prototype, evaluate on realistic multi-call tasks with verifiable outcomes, track accuracy/runtime/calls/tokens/errors, analyse transcripts, hold out tests; few high-impact tools, clear names, high-signal and token-efficient returns.
- **Evals:** combine code, model and human graders; grade outcomes not paths; calibrate LLM judges and allow "Unknown"; read transcripts to know graders work; pass@k (any of k) vs pass^k (all k): 75% per trial gives about 42% for three of three.
- **Context:** compaction keeps decisions and open bugs; structured notes; subagents return condensed summaries (often 1,000-2,000 tokens, as written).

## See also
- [[game-studio-skill-eval-design]] — skill evals
- [[benchmark-leakage-assertions]] — leakage
- [[game-studio-token-efficient-workflows]] — tokens
