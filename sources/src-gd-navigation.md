---
id: src-gd-navigation
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_3d.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_3d.html"
    - "https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_using_navigationmeshes.html"
    - "https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_using_navigationagents.html"
  title: "Godot 4.7 navigation: introduction, navigation meshes, navigation agents"
  retrieved: 2026-11-08
  version: "4.7 — introduction and agents re-read by the main agent; meshes page 4.7 per subagent"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **Components (re-read):** AStar3D (graph of weighted points, cell-based games); NavigationServer3D (mesh-based real-time pathfinding; maps, regions, links, agents, obstacles referenced by RID); NavigationRegion3D (holds a NavigationMesh, can be toggled/filtered by layer); NavigationLink3D (connects two points, one- or two-way; movement across it must be scripted); NavigationAgent3D (helper for pathfinding/avoidance calls for a parent node); NavigationObstacle3D (adjusts avoidance velocity only, does not change routes); NavigationMesh (resource used by regions and GridMap cells).
- **Map synchronization (re-read):** the navigation map does not sync region data until after the first physics frame, so early path queries return nothing; delay setting a target until one physics frame has passed; do not `await` inside `_ready` — call the setup deferred.
- **Agents (re-read):** setting `target_position` queries a new path; the system never moves the parent node; call `get_next_path_position()` once per physics frame and only while `is_navigation_finished()` is false (not supported from regular process); thresholds `path_desired_distance`, `target_desired_distance`, `path_max_distance`; avoidance needs `avoidance_enabled`, connect `velocity_computed`, pass desired velocity each physics frame and move by the safe velocity; a `target_position` must be set even for avoidance only or safe velocity stays zero; avoidance ignores navigation meshes and physics colliders and does not change pathfinding; tuning: `radius`, `neighbor_distance`, `max_neighbors`, time horizons, `max_speed`, `use_3d_avoidance`, layers/mask, `avoidance_priority`. Listed pitfalls: empty path when querying before sync; jitter from per-frame retargeting; fast agents overshooting waypoint distance and backtracking; agents on mesh edges briefly facing backward; disabling path metadata flags disables dependent signals; agents with exactly opposite velocities may fail to avoid.
- **Navigation meshes (per subagent, 4.7):** bake in the editor, or at runtime with `bake_navigation_mesh(on_thread)` (3D) / `bake_navigation_polygon(on_thread)` (2D); server path `parse_source_geometry_data()` then `bake_from_source_geometry_data()` or `..._async()`; settings `parsed_geometry_type`, `collision_mask`, `source_geometry_mode`, `cell_size`, `cell_height`, `agent_radius`; parsing the SceneTree must run on the main thread; reading visual meshes at runtime stalls the RenderingServer, so prefer physics shapes; a very small `cell_size`/`cell_height` can freeze or crash. **Headless baking is not discussed on these pages (unverified).**
