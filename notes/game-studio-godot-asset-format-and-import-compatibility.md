---
id: game-studio-godot-asset-format-and-import-compatibility
type: reference
domain: game-studio
status: proposed
summary: "What is known and what is not about the formats provider assets arrive in and how Godot/Blender import them; most per-provider format facts are unverified."
tags: [dept/assets, tool/godot]
sources:
  - claim: "Godot 3D import hints, post-import, retargeting for GLB/glTF scenes"
    ref: src-gs-godot-3d-import
    retrieved: 2026-11-08
  - claim: "Godot audio import: WAV, Ogg Vorbis, MP3 and looping rules"
    ref: src-gs-audio-import-and-tools
    retrieved: 2026-11-08
  - claim: "Provider format statements are mostly absent from licence pages; Poly Haven/ambientCG/TextureCan format lists not stated"
    ref: src-gs-asset-materials-hdri
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-blender-pipeline]]"   # Blender as the import/cleanup hub
  - relates-to: "[[game-studio-godot-integration]]"   # Godot import side
  - relates-to: "[[game-studio-acceptance-criteria]]"   # validation after import
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08 from official provider pages (paraphrased extractions, not verbatim legal text); no asset was downloaded and nothing was executed. **Not legal advice.** Terms change; items marked `unverified` were not read on an official page. Classes and workflows are *proposals* pending human review; ambiguous cases must go to a human.


## Known (from our preserved Godot sources)
- Godot imports glTF/GLB scenes with name-suffix hints (collision, navmesh, occluder, loop) and `EditorScenePostImport`; humanoid retargeting uses BoneMap + SkeletonProfileHumanoid (T-pose, +Z, Y-up).
- Audio imports as WAV, Ogg Vorbis or MP3; loop behaviour differs by format.
- Sources: [[game-studio-godot-integration]], [[game-studio-blender-pipeline]].

## Unknown / `unverified` (research gap)
- Download formats per provider: Kenney, Quaternius, KayKit packs; Poly Haven/ambientCG/TextureCan texture and model formats (PNG/EXR/JPG/blend/glTF?); Sketchfab and Fab per-listing formats; Mixamo's FBX export and rig conventions.
- Godot's FBX import path and quality for third-party rigs; whether provider rigs map cleanly to the humanoid BoneMap.
- SVG/PNG import details for icons and sprites; font embedding conditions under the OFL.
- Colour-space/normal-map conventions of PBR libraries versus Godot materials.

## Proposal
Treat every acquired asset as untrusted input: convert to GLB/PNG/OGG/WAV/SVG through Blender or ffmpeg where needed ([[gs-adr-interchange-formats]]), then run the import and validation gates. Fill the unknowns through an authorized, documentary or experimental pass before relying on any provider for a given workflow.

## See also
- [[game-studio-acceptance-criteria]]
