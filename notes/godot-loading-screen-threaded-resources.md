---
id: godot-loading-screen-threaded-resources
type: guide
domain: godot
status: proposed
summary: "Build a Godot 4.7 loading screen with ResourceLoader.load_threaded_request/get_status/get: poll progress in _process, never call get before LOADED, choose use_sub_threads and cache_mode deliberately, and hold a minimum display time before switching scenes."
aliases: [loading screen, background loading, threaded loading, load_threaded_request, splash screen]
tags: [dept/game-dev, tool/godot]
sources:
  - claim: "Background loading tutorial and ResourceLoader threaded API, status enum, cache modes and sub-thread trade-off for Godot 4.7"
    ref: src-gd-background-loading-resourceloader
    retrieved: 2026-11-08
  - claim: "change_scene_to_packed replaces the current scene at the end of the frame; scene_changed signals when the new scene is ready"
    ref: src-gd-autoload-scenetree-engine
    retrieved: 2026-11-08
related:
  - depends-on: "[[godot-resource-sharing-and-duplication]]"   # the cache that cache_mode manipulates
  - relates-to: "[[godot-shader-compile-stutter-and-baker]]"   # a loaded scene can still hitch on first draw
  - relates-to: "[[node-lifecycle-callbacks]]"   # polling lives in _process
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** API facts come from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited sources). The loading-scene structure and the minimum display time are **our convention**, marked *(convention)*. Nothing was run in the engine. Status `proposed`.

## Goal
Show a responsive loading screen while a large scene or asset set loads, then switch to it without a frozen frame or a flash.

## Prerequisites
- `load()` blocks the calling thread; the threaded API exists so the main loop keeps drawing.
- Resources are cached by path and shared ([[godot-resource-sharing-and-duplication]]).

## Steps
1. **Make the loading scene the switch point** *(convention)*. A small `loading.tscn` (ProgressBar, hint text) receives the target path, e.g. through an autoload field or `set_meta` before `change_scene_to_packed()`; the loading scene itself is tiny and `preload`ed so entering it never stalls.
2. **Request the load once**, in `_ready()`:
   ```gdscript
   var _path: String
   var _started_at := 0.0
   const MIN_SHOW_SEC := 0.75   # convention: avoid a one-frame flash

   func _ready() -> void:
       _started_at = Time.get_ticks_msec() / 1000.0
       var err := ResourceLoader.load_threaded_request(_path)   # type_hint "", use_sub_threads false, CACHE_MODE_REUSE
       if err != OK: _fail("request failed %s" % err)
   ```
3. **Poll in `_process`**, not in a loop — the class page says to call `load_threaded_get_status()` across frames:
   ```gdscript
   func _process(_dt: float) -> void:
       var progress := []
       match ResourceLoader.load_threaded_get_status(_path, progress):
           ResourceLoader.THREAD_LOAD_IN_PROGRESS:
               $ProgressBar.value = progress[0] * 100.0     # progress[0] is a 0.0–1.0 ratio
           ResourceLoader.THREAD_LOAD_LOADED:
               if Time.get_ticks_msec() / 1000.0 - _started_at >= MIN_SHOW_SEC:
                   _finish()
           ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
               _fail("load failed")
   ```
4. **Take the result only after LOADED**: `var packed: PackedScene = ResourceLoader.load_threaded_get(_path)`; calling it earlier blocks the main thread exactly like `load()`, which defeats the screen.
5. **Switch**: `get_tree().change_scene_to_packed(packed)`. The current scene is removed immediately and the new one is added at the end of the frame; `await get_tree().scene_changed` if you need the new scene's node afterwards.
6. **Batch loads** *(convention)*: for N assets, call `load_threaded_request()` for each, poll each status, and average the ratios; keep the list in an Array so a failed path is reported by name.

## Notes & pitfalls
- **`use_sub_threads = true`** loads faster but "the main thread may slow down" — fine behind a pure loading screen, risky while gameplay runs.
- **`cache_mode`:** default `CACHE_MODE_REUSE` returns the already-cached resource (instant LOADED); `CACHE_MODE_REPLACE` refreshes cached data in place (useful for hot-reloading tuning files); `CACHE_MODE_IGNORE` gives a fresh instance without touching the cache. `_DEEP` variants apply recursively.
- **Status before request:** `THREAD_LOAD_INVALID_RESOURCE` also means "never requested for this path" — so a typo in `_path` looks like a failure, not a hang.
- **Scenes loaded ≠ scenes ready:** instancing, `_ready()` work and first-draw shader compilation happen after the load; see [[godot-shader-compile-stutter-and-baker]] for the hitch that no loading screen removes.
- **Exported text-to-binary conversion:** with `convert_text_resources_to_binary` enabled, converted files cannot be read by GDScript's `load()` in the export — use `ResourceLoader.load()` paths through the normal resource system (per the class page).
- **Minimum display time** is purely cosmetic; keep it short (≤1 s) and skip it on repeat loads if the asset is already cached.
- The tutorial page does not document the status enum, `use_sub_threads` or `cache_mode`; those facts come from the class reference. Whether `load_threaded_get_status` is safe to call from a non-main thread was not on the pages read (*unverified*).

## See also
- [[godot-resource-sharing-and-duplication]] — the cache that cache_mode manipulates
- [[godot-shader-compile-stutter-and-baker]] — a loaded scene can still hitch on first draw
- [[node-lifecycle-callbacks]] — polling lives in _process
