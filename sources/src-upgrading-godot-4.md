---
id: src-upgrading-godot-4
type: source
domain: godot
source:
  url: https://docs.godotengine.org/en/4.7/tutorials/migrating/upgrading_to_godot_4.html
  title: "Upgrading from Godot 3 to Godot 4 — Godot Engine 4.7 documentation"
  retrieved: 2026-11-06
  version: "4.7"
created: 2026-11-06
updated: 2026-11-06
---

> Preserved as a pinned reference to the official Godot 4.7 documentation (conventionally immutable). Full original at
> the URL.

Official page: **Upgrading from Godot 3 to Godot 4** (Godot 4.7).

Key points (as documented):
- Godot 4 introduced broad, breaking API changes from Godot 3; the page documents the migration and the built-in
  **project converter**.
- Representative renames/changes called out across the 3→4 migration: `KinematicBody2D`/`KinematicBody` →
  `CharacterBody2D`/`CharacterBody3D`; coroutine `yield(...)` → `await`; many class/method renames; the rendering
  backend change (GLES-era renderers → the new Vulkan-based renderers / "Compatibility" renderer).
- The converter does an automated pass but **does not make backups** and does not catch everything — manual review is
  required.
- Implication: version-dependent claims must state the version they apply to; do not assume Godot 3 behavior carries to
  Godot 4 (or vice versa).
