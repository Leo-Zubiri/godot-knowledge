---
id: game-studio-automated-vs-player-quality
type: concept
domain: game-studio
status: proposed
summary: Passing tests and a captured still do not establish player-facing quality; timing, responsiveness, animation and audio sync need manual playtest.
tags: [scope/reference-study, dept/qa]
sources:
  - claim: "Reference states what a still shows and cannot show, and keeps feel checks manual"
    ref: src-gs-ccgs-qa-evidence
    retrieved: 2026-11-08
  - claim: "Reference regression rule: a test never seen failing proves nothing"
    ref: src-gs-ccgs-qa-evidence
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-playtesting-methods]]"   # playtesting methods and the limits of sample-size models
  - relates-to: "[[game-studio-evidence-driven-visual-qa]]"   # the evidence gate this qualifies
  - relates-to: "[[game-studio-acceptance-criteria]]"   # human gates
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


## The idea
Three layers must stay separate: **(1) automated technical checks** (parse, import, unit/integration tests), **(2) observed evidence** (rendered capture inspected against criteria), **(3) player-facing quality** (feel: timing, responsiveness, animation, audio sync, fun). The reference documents that a still shows layout, clipping, colour and legibility but not (3), and leaves feel to human QA.

## Rules worth keeping (D; **adopt**)
- A regression test must be observed failing on the unfixed code, then passing; a pass alone is not proof the test works (a weak fixture can pass against the bug).
- Performance tests state thresholds and fail when exceeded.
- Report unknowns as unknown (see [[game-studio-review-modes-and-verdicts]]).

## For us (proposal)
Never describe "tests pass" or "screenshot captured" as "good game feel"; keep a human playtest gate and record what was *not* verified.

## See also
- [[game-studio-evidence-driven-visual-qa]]
- [[game-studio-acceptance-criteria]] — human gates
- [[game-studio-playtesting-methods]] — playtesting methods and the limits of sample-size models
