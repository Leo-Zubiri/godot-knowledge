---
id: godot-project-organization-anti-patterns
type: anti-pattern
domain: godot
status: proposed
summary: "Fourteen project-organization anti-patterns for Godot (generic assets folder, extension-only grouping, global folders, deep nesting, duplicated shared resources, over- and under-modularization, autoload growth and more) with recognition signs, corrections and when each is acceptable."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation and engine source only; not run in the engine)"
sources:
  - claim: "Official organization, autoload and import guidance used as basis"
    ref: src-gd-project-organization-vcs-uids
    retrieved: 2026-11-08
  - claim: "Autoload, scene organization and plugin guidance"
    ref: src-gd-architecture-autoloads-plugins-cli
    retrieved: 2026-11-08
  - claim: "Community debate on type vs feature, preference only"
    ref: src-gs-project-organization-community-pointers
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-project-organization-strategies]]"   # approaches and trade-offs
  - relates-to: "[[god-autoload]]"   # autoload anti-pattern in depth
  - relates-to: "[[godot-project-structure-assessment-and-refactoring]]"   # how to fix safely
  - relates-to: "[[godot-resource-sharing-and-duplication]]"   # duplicate resources
  - relates-to: "[[godot-project-hygiene]]"   # hygiene rules
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** engine facts come from the Godot 4.7 manual sources and engine files read on 2026-11-08 (paraphrased; see the cited sources). Everything labelled **principle**, **heuristic** or **community preference** is not an engine requirement. Nothing here was run in the engine or tested on a real project: structures are *theoretically evaluated*, not *experimentally validated*. Status `proposed`.


Format per pattern: **why** · **bites when** · **recognise** · **fix** · **acceptable when**. Items marked (engine) have an engine-based consequence; the rest are principles or interpretation.

1. **Everything in one `assets/` folder.** Why: easy start. Bites when hundreds of files mix kinds and owners. Recognise: no subfolder says what a file is for. Fix: group by feature or content unit. Acceptable: tiny prototypes.
2. **Grouping only by file extension.** Why: familiar from other tools. Bites when one feature spans six folders and shared items are unowned. Recognise: changing "player" touches every top-level folder. Fix: co-locate by feature or scene (the official page suggests keeping assets near scenes). Acceptable: jams and small projects, a stated preference not an error.
3. **Excessive global folders** (`common/`, `utils/`, `misc/`). Why: avoiding placement decisions. Bites when everything depends on them. Recognise: the folder is the largest or most imported-from. Fix: move single-feature items home; split by responsibility. Acceptable: a small, owned `shared/` with a stated rule.
4. **Unclear feature ownership.** Bites with several people or agents. Recognise: no one can say who may edit a folder. Fix: one owner per folder, index per feature. Acceptable: solo projects.
5. **Deep unnecessary nesting.** Bites in navigation and long `res://` paths. Recognise: more than a few levels with one item each. Fix: flatten. Acceptable: when levels mirror real hierarchy (e.g. model > variants).
6. **Duplicated shared resources.** Bites when copies diverge. Recognise: same filename or checksum in several folders. Fix: one shared resource with an owner ([[godot-resource-sharing-and-duplication]]). Acceptable: deliberate copies for variants, recorded.
7. **Over-fragmented projects.** Bites in review overhead. Recognise: many folders with one file. Fix: merge. Acceptable: planned growth with a stated trigger.
8. **Monolithic feature directories.** Bites when a feature folder holds unrelated sub-capabilities. Fix: split by responsibility. Acceptable: a feature that is genuinely one unit.
9. **Mixing editable sources with runtime-ready assets without a convention.** (engine) Heavy `.blend`/layered files get imported and exported if inside `res://` and not ignored. Fix: external source folder or `.gdignore`, plus a manifest ([[godot-asset-source-import-organization]]). Acceptable: tiny projects where the engine importing a `.blend` is intended.
10. **Enterprise architecture for small games.** Bites as wasted effort. Recognise: layers and interfaces with one implementation. Fix: remove layers. Acceptable: when reuse across projects is planned.
11. **Premature modularization.** Bites as overhead and brittle interfaces. Recognise: addon-like modules used by one project, interfaces that change weekly. Fix: keep in features until a second user appears. Acceptable: a known multi-project plan.
12. **Arbitrary folder creation** (empty or one-off folders without a stated responsibility). Fix: every directory gets a purpose and owner ([[godot-project-structure-selection-method]]).
13. **Uncontrolled autoload growth.** (engine) Autoloads are never freed on scene change and are reachable everywhere, so state, access and allocation become global ([[god-autoload]]). Fix: class_name nodes, Resources, statics; keep autoloads for broad self-contained systems. Acceptable: a few small cross-cutting services.
14. **Unclear scene/script dependencies.** Bites when scenes reach into others by hard-coded paths. Recognise: many `get_node("../..")` and `res://` paths to other features. Fix: signals and injected references ([[godot-project-hygiene]]). Acceptable: within one scene's own tree.

Also: **committing `.godot/` or secrets** and **ignoring `.uid`/`.import` files** are version-control defects, not style (see [[godot-project-structure-assessment-and-refactoring]]).

## See also
- [[godot-project-organization-strategies]] — approaches and trade-offs
- [[god-autoload]] — autoload anti-pattern in depth
- [[godot-project-structure-assessment-and-refactoring]] — how to fix safely
- [[godot-resource-sharing-and-duplication]] — duplicate resources
- [[godot-project-hygiene]] — hygiene rules
