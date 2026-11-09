---
id: src-gd-scene-resources-saving
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/scripting/scene_unique_nodes.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/scene_unique_nodes.html"
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/groups.html"
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html"
    - "https://docs.godotengine.org/en/stable/classes/class_resource.html"
    - "https://docs.godotengine.org/en/stable/classes/class_resourceloader.html"
    - "https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html"
    - "https://docs.godotengine.org/en/stable/classes/class_fileaccess.html"
  title: "Godot 4.7: unique node names, groups, resources, ResourceLoader, saving games, FileAccess"
  retrieved: 2026-11-08
  version: "4.7 — unique nodes, groups, resources, saving games and FileAccess re-read by the main agent; Resource/ResourceLoader class pages per subagent"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **Unique names (re-read, 4.7):** a `%Name` node can be found only by code in the same scene where it was marked; a lookup from another scene returns `null` (no error); to cross a scene boundary get the instanced scene's root first and query the `%` name from there. Per the subagent, `Node.find_child()` searches nested scenes but visits every descendant each call (slow) while unique names are cached.
- **Groups (re-read, 4.7):** a node can belong to any number of groups; the SceneTree can list members, call a method on all, or send a notification; membership is set in the Groups dock/Project Settings or at runtime with `add_to_group()`/`remove_from_group()`; Global and Scene groups share the same system, so identical names are one group (the distinction is organizational) — a mistyped name silently targets a different group. API names per subagent: `SceneTree.get_nodes_in_group()`, `SceneTree.call_group()`.
- **Resources (re-read, 4.7):** script-defined data containers (properties, methods, constants, signals), editable in the Inspector, saved as text in development and compact binary in exports; Godot loads each resource file once, so every node referencing it gets the same shared copy. Per subagent: custom resource = extend `Resource`, add `class_name`, `@export` properties; constructor parameters need defaults or `duplicate()` fails (C#: `[GlobalClass]` and a parameterless constructor); inner classes do not serialize custom properties; `.tres` text / `.res` binary via `ResourceSaver`.
- **Resource class (subagent, 4.7):** `duplicate(deep: bool = false)` is shallow by default (nested Arrays/Dictionaries/Resources stay shared; deep duplicates nested arrays/dictionaries but nested Resources only if local); `duplicate_deep(deep_subresources_mode)` with `DEEP_DUPLICATE_NONE`, `DEEP_DUPLICATE_INTERNAL` (default), `DEEP_DUPLICATE_ALL`; usage flags `PROPERTY_USAGE_ALWAYS_DUPLICATE`/`NEVER_DUPLICATE`; `resource_local_to_scene` (default false) duplicates per scene instance (changing it at runtime does not affect existing duplicates; override `_setup_local_to_scene()`; `setup_local_to_scene()` and its signal are marked deprecated); `take_over_path(path)` instead of setting `resource_path` when a resource with that path is loaded; `changed` is not emitted automatically for custom resources (call `emit_changed()` in setters). **ResourceLoader:** `load(path, type_hint = "", cache_mode = 1)`; threaded `load_threaded_request`/`load_threaded_get_status`/`load_threaded_get`; statuses `THREAD_LOAD_INVALID_RESOURCE/IN_PROGRESS/FAILED/LOADED`; cache modes `CACHE_MODE_IGNORE/REUSE/REPLACE/IGNORE_DEEP/REPLACE_DEEP`. No official warning about loading untrusted resources was found on these pages (unverified beyond that).
- **Saving games (re-read, 4.7):** mark objects by adding them to a "Persist" group; each provides a save function returning a dictionary (including scene path and parent path); the JSON approach stringifies each dictionary and writes one object per line, then parses each line and instantiates scenes on load (load parents first because nested persisted objects can produce invalid node paths); JSON limits — larger files, no native Vector2/Color, custom encoding; binary `FileAccess.store_var()`/`get_var()` usually gives smaller files and needs less encoding, saving only properties with the storage usage flag; `ConfigFile` for user settings not saves; files under `user://`; `FileAccess.open()` is static and returns `null` on failure (check `get_open_error()`). **The saving page itself includes no security warnings.**
- **FileAccess class (re-read, 4.7):** `get_var(allow_objects)` with `true` decodes objects, and deserialized objects can contain code that runs on load — do not use with untrusted files (remote code execution risk); `store_var(full_objects)` with `true` encodes objects (possibly including code), same concern. Saving Resources via `ResourceSaver` as a save format and its safety are not covered (unverified).
