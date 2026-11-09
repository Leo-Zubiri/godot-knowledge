---
id: game-studio-readiness-classification
type: concept
domain: game-studio
status: proposed
summary: "How to judge a tool for agent-driven game production: four separate readiness flags (API available, documented, agent-ready, production-ready) plus recommendation classes."
tags: [dept/orchestration]
sources:
  - claim: "Claim that tools advertise AI/MCP features that the repo docs do not fully back is illustrated by the Blender and Godot MCP evidence (GUI-bound, unguarded, no releases)."
    ref: src-gs-blender-mcp
    retrieved: 2026-11-08
  - claim: "Godot MCP servers differ in whether they need an open editor and what runtime interaction they expose."
    ref: src-gs-godot-mcp-servers
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-tool-matrix]]"   # applies these flags to each tool
  - relates-to: "[[game-studio-index]]"   # entry point
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Ratings are *preliminary recommendations*, not approved standards.


## The idea
Never call a tool "agent-ready" because it exposes an API, CLI or MCP server. Record four **separate** flags, each with evidence (or `unverified`):

| Flag | Meaning |
|---|---|
| **API available** | Programmatic operations exist (CLI, scripting API, JSON channel, MCP). |
| **API documented** | Operations, parameters and expected behaviour are documented. |
| **Agent-ready** | An agent can *discover*, *execute* and *verify* structured operations reliably (including seeing failures). |
| **Production-ready** | Repeatable, failures manageable, outputs predictable, acceptance criteria testable. |

Also record, per operation, whether it runs **headless** or needs an **interactive session** (GUI, browser, open editor).

## Recommendation classes
Primary (core tool) · Complementary (adds capability to a primary) · Experimental (promising, unvalidated) · Not recommended (complexity not justified). A *Primary* rating requires verified capability, workflow fit, integration reliability, maturity, licence suitability and a measurable advantage — not a feature list.

## Integration preference order
1. CLI and structured operations → 2. native APIs → 3. specialized scripting (e.g. Blender Python) → 4. MCP only where it adds agent-facing value → 5. GUI automation as a last resort. The architecture must **not depend on MCP**.

## Cost metrics are kept separate
Agent tokens, API cost, execution time, human intervention, retry rate. In this research all are **not measured**; never substitute an invented number.

## See also
- [[game-studio-tool-matrix]] — flags applied per tool
- [[game-studio-index]] — entry point
