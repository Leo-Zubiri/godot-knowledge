---
id: game-studio-meshy-ai-3d-models-sourcing
type: guide
domain: game-studio
status: unreviewed
summary: "Meshy (meshy.ai) is an AI text/image-to-3D generator with a community gallery (meshy.ai/category/gaming) that can fill gaps when no CC0 model exists for a prop. Its own docs say the Free plan outputs are CC BY 4.0 (commercial use allowed, credit to Meshy required) and paid plans get a private licence without attribution; third-party sites contradict this and it is unclear whether Free accounts can download GLB. So: not CC0, attribution needed, verify the account's download rights in the browser, and expect AI meshes to need scale/orientation/pivot normalisation before use in Godot."
aliases: [meshy, ai 3d generator, text to 3d, meshy gaming gallery, cc by 3d models, ai generated game props]
tags: [dept/assets, dept/art, tool/godot]
applies-to:
  min: "any"
  tested: "NOT tested: researched from web search results only on 2026-11-17; the gallery page returned HTTP 403 to the automated fetcher, so no model was inspected or downloaded"
sources:
  - "https://www.meshy.ai/category/gaming"
  - "https://docs.meshy.ai/pricing"
  - "https://help.meshy.ai/en/articles/9992001-can-i-use-my-generated-assets-for-commercial-projects"
related:
  - relates-to: "[[game-studio-sourcing-cc0-audio-with-a-logged-in-browser]]"   # same technique: inspect licence pages with the owner's logged-in browser
  - relates-to: "[[game-studio-categorised-audio-catalog-pattern]]"   # provenance registry idea (ASSETS.yaml per asset)
created: 2026-11-17
updated: 2026-11-17
created_by_type: agent
---

> **Evidence status — `unreviewed`, secondary sources only.** Nothing here was observed on Meshy itself: `https://www.meshy.ai/category/gaming` answered
> 403 to the fetch tool. The licence statements come from search-result summaries of Meshy's docs/help centre, and **third-party reviews disagree**
> with them. Re-check the licence on the account before shipping any model.

## What it is
An AI service that generates a textured 3D model from text or an image, plus a public gallery of community models grouped by category (the
"gaming" category is the one of interest for props). Useful when no CC0 pack has the prop (e.g. a slingshot, a long baguette, a curved cue).

## Licence (the part that matters for a CC0-first project)
- **Free plan** — per Meshy's docs/help: licence **CC BY 4.0**, commercial use allowed **with attribution** (credit Meshy in the project description,
  readme or store page).
- **Paid plans (Pro and up)** — private licence, full commercial use, **no attribution** required.
- Contradicting third-party claims: "non-commercial only" (Vantaige), "personal and academic only" (Sorceress). They conflict with Meshy's own pages;
  prefer the official text but confirm it on the account.
- **Unknown:** whether Free accounts can download **GLB** (one reviewer says no; Meshy's free-plan page hints downloads need a paid plan). Check the
  download button on the actual account/model before planning around it.
- Whatever the plan, models are **not CC0**: record `license: CC-BY-4.0` (or the paid private licence) per asset in the provenance registry and surface
  the credit in the game's Licences screen.

## How to inspect (technique that worked for audio, same idea here)
Automated fetchers get 403; use a **browser the owner is already logged into** (e.g. Firefox DevTools MCP), open the model page, read the licence
line and the available download formats, and download into a new empty directory. Never run anything from the download.

## Using AI meshes in Godot (expectations, not measured here)
AI-generated meshes typically arrive with arbitrary scale, orientation and pivot and sometimes heavy topology. Normalise at import time instead of
editing the file: compute the AABB, scale to a real-world `length`, and place grip and tip anchors from the bounds; keep a per-model config
resource. Check the result visually in a contact-sheet scene before wiring gameplay.

## Decision rule
CC0 pack first (Kenney, Quaternius, OpenGameArt CC0, Poly Pizza CC0) → Meshy only for gaps, with the owner's explicit OK because it adds an
attribution obligation and breaks a "100 % CC0" policy.
