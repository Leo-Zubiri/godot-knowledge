---
id: game-studio-categorised-audio-catalog-pattern
type: pattern
domain: game-studio
status: unreviewed
summary: "A reusable, game-independent audio catalog: one JSON file listing every sound with a dotted category (sfx.impact.ball_ball, voice.<character>.laugh, ui.accept, ambient.<scene>), tags, intensity, and full provenance; hierarchical lookup, anti-repeat picking with nearest-intensity fallback, validation, procedural fallbacks when a category is empty, generated registry and provenance files, and an `inferred` tag plus a feature flag for unverified classifications."
aliases: [audio catalog, sound library manifest, categorised sounds, audio registry, sound bank json, round robin sound picker]
tags: [dept/audio, dept/assets, tool/godot]
applies-to:
  min: "4.0"
  tested: "Godot 4.7.2.stable.mono; unit and integration tests with the real shipped catalog; implemented in one project, not yet reused in a second"
sources: []
related:
  - relates-to: "[[game-studio-asset-registry-and-manifest-conventions]]"   # the project-wide registry this feeds
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # why every entry carries licence and evidence
  - relates-to: "[[game-studio-ffmpeg-sample-processing-for-cc0-game-audio]]"   # the build step that produces the files
  - relates-to: "[[godot-physics-driven-impact-audio-for-rigid-body-games]]"   # a consumer: variant banks per intensity
created: 2026-11-15
updated: 2026-11-15
created_by_type: agent
---

> **Evidence status — own pattern, `unreviewed`.** Implemented and covered by tests in one project (catalog parsing, lookup, anti-repeat,
> validation of the shipped file). Not yet reused by a second game, so the schema may need to grow. Nothing here was judged by ear.

## Problem
Sound files accumulate in folders with ad-hoc names, code hard-codes paths, nobody knows which variants exist, which are loud/soft, which licence
each has, or which were classified by a guess. A second game cannot reuse the library without reading every file name.

## Solution
**One JSON catalog next to the files**, read by a small generic class; games ask for a *category*, never a path.

### Schema (one entry per file)
`{ id, file, category, tags[], intensity, source_id, source_url, author, license, retrieved, processing }`
- `file` is **relative to the catalog's folder** (the catalog can move with its folder).
- `category` is dotted and hierarchical: `sfx.impact.ball_ball`, `sfx.impact.pocket`, `voice.<character>.laugh`, `ui.accept`, `ui.back`, `ambient.<scene>`.
- `intensity`: `soft | medium | hard | ""` (empty = not graded).
- `tags`: free labels (`nasal`, `wood`, `processed`, `real`, `inferred`).
- `source_id` / `source_url` / `author` / `license` / `retrieved`: provenance of the **original**; `processing`: one sentence on what was done to it.
- Top level: `{"version": 1, "generated": "<date>", "sounds": [...]}`.

### Lookup rules
1. **Hierarchical by dots, not by text prefix.** `find("sfx.impact")` returns everything under it; `find("sfx.imp")` returns nothing. Implement as
   `cat == wanted or cat.begins_with(wanted + ".")`.
2. `find(category, intensity="", tag="")` filters further.
3. `pick(category, intensity, rng)` returns a stream **never equal to the previous pick for the same (category, intensity)** while more than one exists.
4. **Nearest-intensity fallback:** if no entry has the requested intensity, use the closest one that exists (soft < medium < hard) in that category.
5. An empty category returns `null`; **the caller falls back to a procedural/synthetic sound**, so the game always makes noise even with zero files.
6. Load streams lazily and cache by id.
7. `pick_entry` (returns the entry) next to `pick` makes the anti-repeat logic testable without audio files.

### Validation (a function and a test on the shipped catalog)
Unique ids · every `file` exists as a resource · `intensity` is one of the allowed values · `license` and `source_id` are present · (test) every licence is
in the allowed set (e.g. CC0-1.0, Public-Domain) · required categories are covered (≥ N laugh variants, every UI category).

### Build and registry (so nothing is typed twice)
- A **build script** reads the folder of originals, writes the processed files and **generates `catalog.json`** (mark it "generated, do not edit").
- A **registry sync script** reads the catalog and rewrites the project asset registry lines for audio (one line per file, replacing the previous generated
  ones) and a human-readable `PROVENANCE.md` (sources table + derived-sounds table). Add any new licence value (e.g. `Public-Domain`) to the registry linter on purpose.
- **Naming:** `<category with underscores>_<what>_<intensity?>_<nn>.wav`, e.g. `voice_<character>_laugh_03.wav`, `ui_accept_02.wav`, `impact_ball_real_01.wav`.
- Folder layout mirrors the first two category levels: `voice/<character>/`, `ui/`, `sfx/impact/`, `sfx/prank/`, `ambient/`.

### Safeguard for guessed classifications
When a file is classified by inference (for example slices of one recording labelled cue / ball / pocket by order and level, not by listening), give it the tag
`inferred` **and** put its use behind a config flag that defaults to **off** (`use_real_impacts = false`) until a human approves it by ear. Voices and UI sounds whose
role is unambiguous can be on by default.

## Trade-offs
- Costs: a generator step and a registry sync; one more file to keep valid. Benefits: reuse across games, intensity banks without code changes, provenance for
  free, and tests that fail when a file or licence goes missing.
- Not a replacement for engine-side randomization (`AudioStreamRandomizer`) when you only need "random pitch/volume of one stream"; the catalog is for
  *which* sounds exist and where they came from.
- Keep category names stable: renaming one breaks callers silently (they fall back to synthetic sounds) — a test on required categories catches it.

## See also
- [[game-studio-asset-registry-and-manifest-conventions]] — registry conventions this plugs into.
- [[game-studio-asset-license-and-provenance-policy]] — what evidence to store per asset.
- [[game-studio-ffmpeg-sample-processing-for-cc0-game-audio]] — producing the processed files.
- [[godot-physics-driven-impact-audio-for-rigid-body-games]] — a consumer of intensity banks.
