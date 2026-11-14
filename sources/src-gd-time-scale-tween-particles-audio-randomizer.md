---
id: src-gd-time-scale-tween-particles-audio-randomizer
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/classes/class_engine.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/classes/class_engine.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_scenetree.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_tween.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_cpuparticles3d.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_gpuparticles3d.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_audiostreamrandomizer.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_camera3d.html"
  title: "Godot 4.7 class references: Engine (time_scale, physics ticks), SceneTree (create_timer), Tween, CPUParticles3D, GPUParticles3D, AudioStreamRandomizer, Camera3D"
  retrieved: 2026-11-14
  version: "Godot Engine 4.7 documentation (pages under /en/4.7/)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); quoted fragments as returned by the summarizer (it splits long descriptions into short quotes)"
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). Paraphrased extraction of official class-reference pages headed *Godot Engine 4.7*. Nothing here was run in the engine. Re-fetch before promoting dependent notes to `verified`.

## Engine
- `time_scale`: "The speed multiplier at which the in-game clock updates, compared to real time." "For example, if set to 2.0 the game runs twice as fast, and if set to 0.5 the game runs half as fast." "This value affects Timer, SceneTreeTimer, and all other simulations that make use of delta time (such as Node._process() and Node._physics_process())."
- Notes: "It's recommended to keep this property above 0.0, as the game may behave unexpectedly otherwise." "This does not affect audio playback speed." "Use AudioServer.playback_speed_scale to adjust audio playback speed independently of time_scale." "This does not automatically adjust physics_ticks_per_second." "With values above 1.0 physics simulation may become less precise, as each physics tick will stretch over a larger period of engine time."
- `physics_ticks_per_second`: "The number of fixed iterations per second." "CPU usage scales approximately with the physics tick rate." Below about 30 physics can break down; high rates are more accurate for fast objects. Only `max_physics_steps_per_frame` ticks are simulated per rendered frame; raise it when raising the tick rate well above the default. Physics interpolation is suggested when the tick rate is not a multiple of 60.
- `physics_jitter_fix`: default 0.5; "When using a custom physics interpolation solution, or within a network game, it's recommended to disable the physics jitter fix by setting this property to 0."

## SceneTree
- `create_timer(time_sec: float, process_always: bool = true, process_in_physics: bool = false, ignore_time_scale: bool = false)`. "If `ignore_time_scale` is `true`, the timer will ignore Engine.time_scale and update with the real, elapsed time." "If `process_always` is `false`, the timer will be paused when setting paused to `true`."
- `create_tween()`: "Creates and returns a new Tween processed in this tree."

## Tween
- `set_ignore_time_scale`: "If `ignore` is `true`, the tween will ignore Engine.time_scale and update with the real, elapsed time." Default `false`.
- `set_speed_scale`: "Scales the speed of tweening. This affects all Tweeners and their delays."
- "Tweens are not designed to be reused and trying to do so results in an undefined behavior." "Create a new Tween for each animation and every time you replay an animation from start." `kill()`: "Aborts all tweening operations and invalidates the Tween."
- Transitions: `TRANS_ELASTIC` ("interpolated with elasticity, wiggling around the edges"), `TRANS_BOUNCE` ("interpolated by bouncing at the end"), `TRANS_BACK` ("interpolated backing out at ends"); eases `EASE_IN`, `EASE_OUT`, `EASE_IN_OUT`, `EASE_OUT_IN`.

## CPUParticles3D
- "CPU-based 3D particle node used to create a variety of particle systems and effects." GPUParticles3D offers "the same functionality with hardware acceleration" but "may not run on older devices."
- `one_shot`: "If true, only one emission cycle occurs." `explosiveness`: "How rapidly particles in an emission cycle are emitted." With `one_shot`, setting `emitting` to true "will not restart the emission cycle until after all active particles finish processing." `restart(keep_seed: bool = false)`. Signal `finished`: "Emitted when all active particles have finished processing."
- Colour properties only show on a BaseMaterial3D when `vertex_color_use_as_albedo` is enabled.

## GPUParticles3D
- `amount`: "The number of particles to emit in one emission cycle."; higher counts raise GPU load. `amount_ratio`: scales the emitted count without restarting; "Reducing the amount_ratio has no performance benefit."
- `one_shot`, `explosiveness` (0 = spread over the cycle, 1 = all at once), `fixed_fps`, `interpolate`, `visibility_aabb` (grow it if particles pop in or out), `trail_enabled` (needs `use_particle_trails` on the mesh material).
- `emit_particle()` "is only supported on the Forward+ and Mobile rendering methods, not Compatibility."
- `restart()` clears existing particles. `preprocess` "can be very expensive if set to a high number".
- The page says **nothing** about a first-emission stutter or shader compilation.

## AudioStreamRandomizer
- "Picks a random AudioStream from the pool, depending on the playback mode" and applies random pitch and volume shifting.
- `PLAYBACK_RANDOM_NO_REPEATS`: tries to "avoid playing the same stream twice in a row whenever possible."; `PLAYBACK_RANDOM`; `PLAYBACK_SEQUENTIAL`.
- `random_pitch`: "Pitch will be randomly chosen within a range of `1.0 / random_pitch` and `random_pitch`." (1.0 = none). `random_volume_offset_db`. Per-stream `weight` (default 1.0).

## Camera3D
- `h_offset`: "The horizontal (X) offset of the camera viewport." `v_offset`: "The vertical (Y) offset of the camera viewport." `fov`: "The camera's field of view angle (in degrees). Only applicable in perspective mode."
