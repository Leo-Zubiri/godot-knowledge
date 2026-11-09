---
id: godot-3d-import-options-and-export-hygiene
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 3D import options (root scale, Generate LODs, shadow meshes, lightmap UV, animation trimming), EditorScenePostImport/GLTFDocument, and the Blender export hygiene checklist."
tags: [dept/3d-art, dept/assets, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Import configuration and model export considerations pages re-read for 4.7; EditorScenePostImport and GLTFDocument per research subagent"
    ref: src-gd-3d-import-and-levels
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-godot-asset-format-and-import-compatibility]]"   # formats and image/audio import
  - relates-to: "[[game-studio-blender-pipeline]]"   # Blender side of the pipeline
  - relates-to: "[[game-studio-acceptance-criteria]]"   # import validation
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


## Import options (import configuration page)
Root Type (Node3D-derived recommended), Root Name, **Apply Root Scale** (bakes scale into meshes/animations; otherwise root scale multiplies), **Generate LODs**, **Create Shadow Meshes** (welds vertices to cut shadow bandwidth), Light Baking "Static Lightmaps" (GI mode Static + UV2; Lightmap Texel Size), animation Import/FPS/Trimming/Remove Immutable Tracks. **Collision generation is not mentioned on this page.** Subagent: Generate LODs is automatic for glTF/.blend/Collada/FBX, can be disabled globally or per mesh, may cause rendering issues on skinned meshes and be slow on complex meshes.

## Export hygiene (documented)
Characters face **+Z** (Blender front is −Y); triangulate before export (quads/N-gons import unpredictably); apply object transforms; reset the skeleton to rest/T-pose; set lighting up in Godot after import; scale correctly in the modelling tool (subagent).

## Automation hooks (subagent, 4.7 headers)
`EditorScenePostImport` — a `@tool` script overriding `_post_import(scene)` (must return the scene), assigned to the scene's Custom Script import property. `GLTFDocument` — `append_from_file`/`append_from_buffer` into a `GLTFState`, then `generate_scene()` for runtime loading; extensions must be stateless; `get_supported_gltf_extensions()` lists supported ones. Headless/CLI reimport is not covered on these pages (*unverified*).

## What an agent can and cannot check
An agent can read `.import` files and glTF JSON (extensions, scale, material count) and Blender export script options. Import success, LOD artefacts on skinned meshes and shadow-mesh results need the editor to run.

## See also
- [[game-studio-godot-asset-format-and-import-compatibility]] — formats and image/audio import
- [[game-studio-blender-pipeline]] — Blender side of the pipeline
- [[game-studio-acceptance-criteria]] — import validation
