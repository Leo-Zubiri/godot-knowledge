---
id: game-studio-token-efficient-workflows
type: pattern
domain: game-studio
status: proposed
summary: Mechanisms that cut unnecessary agent work (default-minimal process, scripts instead of reading docs, files as memory, subagent summaries, read guards) versus those that add overhead.
sources:
  - claim: "Skill size caps, references folder, session card, generated index"
    ref: src-gs-gp-skill-architecture
    retrieved: 2026-11-08
  - claim: "Reference context strategies, budgets, read guard and subagent summaries"
    ref: src-gs-ccgs-safety-and-session
    retrieved: 2026-11-08
  - claim: "Reference rigor tiers and review-mode cost levers"
    ref: src-gs-ccgs-workflow-rigor-and-gates
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-progressive-disclosure-routing]]"   # skill-loading layers and size caps
  - relates-to: "[[game-studio-configurable-rigor]]"   # process weight
  - relates-to: "[[game-studio-session-lifecycle]]"   # state in files
  - relates-to: "[[game-studio-hardware-and-cost]]"   # cost metrics are not measured
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


> No token, cost or time figures were found; budgets cited below are the project's own guidance (unmeasured).

## Savings (documented)
- Default minimal rigor and solo review spawn no director gates.
- **Scripts over reading:** deterministic questions (which sections a doc has, what changed since review) are answered by scripts; helpers report facts, callers judge. Release v1.2.0 rebuilt core story skills around helper scripts.
- **Files as memory** instead of long chat history; proactive compaction.
- **Subagent summaries:** delegate broad research, return only a summary; direct reads for a few known files.
- **Read guard:** refuse whole-file reads of very large docs and return headings for ranged reads.
- Gate prompts live in one file read by the reviewer, not loaded by the caller.

## Overhead (documented or inferred)
Standard/full documentation sets, per-step gates, large skill/agent catalogs, hook output, and a large command registry loaded into context.

## Skill-loading levers (second reference: GodotPrompter, documented)
Capped skill bodies with overflow to on-demand references, a small gated routing card, a generated index, and trigger-style descriptions reduce what is always loaded; mentor mode, a large agent roster and manual wiring add recurring overhead. Details and caveats (description-only routing was unreliable for some skills) in [[game-studio-progressive-disclosure-routing]]. Token cost remains *not measured*.

## Proposal for us
Prefer scripts + small skills; measure before claiming savings (tokens, API cost, time, human intervention, retry rate — all *not measured* here).

## See also
- [[game-studio-hardware-and-cost]] — metric definitions
