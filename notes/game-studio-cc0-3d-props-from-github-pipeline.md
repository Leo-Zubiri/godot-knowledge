---
id: game-studio-cc0-3d-props-from-github-pipeline
type: pattern
domain: game-studio
status: unreviewed
summary: "A working, scriptable way to get CC0 low-poly 3D props into a Godot 4 game on a headless dev machine: clone the packs' GitHub repos (KayKit publishes Restaurant/Halloween/Furniture/Prototype/Dungeon/City Bits there, each with a CC0 LICENSE.txt and glTF), embed each .bin into a single .gltf, share ONE atlas texture per pack, render 2D icons from the models, and drive the game catalog from a data table. kenney.nl returns 403 to curl and itch.io needs a browser, GitHub works."
aliases: [kaykit github cc0, import gltf godot pipeline, shared texture atlas gltf, render model to icon godot]
tags: [dept/assets, scope/3d, tool/godot]
applies-to:
  min: "Godot 4.0"
  tested: "Ginomo 4.7.2: 36 models from 5 KayKit packs (≈600 KB total) imported, normalised, iconised and thrown in-game; stress test of all items without leaks"
related:
  - relates-to: "[[game-studio-asset-source-catalog]]"
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"
  - relates-to: "[[game-studio-godot-asset-format-and-import-compatibility]]"
created: 2026-11-27
updated: 2026-11-27
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Done and measured in Ginomo (Godot 4.7.2). Licences were read from each repo's own `LICENSE.txt` ("Creative Commons Zero, CC0"); re-check before shipping.

## Where the files come from (what worked and what did not)
- **Worked:** `git clone --depth 1 https://github.com/KayKit-Game-Assets/KayKit-<Pack>-1.0` (Restaurant Bits, Halloween Bits, Furniture Bits, Prototype Bits, Dungeon Remastered, City Builder Bits, Space Base Bits…). Each repo has `LICENSE.txt` (CC0) and `addons/<pack>/Assets/gltf/*.gltf` (+ `.bin` + one atlas PNG). The org listing endpoint 404s; `search/repositories?q=user:KayKit-Game-Assets` works.
- **Did not:** `kenney.nl` pages return HTTP 403 to `curl`; itch.io downloads need a browser session; Poly Pizza mixes licences. Put downloads in their own scratch folder and never run anything from them: the importer only reads JSON and copies files.

## The pipeline (all scripted, idempotent)
1. **One `.gltf` per model.** Embed the `.bin` as a `data:` URI (`buffers[0].uri`) so there is a single file per object. Some packs ship `.gltf.glb` with the atlas embedded in EVERY model (N copies in memory): convert to `.gltf` and replace `images[0].bufferView` by a `uri` to **one shared atlas PNG per pack** so Godot loads the texture once.
2. **Normalise at load.** `instance(item)`: instantiate the scene, merge the AABB of all `MeshInstance3D` (apply their transforms), scale so the LONGEST side = `2·radius·model_scale`, and centre it. Return `null` when the box is empty: a broken model must fall back to a primitive, never render at native size (KayKit units are ~1 m, i.e. ~20× too big for a 5 cm object).
3. **Keep physics on a primitive** (sphere/box/capsule); the model is only the look. Cheaper and more stable on phones.
4. **Icons for the HUD:** a throw-away `-s` script under xvfb renders each model in a transparent `SubViewport` (3/4 view, one directional light + ambient colour, MSAA) and saves `icons/<id>.png`; the catalog stores it as `icon`. 36 icons took seconds.
5. **Data-driven catalog:** one JSON table (`id, pack, src, shape, mass, drag, spin axis, nudges, flinch, splat…`) feeds both the importer and a generator that saves the `Resource` catalog. Balance changes are table edits.
6. **Provenance:** the importer appends one registry line per file (model, shared texture, licence text, icons) so `lint-assets` stays green; and export presets need `include_filter="*.txt"` or the licence texts are NOT in the APK.

## Checks worth keeping
- A test that every model instantiates, is centred, and measures `2·radius·model_scale`; that every item has an icon and es/en names.
- A stress script that throws every item N times and compares `get_tree().get_node_count()` before/after (found no leaks; would catch undeleted shadows/tweens).
- Per-item "silly gameplay" data beats code: heavy = more aim nudge and long cooldown, light = soft, messy = `splat` + camera-lens stain, round = rolls, flat = spins around Y like a frisbee.
