---
id: godot-save-game-serialization
type: pattern
domain: godot
status: proposed
summary: "Save games with a Persist group and JSON or binary FileAccess; never decode objects from untrusted files (get_var allow_objects can run code)."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Saving games page re-read for 4.7 (no security warnings on that page)"
    ref: src-gd-scene-resources-saving
    retrieved: 2026-11-08
  - claim: "FileAccess class warning: deserialized objects can contain code that runs on load"
    ref: src-gd-scene-resources-saving
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-resource-sharing-and-duplication]]"   # resource-based saves
  - relates-to: "[[node-lifecycle-callbacks]]"   # restoring nodes on load
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


## Documented approaches
1. **Persist group + JSON:** add nodes to a "Persist" group; each provides a save function returning a dictionary (scene path, parent path, state); stringify one object per line; on load parse each line, instantiate scenes and restore values. Load **parents first** (nested persisted objects can produce invalid node paths). JSON limits: larger files, no native Vector2/Color, custom encoding for custom types.
2. **Binary `store_var()`/`get_var()`:** smaller files, fewer encoding rules; only properties with the storage usage flag are saved.
3. `ConfigFile` is for user settings, not game saves. Files live under `user://`; `FileAccess.open()` is static and returns `null` on failure (check `get_open_error()`).

## Safety
The FileAccess class page warns that with `get_var(allow_objects = true)` deserialized objects can contain code that runs when loaded — **do not use it with untrusted files** (remote code execution risk); `store_var(full_objects = true)` encodes objects that may include code. The saving page itself has no security warning. Saving Resources through `ResourceSaver` as a save format, and its safety, are **not covered** (*unverified*): do not assume `.tres` saves from untrusted sources are safe.

## What an agent can and cannot check
A headless round-trip test (save, load, compare) is plausible but was not run. Compatibility across versions of the game's own save format is a design matter the docs do not address.

## See also
- [[godot-resource-sharing-and-duplication]] — resource-based saves
- [[node-lifecycle-callbacks]] — restoring nodes on load
