---
id: game-studio-godot-example-verification
type: concept
domain: agent-ops
status: proposed
summary: Code examples in Godot skills need real parsing/compilation against a pinned engine version; a README claim that examples were verified is not evidence without a repeatable check.
tags: [scope/reference-study, dept/qa, tool/godot]
sources:
  - claim: "Validator does not invoke Godot/dotnet; contributors check examples manually; README claims parsed/compiled against 4.7.2"
    ref: src-gs-gp-repo-overview
    retrieved: 2026-11-08
  - claim: "C# examples compiled against two SDK versions once; nothing run inside a game; GDScript examples not compiled/executed"
    ref: src-gs-gp-evals
    retrieved: 2026-11-08
  - claim: "Godot offers a documented headless parse check usable for GDScript"
    ref: src-gs-gp-validation-ci
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-skill-validation-architecture]]"   # the layer that is missing there
  - relates-to: "[[game-studio-godot-integration]]"   # Godot CLI mechanisms
  - relates-to: "[[godot-version-policy]]"   # pin the engine version used for checks
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (GodotPrompter, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale is *proposal*, pending human review.


## The idea
Distinguish three levels of "verified example": (1) **parses** (GDScript syntax/type parse), (2) **compiles** (C# against a pinned SDK), (3) **runs and behaves** inside a game. The reference documents a manual practice and a one-off C# compile against two SDK versions (P) and claims all examples were parsed/compiled since v1.15.1, but **no repeatable script or CI step was found** — treat that claim as `unverified`. Nothing runs examples in a game.

## Findings that motivate it
The project's own fact-checking found real mistakes in skills (a claim that omitting `EventHandler` compiles — it does not; a nonexistent `AsTask()` call; a wrong version for a fog change), showing that unverified examples drift into wrong guidance.

## For us (proposal)
- Run a headless parse check (`godot --headless --script <f> --check-only`, documented — see [[game-studio-godot-integration]]) against a **pinned** 4.7.x for GDScript examples; `dotnet build` against the matching SDK for C#, if C# is shipped.
- Extract examples mechanically from skills/notes so the check is repeatable in CI.
- State what passes mean: parse/compile only; behaviour still needs tests ([[game-studio-automated-vs-player-quality]]).
- Not measured: cost and failure rate of such checks.

## See also
- [[game-studio-skill-validation-architecture]] — where this layer fits
- [[godot-version-policy]] — pin the engine version used for checks
