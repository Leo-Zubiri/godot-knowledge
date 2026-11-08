---
id: game-studio-level-design
type: reference
domain: game-studio
status: proposed
summary: Level design automation architecture for both 2D tile games and 3D environments, with Godot scenes as the integration target.
sources:
  - claim: "Tiled and LDtk-importer facts"
    ref: src-gs-level-2d-tools
    retrieved: 2026-11-08
  - claim: "Godot 3D import hints for collision, navmesh, occluders"
    ref: src-gs-godot-3d-import
    retrieved: 2026-11-08
  - claim: "Godot CLI for headless import/export"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-blender-pipeline]]"   # 3D environments come from Blender GLB
  - relates-to: "[[game-studio-godot-integration]]"   # Godot scenes are the target
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Everything here is a *proposal* pending human review.


The project targets **both 2D and 3D**, so two tracks exist; each tool must be justified per track.

## 3D track
Blender → GLB scene with node-name suffixes (`-col`, `-convcol`, `-navmesh`, `-occ`) yields collision, navigation meshes and occluders at import (documented). Modular kits and greyboxes need nothing beyond Blender + Godot. Headless navmesh baking and the Godot-side bake CLI are `unverified`.

## 2D track
- **Godot-native** scenes/TileMap are the baseline (not researched in depth here).
- **Tiled** (v1.12.2, 2026-05-27) has a built-in Godot 4 export; Godot-related changelog entries run through 1.11.0; licence `unverified`.
- **LDtk** with the third-party godot-ldtk-importer (MIT, Godot 4.1+): imports levels, TileMaps, entities; maintenance and headless use `unverified`; official LDtk repo not checked.
- Add Tiled/LDtk only when a 2D tile-based game needs an external level editor; do not introduce either into the 3D track.

## Open
Procedural-generation tools not investigated (no evidence of advantage). Genre of the first game determines which track comes first.

## See also
- [[game-studio-blender-pipeline]] — 3D asset export
- [[game-studio-godot-integration]] — Godot scenes are the target
