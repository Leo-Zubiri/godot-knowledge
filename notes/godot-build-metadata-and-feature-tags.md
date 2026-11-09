---
id: godot-build-metadata-and-feature-tags
type: concept
domain: godot
status: proposed
summary: "Version string, Engine.get_version_info(), feature tags with OS.has_feature (runtime vs export-time quirks), and debug-versus-release differences in Godot 4.7."
tags: [dept/delivery, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Feature tags page and Engine class (per research subagent, 4.7 headers); debug/release differences from earlier preserved pages"
    ref: src-gd-export-and-platforms
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-export-fundamentals]]"   # custom tags are set in presets
  - relates-to: "[[godot-performance-workflow]]"   # debug-only monitors
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7* per research subagent, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine or a build: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- Check tags at runtime with `OS.has_feature(name)`; defaults include `windows`, `linux`, `android`, `web`, `debug`, `release`, `editor`, `template`, `x86_64`, `arm64`, `64`, `32`, `double`, `single`, `threads`, `nothreads`, `etc2`, `s3tc`. Tags are **case-sensitive**.
- Quirks: texture-compression tags, `web_<platform>` and `movie` are not constant at runtime; **`mobile` stays false in a Web export on a phone** (use `web_android`/`web_ios`); **custom tags apply only to exported builds**, not to projects run in the editor; per-feature setting overrides use `setting.feature` keys and `ProjectSettings.get_setting` ignores them (use `get_setting_with_override`).
- `Engine.get_version_info()` returns `major`, `minor`, `patch`, `hex`, `status`, `build`, `hash`, `timestamp`, `string`. `Engine.is_editor_hint()` (for `@tool` scripts) differs from `OS.has_feature("editor")` (editor build).
- `application/config/version` exists (default empty). Using it as the single place for the game version is **our design suggestion**, not a documented requirement.
- Debug versus release: asserts are stripped in release; some `Performance` monitors are debug-only and return 0 in release; `print()` flushing differs ([[godot-logging-and-crash-evidence]]).

## What an agent can and cannot check
An agent can check tag spelling, setting keys in `project.godot` and that a version string exists. Behaviour differences between debug and release need a build.

## See also
- [[godot-export-fundamentals]] — custom tags are set in presets
- [[godot-performance-workflow]] — debug-only monitors
