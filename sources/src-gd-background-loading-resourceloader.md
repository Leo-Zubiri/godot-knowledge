---
id: src-gd-background-loading-resourceloader
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/tutorials/io/background_loading.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/tutorials/io/background_loading.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_resourceloader.html"
  title: "Godot 4.7: Background loading tutorial and ResourceLoader class (threaded loading, cache modes)"
  retrieved: 2026-11-08
  version: "4.7 (page headers: Godot Engine 4.7 documentation in English)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot 4.7 documentation pages fetched on 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Both pages reported the header *Godot Engine 4.7 documentation*. Nothing was run in the engine. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

- **Background loading (tutorial):** the ordinary `load()` blocks its thread so the game can look unresponsive; background loading suits loading screens and mid-game loads. `ResourceLoader.load_threaded_request(path)` queues a path to load on a thread; `ResourceLoader.load_threaded_get_status(path, progress)` reports status, and the `progress` argument is an Array that receives a one-element array holding the completion ratio; `ResourceLoader.load_threaded_get(path)` returns the resource. **Pitfall stated on the page:** if loading has not finished when `load_threaded_get()` is called, it blocks exactly like `load()` — leave enough time between request and retrieval, or check the status first. Example: an enemy scene path is requested in `_ready()` and retrieved + instantiated when a button is pressed (GDScript and C#). The page does not describe the status enum values, `use_sub_threads`, `cache_mode`, or `ResourceInteractiveLoader`.
- **ResourceLoader class:** `load(path, type_hint="", cache_mode=CACHE_MODE_REUSE)` loads and caches; tries registered `ResourceFormatLoader`s in sequence; returns an empty resource if none can handle the file and prints an error if the file is missing; relative paths get `res://` prefixed. `load_threaded_request(path, type_hint="", use_sub_threads=false, cache_mode=CACHE_MODE_REUSE)` starts loading on a thread; with `use_sub_threads = true` several threads are used — "loading is faster, but the main thread may slow down". `load_threaded_get_status(path, progress=[])` returns a `ThreadLoadStatus`; the optional `progress` array receives a one-element array with a ratio from 0.0 to 1.0; the page says to call it across several frames, such as in `_process()`, rather than in a loop. `load_threaded_get(path)` returns the resource; if the load is not finished, the calling thread blocks until it is — check the status first. **ThreadLoadStatus:** `THREAD_LOAD_INVALID_RESOURCE` 0 (invalid or never requested), `THREAD_LOAD_IN_PROGRESS` 1, `THREAD_LOAD_FAILED` 2, `THREAD_LOAD_LOADED` 3 ("loaded successfully and can be accessed via load_threaded_get()"). **CacheMode:** `CACHE_MODE_IGNORE` 0 (main resource and subresources neither read from nor stored in the cache; dependencies use REUSE), `CACHE_MODE_REUSE` 1 (take cached main resource/subresources/dependencies when present, otherwise load and cache; recursive), `CACHE_MODE_REPLACE` 2 (like REUSE, but cached entries with matching types have their data refreshed in place, otherwise recreated), `CACHE_MODE_IGNORE_DEEP` 3, `CACHE_MODE_REPLACE_DEEP` 4 (recursive variants). Also `exists(path, type_hint)`, `has_cached(path)`, `get_cached_ref(path)`, `get_resource_uid(path)` (−1 if none), `list_directory(dir)` (order not deterministic; use `DirAccess` for general traversal), `Resource.take_over_path()` can override the cache entry. If `convert_text_resources_to_binary` is enabled, converted files cannot be read by `@GDScript.load()` in an exported project.
