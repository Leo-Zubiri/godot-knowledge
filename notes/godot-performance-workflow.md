---
id: godot-performance-workflow
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 performance workflow: measure first, fix the biggest bottleneck, separate CPU and GPU, use the profiler and Performance monitors (some debug-only; C# not profiled)."
tags: [dept/qa, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "General optimization, 3D optimization and profiler pages re-read for 4.7; Performance class per research subagent"
    ref: src-gd-performance
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-renderer-feature-matrix]]"   # renderer limits affect cost
  - relates-to: "[[godot-level-building-blocks]]"   # occlusion, MultiMesh and visibility ranges
  - relates-to: "[[game-studio-acceptance-criteria]]"   # performance budgets are project-defined
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Workflow (documented):** measure before optimizing; fix the biggest bottleneck first and re-profile; CPU and GPU run in parallel so frame time follows the slower — check them separately; algorithms and data layout beat low-level tweaks; avoid micro-optimizing non-critical code.
- **Tools:** Debugger panel > Profiler (function list and graph; ms/percent, inclusive/self time; pause on spikes and step); off by default (resource-intensive), Autostart not saved across sessions; **C# scripts cannot be profiled directly**; frame time includes rendering, so visual effects can look like script spikes; manual timing with `Time.get_ticks_usec()`/`get_ticks_msec()`.
- **`Performance` monitors (subagent):** `get_monitor()`, custom monitors via `add_custom_monitor()`; e.g. `TIME_FPS`, `OBJECT_COUNT`, `RENDER_TOTAL_DRAW_CALLS_IN_FRAME`; some are debug-only and return 0 in release exports; headless behaviour not stated.
- **3D advice:** occlusion culling, minimal transparency, LOD (import-time mesh LOD, visibility ranges, distance fade), billboards/impostors, automatic instancing only for identical opaque/alpha-tested meshes in Forward+ (otherwise MultiMesh), baked lighting with most lights Static, fewer animated polygons, tiled large worlds.
- The CPU, GPU and servers performance pages were **not read**.

## Scripted profiling run — verified addendum (4.7.2, windowed, real GPU; proposed, unreviewed)
A `SceneTree` script (`godot --path . -s tool.gd`) can drive a scene, sample every frame and print a table; verified on Godot 4.7.2 with a
physics-heavy scene (16 rigid bodies). What held and what did not:
- **Do not trust `Performance.TIME_PROCESS` for frame cost**: it returned values inconsistent with the frame rate (p95 ≈ 91 ms while the
  run averaged ≈ 240 fps). **Measure frame time yourself** with `Time.get_ticks_usec()` deltas between `await process_frame`.
- `Performance.TIME_PHYSICS_PROCESS` looked plausible (≈ 1 ms per frame for the 16 bodies at 120 ticks/s); `RENDER_TOTAL_DRAW_CALLS_IN_FRAME`
  and `RENDER_TOTAL_PRIMITIVES_IN_FRAME` returned real values in a **windowed** run (not tried headless). Take the max over the run, and
  remember the primitive count includes the shadow pass.
- In a `-s` script's `_init`, autoloads and absolute node paths are not available yet: `await process_frame` twice before touching them.
- CPU physics time is comparable across machines; fps and render counts depend on the GPU, so a phone needs its own run.
- Make the script exit non-zero when the p95 frame time exceeds the project budget, so it can gate a build.

## What an agent can and cannot check
An agent can add monitor logging and run a scripted scene to capture numbers; render monitors in a headless run are *unverified*. Perceived smoothness needs a human. Budgets are project-defined, not invented here.

## See also
- [[godot-renderer-feature-matrix]] — renderer limits affect cost
- [[godot-level-building-blocks]] — occlusion, MultiMesh and visibility ranges
- [[game-studio-acceptance-criteria]] — performance budgets are project-defined
