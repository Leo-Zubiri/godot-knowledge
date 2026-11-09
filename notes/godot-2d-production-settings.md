---
id: godot-2d-production-settings
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 2D production settings and pitfalls: TileMapLayer/TileSet, 2D lights and normal maps, Parallax2D, canvas layers, Camera2D, texture filter."
tags: [dept/2d-art, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "2D pages: tilesets, 2D lights, parallax, canvas layers, transforms, Camera2D, CanvasItem"
    ref: src-gd-2d-production
    retrieved: 2026-11-08
related:
  - relates-to: "[[characterbody2d-movement]]"   # 2D gameplay
  - relates-to: "[[godot-ui-layout-and-themes]]"   # pixel-art stretch settings
  - relates-to: "[[game-studio-2d-ui-audio-materials]]"   # 2D tool stack
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **TileSet pitfalls:** set tile size before auto-generating; scene tiles cost more than atlas tiles; alternative tiles inherit nothing from the base tile and changing their ID breaks maps; custom data is shared by all instances of a tile; Y Sort Origin needs Y Sort Enabled; changing margins/separation can remove tiles. (TileMap→TileMapLayer migration not read.)
- **2D lights:** CanvasModulate for ambient; LightOccluder2D needs a polygon; shadow filter None is fastest for pixel art; the background receives no light; nearest filtering does not pixelate lighting (needs a shader); normal maps weaken lights.
- **Parallax:** prefer `Parallax2D`; `scroll_scale` < 1 looks farther; textures should start at (0,0) and cover the viewport.
- **CanvasLayer:** higher index draws above, independent of tree position; HUD on a layer stays fixed when the camera moves.
- **Camera2D:** smoothing off by default; limits on; drag margins 0.2; bitmap fonts blur when zoomed. **CanvasItem** `texture_filter` 0 inherits; Nearest is 1. Pixel snapping was not covered.

## What an agent can and cannot check
An agent can read `.tres`/`.tscn` for TileSet layers, non-empty occluder polygons, stretch/filter settings and z_index/layer collisions. Seams, art coherence and lighting look need a human.

## See also
- [[characterbody2d-movement]] — 2D gameplay
- [[godot-ui-layout-and-themes]] — pixel-art stretch settings
- [[game-studio-2d-ui-audio-materials]] — 2D tool stack
