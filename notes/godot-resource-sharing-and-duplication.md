---
id: godot-resource-sharing-and-duplication
type: concept
domain: godot
status: proposed
summary: "Resources are loaded once and shared by default; duplication is shallow unless asked, so shared state leaks between instances unless duplicated or made local to scene."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Resources page re-read for 4.7; Resource and ResourceLoader class details per research subagent"
    ref: src-gd-scene-resources-saving
    retrieved: 2026-11-08
related:
  - depends-on: "[[node-vs-resource-vs-autoload]]"   # resources as shared data
  - relates-to: "[[godot-save-game-serialization]]"   # resources versus other save formats
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- Godot loads each resource file **once**; every node that references it gets the **same shared copy** (documented). Changing a shared resource changes it for all users.
- `Resource.duplicate(deep = false)` is **shallow** by default: nested Arrays, Dictionaries and Resources stay shared; `deep` duplicates nested arrays/dictionaries but nested Resources only if local; `duplicate_deep(...)` offers `DEEP_DUPLICATE_NONE/INTERNAL(default)/ALL` (research subagent, 4.7 header).
- `resource_local_to_scene` (default false) gives each scene instance its own copy; changing it at runtime does not affect copies already made; override `_setup_local_to_scene()`. Constructor parameters of custom resources need defaults or `duplicate()` fails; inner classes do not serialize custom properties.
- Use `take_over_path(path)` rather than setting `resource_path` when a resource with that path is loaded; `changed` is not emitted automatically for custom resources (call `emit_changed()`).
- `ResourceLoader.load(path, type_hint, cache_mode)` and threaded loading (`load_threaded_request/get_status/get`) exist; cache modes IGNORE/REUSE/REPLACE (+ DEEP variants).
- **Safety:** no official warning about loading untrusted resources was found on the pages read — *unverified*, not a statement that it is safe.

## What an agent can and cannot check
Class and method names can be checked against the class reference; a headless script can load a `.tres` and assert fields. Whether sharing is a bug in a given scene needs careful reading or running.

## See also
- [[node-vs-resource-vs-autoload]]
- [[godot-save-game-serialization]] — resources versus other save formats
