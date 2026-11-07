---
id: node-vs-resource-vs-autoload
type: pattern
domain: godot
status: proposed
summary: Choosing where shared data/behavior lives — Node (in the tree), Resource (shareable data asset), or Autoload (global singleton).
aliases: [resource vs node, custom resource, where to put data]
sources:
  - claim: "Autoload is a globally-addressable node loaded once at startup for cross-scene state; Nodes live in the scene tree and do work; Resources are reference-counted data containers that can be shared/saved."
    ref: src-singletons-autoload
    retrieved: 2026-11-06
    version: "4.7"
  - claim: "Resource is Godot's base class for serializable data containers (e.g. saved as .tres/.res)."
    url: https://docs.godotengine.org/en/4.7/classes/class_resource.html
    retrieved: 2026-11-06
    version: "4.7"
related:
  - relates-to: "[[autoload-singletons]]"   # autoload is one of the three options compared here
  - contradicts: "[[god-autoload]]"         # defaulting everything to a global is the failure mode
created: 2026-11-06
updated: 2026-11-06
created_by_type: agent
---

## Problem
"Where should this live?" is a recurring Godot design question. Putting everything in an Autoload is tempting but
causes global coupling; putting data in a Node ties it to the tree. The three main homes have different strengths.

## Solution
Pick by **what the thing is**:

- **Node** — something that exists in the scene, has a position/lifecycle, or does per-frame work (a player, an enemy, a
  UI element). It lives in the tree and uses [[node-lifecycle-callbacks]].
- **Resource** — a **data container** you want to author, reuse, and (optionally) save to disk (`.tres`/`.res`): stats
  blocks, item definitions, configuration. Resources are reference-counted and can be shared between many nodes; define
  custom ones with `class_name` extending `Resource`.
- **Autoload (singleton)** — **genuinely global** state/services that must persist across scenes
  ([[autoload-singletons]]): current save slot, audio manager, scene switcher.

Heuristic: *is it a thing in the world?* → Node. *Is it reusable data?* → Resource. *Is it one global service for the
whole game?* → Autoload. When unsure, prefer the **least global** option that works.

## Trade-offs
- Resources shared by reference can be mutated by any holder — duplicate (`.duplicate()`) when you need an independent copy.
- Autoload maximizes reach but also coupling; see [[god-autoload]].

> `applies-to`: **Godot 4.7**.

## See also
- [[autoload-singletons]] · [[node-lifecycle-callbacks]] · [[god-autoload]]
