---
id: game-studio-skill-eval-design
type: pattern
domain: game-studio
status: proposed
summary: Evaluate whether a skill earns its tokens with with/without-skill ablations, keeping 'ceiling' cases as routing checks, and distinguishing grader noise from model error.
tags: [scope/reference-study, dept/qa]
sources:
  - claim: "Ablation method, discriminating vs ceiling cases, judge, three runs per case, results and stated limits"
    ref: src-gs-gp-evals
    retrieved: 2026-11-08
  - claim: "Manual test plan with probabilistic cases to be repeated"
    ref: src-gs-gp-platforms-and-hooks
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-untrusted-content-and-headless-runs]]"   # grader tips and untrusted-output rules
  - relates-to: "[[benchmark-leakage-assertions]]"   # avoid asserting constants the skill itself supplies
  - relates-to: "[[knowledge-availability-vs-application]]"   # measure mediation, not just availability
  - relates-to: "[[game-studio-skill-validation-architecture]]"   # behaviour layer above structural checks
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (GodotPrompter, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale is *proposal*, pending human review.


## Pattern (documented by the reference; **adapt**)
- Run each case **with and without** the skill in an empty workspace (no routing card), several runs per case, graded by a rubric/judge.
- Tag cases **discriminating** (arms differ) or **ceiling** (both pass; kept only as routing checks).
- Include cases targeting **recent changes** where the bare model may be wrong.
- Record **limits**: noisy judging, rubric flips between runs, failures caused by grader wording rather than model error, changed-but-not-rerun cases.

## Reported numbers (project-reported, small samples, Sonnet judge — not verified)
pilot +0.07; Godot 4.7 cases +0.69; pre-release regression +0.24 across 14 cases (cost stated as $21.72 by the project); one case −0.07; rendering +0.42. Treat as illustrative, not as benchmarks.

## Caution for us
Our own repo already learned that an assertion matching a constant present in the knowledge under test leaks the answer ([[benchmark-leakage-assertions]]) and that availability is not application ([[knowledge-availability-vs-application]]). Evals must be designed to avoid both. Model-judged scores are themselves unmeasured for reliability.

## See also
- [[game-studio-skill-validation-architecture]]
- [[game-studio-untrusted-content-and-headless-runs]] — grader tips and untrusted-output rules
