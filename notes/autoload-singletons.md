---
id: autoload-singletons
type: pattern
domain: godot
status: proposed
summary: Use an Autoload (singleton) for state/services that must persist across scenes — but keep it narrow to avoid global coupling.
aliases: [autoload, singleton, global, globals]
sources:
  - claim: "Autoload registers a script/scene loaded once at startup, added under the root and addressable globally by name; configured in Project Settings → Globals → Autoload; intended for cross-scene state and scene switching."
    ref: src-singletons-autoload
    retrieved: 2026-11-06
    version: "4.7"
related:
  - contradicts: "[[god-autoload]]"                 # the pitfall of overusing a global
  - relates-to: "[[node-vs-resource-vs-autoload]]"  # choosing the right home for shared data
created: 2026-11-06
updated: 2026-11-06
created_by_type: agent
---

## Problem
Some state or services must outlive individual scenes — e.g. the current player's progress, an audio manager, or a
scene-transition helper. Passing these through every node is awkward.

## Solution
Register an **Autoload** (Project → Project Settings → **Globals → Autoload**). Godot loads it **once at startup**, adds
it under the scene-tree root, and makes it reachable from any script by its configured name:

```gdscript
# Autoload named "PlayerData" (res://player_data.gd)
extends Node
var coins: int = 0

# anywhere else
PlayerData.coins += 10
```

Good fits: a single source of truth for cross-scene data, global services (audio, save/load), and orchestrating scene
changes.

## Trade-offs
- **Keep it narrow.** Every autoload is global coupling: anything can touch it, which makes dependencies implicit and
  testing harder. Put only genuinely global concerns here.
- Prefer passing data explicitly, using **signals** ([[gdscript-signals]]) for events, or a **Resource**
  ([[node-vs-resource-vs-autoload]]) for shareable data, when those fit better.
- Overusing it leads to the [[god-autoload]] anti-pattern.

> `applies-to`: **Godot 4.7** (autoload has existed across 4.x; the Project Settings path is current for 4.7).

## See also
- [[node-vs-resource-vs-autoload]] — pick the right container for shared state
- [[god-autoload]] — what happens when a global grows unbounded
