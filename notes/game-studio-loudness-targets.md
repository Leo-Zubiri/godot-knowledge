---
id: game-studio-loudness-targets
type: concept
domain: game-studio
status: proposed
summary: "Record one loudness target per platform class in the project; EBU R128 gives a broadcast reference (−23 LUFS ±0.5 LU), game-specific platform targets remain unverified."
tags: [dept/audio]
sources:
  - claim: "EBU R128: −23 LUFS target, ±0.5 LU since v3.0, loudness range and true peak, current v5.0 (Nov 2023)"
    ref: src-gs-accessibility-and-loudness
    retrieved: 2026-11-08
  - claim: "ITU-R BS.2434 game-loudness figures known only from a search summary"
    ref: src-gs-accessibility-and-loudness
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-2d-ui-audio-materials]]"   # audio production
  - relates-to: "[[game-studio-accessibility-minimums]]"   # separate volume controls
  - relates-to: "[[game-studio-acceptance-criteria]]"   # audio criteria
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08; no experiment was run and nothing is validated in production. Most design-theory sources could only be read as abstracts or summaries (several PDFs were unreadable), so these notes are `proposed` pointers with explicit caveats, not authoritative claims. Workflows described are `designed` only.

**Evidence classes used here:** *verified* = read on the cited page this session; *abstract-only* = abstract or search summary seen, full text not read; *interpretation* = our reasoning; *hypothesis* = untested; *unverified* = not confirmed.


## Verified reference
**EBU R 128** (read): programme loudness target **−23 LUFS**, deviation limited to **±0.5 LU** since version 3.0 (2014), plus loudness range and maximum true peak (numeric limits not on the page); current version 5.0, November 2023. It is a **broadcast** recommendation, not a game standard.

## Unverified
ITU-R BS.2434 (2018) reportedly cites typical game loudness around −24±2 LKFS (consoles) and −18±2 LKFS (portable) and regional targets; **not read**. Platform-specific targets (Sony, Apple, store requirements) were not found — do not assume numbers.

## Proposal (interpretation)
- Choose a **target per platform class** and record it in the project standards and the asset manifest; measure integrated loudness and true peak of exported audio and flag clipping (tooling such as ffmpeg's loudness analysis is general knowledge, CLI behaviour not researched here).
- An agent can measure and normalise; it **cannot judge** mix balance or emotional fit — a human approves. Effects belong on audio buses at runtime in Godot ([[game-studio-2d-ui-audio-materials]]).

## See also
- [[game-studio-accessibility-minimums]] — volume controls and non-audio cues
- [[game-studio-acceptance-criteria]] — audio criteria
