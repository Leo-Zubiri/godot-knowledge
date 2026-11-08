---
id: benchmark-leakage-assertions
type: anti-pattern
domain: godot
status: proposed
summary: Asserting an exact implementation constant (e.g. SPEED==300) that also lives in the knowledge/reference under test leaks the answer, so "knowledge helps" can be an artifact of copying a magic number rather than better code.
aliases: [benchmark leakage, implementation-specific assertions, magic-constant test coupling, overfit evaluation]
sources:
  - claim: "In an A/A'/B generation experiment, every GUT failure was the single exact assertion velocity.x==300.0; the knowledge note hard-codes SPEED:=300, so the condition with knowledge passed by copying that constant while a valid SPEED=200 failed only that assertion."
    ref: src-h06-platformer-experiment
    retrieved: 2026-11-08
related:
  - relates-to: "[[characterbody2d-movement]]"   # the note whose SPEED:=300 constant the test happened to assert
  - relates-to: "[[knowledge-availability-vs-application]]"  # this false signal vs. what blind evaluation actually measured
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

## Summary
When an executable test asserts an **exact implementation-specific value** (a magic constant, a precise speed, an
arbitrary threshold) that **also appears in the knowledge or reference being evaluated**, the test leaks the answer. A
knowledge-assisted run can then "win" simply by copying that constant — not by producing better code. Prefer
**behavioral** assertions and guaranteed **holdout independence**.

## The anti-pattern
You evaluate whether a knowledge base improves generated code by running an executable suite, and a test asserts an
exact literal — e.g. `assert velocity.x == 300.0`. The same literal (`const SPEED := 300.0`) lives in the knowledge note
the "knowledge" condition reads. Runs that read the note copy `300`; runs without it pick an equally-valid value (e.g.
`200`) and fail **only** that assertion. The headline ("knowledge → 5/5 vs 0/5") looks decisive but measures
**constant-matching**, not correctness. This is general evaluation methodology; the example here is Godot/GDScript.

## Why it fails
- **It measures memorization, not quality.** The failing output is often fully correct behavior with a different
  constant; a visual/behavioral check shows it working.
- **It manufactures a false positive for the knowledge base.** The apparent benefit is leakage between the test's
  reference implementation and the knowledge under test, not an effect of the knowledge's content.
- **It hides the real signal.** When this experiment's blind, test-unaware quality evaluation was consulted, the
  conditions were effectively tied — the executable "win" did not correspond to higher-quality code.

## The fix
- **Assert behavior, not implementation constants:** e.g. "moves right" / "speed > 0" / "position increases
  monotonically," not `velocity.x == 300`.
- **Randomize or parameterize** any constant the task legitimately needs, so it cannot be memorized from a note.
- **Guarantee holdout independence:** no test may assert a literal that appears verbatim in the knowledge under test;
  keep the test's reference implementation and the knowledge decoupled.
- **Weight blind/behavioral evidence** over exact-match executable checks when judging a knowledge base's value.

## Limitations of the evidence
Based on a **single, exploratory N=5 experiment** (preserved source `src-h06-platformer-experiment`); not statistically
significant and not generalized. The methodological lesson is widely applicable, but this note remains `proposed`
pending human review and corroboration.

## See also
- [[characterbody2d-movement]] — the note whose SPEED:=300 constant the test happened to assert
- [[knowledge-availability-vs-application]] — this false signal vs. what blind evaluation actually measured
