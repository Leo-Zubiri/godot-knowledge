---
id: godot-level-building-blocks
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 level building blocks: GridMap MeshLibrary structure, CSG for prototyping, MultiMesh, occlusion culling, visibility ranges and large-world precision limits."
tags: [dept/level-design, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Occlusion, CSG, MultiMesh, GridMap and large world coordinates pages re-read for 4.7 (CSG and MultiMesh flagged possibly outdated)"
    ref: src-gd-3d-import-and-levels
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-level-design]]"   # level design overview
  - relates-to: "[[godot-navigation-overview]]"   # GridMap navigation
  - relates-to: "[[godot-performance-workflow]]"   # culling and instancing
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **GridMap:** the MeshLibrary scene root is a Node3D whose direct children each become an item; each must be a MeshInstance3D (only its visual mesh is exported); the material goes in the mesh's own slot; a child may have one StaticBody3D and one NavigationRegion3D; **only this format is recognized**; baked navmesh cell size must match the NavigationServer map cell size; set lightmap texel size before conversion.
- **CSG:** for prototyping/blockout (page says not yet updated for 4.7); no built-in UVs; custom meshes must be closed and manifold; can be baked to a MeshInstance3D.
- **MultiMesh:** one draw call for very many copies of one mesh; visibility is **all-or-none** (no per-instance culling); split by region; set transform format, mesh, instance count, visible count, then transforms.
- **Occlusion culling:** enable the project setting, add and bake OccluderInstance3D; only MeshInstance3D bakes automatically (MultiMesh, particles and unconverted CSG need manual occluders); transparent materials excluded; an object is culled only when fully covered; moving occluders rebuilds; benefit greatest indoors and smaller on Forward+.
- **Visibility ranges:** Begin/End with margins, fade modes (fades force transparent rendering), Visibility Parent for HLOD (subagent).
- **Large worlds:** single precision is fine up to roughly 2,048–4,096 units (first person), 4,096–8,192 (third person), 16,384–32,768 (top-down); beyond about 32,768–65,536 large world coordinates are usually needed; double precision requires recompiling editor and export templates with `precision=double`, rebuilding GDExtensions, same build type on server and clients, and has no 2D benefit.

## What an agent can and cannot check
An agent can read `.tscn` for MeshLibrary layout, occluder presence, cell sizes, the occlusion project setting and distances from origin. Bakes (occluder, navmesh, lightmap), culling correctness and frame cost need the editor/engine.

## See also
- [[game-studio-level-design]] — level design overview
- [[godot-navigation-overview]] — GridMap navigation
- [[godot-performance-workflow]] — culling and instancing
