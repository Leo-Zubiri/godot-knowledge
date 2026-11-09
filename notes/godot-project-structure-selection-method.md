---
id: godot-project-structure-selection-method
type: guide
domain: godot
status: proposed
summary: "Adaptive procedure for an agent to propose a Godot project structure (new project) or assess one: inputs, decision criteria as labelled heuristics, per-directory contract, eight illustrative trees, decision record, git and parallel-agent rules, and validation criteria."
tags: [dept/game-dev, tool/godot, dept/orchestration]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation and engine source only; not run in the engine)"
sources:
  - claim: "Engine and import/VCS facts the proposal must respect"
    ref: src-gd-project-organization-vcs-uids
    retrieved: 2026-11-08
  - claim: "Autoload, resource, plugin and CLI facts used in rules"
    ref: src-gd-architecture-autoloads-plugins-cli
    retrieved: 2026-11-08
  - claim: "Community layouts used only as examples of preference"
    ref: src-gs-project-organization-community-pointers
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-project-organization-strategies]]"   # approaches compared
  - relates-to: "[[godot-asset-source-import-organization]]"   # asset placement
  - relates-to: "[[godot-project-structure-assessment-and-refactoring]]"   # existing projects
  - relates-to: "[[godot-project-organization-anti-patterns]]"   # what to avoid
  - relates-to: "[[game-studio-game-project-profile]]"   # project facts feed this
  - relates-to: "[[game-studio-path-scoped-safety]]"   # agent write scopes
  - relates-to: "[[game-studio-multiagent-topology]]"   # parallel agents
  - relates-to: "[[gs-adr-living-design-docs]]"   # decision records live with docs
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** engine facts come from the Godot 4.7 manual sources and engine files read on 2026-11-08 (paraphrased; see the cited sources). Everything labelled **principle**, **heuristic** or **community preference** is not an engine requirement. Nothing here was run in the engine or tested on a real project: structures are *theoretically evaluated*, not *experimentally validated*. Status `proposed`.


**Use this when:** an agent must propose a structure from a game description, or judge whether a structure fits. **Do not use it to apply a fixed template.**

## 1. Analyse the project (works with incomplete input)
- **Essential (ask if missing, because they change the structure):** 2D/3D/hybrid; scale (jam, prototype, slice, small, large); team and agent participation (solo, several humans, parallel agents); expected lifespan (throwaway or long-lived); whether assets come from external tools (Blender, image editors) or only Godot.
- **Useful (assume if missing, mark as assumption):** genre; number of characters, enemies, levels; UI and narrative weight; audio volume; save/load; procedural content; multiplayer; target platforms; localization.
- **Rule:** ask only about essentials that would change the choice; for the rest state a default and an uncertainty note. Never block on completeness.

## 2. Choose the strategy (heuristics, not thresholds)
| Signal | Leans toward |
|---|---|
| jam, prototype, one person, days or weeks | by type or almost flat; no extra layers |
| several distinct features (combat, inventory, dialogue) that will outlive the prototype | feature folders (hybrid inside if there are shared assets) |
| characters/enemies/levels are the main content units | scene-first |
| several humans or parallel agents working at once | feature folders with one owner per folder |
| code or assets reused in more than one project, or a separate team | modular (addon-style) with a public interface |
| mostly shared reusable behaviour | component layer on top of another approach |
These are **practical heuristics from our reading**; the docs give none. Revisit when: a folder exceeds what one reviewer can scan, a shared folder becomes a dumping ground, or a feature is copied between projects.

## 3. Generate the proposal
Order: root files, `addons/`, entry scenes, features or content areas, shared resources, dimension-specific assets, asset sources and imports, tests, docs, tooling. **For every directory write:** purpose; what belongs; what does not; owner (person, role or agent scope); mandatory / optional / conditional; depends on. **Do not create empty directories without a responsibility.**

| Directory | Purpose | Not here | Owner | Status | Depends on |
|---|---|---|---|---|---|
| `project.godot` and root config | project settings, autoloads, input map | game content | project lead | mandatory (engine) | engine |
| `addons/` | third-party and editor plugins with their licences | project code | integrator | conditional | none |
| `features/<name>/` | scenes, scripts and exclusive resources of one capability | assets used by many features | feature owner | conditional (feature/hybrid) | `shared/`, addons |
| `shared/` (or `common/`) | resources and components used by 2+ features | single-feature items | lead | conditional | none |
| `assets/` or per-feature asset folders | imported, runtime-ready assets | editable sources | asset owner | mandatory in some form | none |
| `tests/` | automated tests (framework is third-party) | game code | QA / dev | optional | features |
| `docs/` with `.gdignore` | design and architecture notes not imported | assets | author | optional | none |
| external `art-src/` (outside `res://`) | editable sources and generators | engine-facing files | artists | conditional | none |

## 4. Illustrative trees (examples, **not templates**)
- **Minimal 2D (jam):** `project.godot`, `main.tscn`, `player/`, `enemies/`, `levels/`, `audio/` — scene-first, no shared layer; why: nothing is reused yet.
- **Medium 2D:** `features/{player,enemies,ui,levels}/`, `shared/{themes,audio,tilesets}/`, `addons/`; sprite sheets live with their feature; why: features outlive the prototype and tilesets/themes are shared.
- **Large 2D:** the medium tree plus `features/<name>/{scenes,scripts,data}` inside big features, `shared/components/`, `tests/`, `docs/.gdignore`, owners per folder; why: multi-developer review.
- **Minimal 3D:** `main.tscn`, `characters/player/`, `levels/`, `models/`, `materials/`; why: models, materials and levels are the units.
- **Medium 3D:** `features/{player,combat,ui}/`, `content/{characters,environment}/`, `shared/{materials,shaders,vfx}/`, external `art-src/` for Blender with exports into `content/`; why: environment pieces and characters reused across levels.
- **Large 3D:** medium plus per-level folders under `content/levels/`, a `shared/components/` layer, `tests/`, `tools/` for validation scripts, asset manifests; why: many levels and owners.
- **Hybrid 2D/3D:** feature folders with `2d/` and `3d/` subfolders only where a feature has both; `shared/ui/` dimension-neutral; why: avoid duplicating features per dimension.
- **AI-assisted parallel:** feature folders = write scopes, a short `README` or index per feature stating owner and public interface, shared and `addons/` read-only for task agents, tests per feature; why: scope isolation (see [[game-studio-path-scoped-safety]]). Folders alone do not make parallel work safe (merge of `project.godot`, shared resources and UID files still need coordination).

## 5. Rules the proposal must carry
- **Naming:** snake_case folders and files (C# scripts follow class names), PascalCase nodes, one convention for scene/script pairs, prefix files exclusive to a scene with its name (preference), autoload names in PascalCase.
- **Dependencies:** scenes self-contained; context flows from the parent via signals first, then calls or exported references ([[godot-project-hygiene]]); shared resources are `Resource` types or components, not autoloads; autoloads only for broad self-contained systems ([[god-autoload]]); a feature may depend on `shared/` and `addons/`, not on another feature's internals (principle).
- **Git and collaboration:** use the generated `.gitignore` (`.godot/`) and add `*.translation` if CSV translations are used; commit `.import` and `.uid` files, `export_presets.cfg`; keep `export_credentials.cfg` out; LFS is optional and set up before the first commit; one owner per folder reduces merge conflicts (principle; no measured data).
- **Agents:** keep an index of folders; avoid ambiguous placement by writing the placement rule once; give each task a directory scope.

## 6. Record each important decision
`Requirement → selected approach → alternatives considered → reason → trade-offs → assumptions → conditions that would change it.` Keep one short record per decision (store with the project's design docs, see [[gs-adr-living-design-docs]]).

## 7. Validate the proposal (theoretical only)
Checklist: clear purpose per directory; a new file has one obvious place; responsibilities separate; dependencies point one way; Godot compatibility (names, `.gdignore`, import inside `res://`); asset pipeline compatible; git rules present; agent scopes defined; **simplest structure that supports the requirements**. A structure with more folders is not better. Do **not** claim experimental validation: none exists unless a real project run is recorded.

## See also
- [[godot-project-organization-strategies]] — approaches compared
- [[godot-asset-source-import-organization]] — asset placement
- [[godot-project-structure-assessment-and-refactoring]] — existing projects
- [[godot-project-organization-anti-patterns]] — what to avoid
- [[game-studio-game-project-profile]] — project facts feed this
- [[game-studio-path-scoped-safety]] — agent write scopes
- [[game-studio-multiagent-topology]] — parallel agents
- [[gs-adr-living-design-docs]] — decision records live with docs
