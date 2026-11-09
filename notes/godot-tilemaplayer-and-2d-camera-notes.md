---
id: godot-tilemaplayer-and-2d-camera-notes
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 TileMapLayer/TileSet pitfalls (TileMap deprecated), Camera2D and pixel snapping settings, and AudioStreamSynchronized limits."
tags: [dept/2d-art, tool/godot, dim/2d]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "TileMap deprecation, TileMapLayer, TileSet and Camera2D pages; AudioStreamSynchronized class"
    ref: src-gd-2d-tilemap-audio-import-i18n
    retrieved: 2026-11-08
  - claim: "Stretch mode and default texture filter defaults in the 4.7-stable class XML"
    ref: src-gd-projectsettings-subemitters-visualshaders
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-2d-production-settings]]"   # project settings for 2D
  - relates-to: "[[godot-navigation-overview]]"   # navigation for tile maps
  - relates-to: "[[godot-audio-buses-and-adaptive-music]]"   # layered music
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** distilled from the official Godot documentation as extracted on 2026-11-08 (paraphrased, see the cited source). Nothing was run in the engine: *documented*, not *experimentally validated*. Items marked UNV were not read on an official page. Status `proposed`.

- **Migration:** `TileMap` is deprecated in favour of several `TileMapLayer` nodes; the editor offers "Extract TileMap layers as individual TileMapLayer nodes". The introduction version ("4.3") is UNV from the docs.
- **TileMapLayer pitfalls:** updates batch to end of frame (`update_internals()` forces, costly); serialized coordinates are 16-bit signed (-32768..32767); Y-sorting disables `rendering_quadrant_size`; set `physics_quadrant_size` to 1 for exact body-to-cell lookup; sub-resources in runtime `TileData` are shared (duplicate first); built-in tile navigation performs poorly: bake with `NavigationRegion2D`.
- **TileSet:** set tile size before creating the atlas; changing alternative-tile IDs breaks maps; terrain sets need Terrain Set >= 0.
- **Camera2D / pixel art:** no dedicated pixel-art page. Settings seen: `snap_2d_transforms_to_pixel` false by default, `snap_2d_vertices_to_pixel` not recommended with it, `physics_jitter_fix` 0.5. The engine default for `display/window/stretch/mode` is `disabled` in 4.5, 4.6 and 4.7 (class XML); a search claim that new 4.7 projects default to `canvas_items` was **not confirmed** (the template/wizard value was not checked). `default_texture_filter` default is 1 (keywords nearest/linear).
- **AudioStreamSynchronized:** plays sub-streams in sync, up to 32; ends when the last sub-stream finishes and continues if any loops.

## See also
- [[godot-2d-production-settings]] — project settings for 2D
- [[godot-navigation-overview]] — navigation for tile maps
- [[godot-audio-buses-and-adaptive-music]] — layered music
