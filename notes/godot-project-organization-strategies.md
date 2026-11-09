---
id: godot-project-organization-strategies
type: reference
domain: godot
status: proposed
summary: "Seven ways to organize a Godot project (by type, by feature, hybrid, scene-first, modular, component, shared-resource) compared, with profile guidance (2D, 3D, hybrid, production) and a clear line between engine facts, principles and community preference."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation and engine source only; not run in the engine)"
sources:
  - claim: "Official page: no imposed structure, group assets close to scenes, snake_case, addons/ for third parties"
    ref: src-gd-project-organization-vcs-uids
    retrieved: 2026-11-08
  - claim: "Scene organization and autoload guidance (self-contained scenes, subsystems, autoload limits)"
    ref: src-gd-architecture-autoloads-plugins-cli
    retrieved: 2026-11-08
  - claim: "Community layouts and the by-type vs by-feature debate, labelled preference"
    ref: src-gs-project-organization-community-pointers
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-project-hygiene]]"   # naming and file rules
  - relates-to: "[[godot-project-structure-selection-method]]"   # how to choose
  - relates-to: "[[godot-project-organization-anti-patterns]]"   # failure modes
  - relates-to: "[[node-vs-resource-vs-autoload]]"   # shared state
  - relates-to: "[[game-studio-prototype-vs-vertical-slice]]"   # production stages
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** engine facts come from the Godot 4.7 manual sources and engine files read on 2026-11-08 (paraphrased; see the cited sources). Everything labelled **principle**, **heuristic** or **community preference** is not an engine requirement. Nothing here was run in the engine or tested on a real project: structures are *theoretically evaluated*, not *experimentally validated*. Status `proposed`.


## What the engine does and does not decide
- **Engine fact:** Godot imposes no structure; it is scene-based and uses the filesystem as-is, with no asset database. Imports happen inside the project; `addons/` is the conventional place for third-party content; `.gdignore` hides a folder from import and export. snake_case avoids case-sensitivity trouble in the PCK.
- **Official recommendation (soft):** "group assets as close to scenes as possible"; its example tree is feature-ish (models/town/house, characters/player, levels/riverdale).
- **Everything else below is principle or preference.** The official docs name no best strategy and give no size thresholds; we found none anywhere.

## The seven approaches
| Approach | Core idea | Strengths | Weaknesses / failure modes | Coupling and reuse | Agent navigation (interpretation) | Fits |
|---|---|---|---|---|---|---|
| **By resource type** (`scenes/`, `scripts/`, `assets/`) | folders = file kinds | zero placement debate; trivial to learn | one feature spreads across folders; folders grow monolithic; hides ownership | low visible coupling, hard to see real coupling; reuse by copying folders is hard | easy to find "all scripts", hard to find "all of combat" | jams, tiny prototypes |
| **By feature/domain** (`features/combat/`) | folders = capabilities | everything for a feature together; deletable and portable; ownership clear | shared assets get buried or duplicated; "where does this go" debates | cross-feature references become visible, which is good | one directory = one task scope | medium and large, teams, agents |
| **Hybrid** (feature folders, type subfolders inside; shared type folders) | feature first, type second | balances the two | can hide a lack of decisions; two rules to remember | depends on discipline about shared | good if the shared rule is explicit | most medium projects (heuristic, not a law) |
| **Scene-first** (a scene and its exclusive resources in one folder; inherited scenes nested) | scene = unit | matches Godot's model; exclusive resources travel with the scene | scene reuse across features needs a shared home | strong locality | natural unit of work | character/enemy/level-driven games |
| **Modular** (self-contained modules or addons with public interfaces) | boundaries enforced by convention | independent reuse across projects | overhead; premature if only one project uses it | lowest coupling if interfaces are respected | clear scopes, more files to load | large, long-lived, multi-project, multi-team |
| **Component-oriented** (reusable node/scene components under a components folder) | composition | reuse of small behaviours | folder of unrelated components becomes a junk drawer | reuse high, ownership vague | needs an index | any size, as a layer on another approach |
| **Shared-resource** (central `shared/` or `common/`) | one home for cross-feature items | avoids duplication | grows into a dumping ground; hidden dependencies | everything depends on it | ambiguous placement | only as a rule inside another approach |

**Hybrid is not universally superior.** It is the common middle ground in the community sources we read, but those are blogs and forum threads; the one forum thread read reached no consensus. Pick it when a project has real features **and** real shared assets; do not use it to avoid deciding.

## Profiles: shared foundation and real differences
- **Shared foundation for all:** project root with `project.godot`; third parties in `addons/`; a `.gdignore` folder for non-game material (docs, press kit); snake_case; the generated `.gitignore`; a clear entry scene; a single rule for where shared things go.
- **2D specifics:** sprite sheets, tile sets and tile maps, pixel-art import presets (see [[godot-2d-production-settings]], [[godot-tilemaplayer-and-2d-camera-notes]]); UI-heavy 2D benefits from a themes/ui area ([[godot-ui-layout-and-themes]]); skeletal/hand-drawn animation adds animation resources beside the character.
- **3D specifics:** source models and import settings (see [[godot-asset-source-import-organization]]), materials/shaders as shared resources, level/environment pieces versus characters; physics-oriented games add collision/layer conventions ([[godot-physics-bodies-layers-and-interpolation]]).
- **Hybrid (2D+3D):** keep one rule per dimension and put dimension-specific assets under that dimension inside the feature; shared UI and data stay dimension-neutral. No separate template per combination.
- **Production profiles:** jam/prototype — minimal, by type or none; vertical slice — start feature folders for what will survive; small production — hybrid or feature; large or multi-developer — feature or modular plus ownership and review rules; AI-assisted — feature folders with explicit scope per task ([[game-studio-path-scoped-safety]]). Avoid enterprise structure for small projects.

## See also
- [[godot-project-hygiene]] — naming and file rules
- [[godot-project-structure-selection-method]] — how to choose
- [[godot-project-organization-anti-patterns]] — failure modes
- [[node-vs-resource-vs-autoload]] — shared state
- [[game-studio-prototype-vs-vertical-slice]] — production stages
