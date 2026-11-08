---
id: godot-index
type: index
domain: godot
summary: Map of content for the Godot knowledge base — entry point to the seeded scripting, architecture, and versioning notes.
related:
  - relates-to: "[[godot-version-policy]]"   # read this first to understand version scoping
created: 2026-11-06
updated: 2026-11-08
created_by_type: agent
---

## Godot knowledge — map of content
A navigational entry point (MOC). It only links and groups notes; it makes **no claims of its own**. Start here, then
open the 1–3 notes you actually need. All claim-bearing notes are currently `proposed`/`unreviewed` (agent-authored,
awaiting human verification — see [`AGENTS.md`](../AGENTS.md)).

### Start here
- [[godot-version-policy]] — which Godot version this base targets (4.7.2) and how version-dependent claims are scoped.

### GDScript
- [[gdscript-static-typing]] — explicit & inferred static types, and why to use them.
- [[gdscript-signals]] — signals as Godot's decoupling / observer mechanism.
- [[input-handling]] — InputMap actions + the Input singleton (poll vs event callbacks).

### Nodes & scene architecture
- [[node-lifecycle-callbacks]] — `_enter_tree` / `_ready` / `_process` / `_exit_tree` order and use.
- [[node-vs-resource-vs-autoload]] — choosing where shared state/behavior lives.

### 2D gameplay
- [[characterbody2d-movement]] — code-driven movement with `CharacterBody2D` + `move_and_slide()`.
- [[area2d-detection]] — overlap detection (pickups/hitboxes/triggers) via `Area2D` signals + layers/masks.

### Global state & patterns
- [[autoload-singletons]] — the disciplined use of global singletons.
- [[god-autoload]] — the anti-pattern of an ever-growing global (and the fix).

### Experiment-derived methodology (from the godot-lab H06 experiment)
- [[benchmark-leakage-assertions]] — why asserting an exact implementation constant that also lives in the knowledge
  under test produces a false "knowledge helps" signal (and the fix).
- [[knowledge-availability-vs-application]] — available ≠ retrieved ≠ better code; measure mediation; provenance can
  improve while quality does not.

### Game studio (agent-driven 2D+3D production)
- [[game-studio-index]] — tool architecture, evaluations, decisions and workflows for AI-agent game production around Godot (all `proposed`).

### Game studio sources
- [[game-studio-sources-index]] — hub of the game-studio sources.

### Preserved sources
Official Godot 4.7 documentation is preserved under [`sources/`](../sources/) and cited by the notes above
([[src-gd-static-typing]], [[src-gd-signals]], [[src-godot-notifications]], [[src-singletons-autoload]], [[src-release-policy]],
[[src-upgrading-godot-4]], [[src-characterbody2d]], [[src-area2d]], [[src-input]]). The **H06 experiment** itself is preserved as
a reproducible source ([[src-h06-platformer-experiment]] → `godot-lab@9aa96dd`), cited by the two methodology notes above.
