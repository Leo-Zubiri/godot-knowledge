---
id: src-singletons-autoload
type: source
domain: godot
source:
  url: https://docs.godotengine.org/en/4.7/tutorials/scripting/singletons_autoload.html
  title: "Singletons (Autoload) — Godot Engine 4.7 documentation"
  retrieved: 2026-11-06
  version: "4.7"
  capture: paraphrased
created: 2026-11-06
updated: 2026-11-06
---

> Preserved as a pinned reference to the official Godot 4.7 documentation (conventionally immutable). Full original at
> the URL.

Official page: **Singletons (Autoload)** (Godot 4.7).

Key points (as documented):
- Autoload lets you register a scene or script that Godot **loads once at startup** and keeps available for the whole
  session; it is Godot's built-in mechanism for global state/services.
- Configured in **Project → Project Settings → Globals → Autoload**; each entry has a node name by which it is accessed
  globally (e.g. `PlayerData`).
- An autoload is added as a child of the root (the "root viewport") and is therefore always in the scene tree and
  addressable from any script by its name.
- The page frames autoload as a solution for information/state that must be **shared across scenes** and for
  switching the current scene, while noting it should be used judiciously (not everything belongs in a global).
