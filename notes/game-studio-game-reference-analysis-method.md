---
id: game-studio-game-reference-analysis-method
type: reference
domain: game-design
status: proposed
summary: "Proposed repeatable method for analysing existing games with five separate evidence layers, a division of labour between a human player and an agent, and what must not be recorded."
tags: [scope/game-analysis, dept/design]
sources:
  - claim: "HEP heuristics count, categories and study limits"
    ref: src-gs-design-primary-papers-read
    retrieved: 2026-11-08
  - claim: "Named analysis methods and heuristics are only known from search summaries (MDA, design patterns, close playing, usability heuristics)"
    ref: src-gs-design-reference-analysis-pointers-unverified
    retrieved: 2026-11-08
  - claim: "MDA is a vocabulary framework with an abstract read; no empirical validation found"
    ref: src-gs-design-theory-and-typologies
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-reference-analysis-legal-boundary]]"   # what may be recorded
  - relates-to: "[[game-studio-game-design-theory-vocabulary]]"   # MDA-style interpretation
  - relates-to: "[[game-studio-playtesting-methods]]"   # hypotheses need testing
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research dated 2026-11-08; no experiment was run and nothing is validated in production. Most design-theory sources could only be read as abstracts or summaries (several PDFs were unreadable), so these notes are `proposed` pointers with explicit caveats, not authoritative claims. Workflows described are `designed` only.

**Evidence classes used here:** *verified* = read on the cited page this session; *abstract-only* = abstract or search summary seen, full text not read; *interpretation* = our reasoning; *hypothesis* = untested; *unverified* = not confirmed.


> The method below is a **design proposal (our interpretation)**. The analysis frameworks it draws on were not read in full (see the source note), so it is not a standard.

## Five evidence layers (keep in separate sections of every analysis note)
1. **Observed behaviour** — what a player can see or measure: loops, timings, counts, UI states; record who observed it and which build/version.
2. **Developer-confirmed** — talks, postmortems, interviews, official blogs; cite URL, author, year; short paraphrase only.
3. **Publicly documented technical detail** — official docs, published papers.
4. **Analytical interpretation** — e.g. MDA-style reasoning, labelled as interpretation.
5. **Hypotheses to validate** — stated as testable, with the prototype or measurement that would test them.

## Procedure (agent + human)
1. Scope a narrow question first (e.g. "onboarding in game X").
2. A **human plays** and records observations; the agent structures notes and proposes a checklist (loop, progression/reward, level structure, encounter and difficulty, feedback, onboarding, UI/UX, audio, narrative, pacing).
3. The agent searches for developer-confirmed sources and records short paraphrases.
4. The agent drafts interpretation and hypotheses; a human approves before anything is reviewed.
5. **Transfer:** write the principle in your own words as a genre-neutral statement with its evidence class.

## Heuristic evaluation as an optional layer (verified detail)
HEP (Desurvire et al. 2004, read) offers 43 playability heuristics in four categories for early-stage evaluation; its authors found it useful before expensive prototypes but conclude user testing remains the benchmark (one game, four users). Pinelle et al. (CHI 2008) and the other named methods remain unread pointers.

## Limits
An agent cannot see or feel the game, judge pacing, or tell whether a hypothesis holds. Retention and pacing figures are usually not public; treat any such number as unverified unless the developer published it.

## See also
- [[game-studio-reference-analysis-legal-boundary]] — what to avoid recording
- [[game-studio-game-design-theory-vocabulary]] — MDA-style interpretation
- [[game-studio-playtesting-methods]] — hypotheses need testing
