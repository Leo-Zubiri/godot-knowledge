---
id: game-studio-godot-asset-format-and-import-compatibility
type: reference
domain: game-studio
status: proposed
summary: "What is known and what is not about the formats provider assets arrive in and how Godot/Blender import them; most per-provider format facts are unverified."
tags: [dept/assets, tool/godot]
sources:
  - claim: "Quaternius UAL pack formats and CC0 statement"
    ref: src-gs-asset-quaternius-ual-pack
    retrieved: 2026-11-08
  - claim: "Godot 4.7 documentation: available 3D formats and image import"
    ref: src-gs-godot-import-formats-47
    retrieved: 2026-11-08
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
  - relates-to: "[[godot-3d-import-options-and-export-hygiene]]"   # import options, export hygiene and post-import hooks
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

## Confirmed for Godot 4.7 (official docs, page headers say 4.7)
- 3D: glTF 2.0 (recommended; binary keeps textures inside, text variant diffs better), `.blend` (Godot calls Blender to export glTF; Blender 3.0+, 3.5+ recommended, installed on every machine; not in Android/web editors), FBX (**ufbx default since 4.3**; FBX2glTF is the older, not recommended path), DAE (poorly suited), OBJ (no skinning/animation/UV2/PBR). Blender export notes: deformation-bones-only for shape keys; backface culling off by default; Blender before 3.2 skips emissive textures.
- Images: PNG (8-bit, no HDR), JPEG (no alpha), WebP, EXR/HDR for skies; **SVG** is rasterized at import via ThorVG (limited features; text must be converted to paths; only SVG can import as DPITexture); 2D default compression is Lossless (use for pixel art), avoid VRAM Compressed in 2D; 3D uses VRAM Compressed and mipmaps.
- Audio and retargeting rules: see [[game-studio-godot-integration]] and [[game-studio-blender-pipeline]].

## Unknown / `unverified` (research gap)
- Download formats per provider: Kenney, KayKit, Poly Haven/ambientCG/TextureCan, Sketchfab and Fab listings, BlenderKit, Mixamo; Quaternius Universal Animation Library lists FBX/GLB/Blend/OBJ/glTF on its pack page.
- Whether provider rigs map cleanly to the humanoid BoneMap (vendor claims of "tested in Godot" are unverified).
- Godot font import rules (the docs page returned 404).
- Colour-space/normal-map conventions of PBR libraries versus Godot materials.

## Proposal
Treat every acquired asset as untrusted input: convert to GLB/PNG/OGG/WAV/SVG through Blender or ffmpeg where needed ([[gs-adr-interchange-formats]]), then run the import and validation gates. Fill the unknowns through an authorized, documentary or experimental pass before relying on any provider for a given workflow.

## See also
- [[game-studio-acceptance-criteria]]
- [[godot-3d-import-options-and-export-hygiene]] — import options, export hygiene and post-import hooks
