---
id: src-gd-2d-production
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/2d/using_tilesets.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/2d/using_tilesets.html"
    - "https://docs.godotengine.org/en/stable/tutorials/2d/2d_lights_and_shadows.html"
    - "https://docs.godotengine.org/en/stable/tutorials/2d/2d_parallax.html"
    - "https://docs.godotengine.org/en/stable/tutorials/2d/canvas_layers.html"
    - "https://docs.godotengine.org/en/stable/tutorials/2d/2d_transforms.html"
    - "https://docs.godotengine.org/en/stable/classes/class_camera2d.html"
    - "https://docs.godotengine.org/en/stable/classes/class_canvasitem.html"
  title: "Godot 4.7 2D production: TileSet, 2D lights, parallax, canvas layers, transforms, Camera2D"
  retrieved: 2026-11-08
  version: "4.7 (headers reported by subagent); CanvasItem page read partially"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **TileMapLayer/TileSet:** TileMapLayer nodes hold the layout and a TileSet resource holds tiles (atlas, scene collections); set tile size before auto-generating tiles; terrains replace Godot 3 autotiles (a tile can belong to several terrains); custom data layers store per-tile data. Pitfalls: scene tiles carry more overhead than atlas tiles; alternative tiles inherit nothing from the base tile; changing an alternative tile ID breaks existing maps; custom data is shared by all instances of a tile; Y Sort Origin only works with Y Sort Enabled; changing margins or separation can remove tiles. The TileMap→TileMapLayer migration was not read (unverified).
- **2D lights:** CanvasModulate for ambient colour; PointLight2D and DirectionalLight2D with LightOccluder2D (needs a polygon); shadow filter None is fastest and suits pixel art; pitfalls — the background colour receives no light, directional shadows are infinitely long, nearest texture filtering does not pixelate lighting (needs a shader snapping `LIGHT_VERTEX`), normal maps make lights look weaker.
- **Parallax:** `Parallax2D` is recommended over ParallaxBackground/ParallaxLayer; `scroll_scale` below 1 looks farther; `repeat_size`/`repeat_times` loop it; textures should have top-left at (0,0) and cover the viewport; zooming out can leave gaps.
- **CanvasLayer:** higher layer index draws above, layer number alone decides order (not tree position); a HUD on a layer keeps screen position when the camera moves; ordering can also use tree order or `z_index`.
- **Camera2D:** position smoothing off by default (speed 5.0); limits enabled by default; drag margins default 0.2; process callback defaults to idle; bitmap fonts blur when zoomed (oversampling ignores zoom; MSDF avoids it); pixel snapping not covered. **CanvasItem:** `texture_filter` default 0 inherits from the parent, Nearest is 1. **Canvas transforms** work in canvas coordinates so automatic resolution scaling works.
