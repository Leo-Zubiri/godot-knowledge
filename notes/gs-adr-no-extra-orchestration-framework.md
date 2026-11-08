---
id: gs-adr-no-extra-orchestration-framework
type: decision
domain: game-studio
status: proposed
summary: Proposed: no additional orchestration framework; AGENTS.md, standard SKILL.md, MCP config and a task runner are sufficient.
sources:
  - claim: "Portable instruction/skill mechanisms across three agent products"
    ref: src-gs-agent-instructions-portability
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-agent-orchestration]]"   # evidence and caveats
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Context
The brief forbids extra frameworks without a measurable advantage; none was found.

## Decision
Use AGENTS.md as single instruction source, standard-only skills, shell/Makefile adapters.

## Consequences
Revisit only with measured evidence of coordination failures. Advisory instructions need CI and review as enforcement.

## See also
- [[game-studio-architecture-proposal]] — overall proposal
