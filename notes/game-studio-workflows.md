---
id: game-studio-workflows
type: guide
domain: game-studio
status: proposed
summary: Seven representative production workflows (character, PBR material, environment, UI, VFX, audio, vertical slice) documented as designed only, with autonomy, human steps and failure modes.
sources:
  - claim: "Blender → GLB → Godot mechanisms"
    ref: src-gs-godot-3d-import
    retrieved: 2026-11-08
  - claim: "Godot CLI/test mechanisms"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
  - claim: "Material Maker CLI"
    ref: src-gs-2d-ui-tools
    retrieved: 2026-11-08
  - claim: "Godot audio import rules"
    ref: src-gs-audio-import-and-tools
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-acceptance-criteria]]"   # each workflow ends in these gates
  - depends-on: "[[game-studio-blender-pipeline]]"   # 3D steps
  - depends-on: "[[game-studio-godot-integration]]"   # Godot steps
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Everything here is a *proposal* pending human review.


**All workflows below are `designed` only — none was executed or experimentally validated.** Time, tokens, API cost, retry rate: *not measured*.

| # | Workflow | Tool chain (preliminary) | Autonomous (design) | Human needed | Main failure modes |
|---|---|---|---|---|---|
| 1 | Character | Blender bpy (model, UV, materials, rig, animation) → GLB → Godot import → gdUnit4 | scripted build, export, import, tests | art direction, rig/animation quality review | retarget/rest-pose errors, stale bpy API, visual quality undetectable by script |
| 2 | PBR material | Material Maker CLI (`--target godot`) or Blender bake → Godot import | export and import | visual match, seam/tiling judgement | Godot output of Material Maker `unverified`; headless Linux `unverified` |
| 3 | Environment | Blender modular kit → GLB with `-col/-navmesh/-occ` → Godot scene assembly | export, import, scene build | layout and level feel | navmesh bake headless `unverified`; collision mismatch |
| 4 | UI | design spec (Penpot/SVG, optional) → Godot Control/Theme `.tscn/.tres` → runtime test | implementation, tests | visual design approval | headless screenshots limited; Penpot MCP needs browser |
| 5 | VFX | Godot particles/shaders (real-time) ; Blender/offline only for baked sprites | authoring as text resources | look and performance judgement | cost vs budget, visual evaluation |
| 6 | Audio | source audio → ffmpeg/sox (not researched) → WAV/Ogg → Godot import → playback test | conversion, import, format checks | creative quality, loudness taste | loop point errors; tools unresearched |
| 7 | Vertical slice | 2D and 3D mini-scene combining 1–6 | composition and tests | overall review | integration drift, version pinning |

Common steps: isolated workspace → generate with committed script → write manifest → run validation → route failures to the owning step → human gate.

## See also
- [[game-studio-acceptance-criteria]]
