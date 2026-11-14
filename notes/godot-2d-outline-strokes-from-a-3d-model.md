---
id: godot-2d-outline-strokes-from-a-3d-model
type: guide
domain: godot
status: unreviewed
summary: "How to derive a clean 2D line drawing (polyline strokes) of a 3D character from its own mesh in Godot 4.7.2, headless and without rendering: project each part orthographically, rasterise the triangles into a software depth buffer that records which part is in front per pixel, trace each part's VISIBLE region with BitMap.opaque_to_polygons, and drop the borders shared with a part already traced. The strokes feed animated line art (traced logo, icons, in-world posters) that matches the model by construction."
aliases: [silhouette from mesh, line art from 3d model, outline tracing, opaque_to_polygons, software depth buffer, traced logo]
tags: [dept/2d-art, dept/3d-art, tool/godot, dim/2d]
applies-to:
  min: "4.0"
  tested: "Godot 4.7.2.stable.mono, run with --headless (no GPU); a ~2,200-triangle model at 640 px height took a few seconds"
sources: []
related:
  - relates-to: "[[game-studio-blender-pipeline]]"   # the model: one object per part
  - relates-to: "[[game-studio-art-readability-silhouette-and-animation-principles]]"   # why the silhouette is the thing to get right
  - relates-to: "[[godot-code-driven-character-animation-without-skeleton]]"   # same per-part model
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> **Evidence status — run here, unreviewed.** The method was implemented as a tool script and its output inspected in screenshots by
> the agent only. No external source: the engine calls used (`Mesh.get_faces`, `BitMap`, `Geometry2D`) are standard API; their exact
> behaviour was observed, not looked up for this note.

## Problem
A hand-drawn 2D silhouette of a character (for a logo animation, an icon, a poster inside the game) drifts from the 3D model: the owner
sees "it is close but looks odd". Deriving the line art from the mesh removes the drift and survives every later change to the model.

## Method (a `SceneTree` tool script, run with `--headless -s`)
1. **Collect triangles per part.** Instantiate the model, and for each named part take `mesh.get_faces()` transformed into model
   space. Compute the overall bounding box; map x/y to pixels (orthographic front view), keep z as depth.
2. **Software depth buffer.** Two flat arrays, `depth` (float, −INF) and `owner` (int, −1). Rasterise every triangle: for each pixel in
   its bounding box, barycentric test, interpolate z, and keep the part with the **largest z** (camera on +Z). This is the step that
   matters — see "what did not work".
3. **Trace the visible region of each part.** Build a `BitMap` of the pixels the part owns and call
   `opaque_to_polygons(rect, epsilon)` to get its contour(s).
4. **Do not draw shared borders twice.** Process parts in the order a hand would draw them. Keep a `BitMap` of everything already
   traced, grown by a few pixels (`grow_mask`); cut each new contour into the runs that are *not* inside it. Drop very short runs.
5. **Normalise and save** as JSON: x in [−0.5, 0.5] in units of the model height, y in [0, 1] from the top. Snap to ~0.0005 so the file
   is stable across runs. Commit it next to the model with its provenance entry.
6. **Consume** with a small static loader in a shared module (not inside one screen), so a splash, a menu and an in-world poster can all
   use it. Keep the old hand-drawn version as a fallback when the file is missing.

## What did not work
- **Ordering parts by a single depth value** (their maximum z) and masking what the nearer parts cover. A belly is nearer than a hat
  brim at its bulge but further at the top, so lines showed through and a spurious line appeared under the nose. Per-pixel depth fixed
  both.
- Tracing each part's **full** outline and hoping overlaps look fine: interior lines everywhere.

## Notes
- Cost: nested GDScript loops over triangle bounding boxes; fine for a build-time tool at a few thousand triangles and ~640 px. Not for
  runtime.
- The result is a set of **open polylines**, ideal for "the line draws itself" animations (draw a fraction of the total length).
- To put it on a 3D surface, rasterise the strokes into an `Image` once (stamp a small square along each segment), cache the
  `ImageTexture` by colour pair, and use it as albedo on a quad. `Label3D` text next to it should have `shaded = true` in a dark scene
  or it glows.
- Files read with `FileAccess` at runtime (JSON) are **not** exported unless the export preset's include filter lists them.

## See also
- [[game-studio-blender-pipeline]] — producing the per-part model the tracing relies on
