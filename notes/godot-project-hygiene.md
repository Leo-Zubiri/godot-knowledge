---
id: godot-project-hygiene
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 project hygiene from the official best-practice pages: scene independence and dependency order, naming, addons/gdignore, version control and LFS, case sensitivity."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Scene organization, interfaces, data/logic preferences, version control and project organization pages"
    ref: src-gd-best-practices
    retrieved: 2026-11-08
  - claim: "Version-control files, import and UID files, export configuration"
    ref: src-gd-project-organization-vcs-uids
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-project-structure-selection-method]]"   # structure selection
  - relates-to: "[[godot-export-fundamentals]]"   # export_credentials.cfg must stay out of version control
  - relates-to: "[[node-vs-resource-vs-autoload]]"   # where shared state lives
  - relates-to: "[[godot-version-policy]]"   # version scoping
  - relates-to: "[[god-autoload]]"   # the autoload anti-pattern
created: 2026-11-08
updated: 2026-11-10
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


## Scene independence (documented)
Scenes should carry what they need; external context comes from the parent. Order of preference for supplying it: **signals (safest)**, then method calls or Callable properties, then node references/NodePaths. Parent–child should mean "removing the parent removes the child"; otherwise use siblings with a common ancestor mediating. A `@tool` script with `_get_configuration_warnings()` lets the editor flag unmet dependencies. To stop transform inheritance use `top_level` or an intermediate Node; `RemoteTransform`/`RemoteTransform2D` make separated nodes follow a target. Autoloads suit systems that track their own data and work in isolation; systems that modify others' data should be scenes or scripts.

## Interfaces and data
Cost order: `get_node()` slowest, `$Child` faster, cache with `@onready`; an exported `Node` property survives moving the node; `load()`/`preload()` return the cached instance (use `duplicate()` or `new()` for a separate object); asserts are stripped in release. The data-preferences page itself says it **has not been updated for 4.7** — treat it as dated. Set node properties before adding the node to the tree; use `preload` for fixed-path constants and `load()`/`@export` for resources that may change.

## Files, version control, naming
lowercase snake_case folders/files (C# scripts follow PascalCase class names), PascalCase node names; case mismatches can break exported PCKs; third-party content in top-level `addons/`; an empty `.gdignore` stops import of a folder (ignored resources cannot be loaded). Ignore `.godot/` and `*.translation`; generate metadata via Project > Version Control; on Windows set `core.autocrlf` to `input`; install Git LFS on every machine before committing large files; older versions may store credentials in `export_presets.cfg`.

## Version-control files in detail (added, documented)
Ignore `.godot/` and `*.translation`; the project manager's Git option generates `.gitignore` (only `.godot/` and `/android/`, per the 4.7 source) and `.gitattributes` (`* text=auto eol=lf`), so add `*.translation` yourself if you use CSV translations. **Commit** `.import` files, `.uid` files (4.4+; see [[godot-asset-source-import-organization]]) and `export_presets.cfg`; keep `.godot/export_credentials.cfg` out. Git LFS is optional and must be set up before the first commit. Folder strategy and moves: [[godot-project-structure-selection-method]], [[godot-project-structure-assessment-and-refactoring]].

**Mono/.NET editor rewrites `project.godot` (observed 2026-11-10, Godot 4.7.2.stable.mono).** Running the **`.mono`** editor/`--import` on a **GDScript-only** project can re-add a `[dotnet]` section (`project/assembly_name`) and reorder or drop hand-written keys, producing a dirty `project.godot` after an otherwise read-only import (it was intermittent — one import rewrote it, a later one did not). Keep the hand-maintained `project.godot` as the source of truth, discard import-time rewrites (`git checkout -- project.godot`), and prefer the **non-`.mono`** 4.7.2 build for a GDScript project (or a CI runner with `.NET` disabled, which does not add the section). This is the friction behind "does `[dotnet]` reappear?"

**A new `class_name` needs `--import` before it resolves (observed 2026-11-10, Godot 4.7.2; hit 3× in one session).** Global classes live in `.godot/global_script_class_cache.cfg`, which `--import` (or opening the editor) regenerates. Until then, any script that references the new type **fails to parse** with *"Could not find type X in the current scope"* — so a headless `--check-only`/parse pass and **running the scene** both break on the new class. `.godot/` is git-ignored ([[godot-project-structure-selection-method]]), so a **freshly created worktree or clone starts with a stale/empty cache** and the same error appears for classes that already exist in the repo. Fix: run `--import` (e.g. a `make import` target) **after adding a `class_name` and as the first step in a fresh checkout**, before check/run. Not a code bug — a build-cache regeneration step.

## What an agent can and cannot check
**Can check by reading files:** naming, folder layout, ignore files, typed signatures. **Needs the engine:** node-path correctness, configuration-warning output, cached-resource behaviour.

## See also
- [[godot-project-structure-selection-method]] — structure selection
- [[node-vs-resource-vs-autoload]] — choosing where shared state lives
- [[godot-version-policy]] — version scoping
- [[god-autoload]] — the autoload anti-pattern
- [[godot-export-fundamentals]] — export_credentials.cfg must stay out of version control
