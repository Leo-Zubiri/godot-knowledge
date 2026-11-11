---
id: src-gd-godot-physics-options-and-jolt
type: source
kind: web-paraphrase
domain: godot
retrieved: 2026-11-10
method: "web research; official docs.godotengine.org/en/4.7 and Jolt README prioritized, community sources marked"
---

# Source — Godot 4.7 physics options for a ball game (paraphrased)

Researched 2026-11-10. **[OFICIAL]** = docs.godotengine.org/en/4.7 or jrouwe JoltPhysics README; **[SEMI]** = godot-jolt
authors' README; **[NO-OFICIAL]** = GDQuest/forums/blogs.

- **3D backends:** `GodotPhysics3D` and **`Jolt Physics`**. Jolt is a **built-in module since Godot 4.4** and the 4.7 docs
  say new projects use it **by default**; set via `physics/3d/physics_engine`. Jolt README: "better performance… more
  stable simulation than Godot Physics," drop-in. Built-in Jolt was flagged **experimental** (4.4 wording). Sleeping
  settings: `simulation/allow_sleep`, `sleep_velocity_threshold`, `sleep_time_threshold`. **[OFICIAL/SEMI]**
  https://docs.godotengine.org/en/4.7/tutorials/physics/using_jolt_physics.html , https://github.com/godot-jolt/godot-jolt
- **2D backends:** only **GodotPhysics2D** is official. **No official Box2D**; community GDExtensions are early or
  **archived/unmaintained** (`rburing/physics_server_box2d` WIP; `appsinacup/godot-box2d` archived 2024). **[OFICIAL by
  omission / NO-OFICIAL]** https://github.com/appsinacup/godot-box2d
- **CCD:** `RigidBody2D`/`RigidBody3D` expose **`continuous_cd`** (off by default). Jolt adds ProjectSettings
  `simulation/continuous_cd_movement_threshold`, `continuous_cd_max_penetration`. Forums: CCD reduces but doesn't fully
  eliminate high-speed tunnelling on static seams. **[OFICIAL + NO-OFICIAL]**
- **Determinism:** Jolt is deterministic **only on the same binary/platform** by default; cross-platform needs CMake
  `CROSS_PLATFORM_DETERMINISTIC` (~8% cost) — **not documented as enabled in Godot's build**. godot-jolt README: do **not**
  rely on determinism. Godot physics is "unsuitable for deterministic simulation"; use fixed-point logic if required.
  Practical guidance → **host-authoritative + snapshots, not lockstep**. **[OFICIAL de Jolt/Godot]**
  https://jrouwe.github.io/JoltPhysics/md__build_2_r_e_a_d_m_e.html , https://docs.godotengine.org/en/4.7/tutorials/physics/troubleshooting_physics_issues.html
- **Materials:** `PhysicsMaterial` has only `friction`, `bounce`, `rough`, `absorbent`. **No native rolling friction** —
  approximate with the body's `linear_damp`/`angular_damp`. **[OFICIAL]**
  https://docs.godotengine.org/en/4.7/classes/class_physicsmaterial.html
- **Low-level / custom integration:** `RigidBody3D._integrate_forces(state)` gives direct state access;
  `custom_integrator = true` disables built-in force integration (gravity/damping) so you write your own motion while
  keeping Godot's broadphase/collision (needs `contact_monitor` + `max_contacts_reported` for contacts). `PhysicsServer2D/3D`
  for fully manual control. **[OFICIAL]** https://docs.godotengine.org/en/4.7/classes/class_rigidbody3d.html
- **Reuse with a custom sim:** render nodes, `Area2D/3D` (pockets), CollisionShapes, `PhysicsDirectSpaceState` queries
  (raycast/shapecast/intersect) and Transforms are all still usable — a "custom sim" replaces only the integrator/solver.
- **Billiards-specific:** **no official pool demo**; forums warn real-scale balls are "on the lower limit for 3D physics"
  (tunnelling risk). **Pooltool** (open-source, analytic/event-based billiards; Panda3D) is a transferable *model*
  reference. **[NO-OFICIAL]** https://discourse.panda3d.org/t/pooltool-a-sandbox-billiards-game-tool/27913

## Sources
- https://docs.godotengine.org/en/4.7/tutorials/physics/using_jolt_physics.html
- https://docs.godotengine.org/en/4.7/classes/class_physicsmaterial.html
- https://docs.godotengine.org/en/4.7/classes/class_rigidbody3d.html
- https://docs.godotengine.org/en/4.7/tutorials/physics/troubleshooting_physics_issues.html
- https://jrouwe.github.io/JoltPhysics/md__build_2_r_e_a_d_m_e.html
- https://github.com/godot-jolt/godot-jolt
- https://discourse.panda3d.org/t/pooltool-a-sandbox-billiards-game-tool/27913
