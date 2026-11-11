---
id: godot-minigame-collection-architecture
type: pattern
domain: godot
status: unreviewed
summary: "A hub-and-registry architecture for a collection of minigames in Godot 4.7: manifest Resources describe each game, a base scene contract fixes lifecycle and signals, player intent is kept apart from simulation, per-minigame settings are applied on enter and restored on exit, features never import each other, and all text goes through i18n keys."
aliases: [minigame hub, game registry, manifest resource, minigame lifecycle contract, party game architecture]
tags: [dept/game-dev, dept/orchestration, tool/godot]
sources:
  - claim: "Autoload registration and ordering, SceneTree change_scene_to_packed timing and scene_changed, scene-organization best practice (no dependencies, dependency injection, Main/World/GUI), Engine.physics_ticks_per_second"
    ref: src-gd-autoload-scenetree-engine
    retrieved: 2026-11-08
  - claim: "Custom Resources with class_name and @export as data containers; resources are loaded once and shared by path"
    ref: src-gd-projectsettings-configfile-resources
    retrieved: 2026-11-08
  - claim: "Threaded loading API used by the hub's loading screen"
    ref: src-gd-background-loading-resourceloader
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-lan-host-authoritative-turn-based]]"   # the intent/simulation split exists so this can be added later
  - relates-to: "[[godot-localization-workflow]]"   # manifests carry translation keys, not strings
  - relates-to: "[[godot-loading-screen-threaded-resources]]"   # the hub loads minigames behind a loading scene
  - relates-to: "[[godot-config-driven-tunables]]"   # per-minigame tuning Resources follow the same taxonomy
  - relates-to: "[[godot-project-organization-strategies]]"   # by-feature folders are the isolation unit
  - relates-to: "[[autoload-singletons]]"   # the hub and registry are the only autoloads
  - relates-to: "[[node-lifecycle-callbacks]]"   # contract methods are called after _ready
  - relates-to: "[[godot-physics-bodies-layers-and-interpolation]]"   # the per-minigame tick change needs an interpolation reset
created: 2026-11-08
updated: 2026-11-10
created_by_type: agent
---

> **Evidence status — interpretation, with a verified addendum.** The registry, contract, folder rules and settings handshake are a **design pattern we propose**; the base API facts come from the Godot 4.7 docs (cited). **Section 9 and the tick-handshake claim were exercised in the engine on 2026-11-10** (Godot 4.7.2.stable.mono, gdUnit4 6.2.3, headless) — the typed contract, the seat model, the intent sink, the per-minigame tick apply/restore on finish **and abort**, and that `await get_tree().physics_frame` advances physics headless. Those are evidence class *verified-in-engine (this environment only)*. Status stays `unreviewed` until a human reviews.

## Problem
A collection of small, independent games needs one menu, shared services (audio, settings, profiles), consistent pause/quit behaviour and the option to add local or LAN multiplayer later — without each minigame reaching into the others or into the hub.

## Solution *(interpretation)*

### 1. Manifest Resource per minigame
`class_name MinigameManifest extends Resource` with `@export` fields: `id: StringName`, `display_key: String` (a translation key, see [[godot-localization-workflow]]), `description_key`, `icon: Texture2D`, `scene: PackedScene` (or a `String` path for lazy loading), `players_min: int`, `players_max: int`, `modes: Array[StringName]` (e.g. `solo`, `local_versus`, `lan`), `physics_ticks_per_second: int = 60`, `tuning: Resource` (optional, see [[godot-config-driven-tunables]]), `version: int`. Saved as `res://minigames/<id>/manifest.tres`. Resources are loaded once and shared, so manifests are read-only data.

### 2. Registry
An autoload `MinigameRegistry` scans `res://minigames/*/manifest.tres` at startup (or holds an exported `Array[MinigameManifest]` for exports where directory listing is unreliable), validates ids are unique and `players_min <= players_max`, and exposes `get_all()`, `get(id)`, `filter(players, mode)`. The hub menu is built from this list — adding a minigame means adding a folder, not editing the hub.

### 3. Base scene contract
Every minigame root extends `MinigameBase` (a `Node` subclass) and overrides:
```gdscript
class_name MinigameBase extends Node
signal finished(result: MinigameResult)     # scores, winner, stats
signal paused_changed(is_paused: bool)
func setup(ctx: MinigameContext) -> void: pass   # players, mode, tuning, rng seed — called by the hub after _ready()
func start() -> void: pass                       # input becomes live
func set_paused(p: bool) -> void: pass           # hub owns the pause menu; minigame only freezes its sim
func finish(result: MinigameResult) -> void:     # minigame calls this once; hub listens to `finished`
    finished.emit(result)
```
The hub never calls into minigame internals and the minigame never calls the hub: the hub supplies dependencies (`setup`) and listens to signals — the scene-organization page's "parent initialises, child emits" rule.

### 4. Hub flow
`Hub` (autoload) does: load the loading scene → `ResourceLoader.load_threaded_request(manifest.scene_path)` → poll ([[godot-loading-screen-threaded-resources]]) → `get_tree().change_scene_to_packed(packed)` → `await get_tree().scene_changed` → `current_scene.setup(ctx)`; `start()` after any countdown; on `finished` → apply result to profiles → return to the menu scene. Autoloads are children of `root` and survive the scene change; the GUI that must persist across minigames (pause overlay, toasts) lives in a `CanvasLayer` under the hub autoload, as the docs warn a GUI inside the current scene is deleted on transition.

### 5. Player intent separate from simulation
Inside a minigame, input handling produces **intent objects** (`{player: 1, action: "shoot", vector: Vector2}`) in one node (`IntentSource`), and a separate `Simulation` node consumes them in `_physics_process`. Local play wires them directly; LAN play later replaces the wire with the RPC pair from [[godot-lan-host-authoritative-turn-based]] without touching the simulation. Resolve all randomness through an `RandomNumberGenerator` seeded from `ctx.seed` so a host can replay a turn.

### 6. Per-minigame settings handshake
On `setup`, the hub records the current `Engine.physics_ticks_per_second` (and any other engine-wide value the manifest overrides: `Engine.max_fps`, `Engine.time_scale`, a listener bus volume) and applies the manifest's values; on `finished` or abort it **restores** them before the next scene change. Raising ticks well above 60 should also raise `Engine.max_physics_steps_per_frame` (documented). Never leave `time_scale` modified after a pause.

### 7. Folder isolation rules
```
res://hub/            # menu, hub autoload, loading scene
res://shared/         # MinigameBase, MinigameManifest, context/result classes, audio service, UI theme
res://minigames/<id>/ # manifest.tres, scenes, scripts, art of ONE minigame
res://addons/         # third-party and reusable modules
```
Rule: `minigames/<a>/` may import only `shared/` and `addons/`; never `hub/` or `minigames/<b>/`. Checkable with `rg "res://(hub|minigames)/" res://minigames/<a>/` expecting only its own folder. See [[godot-project-organization-strategies]] for the by-feature layout.

### 8. Text and assets
Manifests and results carry **translation keys**; the hub calls `tr(key)` when rendering. Shared art (fonts, UI theme) lives in `shared/`; per-game art stays in the game folder so deleting a minigame deletes everything it owned.

### 9. Typed, serializable contract and seats *(verified-in-engine 2026-11-10)*
Prefer **typed Resources with a Dictionary wire form** over bare Dictionaries for the context/result/intent, so the Inspector, `@export` validation and the LAN boundary all work from one definition:
- `GameResult`/`MatchResult` — **per-seat and composable**: `per_seat: Dictionary` (`seat → {score, rank, stats}`), `outcome: Dictionary` (`winner_seats`, `draw`, `aborted`). A later *session* folds N round results by summing per seat; keep "best-of-N" in the hub, not the minigame.
- `Intent` — **self-describing**: carries its own `seat_index` (never inferred from the caller), `type`, `payload`, plus `to_dict()`/`from_dict()`. Local play passes the object; LAN sends `to_dict()` and the host rebuilds it — a round-trip through `var_to_bytes` must survive (one unit test). The simulation validates turn/range; the input layer does not.
- `Context`/`MatchConfig` — `mode`, `seats`, `rng_seed`, and an **opaque** `rules: Resource` the kit never reads (the minigame casts it, like `Config.get_res()`).
- **Seats as the identity/input unit** (not a player int). `class_name Seat` with `index`, `kind ∈ {LOCAL, REMOTE, AI}`, `peer_id` (ENet host = 1), `name_key`, `loadout_ids`. Hot-seat = several `LOCAL` seats on one device; LAN = `REMOTE` seats keyed by `peer_id`; results index by `index`. Modelling players as seats now is the single change that keeps hot-seat, multi-gamepad and net-peer on one code path; retrofitting `winner: int → seats` later touches every result, prank-attribution and the LAN handshake.
- **Intent sink.** `submit_intent(intent)` stays the single input door: it emits a signal (observability/tests) and forwards to an injected `Callable`. Local sets a sink that applies to its own sim; a future `gn_lan_session` swaps in a sink that RPCs the host, and the kit never references the network.
- **Seed replays logic, not physics.** The `rng_seed` makes shuffles/spawn-jitter/selection reproducible; it does **not** make a rigid-body engine (Jolt) deterministic across machines — do not build physics replay on it ([[godot-lan-host-authoritative-turn-based]]).
- **Lifecycle safety (verified):** connect `finished` with `CONNECT_ONE_SHOT` and make `finish()` idempotent; free the instance with `queue_free()` **after** the signal returns (never `free()` inside the emitter); guard re-entrancy (refuse a second start over a live one); `abort(reason)` must restore the tick exactly like `finish`.

## Trade-offs
- The contract adds boilerplate for tiny games; keep `MinigameBase` default implementations no-ops.
- Directory scanning at startup costs time on slow storage; an exported manifest list is faster and explicit.
- Shared services become the only coupling point; guard them with small interfaces or they grow into a god autoload (see [[autoload-singletons]]).
- Per-game physics ticks change behaviour of shared physics-based UI; restore them reliably even on abort.
- **Verified 2026-11-10:** `Engine.physics_ticks_per_second` can be changed at runtime and restored cleanly (apply on enter, restore on finish *and* abort). With `physics/common/physics_interpolation=true` the change needs `reset_physics_interpolation()` on the new subtree to avoid a one-frame interpolation artifact — the same reset you call after teleporting a body ([[godot-physics-bodies-layers-and-interpolation]]). Whether the visual artifact actually appears without the reset was **not** confirmed (needs a display); the reset is applied defensively.
- Still not validated: whether `scene_changed` reliably fires after `change_scene_to_packed()` in every case (this slice instantiated the minigame as a child instead of switching the main scene, so it did not exercise `change_scene_to_packed`).

## See also
- [[godot-lan-host-authoritative-turn-based]] — the intent/simulation split exists so this can be added later
- [[godot-localization-workflow]] — manifests carry translation keys, not strings
- [[godot-loading-screen-threaded-resources]] — the hub loads minigames behind a loading scene
- [[godot-config-driven-tunables]] — per-minigame tuning Resources follow the same taxonomy
- [[godot-project-organization-strategies]] — by-feature folders are the isolation unit
- [[autoload-singletons]] — the hub and registry are the only autoloads
- [[node-lifecycle-callbacks]] — contract methods are called after _ready
- [[godot-physics-bodies-layers-and-interpolation]] — the per-minigame tick change needs an interpolation reset
