---
id: godot-skeleton3d-modifiers-and-gdscript-style
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 Skeleton3D and SkeletonModifier3D (deprecated overrides), GDScript style/exports/warnings essentials, and the official FSM demo pointer."
tags: [dept/3d-art, tool/godot, dim/3d]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Skeleton3D, SkeletonModifier3D, BoneAttachment3D class pages"
    ref: src-gd-skeleton-gdscript-fsm-demo
    retrieved: 2026-11-08
  - claim: "GDScript style guide, basics, exports and warning system pages"
    ref: src-gd-skeleton-gdscript-fsm-demo
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-animation-tree-and-tween-pitfalls]]"   # animation
  - relates-to: "[[characterbody3d-movement]]"   # 3D character
  - relates-to: "[[godot-project-hygiene]]"   # conventions
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---


> **Evidence status:** distilled from the official Godot documentation as extracted on 2026-11-08 (paraphrased, see the cited source). Nothing was run in the engine: *documented*, not *experimentally validated*. Items marked UNV were not read on an official page. Status `proposed`.

- **Skeleton:** modifier callback mode 0 physics / 1 idle (default) / 2 manual; `get_bone_pose` returns pre-modifier values, read final results via `SkeletonModifier3D.modification_processed`. **Deprecated:** global-pose override methods, `physical_bones_*`, `animate_physical_bones` (versions not stated). Modifiers (IK, look-at, spring bones, retarget, XR) are nodes under the Skeleton3D; `influence` is applied by the skeleton. `BoneAttachment3D.override_pose` may misbehave with modifiers.
- **GDScript style:** tabs, lines <100, double quotes, snake_case, signals past tense, fixed member order; the guide names **no formatter or linter** and no official built-in one was found for 4.7 (UNV).
- **Language facts:** `@abstract` and variadic `...args` since 4.5 (per page); `@onready` with `@export` is an error by default; `match` is stricter than `==`; reading exports in `_init()` yields defaults.
- **Warnings:** suppress with `@warning_ignore`; levels and CLI behaviour not described on the page.
- **FSM:** no dedicated 4.7 docs page; the official demo `2d/finite_state_machine` is a supplementary, unread-in-detail example.

## See also
- [[godot-animation-tree-and-tween-pitfalls]] — animation
- [[characterbody3d-movement]] — 3D character
- [[godot-project-hygiene]] — conventions
