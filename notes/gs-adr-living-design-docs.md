---
id: gs-adr-living-design-docs
type: decision
domain: game-design
status: proposed
summary: "Proposed: use lightweight, living design documents kept current through the definition of done, instead of a large upfront GDD."
tags: [dept/design]
sources:
  - claim: "Documents written once go stale; keep them living and include them in the definition of done (Florencio)"
    ref: src-gs-design-prototype-slice-docs
    retrieved: 2026-11-08
  - claim: "No data found showing heavy GDDs work or fail; evidence is opinion and anecdote"
    ref: src-gs-design-prototype-slice-docs
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-prototype-vs-vertical-slice]]"   # pre-production practice
  - relates-to: "[[game-studio-agent-orchestration]]"   # agents must keep docs consistent with code
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Context
Design documentation (GDD/TDD) is needed so agents and humans share intent, but sources found recommend against large upfront documents that go stale, and none of the sources read provides data for or against heavy GDDs. Agent-generated documents tend to look complete even where the design is undecided and cost tokens to read.

## Decision
Start with a short design document (the pillars, core loop, scope and build order) and keep it **living**: updating it is part of the definition of done for any feature. Grow it only where a decision needs recording; keep one source of truth per decision. `proposed`, pending human review. This is a project policy, not a research finding.

## Consequences
- Documents stay small and cheap to load; agents can check code against them.
- Risk: the document silently drifts from the build — mitigate with the definition of done and review of diffs.
- Risk: verbose agent drafts — keep length limits and reviewable diffs; a document never replaces playtesting ([[game-studio-playtesting-methods]]).
- Evidence is thin (one practitioner article read plus opinion pieces unread); revisit if better sources or project data appear.

## See also
- [[game-studio-prototype-vs-vertical-slice]] — pre-production context
- [[game-studio-agent-orchestration]] — agent responsibilities
