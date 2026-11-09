---
id: agent-ops-index
type: index
domain: agent-ops
summary: "Map of content for agent operations: orchestration, safety and permissions, sessions and cost, skills and knowledge-base engineering, and the two reference-architecture studies — engine- and game-agnostic."
related:
  - relates-to: "[[godot-index]]"   # Godot engine knowledge
  - relates-to: "[[game-studio-index]]"   # game production knowledge that uses these practices
  - relates-to: "[[game-design-index]]"   # game design knowledge
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Agent operations — map of content
Navigational only; no claims. Knowledge about running AI coding agents safely and efficiently and about engineering the knowledge base itself. It is **engine- and game-agnostic**; note ids keep the historical `game-studio-` prefix. All claim-bearing notes are `proposed`.

### Orchestration and topology
- [[game-studio-readiness-classification]] — how tools and interfaces are judged
- [[game-studio-agent-orchestration]] · [[game-studio-multiagent-topology]] · [[game-studio-delegation-boundaries]]
- [[gs-adr-no-extra-orchestration-framework]] · [[gs-adr-mcp-optional]]

### Process rigor and review
- [[game-studio-configurable-rigor]] · [[game-studio-review-modes-and-verdicts]]

### Safety, permissions and recovery
- [[game-studio-path-scoped-safety]] · [[game-studio-agent-permission-controls]] · [[game-studio-untrusted-content-and-headless-runs]]
- [[game-studio-mcp-spec-requirements]] · [[game-studio-agent-audit-and-recovery]]

### Sessions, cost and reproducibility
- [[game-studio-session-lifecycle]] · [[game-studio-token-efficient-workflows]] · [[game-studio-reproducibility-and-model-pinning]]

### Skills and knowledge-base engineering
- [[game-studio-skills-architecture]] · [[game-studio-godot-skill-taxonomy]] · [[game-studio-progressive-disclosure-routing]] · [[game-studio-platform-portability-matrix]]
- [[game-studio-skill-validation-architecture]] · [[game-studio-skill-eval-design]] · [[game-studio-godot-example-verification]]
- [[game-studio-version-aware-godot-knowledge]] · [[game-studio-third-party-addon-knowledge]] · [[game-studio-game-project-profile]]
- Evaluating knowledge: [[benchmark-leakage-assertions]] · [[knowledge-availability-vs-application]]

### Reference-architecture studies (patterns only, not dependencies)
- [[game-studio-ccgs-reference-comparison]] · [[game-studio-gp-reference-comparison]] · [[game-studio-framework-churn-risk]]

### Sources
Agent-operations sources (`src-gs-agent-*`, `src-gs-ccgs-*`, `src-gs-gp-*`, `src-h06-platformer-experiment`) are listed in [[game-studio-sources-index]].

## See also
- [[godot-index]] — Godot engine knowledge
- [[game-studio-index]] — game production knowledge
- [[game-design-index]] — game design knowledge
