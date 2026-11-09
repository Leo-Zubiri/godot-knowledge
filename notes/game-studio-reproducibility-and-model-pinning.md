---
id: game-studio-reproducibility-and-model-pinning
type: concept
domain: game-studio
status: proposed
summary: "Pin the model snapshot ID and record it, expect nondeterminism (temperature/top_p/top_k removed from the Claude API on 2026-10-21), and track deprecation dates."
tags: [dept/orchestration]
sources:
  - claim: "Model IDs are pinned snapshots; deprecation notice period; temperature, top_p and top_k removal; prompt-caching figures"
    ref: src-gs-agent-ops-models-injection-cost
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-token-efficient-workflows]]"   # cost levers
  - relates-to: "[[game-studio-skill-eval-design]]"   # evals under nondeterminism
  - relates-to: "[[game-studio-readiness-classification]]"   # reproducibility as a readiness dimension
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** official documentation as read on 2026-11-08 (paraphrased extractions by research subagents). Vendor and platform pages change quickly: re-check before acting. Fees and defaults are recorded as the page wrote them; nothing was tested here. Status `proposed`; not legal advice.


- **Pinned IDs:** per the Claude models overview, every Claude model ID is a pinned snapshot (including dateless IDs from the 4.6 generation on; earlier aliases are pointers to dated IDs). Retirement dates are listed as "not sooner than"; public models get at least 60 days' notice.
- **No fixed-temperature reproducibility:** `temperature`, `top_p` and `top_k` were removed in API version 2026-10-21 and return a 400 error; seed support was not found (*unverified*). **Treat every agent run as nondeterministic.**
- **Practice (interpretation):** record the model ID and tool/Godot/Blender versions with each run or asset; prefer scripts committed to Git over regenerated outputs; re-run validators instead of trusting a previous run.
- **Cost facts (as written 2026-11-08, change often):** prompt-cache default 5-minute TTL, optional 1-hour; write 1.25× (5 min) / 2× (1 h); reads 0.1× standard (0.05× on Opus 5.5 and Sonnet 5.5); minimum 512 cacheable tokens; a tool-definition change invalidates tools, system and messages caches; Sonnet 5.5 listed at $2 / $10 per MTok. Cost metrics in our own work remain *not measured*.
- OpenAI and OpenCode version-pinning and seed documentation were not read.

## See also
- [[game-studio-token-efficient-workflows]] — cost levers
- [[game-studio-skill-eval-design]] — evals under nondeterminism
- [[game-studio-readiness-classification]] — reproducibility as a readiness dimension
