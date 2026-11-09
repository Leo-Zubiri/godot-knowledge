---
id: godot-scene-scoped-lookups
type: concept
domain: godot
status: proposed
summary: "Unique names (%Name) work only inside their scene and fail with null elsewhere; groups are global by name and typo-prone; find_child is slow."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Unique names and groups pages re-read for 4.7; find_child cost per research subagent"
    ref: src-gd-scene-resources-saving
    retrieved: 2026-11-08
related:
  - relates-to: "[[gdscript-signals]]"   # signals are the preferred way to cross scenes
  - relates-to: "[[node-lifecycle-callbacks]]"   # lookups happen at ready time
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **`%UniqueName`** is scoped to the scene where it was marked. A lookup from another scene returns `null` **without an error**. To cross a scene boundary, get the instanced scene's root first and query the `%` name from there (or use groups, signals or an autoload).
- **Groups:** a node can be in many groups; use `add_to_group()`/`remove_from_group()` and the SceneTree's group calls (`get_nodes_in_group()`, `call_group()`, per subagent). Global and Scene groups are the same system — identical names are one group — so **a mistyped name silently targets a different group**.
- `Node.find_child()` searches nested scenes but visits every descendant each call (slow); unique names are cached (research subagent).
- Not covered: `owner`; whether runtime group membership persists across runs.

## What an agent can and cannot check
Grep for `%` names and group strings to catch typos and mismatches across scripts. The `null` failure appears only at runtime.

## See also
- [[gdscript-signals]] — signals are the preferred way to cross scenes
- [[node-lifecycle-callbacks]] — lookups happen at ready time
