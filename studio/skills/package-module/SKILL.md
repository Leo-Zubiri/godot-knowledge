---
name: package-module
description: Extract reusable Godot code into a self-contained module under addons/<prefix>_<name>/ that another project can install by copying a folder. Use when a second consumer appears (second feature, minigame or game) or when the user asks to make something reusable.
---

# Package a reusable module

Layout, plugin.cfg rules, Asset Library expectations and pitfalls: note `godot-reusable-module-packaging` (read it).

1. **Justify the second use.** Name the two consumers. If there is only one, keep the code in place with a header
   comment `# extract-candidate: <prefix>_<name>` and module discipline (no upward imports, no hard-coded strings,
   own tests) — stop here.
2. **Create** `addons/<prefix>_<name>/` with `README.md` (purpose, public API, dependencies on other modules,
   install steps, autoloads the host must register), `CHANGELOG.md` (0.1.0), `LICENSE` as the project dictates,
   `plugin.cfg` **only** if it ships editor tooling.
3. **Isolate.** Prefixed `class_name`s; configuration via `@export`/setters; events via signals; data paths passed
   in; **zero** references to the game's `core/`, `features/` or concrete config files. The module never registers
   its own autoloads.
4. **Move** scripts with their `.uid` files; re-save scenes that referenced them (`godot-project-hygiene`).
5. **Tests** in the project's test tree under the module's name; they must pass without the rest of the game.
6. **Lint.** `rg "res://(core|features)" addons/<prefix>_<name>` must be empty; run the project's deps lint.
7. **Document** the module in the project's architecture doc and bump `CHANGELOG.md` on later changes.

Extraction to another repo: copy the folder (with `.uid`s) or `git subtree split -P addons/<prefix>_<name>`;
register autoloads per README; run its tests there — failures mean hidden coupling to fix at the source.
