---
id: src-gd-performance
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/performance/index.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/performance/index.html"
    - "https://docs.godotengine.org/en/stable/tutorials/performance/general_optimization.html"
    - "https://docs.godotengine.org/en/stable/tutorials/performance/optimizing_3d_performance.html"
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/debug/the_profiler.html"
    - "https://docs.godotengine.org/en/stable/classes/class_performance.html"
  title: "Godot 4.7 performance: optimization workflow, 3D optimization, profiler, Performance monitors"
  retrieved: 2026-11-08
  version: "4.7 — general optimization, 3D optimization and profiler re-read by the main agent"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **General optimization (re-read):** measure before optimizing (timers, the built-in profiler, external profilers, frame-rate tools); fix the biggest bottleneck first and re-profile; CPU and GPU run in parallel so frame time follows the slower — check them separately; design (algorithms, cache-friendly data) matters more than low-level tweaks; avoid micro-optimizing non-critical code.
- **3D optimization (re-read):** occlusion culling (layouts may need extra walls); keep transparency minimal (move transparent parts to their own surface/material); LOD via import-time mesh LOD, manual visibility ranges and distance fade; billboards/impostors for distant objects (many overlapping transparent billboards strain fill rate); automatic instancing for identical opaque or alpha-tested meshes only in Forward+, otherwise MultiMesh; bake lightmaps and set most lights Static, keeping the DirectionalLight3D dynamic; reduce animated polygon counts and animation of distant/unseen meshes (VisibleOnScreen nodes); build large worlds in tiles loaded on demand and handle float precision by large world coordinates or recentering.
- **Profiler (re-read):** Debugger panel > Profiler tab; shows function list and performance graph (frame, physics frame, idle, physics time); ms/percent and inclusive/self time; pause on spikes and step frames; off by default (resource-intensive), Autostart is not saved across editor sessions; **C# scripts cannot be profiled directly** (page suggests Rider/dotTrace); frame time includes rendering so visual effects can look like script spikes; manual timing with `Time.get_ticks_usec()`/`get_ticks_msec()`.
- **Performance class (subagent, 4.7):** `get_monitor(monitor)`, `add_custom_monitor(id, callable, arguments, type)`, `get_custom_monitor(id)`; samples include `TIME_FPS`, `TIME_PROCESS`, `MEMORY_STATIC`, `OBJECT_COUNT`, `RENDER_TOTAL_DRAW_CALLS_IN_FRAME`, `PHYSICS_2D_ACTIVE_OBJECTS`; some monitors (e.g. `OBJECT_ORPHAN_NODE_COUNT`) are debug-only and return 0 in release exports; headless behaviour not stated. The performance index lists CPU, GPU (MultiMesh, shader-compilation stutter), 3D, threads and servers pages; CPU, GPU and servers pages were not read.
