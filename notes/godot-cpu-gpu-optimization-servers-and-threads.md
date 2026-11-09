---
id: godot-cpu-gpu-optimization-servers-and-threads
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 optimization specifics: CPU and GPU advice, when to use servers (RIDs), and thread-safety rules that make threaded loading safe."
tags: [dept/game-dev, tool/godot, dept/qa]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "CPU/GPU optimization, servers and thread-safe API pages"
    ref: src-gd-particles-shaders-performance
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-performance-workflow]]"   # measure first
  - relates-to: "[[godot-physics-bodies-layers-and-interpolation]]"   # physics tick and interpolation
  - relates-to: "[[godot-level-building-blocks]]"   # MultiMesh and culling
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** distilled from the official Godot documentation as extracted on 2026-11-08 (paraphrased, see the cited source). Nothing was run in the engine: *documented*, not *experimentally validated*. Items marked UNV were not read on an official page. Status `proposed`.

- **CPU:** profile first; GDScript trades speed for ease; C# can pause for garbage collection (pool objects); fewer nodes doing more is often faster; simplified collision shapes; lowering the physics tick causes jitter/input lag (use built-in interpolation); pausing/hiding nodes can cost more than `remove_child()`; the profiler may omit time waiting on servers (known bug).
- **GPU:** fewer, batched draw calls; reuse materials then shaders; vertex count rarely the desktop bottleneck; test fill rate by comparing FPS at large vs small window with V-Sync off; VRAM compression is fine in 3D, visible in 2D, pixel art keeps it off; shadows and post-processing dominate fragment cost; mobile GPUs are tile-based.
- **Servers (RenderingServer, PhysicsServer, AudioServer):** RIDs are opaque, freed manually and not reference-counted; use only after other optimizations (tens of thousands of instances); reading values stalls the server.
- **Threads:** most singletons are thread-safe, but physics needs "Run on Separate Thread" and rendering "Thread Model: Separate" (both with known bugs); the active scene tree is not thread-safe, so build off-tree and attach with `call_deferred`; never modify one resource from several threads; resizing containers needs a mutex.

## See also
- [[godot-performance-workflow]] — measure first
- [[godot-physics-bodies-layers-and-interpolation]] — physics tick and interpolation
- [[godot-level-building-blocks]] — MultiMesh and culling
