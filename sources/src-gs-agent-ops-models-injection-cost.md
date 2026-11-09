---
id: src-gs-agent-ops-models-injection-cost
type: source
domain: agent-ops
source:
  url: "https://platform.claude.com/docs/en/about-claude/models/overview"
  urls:
    - "https://platform.claude.com/docs/en/about-claude/models/overview"
    - "https://platform.claude.com/docs/en/about-claude/model-deprecations"
    - "https://platform.claude.com/docs/en/build-with-claude/prompt-caching"
    - "https://platform.claude.com/docs/en/test-and-evaluate/strengthen-guardrails/mitigate-jailbreaks"
    - "https://platform.claude.com/docs/en/test-and-evaluate/develop-tests"
  title: "Claude platform docs: model IDs and deprecations, prompt caching, prompt-injection mitigation, eval design"
  retrieved: 2026-11-08
  version: "as written on 2026-11-08; pricing and dates change"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; not re-read by the main agent. Fees, prices, shares, deadlines and product defaults are recorded *only as the page wrote them on that date* and change; items marked UNV/unverified were not read on an official page (404, blocked, search-snippet only). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **Model IDs (models overview):** every Claude model ID is a pinned snapshot, including the dateless IDs used from the 4.6 generation on (for earlier models the alias is a pointer to a dated ID); example IDs `claude-sonnet-5-5`, `claude-opus-5-5`; a table gives "retirement: not sooner than" dates (e.g. Sonnet 5.5 September 28, 2027); 1M-token context window and 128K max output listed for the four current models; Sonnet 5.5 listed at $2 per input MTok and $10 per output MTok; Batch API 50% off; default effort `high` for Sonnet 5.5.
- **Deprecations:** at least 60 days' notice before retirement of publicly released models (example: claude-sonnet-4-5-20250929 deprecated 2026-09-30, retires 2026-11-30); partner platforms set their own schedules. **`temperature`, `top_p` and `top_k` were removed in API version 2026-10-21 and return a 400 error**; the page recommends prompting instead; seed support not found on the pages read (UNV).
- **Prompt caching (~100k chars):** default 5-minute TTL, optional 1-hour; write multipliers 1.25× (5 min) and 2× (1 h) of base input price; reads 0.1× standard, 0.05× on Opus 5.5 and Sonnet 5.5, 0.025× on Fable 5.1; minimum cacheable prompt 512 tokens for the current models; cache order tools, system, messages — a tool-definition change invalidates all three levels.
- **Prompt-injection mitigation:** separates direct and indirect injection; put untrusted content only in `tool_result` blocks and label its source; state an untrusted-content policy in the system prompt; JSON-encode third-party strings; do not put your own instructions in tool results; least privilege and sandboxed tools; screen tool outputs with a small model; red-team the agent; the page says Claude is "inherently resilient" but gives no failure rates.
- **Eval design (develop-tests):** specific, measurable criteria; automate grading (exact match, code checks, LLM judge); use a different model as grader when possible; many auto-graded cases beat few hand-graded ones. This is about application evals, not agent transcripts; vendor engineering pages on agent eval/transcripts not read (UNV).
