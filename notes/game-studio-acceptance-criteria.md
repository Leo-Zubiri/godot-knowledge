---
id: game-studio-acceptance-criteria
type: reference
domain: game-studio
status: proposed
summary: Objective acceptance criteria for assets and features (3D, materials, environments, UI, VFX, audio): an exported file is not a production-ready asset.
sources:
  - claim: "Godot CLI mechanisms usable for import/parse/export checks"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
  - claim: "gdUnit4/GUT headless test runners and reports"
    ref: src-gs-gut-gdunit4
    retrieved: 2026-11-08
  - claim: "Godot 3D import facts used by criteria (suffixes, retargeting)"
    ref: src-gs-godot-3d-import
    retrieved: 2026-11-08
  - claim: "Godot audio import rules"
    ref: src-gs-audio-import-and-tools
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-asset-conventions]]"   # reports and manifests
  - relates-to: "[[game-studio-godot-integration]]"   # execution layer
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Everything here is a *proposal* pending human review.


> Criteria categories are drawn from the brief; **numeric budgets are intentionally not invented** — set them per project (poly/memory/texture/performance budgets = *project-defined*). Tool mechanisms are documented; the checklist itself is a design proposal.

## 3D (Blender → Godot)
Geometry/topology suitable for its role · UV validity (no unintended overlap, within 0–1 unless tiled) · texture resolution and format within budget · material compatible with Godot PBR (separate albedo/roughness/metallic maps) · scale and orientation correct (Y-up, intended units) · rig and animation correct (humanoid BoneMap if retargeted; loops flagged) · collision and navmesh hints present · polygon/memory/performance within project budgets · **Godot imports without errors** (`--import`) · **runtime check** in a test scene.

## Materials · Environments · UI · VFX · Audio
- **Materials:** full map set, tiling/seams acceptable, import settings correct, visual comparison in Godot.
- **Environments:** collision/navmesh generated, occluders where intended, scene loads, navigation test passes.
- **UI:** Control/Theme implementation (not images only), resolution/scaling behaviour, runtime screenshot/test.
- **VFX:** real-time cost within budget, visual check, effect-vs-offline decision recorded.
- **Audio:** correct format for role (WAV short SFX / Ogg music), loop behaviour verified, loudness/bus assignment, playback test.

## Automated mechanisms (documented)
`--check-only` for scripts, `--import` for assets, gdUnit4/GUT for tests with JUnit output, `--export-*` for build validation. Screenshot/visual checks are limited headless (see [[game-studio-godot-integration]]).

## Human gates
Visual/animation quality, art direction, licence/provenance sign-off.

## See also
- [[game-studio-evidence-driven-visual-qa]] — visual-evidence gate and result states
- [[game-studio-review-modes-and-verdicts]] — verdict vocabulary
- [[game-studio-asset-conventions]] — report format
