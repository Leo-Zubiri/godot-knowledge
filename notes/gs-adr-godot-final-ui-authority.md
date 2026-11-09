---
id: gs-adr-godot-final-ui-authority
type: decision
domain: game-studio
status: proposed
summary: "Proposed: Godot Control nodes and Theme resources are the final UI authority; external design tools only supply specs and assets."
tags: [dept/ui-ux, tool/godot]
sources:
  - claim: "Godot audio/Theme authority and Penpot MCP browser dependency"
    ref: src-gs-2d-ui-tools
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-2d-ui-audio-materials]]"   # UI section
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Context
Penpot's MCP needs a browser plugin and design exports are not engine UI; Godot UI is text-authored and git-diffable.

## Decision
Implement UI in Godot (`.tscn/.tres`); Penpot/SVG/FigCraft are optional spec sources.

## Consequences
Design-to-engine drift must be checked by runtime tests; Godot Theme docs still to be fetched.

## See also
- [[game-studio-architecture-proposal]] — overall proposal
- [[game-studio-2d-ui-audio-materials]] — UI section
