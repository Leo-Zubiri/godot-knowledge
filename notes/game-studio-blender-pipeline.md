---
id: game-studio-blender-pipeline
type: reference
domain: game-studio
status: proposed
summary: "Recommended Blender automation architecture for agents: headless bpy scripts as the source of truth, MCP only for exploration, GLB into Godot with import hints."
tags: [dept/3d-art, tool/blender, dim/3d]
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
updated: 2026-11-14
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Ratings are *preliminary recommendations*, not approved standards.


## Proposed architecture (design, not validated)
1. **Source of truth = committed `bpy` scripts** run with `blender --background --factory-startup --python <script> -- <args>` (pattern confirmed in the Mixar README). Pin Blender 5.2 LTS (and `bpy` 5.2.x / Python 3.13 if used as a module). Scripts are file-based, diffable and exit-code-checkable (reasoning, not a benchmark).
2. **MCP for exploration only.** The community server needs a running GUI with an unauthenticated socket and has arbitrary code execution (`execute_blender_code`); the official Blender Lab server runs code "without any guards" (VM recommended) and needs Blender 5.1+. Neither is documented as headless. Save any exploratory result as a script and re-run it headless to produce the artifact.
3. **Export GLB**, then let Godot import with hints: `-col`, `-convcol`, `-navmesh`, `-occ`, `-loop`/`-cycle`; custom properties arrive as glTF extras; NLA tracks via "Group Tracks"; retarget humanoids with BoneMap + `SkeletonProfileHumanoid` (T-pose, +Z, Y-up).
4. **Validate in bpy and Godot** before acceptance (see [[game-studio-acceptance-criteria]]).

## Verified in practice (2026-11, Blender 5.2.3, Linux, no display) — *run here, unreviewed*
Two assets (a rigid-part character and a furniture-scale prop) were produced end to end by script. What held:
- `blender --background --factory-startup --python script.py -- <args>` builds the scene, **renders stills with `BLENDER_WORKBENCH`** and
  exports GLB with no window and no GPU setup. (EEVEE headless was not tried.)
- Export call that imported cleanly into Godot 4.7.2: `bpy.ops.export_scene.gltf(filepath=…, export_format="GLB", export_yup=True,
  export_apply=True, export_materials="EXPORT", export_animations=False)`.
- **One object per recolourable slot / movable part**, exact names, one material each, **object origin at the joint**. The engine can then
  recolour per instance and animate parts in code without a skeleton ([[godot-code-driven-character-animation-without-skeleton]]).
- **Proportion parameters at the top of the script**; iterate by re-running. Review with a **black silhouette render** (front, side, 3/4)
  and a flat grey render before any colour ([[game-studio-art-readability-silhouette-and-animation-principles]]).
- **Validate inside the script and `sys.exit(1)` on failure:** required objects present, triangle budget, base at Z = 0, facing direction.
- Write a **manifest JSON** next to the GLB (dimensions, triangles per part, slot names, script hash, Blender version). Engine tests
  compare the imported scene against it, and gameplay code can refuse the model when its dimensions do not match the gameplay config.
- For real-world objects, put the **published measurements and their source URL in the script** and copy them to the manifest, so the
  model and the physics configuration can be checked against the same numbers.
- Keep review renders out of the repository (ignored folder); keep the generated `.blend` only if someone will open it by hand.

## Risks
- The Python API changes between releases and docs are large — agents may use stale names; pin the version.
- Headless limits (EEVEE needs GL; some operators need UI context) are `unverified` this session.
- glTF exporter option list not confirmed (manual URL returned 404).
- Visual/animation quality needs screenshots or human review.
- Mixar (closed backend, credits, MCP-call recording) adds nothing a bpy-driven agent needs: not recommended.

## See also
- [[game-studio-godot-integration]] — Godot-side import and tests
- [[gs-adr-blender-primary-3d]] — this is the architecture that decision implies
