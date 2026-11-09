---
id: godot-project-structure-assessment-and-refactoring
type: guide
domain: godot
status: proposed
summary: "How to assess an existing Godot project's organization (checklist, severity classes, structural vs stylistic findings) and a gated, reference-safe refactoring protocol for moves and renames."
tags: [dept/game-dev, tool/godot, dept/qa]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation and engine source only; not run in the engine)"
sources:
  - claim: "Editor move behaviour, UIDs, .uid files, import files, export config"
    ref: src-gd-project-organization-vcs-uids
    retrieved: 2026-11-08
  - claim: "Autoload, resource and plugin facts for assessment"
    ref: src-gd-architecture-autoloads-plugins-cli
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-project-structure-selection-method]]"   # target structure
  - relates-to: "[[godot-project-organization-anti-patterns]]"   # what to look for
  - relates-to: "[[godot-project-hygiene]]"   # naming and git rules
  - relates-to: "[[godot-resource-sharing-and-duplication]]"   # duplicate resources
  - relates-to: "[[game-studio-agent-audit-and-recovery]]"   # recovery and audit trail
  - relates-to: "[[game-studio-review-modes-and-verdicts]]"   # human approval gates
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** engine facts come from the Godot 4.7 manual sources and engine files read on 2026-11-08 (paraphrased; see the cited sources). Everything labelled **principle**, **heuristic** or **community preference** is not an engine requirement. Nothing here was run in the engine or tested on a real project: structures are *theoretically evaluated*, not *experimentally validated*. Status `proposed`.


**Default stance: leave a working project alone.** Propose changes only for findings that cause real cost, and prefer small steps.

## Assessment (read-only; needs no engine)
Inventory first: directory tree with counts and sizes, scenes, scripts, resources, `project.godot` (autoloads, input map, main scene, plugins), `.gitignore`, `.import`/`.uid` presence, third-party folders, tests. Then check:
- directory responsibilities (can each folder's purpose be stated in a sentence?);
- naming consistency and case-sensitivity risks (mixed case files break exported PCKs on Linux);
- duplicate resources and misplaced assets (same file in several folders; importable files in `.gdignore` folders);
- global dependencies (autoload count and what each holds);
- feature boundaries and cross-feature references; shared-resource misuse (a `shared/` that holds single-feature items);
- over-fragmentation, monolithic folders, needless nesting, unclear ownership;
- missing `.uid` or `.import` files in version control; `.godot/` committed; credentials committed;
- broken references: needs the engine (editor warnings on open, `--import`, headless run); **by reading files alone only suspected** (e.g. `ext_resource` paths with no file).

## Severity (our scheme; classify structural problems separately from taste)
- **Critical:** committed secrets (`export_credentials.cfg`); missing `.uid`/`.import` files that break references on a fresh clone; case mismatches that break exports; broken references to existing features.
- **High:** `.godot/` committed; duplicated shared resources diverging; an autoload that owns most game state; importable assets in unloadable ignored folders.
- **Medium:** monolithic folders, unclear ownership, cross-feature coupling, scattered feature files.
- **Low:** inconsistent naming that does not break exports; needless nesting; empty folders.
- **Informational:** differences from preferred style (type vs feature, `src/` placement) — preference only, never a defect.

## Safe refactoring protocol
1. **Inspect** the project and confirm a clean working tree and a recent commit.
2. **Inventory** current state (paths, references, autoloads, settings).
3. **Propose** concrete moves with reasons; small batches.
4. **Impact assessment:** for each move list scenes/resources that reference it, scripts with hard-coded `res://` paths, autoload entries, project settings (main scene, icons, input), external tools (export presets, CI, build scripts, manifests), third-party addons, `.import`/`.uid` siblings, git history.
5. **Explicit human approval** before any move.
6. **Controlled change:** prefer moving through the **editor FileSystem dock** — in 4.7 source it updates loaded resource paths, remaps dependencies with `ResourceLoader.rename_dependencies`, updates project settings and autoload entries, the main scene and favourites. An **OS-level move** does none of that beyond UID tracking: move the `.uid` and `.import` files with the source, then open and re-save affected scenes. Use `git mv` so history follows. One batch per commit.
7. **Reference validation:** open the project in the editor and read warnings; search for the old path strings (`rg "res://old/"`, including `.tscn`, `.tres`, `.gd`, `project.godot`, `export_presets.cfg`, CI files).
8. **Import validation:** run an import pass (`godot --headless --path <p> --import`) and check for errors; confirm no new untracked `.import`/`.uid` files are left out of git.
9. **Tests** where they exist (third-party frameworks; none official).
10. **Final report:** what moved, why, verified and unverified items, remaining risks.

## Rules
Never perform broad moves or renames without the impact assessment; never rename and restructure in the same step; prefer incremental structural fixes over a full reorganization; do not change the case of a file only (case-insensitive systems mishandle it) without a two-step rename. Everything above is a **designed procedure**, not experimentally validated on a real project.

## See also
- [[godot-project-structure-selection-method]] — target structure
- [[godot-project-organization-anti-patterns]] — what to look for
- [[godot-project-hygiene]] — naming and git rules
- [[godot-resource-sharing-and-duplication]] — duplicate resources
- [[game-studio-agent-audit-and-recovery]] — recovery and audit trail
- [[game-studio-review-modes-and-verdicts]] — human approval gates
