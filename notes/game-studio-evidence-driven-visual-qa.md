---
id: game-studio-evidence-driven-visual-qa
type: pattern
domain: game-studio
status: proposed
summary: A visual change is not done until the game is run with real rendering, a frame is captured and inspected, evidence is retained with a staleness hash, and the result is OBSERVED / NOT VERIFIED / N/A.
tags: [scope/reference-study, dept/qa, tool/godot]
sources:
  - claim: "Reference run-and-observe rule, Godot 4 recipe, result states, limits and forbidden flags"
    ref: src-gs-ccgs-qa-evidence
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-godot-integration]]"   # Godot CLI and the screenshot problem
  - relates-to: "[[game-studio-acceptance-criteria]]"   # adds a visual-evidence gate
  - relates-to: "[[game-studio-automated-vs-player-quality]]"   # what a still cannot prove
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


## Pattern (documented; **adopt**)
1. Launch windowed (reference: 1280×720), directly into the affected scene, so the change is reachable.
2. Wait for real rendered frames, capture one, exit. Godot 4 recipe in the reference: `--write-movie <png>` with `--quit-after 60` (frame number appended; frames use viewport size).
3. Inspect the capture against the acceptance criteria.
4. Keep the capture per story with a hash of the changed files, so later edits mark it stale.
5. Report exactly one of **OBSERVED** (evidence path), **NOT VERIFIED** (run impossible: missing engine, crash, empty capture — blocks closure of visual/UI stories by default) or **N/A** (nothing observable, reason given).
- Headless/null-renderer launches are explicitly forbidden because they skip rendering; waiving the run at minimal QA is also forbidden (only tests are waived).

## Tension with our other evidence
Our own sources found headless screenshots unreliable and the Xvfb recipe unverified; the reference relies on `--write-movie` in a windowed run. Both are documented, **neither tested by us** — see [[game-studio-godot-integration]]. A smoke test is still required before this becomes a standard.

## Movie Maker recording — verified addendum (Godot 4.7.2, windowed, real GPU; proposed, unreviewed)
`godot --path . --write-movie out.avi --fixed-fps 60 --quit-after 2700 res://scene.tscn` **worked in a normal window** (not Xvfb): 2700 frames
→ a 45 s AVI, recorded in ≈ 2 min 20 s (≈ 31 % of real time, so budget time), and `ffmpeg -c:v libx264 -pix_fmt yuv420p -crf 23` shrank it to ≈ 3 MB.
Fixed fps makes the physics deterministic per frame; to get a *reproducible* demo, drive the scene with a scripted player using a fixed RNG seed
(here: a bot that aims, picks power and shoots through the same public methods the human controller uses). To check a recording without
watching it, extract frames with `ffmpeg -ss <t> -i video.mp4 -frames:v 1 frame.png` and look at a few. Audio was not checked. Keep the video
out of git (binary); keep the command in the repo.

## Caveat
Model-judged inspection of the frame is itself unmeasured (`unverified`); human review remains for art quality.

## See also
- [[game-studio-acceptance-criteria]] — where the gate is recorded
- [[game-studio-automated-vs-player-quality]] — what a still cannot prove
