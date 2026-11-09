---
id: game-studio-blender-pipeline
type: reference
domain: game-studio
status: proposed
summary: "Recommended Blender automation architecture for agents: headless bpy scripts as the source of truth, MCP only for exploration, GLB into Godot with import hints."
tags: [dept/3d-art, tool/blender]
sources:
  - claim: "Blender 5.2 LTS, bpy wheel constraints, unconfirmed headless limits"
    ref: src-gs-blender-releases-bpy
    retrieved: 2026-11-08
  - claim: "Official and community Blender MCP properties and security"
    ref: src-gs-blender-mcp
    retrieved: 2026-11-08
  - claim: "Mixar adds a closed hosted dependency over vanilla Blender"
    ref: src-gs-mixar
    retrieved: 2026-11-08
  - claim: "Godot suffix hints, import options, retargeting"
    ref: src-gs-godot-3d-import
    retrieved: 2026-11-08
related:
  - depends-on: "[[gs-adr-blender-primary-3d]]"   # this is the architecture that decision implies
  - relates-to: "[[game-studio-godot-integration]]"   # import side
  - relates-to: "[[game-studio-acceptance-criteria]]"   # validation of exported assets
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Ratings are *preliminary recommendations*, not approved standards.


## Proposed architecture (design, not validated)
1. **Source of truth = committed `bpy` scripts** run with `blender --background --factory-startup --python <script> -- <args>` (pattern confirmed in the Mixar README). Pin Blender 5.2 LTS (and `bpy` 5.2.x / Python 3.13 if used as a module). Scripts are file-based, diffable and exit-code-checkable (reasoning, not a benchmark).
2. **MCP for exploration only.** The community server needs a running GUI with an unauthenticated socket and has arbitrary code execution (`execute_blender_code`); the official Blender Lab server runs code "without any guards" (VM recommended) and needs Blender 5.1+. Neither is documented as headless. Save any exploratory result as a script and re-run it headless to produce the artifact.
3. **Export GLB**, then let Godot import with hints: `-col`, `-convcol`, `-navmesh`, `-occ`, `-loop`/`-cycle`; custom properties arrive as glTF extras; NLA tracks via "Group Tracks"; retarget humanoids with BoneMap + `SkeletonProfileHumanoid` (T-pose, +Z, Y-up).
4. **Validate in bpy and Godot** before acceptance (see [[game-studio-acceptance-criteria]]).

## Risks
- The Python API changes between releases and docs are large — agents may use stale names; pin the version.
- Headless limits (EEVEE needs GL; some operators need UI context) are `unverified` this session.
- glTF exporter option list not confirmed (manual URL returned 404).
- Visual/animation quality needs screenshots or human review.
- Mixar (closed backend, credits, MCP-call recording) adds nothing a bpy-driven agent needs: not recommended.

## See also
- [[game-studio-godot-integration]] — Godot-side import and tests
- [[gs-adr-blender-primary-3d]] — this is the architecture that decision implies
