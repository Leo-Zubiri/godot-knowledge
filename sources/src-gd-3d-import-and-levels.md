---
id: src-gd-3d-import-and-levels
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/import_configuration.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/import_configuration.html"
    - "https://docs.godotengine.org/en/stable/tutorials/assets_pipeline/importing_3d_scenes/model_export_considerations.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/mesh_lod.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/visibility_ranges.html"
    - "https://docs.godotengine.org/en/stable/classes/class_editorscenepostimport.html"
    - "https://docs.godotengine.org/en/stable/classes/class_gltfdocument.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/occlusion_culling.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/csg_tools.html"
    - "https://docs.godotengine.org/en/stable/tutorials/performance/using_multimesh.html"
    - "https://docs.godotengine.org/en/stable/tutorials/3d/using_gridmaps.html"
    - "https://docs.godotengine.org/en/stable/tutorials/physics/large_world_coordinates.html"
  title: "Godot 4.7 3D import options, export hygiene, LOD, EditorScenePostImport, GLTFDocument and level building blocks"
  retrieved: 2026-11-08
  version: "4.7 — import configuration, export considerations, occlusion, CSG, MultiMesh, GridMap and large worlds re-read; CSG and MultiMesh pages carry not-updated-for-4.7 notices"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **Import options (re-read):** Root Type (a Node3D-derived type recommended), Root Name, **Apply Root Scale** (bakes scale into meshes and animations and keeps the root at default scale; otherwise the root scale multiplies), **Generate LODs**, **Create Shadow Meshes** (welds vertices to cut shadow bandwidth), **Light Baking** "Static Lightmaps" (sets GI mode Static and generates UV2; Lightmap Texel Size controls precision), animation options Import, FPS (rate used to bake curves), Trimming (removes unchanged keyframes at start/end), Remove Immutable Tracks. Collision generation is not mentioned on this page. Per subagent: Generate LODs is automatic for glTF/.blend/Collada/FBX (OBJ needs "Import As Scene" and an editor restart), can be disabled globally or per mesh in Advanced Import Settings, may cause rendering issues especially on skinned meshes and can be slow on complex meshes; per-node LOD Bias; global threshold Rendering > Mesh LOD > LOD Change > Threshold Pixels (default 1); MultiMesh and particles use a single LOD level for all instances.
- **Export hygiene (re-read):** characters face +Z (Blender front is −Y); for maps +X east and +Z south; triangulate before export (Triangulate modifier with Apply Modifiers, or exporter option) because import triangulation of quads/N-gons is unpredictable; apply object transforms; reset the skeleton to rest/T-pose; set lighting up in Godot after import (imported lights may look too strong or weak). Per subagent: right-handed Y-up, −Z forward; scale correctly in the modelling tool because scaling after import can cause precision problems.
- **EditorScenePostImport / GLTFDocument (subagent, 4.7):** a `@tool` script extending EditorScenePostImport overrides `_post_import(scene)` (must return the scene) and is assigned to the scene's Custom Script import property; `get_source_file()` returns the source path. GLTFDocument: `append_from_file`/`append_from_buffer` into a GLTFState then `generate_scene(...)` for runtime loading; `register_gltf_document_extension` (extensions must be stateless); named extensions on the page `KHR_node_visibility` (export) and `GODOT_single_root`; `get_supported_gltf_extensions()` lists the rest at runtime. Visibility ranges: Begin/End with margins, fade modes Disabled/Self/Dependencies (fades force transparent rendering), Visibility Parent for HLOD.
- **Occlusion culling (re-read):** enable the "Use Occlusion Culling" project setting (Advanced toggle visible), add OccluderInstance3D and bake from geometry or place shapes manually; use bake cull mask/visual layers to keep dynamic objects out; only MeshInstance3D nodes bake automatically (MultiMesh, particles and CSG need manual occluders unless CSG is converted to a mesh); transparent materials are left out; an object is culled only when its bounding box is completely covered; moving an occluder forces costly rebuilds (hiding/showing is cheaper); benefit is greatest in indoor scenes and smaller on Forward+ (depth prepass).
- **CSG (re-read; page says not yet updated for 4.7):** boolean union/intersection/subtraction, mainly for prototyping/level blockout; no built-in UV mapping (triplanar often used); custom meshes must be closed and manifold with volume; complex geometry slows processing; can be baked to a MeshInstance3D (hide the original CSG manually). Per subagent: a blocked-out level exports via Scene > Export As > glTF 2.0 Scene.
- **MultiMesh (re-read; page says not yet updated for 4.7):** one draw call for very many copies of one mesh (hundreds of thousands to millions); instances cannot be individually culled (all-or-none visibility); split across several MultiMeshes by region; per-instance behaviour in the vertex shader via `INSTANCE_ID`/`INSTANCE_CUSTOM`; `visible_instance_count`; set transform format, then mesh, then instance count, then visible count, then instance transforms.
- **GridMap (re-read):** MeshLibrary scene root is a Node3D whose direct children each become an item; each child must be a MeshInstance3D (only its visual mesh is exported); material belongs in the mesh's own material slot, not overrides; a child may have one StaticBody3D (with CollisionShape3D nodes) and one NavigationRegion3D; only this format is recognized; materials set on the GridMap node are ignored; baked navmesh cell size must match the NavigationServer map cell size; set lightmap texel size before conversion; placement limited by Pick Distance.
- **Large world coordinates (re-read):** float precision is highest near 0 and drops at each power of two; single-precision integers exact only to about ±16.8 million; recommended single-precision ranges roughly 2,048–4,096 units (first person), 4,096–8,192 (third person), 16,384–32,768 (top-down), and any 3D game should stay under about 32,768–65,536 before large world coordinates are usually needed; double precision needs recompiling the editor and the export templates with `precision=double` (binaries get a `.double` suffix, selected as custom export templates), same build type for server and clients, GDExtensions rebuilt with `REAL_T_IS_DOUBLE`, a performance/memory cost, and no 2D benefit.
