---
name: tune-config
description: Add or change an adjustable value in a Godot project without hard-coding it, using the config-driven taxonomy (ProjectSettings, typed tuning Resources, player ConfigFile, dev overrides, true constants). Use whenever a number, threshold or toggle appears in a script.
---

# Add a tunable

Taxonomy and pitfalls: note `godot-config-driven-tunables` (read it). Resource sharing pitfalls:
`godot-resource-sharing-and-duplication`.

1. **Classify.** Engine/platform setting → `ProjectSettings` (+ feature-tag override). Designer would change it →
   **typed tuning Resource** in the project's config folder. Player preference → `ConfigFile` in `user://`.
   Developer-only experiment → gitignored override file. Structural constant (enum, id) → code.
2. **Tuning Resource.** Find the domain Resource (one `.tres` per domain, never one giant file); if missing, create
   `class_name <Domain>Tunable extends <project base tunable>` next to its consumer. Declare with limits:
   `@export_range(min, max, step) var name := default` or `@export_enum`; cross-field rules in `validate()`.
3. **Consume.** Load through the project's config service in `_ready()` and re-read on its `reloaded` signal.
   Never mutate the shared Resource; `duplicate()` for per-instance variants.
4. **Record.** Update the `.tres` (text, reviewed like code) and the design doc if the feel changes.
5. **Test.** If the value changes behaviour, add a unit case reading it from the `.tres`.
6. **Verify.** Run the project's check/test targets; try the value through the dev override file without touching
   git.

Anti-patterns: `const SPEED = 300` in gameplay; reading `.tres` with `FileAccess`; tuning stored in `user://`;
a single `config.tres` for everything.
