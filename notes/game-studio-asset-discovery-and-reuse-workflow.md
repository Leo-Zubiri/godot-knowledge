---
id: game-studio-asset-discovery-and-reuse-workflow
type: guide
domain: game-studio
status: proposed
summary: "Designed 11-step workflow for finding, licensing, acquiring, validating and registering an existing asset before generating or creating one, with realistic automation limits."
sources:
  - claim: "Programmatic access varies: Freesound/Poly Haven/ambientCG APIs; Sketchfab and Freesound downloads need user OAuth; most providers manual"
    ref: src-gs-asset-audio
    retrieved: 2026-11-08
  - claim: "Sketchfab download requires end-user login; itch.io and marketplaces have no verified automation"
    ref: src-gs-asset-marketplaces
    retrieved: 2026-11-08
  - claim: "Poly Haven site ToS bans scraping; ambientCG API documented"
    ref: src-gs-asset-materials-hdri
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-asset-license-and-provenance-policy]]"   # step 4 rules
  - depends-on: "[[game-studio-asset-registry-and-manifest-conventions]]"   # step 10 record
  - relates-to: "[[game-studio-reuse-vs-generation-decision-framework]]"   # step 3 and 11 decisions
  - relates-to: "[[game-studio-workflows]]"   # each production workflow starts here
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08 from official provider pages (paraphrased extractions, not verbatim legal text); no asset was downloaded and nothing was executed. **Not legal advice.** Terms change; items marked `unverified` were not read on an official page. Classes and workflows are *proposals* pending human review; ambiguous cases must go to a human.


> **Designed only** — not executed or validated.

## Goal
Avoid producing assets from scratch when a legally and technically suitable existing one exists.

## Steps
1. **Specify** the asset: type, style, technical spec (format, poly/texture budget, rig), intended use.
2. **Search approved sources** ([[game-studio-asset-source-catalog]]) starting with free, provider-wide permissive licences (libre-open tier first, per [[gs-adr-free-and-open-source-first]]).
3. **Compare candidates:** visual quality, style fit, technical suitability, licence ([[game-studio-reuse-vs-generation-decision-framework]]).
4. **Verify the individual asset's licence and provenance** (per-asset providers: Sketchfab, Freesound, BlenderKit, itch.io, OpenGameArt; per-pack files for Kenney).
5. **Human approval** when licence, source reliability or ShareAlike/NC/unknown terms are unclear.
6. **Acquire.** Reality check: only Freesound (OAuth2 for download), Poly Haven and ambientCG have documented programmatic paths; Sketchfab needs a human login; most others are manual downloads. GUI automation is a last resort and may breach terms (e.g. scraping bans).
7. **Preserve** the original (where its licence allows keeping it in the repo) and the **licence evidence snapshot**.
8. **Validate** the file: format, import, scale/orientation, budgets ([[game-studio-acceptance-criteria]]).
9. **Integrate** into Blender/Godot ([[game-studio-blender-pipeline]], [[game-studio-godot-integration]]).
10. **Record** usage in the registry ([[game-studio-asset-registry-and-manifest-conventions]]); regenerate credits.
11. **Generate or create** only if no candidate is adequate ([[game-studio-ai-generation]]).

## Pitfalls
Downloading for convenience from a source whose terms forbid automation; committing non-CC0 originals to a public repo; using Sonniss/Pixabay or NoAI-tagged assets as generative-tool inputs; skipping the per-asset licence check.

## See also
- [[game-studio-asset-license-and-provenance-policy]]
