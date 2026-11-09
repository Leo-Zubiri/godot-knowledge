---
id: game-studio-accessibility-minimums
type: reference
domain: game-studio
status: proposed
summary: "Basic accessibility considerations from the Game Accessibility Guidelines and the Xbox Accessibility Guidelines, separated into what an agent can check mechanically and what needs human judgement; no numeric thresholds are invented."
tags: [dept/ui-ux, dept/qa]
sources:
  - claim: "Game Accessibility Guidelines basic tier by need; no numeric thresholds stated on the page"
    ref: src-gs-accessibility-and-loudness
    retrieved: 2026-11-08
  - claim: "Xbox Accessibility Guidelines v3.2 (2023): best practices, not a compliance checklist"
    ref: src-gs-accessibility-and-loudness
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-ui-layout-and-themes]]"   # Godot stretch presets, fonts and theme practice
  - relates-to: "[[game-studio-acceptance-criteria]]"   # UI and audio criteria
  - relates-to: "[[gs-adr-godot-final-ui-authority]]"   # UI implemented in Godot
  - relates-to: "[[game-studio-loudness-targets]]"   # audio cues and volume controls
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08; no experiment was run and nothing is validated in production. Most design-theory sources could only be read as abstracts or summaries (several PDFs were unreadable), so these notes are `proposed` pointers with explicit caveats, not authoritative claims. Workflows described are `designed` only.

**Evidence classes used here:** *verified* = read on the cited page this session; *abstract-only* = abstract or search summary seen, full text not read; *interpretation* = our reasoning; *hypothesis* = untested; *unverified* = not confirmed.


## Source scope
The **Game Accessibility Guidelines** (basic tier, read) and the **Xbox Accessibility Guidelines v3.2** (intro read) are practitioner best practices. Microsoft states the XAGs are **not a compliance or legal checklist**. The GAG page gives **no numeric thresholds** (contrast ratios, font or button sizes) — do not invent any; get thresholds from a primary standard if a project needs them.

## Basic considerations (documented recommendations)
| Need | Considerations |
|---|---|
| Motor | adjustable speed/sensitivity/haptics (or haptics off); large, well-spaced on-screen buttons; same input for menus and gameplay; simple or alternative controls; remappable controls |
| Cognitive | avoid flashing and repetitive patterns; player-paced text; interactive tutorials, plain language; reach play without deep menus; simple text formatting, readable default font size |
| Vision | strong text/UI contrast; avoid VR motion-sickness triggers; sensible default FOV; **never colour alone** for essential information |
| Hearing | clear subtitles/captions for all important speech; no essential information through sound alone; separate volume controls for effects, speech, music |
| Speech | never require voice input |
| General | ask for accessibility feedback; save and remember all settings; document features; a wide range of difficulty levels |
The page notes remapping, text size, colourblindness and subtitle presentation as the most commonly complained-about issues.

## What an agent can and cannot do (interpretation)
- **Can check mechanically:** that settings exist and persist, that remap/volume/subtitle options are present, contrast and minimum text size **against thresholds the project defines**, and that information has a non-colour cue.
- **Cannot judge:** hierarchy and clarity of the whole UI, comprehension, comfort. A human (ideally including disabled players) approves.

## See also
- [[game-studio-acceptance-criteria]] — where checks are recorded
- [[gs-adr-godot-final-ui-authority]] — UI implemented in Godot
- [[game-studio-loudness-targets]] — audio cues and volume controls
- [[godot-ui-layout-and-themes]] — Godot stretch presets, fonts and theme practice
