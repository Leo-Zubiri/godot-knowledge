---
id: game-studio-game-design-theory-vocabulary
type: reference
domain: game-studio
status: proposed
summary: "Shared vocabulary from game design theory (MDA, flow, GameFlow, self-determination, player typologies) with each model's evidence caveat — useful for naming and checking design, not as validated laws."
tags: [dept/design]
sources:
  - claim: "MDA abstract: authors, year, venue and purpose; the PDF text was unreadable"
    ref: src-gs-design-theory-and-typologies
    retrieved: 2026-11-08
  - claim: "Bartle's types, derivation and the author's own rigor caveats"
    ref: src-gs-design-theory-and-typologies
    retrieved: 2026-11-08
  - claim: "Hamari and Tuunanen seven-dimension synthesis of player typologies"
    ref: src-gs-design-theory-and-typologies
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-playtesting-methods]]"   # what theory cannot replace
  - relates-to: "[[game-studio-game-reference-analysis-method]]"   # MDA-style layers used for analysis
  - relates-to: "[[game-studio-prototype-vs-vertical-slice]]"   # where design hypotheses get tested
  - relates-to: "[[game-studio-index]]"   # entry point
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08; no experiment was run and nothing is validated in production. Most design-theory sources could only be read as abstracts or summaries (several PDFs were unreadable), so these notes are `proposed` pointers with explicit caveats, not authoritative claims. Workflows described are `designed` only.

**Evidence classes used here:** *verified* = read on the cited page this session; *abstract-only* = abstract or search summary seen, full text not read; *interpretation* = our reasoning; *hypothesis* = untested; *unverified* = not confirmed.


## How to use this note
These models give a **shared vocabulary** for discussing designs and for an agent to structure its reasoning. None is an empirically validated formula; several sources say so themselves.

## Models and caveats
| Model | What it says (as far as read) | Caveat | Evidence |
|---|---|---|---|
| **MDA** (Hunicke, LeBlanc, Zubek, 2004) | Games analysed through Mechanics → Dynamics → Aesthetics; meant to connect design, game criticism and technical research; developed in the GDC Game Design and Tuning Workshop 2001–2004 | Short workshop paper; no empirical validation found; the list of eight "aesthetics" was not read in the primary text | abstract-only (listing read; PDF unreadable) |
| **Flow** (Csikszentmihalyi) and **GameFlow** (Sweetser & Wyeth, 2005) | Enjoyment as balance of challenge and skill; GameFlow lists eight elements (concentration, challenge, skills, control, clear goals, feedback, immersion, social interaction) | Critiques found only as summaries: partial empirical support for the challenge–skill balance; GameFlow validated by expert review of two games | abstract-only / unverified |
| **Self-determination theory** (Ryan, Rigby & Przybylski, 2006) | Autonomy, competence and relatedness predict enjoyment and future play | Self-reported samples; methods not read | abstract-only |
| **Bartle's player types** (1996) | Achievers, explorers, socialisers, killers on two axes | **The author states it is not conventionally rigorous**, based on a debate among ~30 players of one MUD, the types are stereotypes, ideal mixes were never measured | verified (read in full) |
| **Typology syntheses** (Hamari & Tuunanen, 2014) | Seven recurring dimensions: intensity, achievement, exploration, sociability, domination, immersion, in-game demographics | The abstract page shows no explicit warnings (later critiques on validity — Yee 2006, Kirchner-Krath 2024 — were not read) | abstract-only |

## Interpretation (ours)
- Use these as **prompts and checklists** ("what experience do we intend, which mechanics should produce it, what dynamics might emerge?"), not as segmentation of real players.
- Treat typologies as brainstorming aids; the primary source itself warns against reading them as rigorous.
- An agent can write intended aesthetics, derive candidate mechanics and flag mechanics with no stated purpose. It **cannot observe the dynamics real players produce** — that needs play data or human observation ([[game-studio-playtesting-methods]]).

## Gaps (no primary source read)
Feedback-loop theory, progression and reward-schedule design, difficulty-curve construction, per-genre convention catalogues. Do not invent content for them; find sources first.

## See also
- [[game-studio-playtesting-methods]] — observation versus theory
- [[game-studio-game-reference-analysis-method]] — analysis layers
- [[game-studio-prototype-vs-vertical-slice]] — where design hypotheses get tested
- [[game-studio-index]] — entry point
