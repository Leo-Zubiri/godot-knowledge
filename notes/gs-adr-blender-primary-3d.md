---
id: gs-adr-blender-primary-3d
type: decision
domain: game-studio
status: proposed
summary: Proposed: Blender, driven by headless bpy scripts, is the primary 3D production tool; its scope is not stretched where specialists win.
sources:
  - claim: "Blender 5.2 LTS, pip bpy, CLI pattern"
    ref: src-gs-blender-releases-bpy
    retrieved: 2026-11-08
  - claim: "Blender MCP is GUI-bound and unguarded"
    ref: src-gs-blender-mcp
    retrieved: 2026-11-08
  - claim: "Mixar adds closed backend"
    ref: src-gs-mixar
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-blender-pipeline]]"   # architecture implementing this
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Context
Brief names Blender as leading 3D candidate. Evidence: LTS release, documented Python API and CLI background mode; MCP options are interactive-only and unsandboxed; Mixar adds only a hosted dependency.

## Decision
Blender 5.2 LTS via committed bpy scripts is the proposed primary 3D tool. Texturing/animation stay in Blender unless a specialist (e.g. Material Maker for batch PBR) shows a demonstrated advantage. `proposed`, pending human review.

## Consequences
Pin Blender/bpy versions; legal check on GPL when distributing bpy-based tools; headless limits and glTF options still `unverified`; no experimental validation of agent-generated assets yet.

## See also
- [[game-studio-architecture-proposal]] — overall proposal
