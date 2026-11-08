---
id: src-h06-platformer-experiment
type: source
domain: godot
source:
  url: godot-lab@9aa96dde2e726511d0ba75c788a7c2d628bc5afb
  title: "H06 exp-h06-platformer-pickup — A/A'/B knowledge-benefit experiment (godot-lab, protocol v2)"
  retrieved: 2026-11-08
  version: "protocol v2; knowledge pin godot-knowledge@91250e6"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved reference to a **reproducible experiment** (a code repo at a pinned commit), not a web document. Content
> below is **preserved evidence** — the experiment's design and *observed results* — so later notes can cite it. It is
> NOT synthesis and makes no general technical claims; those live in `notes/` and cite this source by its `id`.
> **Immutability note:** the godot-lab commit is a local, unpushed commit at time of preservation; the reference is the
> immutable SHA plus the stable in-repo paths. If/when pushed, the same SHA resolves on the remote.

## What this is
- **Repository / commit:** `godot-lab` @ `9aa96dde2e726511d0ba75c788a7c2d628bc5afb` (branch `exp/h06-platformer-pickup`).
- **Experiment:** `experiments/exp-h06-platformer-pickup/` — generate `player.gd` (CharacterBody2D) + `coin.gd` (Area2D)
  for a 2D platformer pickup, Godot 4.7.2 GDScript.
- **Question:** does consulting `godot-knowledge` measurably improve AI-generated Godot code?
- **Design:** three conditions — **A** (baseline, no knowledge), **A′** (placebo: told to retrieve, empty dir),
  **B** (read-only `godot-knowledge` @ `91250e6`). **N=5 per condition (15 runs)**. Generator `claude-sonnet-5-5`
  (effort high, web off), each run in a bubblewrap sandbox (knowledge the only per-condition difference). Blind quality
  evaluator `claude-opus-5-5`; objective validation via GUT 9.6.1 on Godot 4.7.2-mono.

## Preserved artifacts (stable paths in that commit)
- Final report: `reports/final-results.md`; per-run table: `results/comparisons.csv`; aggregates:
  `results/exp-h06-platformer-pickup-matrix.{json,md}`.
- Evidence: `experiments/exp-h06-platformer-pickup/evidence/{godot-execution,visual,evaluation}/`.
- Raw preserved generations: `runs/exp-h06-platformer-pickup/matrix/` (every attempt kept).

## Observed results (evidence — specific to this one task; NOT general claims)
- **GUT PASS:** A **0/5**, A′ **3/5**, B **5/5**.
- **Every** failure was the *same* assertion: `velocity.x == 300.0` (exact, ±1.0). The knowledge note
  `characterbody2d-movement` hard-codes `const SPEED := 300.0` (same constant the test's reference uses). B runs copied
  300 → pass; A runs used 200; one A′ used 160 → failed only that assertion. (A speed of 200 is valid platformer code.)
- **Blind quality (opus, blind to condition/test):** overall means A **2.29**, A′ **2.42**, B **2.42** — no meaningful
  separation at N=5; B scored **worse on hallucinations** (2.0 vs A 3.0, reverse-scored).
- **Provenance (separate pass):** B cited **real, existing** notes (existence 3); **A fabricated references in 3/5 runs**
  (existence 0–1) — runs `3d270d38`, `91139175`, `9f787425`; A′ correctly cited nothing.
- **Mediation:** B read `/knowledge` in **4/5** runs (mean 3.2 reads); A′ **0** reads (+1 turn vs A — "looked, empty,
  proceeded"). The mediator **under-counted** at least one case: B run `9e367447` logged 0 reads yet cited real notes
  (likely a directory listing the mediator does not capture).
- **Visual (real engine):** all 15 runs (A/A′/B) rendered and **collected the coin** on screen; candidate SHA-256
  unchanged by rendering.
- **Run IDs** — B: `24d62fcb 33987f47 828d025c 9e367447 d3236b80`; A: `3d270d38 537325da 561d1e68 91139175 9f787425`;
  A′: `0bd36f68 307b6749 52abef87 99b3df94 9c0044ba`.

## Limitations recorded by the experiment
- **N=5 is exploratory** — no statistical significance; results do not generalize beyond this single task.
- Generator and evaluator are **both Anthropic** models — not provider-independent.
- The executable signal was dominated by **one over-specified assertion** (benchmark leakage); it measures
  constant-matching more than correctness.
