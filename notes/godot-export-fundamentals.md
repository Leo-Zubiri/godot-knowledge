---
id: godot-export-fundamentals
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 export fundamentals: presets and resource filters, config and credentials files, export templates, PCK/ZIP packs, patching and DLC pitfalls, encryption caveat."
tags: [dept/delivery, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Export presets, filters, templates, packs and patches pages for Godot 4.7"
    ref: src-gd-export-and-platforms
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-project-hygiene]]"   # credentials file and version metadata
  - relates-to: "[[godot-ci-export-documented-limits]]"   # command-line export and CI gaps
  - relates-to: "[[godot-export-platform-notes]]"   # per-platform requirements
  - relates-to: "[[game-studio-delivery-platforms-and-fees]]"   # where builds go next
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7* per research subagent, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine or a build: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


## Presets and files
- Presets live in the Export dialog (Export All / Export Project / Export PCK/ZIP); **templates (and for some platforms SDKs) must be installed first** via Editor > Manage Export Templates. Missing templates or SDKs block export for that platform.
- `export_presets.cfg` is safe to commit. **`.godot/export_credentials.cfg` holds passwords and keys: keep it out of version control** and copy it manually to a new machine.
- Resource filter modes: all, selected scenes, selected resources, all except checked, dedicated server; extra filters cover non-resource files (`.txt`, `.json`, `.csv`) and exclusions. Files and folders starting with a period are never exported; output paths are relative to the project folder.

## Packs, patches, DLC
- PCK is uncompressed, faster and the default; ZIP is smaller and slower, and an exported binary does **not** auto-load a ZIP pack (a launcher is needed).
- `--export-pack` writes the pack; `ProjectSettings.load_resource_pack()` loads it and by default **a pack file replaces an existing file at the same path** (silent overwrite — put mods in their own folder). Load packs early (e.g. an autoload `_init()`).
- Patching: add the original release PCK as a base pack, enable "Export as Patch", and add every later patch to the base packs; **load order matters**. Delta patches are smaller but load slower, and re-exporting can be non-deterministic, which breaks delta patches (regular patches are unaffected).
- Godot has no built-in DRM; the page suggests signing packs with the Crypto class for launcher-based patching.

## Encryption (caveat)
Known only from a search summary of the compile guide (*unverified wording*): a 256-bit AES key must be compiled into export templates built from source and set in the preset; official precompiled templates do not support it in at least the 4.4 version of the page; Android needs APK expansion. Do not promise encryption without reading the current page.

## What an agent can and cannot check
**By reading files/CLI:** `export_presets.cfg` content (presets, filters, runnable flag, feature tags), that `export_credentials.cfg` is git-ignored, that required presets exist per target. **Needs a build or device:** that the export launches, PCK load order and patch behaviour, encryption key mismatches.

## See also
- [[godot-export-platform-notes]] — per-platform requirements
- [[godot-project-hygiene]] — credentials file and version metadata
- [[godot-ci-export-documented-limits]] — command-line export and CI gaps
- [[game-studio-delivery-platforms-and-fees]] — where builds go next
