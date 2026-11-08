---
id: src-gs-godot-3d-import
type: source
domain: game-studio
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/node_type_customization.html ; https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/import_configuration.html ; https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/retargeting_3d_skeletons.html"
  title: "Godot 3D scene import: node-type suffixes, import configuration, skeleton retargeting"
  retrieved: 2026-11-08
  version: "Godot stable docs, 2026-11-08"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Suffixes (accept `-`, `$`, `_`; case-insensitive): `-col` (trimesh StaticBody), `-convcol`, `-colonly`, `-convcolonly`, `-occ`, `-occonly`, `-navmesh` (converts to navmesh, removes original), `-rigid`, `-vehicle`, `-wheel`, `-noimp`, `-alpha`, `-vcol`, `-loop`/`-cycle` (looping animation).
- Import options: `EditorScenePostImport` with `_post_import(scene)`; animation FPS/trimming; animation filter script; "Group Tracks" for Blender NLA/active animations; "Generate LODs"; lightmap UV2 generation; custom properties as glTF extras (via `GLTFDocument` extensions).
- Retargeting: BoneMap + `SkeletonProfileHumanoid` (auto-map by bone name); Rest Fixer (Apply Node Transform, Normalize Position Tracks, Overwrite Axis, Fix Silhouette); reference T-pose facing +Z, Y-up; humanoid root should carry no transform. Rigify naming compatibility `unverified`. Root motion, headless reimport, navmesh headless bake not covered (`unverified`).
