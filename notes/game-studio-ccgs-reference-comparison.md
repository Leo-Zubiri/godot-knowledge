---
id: game-studio-ccgs-reference-comparison
type: reference
domain: agent-ops
status: proposed
summary: Classification (adopt/adapt/reference-only/reject/unverified) of Claude-Code-Game-Studios patterns against our Godot/Blender/ComfyUI studio, with licence scope and repo split.
tags: [scope/reference-study]
sources:
  - claim: "Repo facts, licence scope, releases, config model, project-reported comparison"
    ref: src-gs-ccgs-repo-overview
    retrieved: 2026-11-08
  - claim: "Rigor, gates and skills"
    ref: src-gs-ccgs-workflow-rigor-and-gates
    retrieved: 2026-11-08
  - claim: "Agent topology and model tiers"
    ref: src-gs-ccgs-agent-topology
    retrieved: 2026-11-08
  - claim: "Safety, hooks and session lifecycle"
    ref: src-gs-ccgs-safety-and-session
    retrieved: 2026-11-08
  - claim: "Visual evidence and test standards"
    ref: src-gs-ccgs-qa-evidence
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-architecture-proposal]]"   # feeds the overall proposal
  - relates-to: "[[game-studio-multiagent-topology]]"   # topology classification
  - relates-to: "[[game-studio-configurable-rigor]]"   # rigor classification
  - relates-to: "[[game-studio-evidence-driven-visual-qa]]"   # evidence classification
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


## Scope and licence
MIT (copyright holder "Donchitos 2026"); the licence text does not address third-party/bundled assets, so MIT does not by itself settle that. Claude-Code-only by design (hooks, model pins, skill overrides, status line); not covered at all: Blender, ArtCraft, ComfyUI, asset provenance. Godot is supported (5 specialists, gdUnit4, parse check, naming checks for Godot `assets/`); Unity/Unreal parts are dead weight for us.

## Classification
| Pattern | Class | Why |
|---|---|---|
| Responsibility boundaries with escalation to shared parent | adapt | Useful; our departments differ; plain-text rules for portability → [[game-studio-delegation-boundaries]] |
| 49-role roster, other-engine specialists | reject | No evidence it pays off for our case → [[game-studio-multiagent-topology]] |
| Strong model for gates, cheaper for implementation | adapt | Claude-specific pins; portable idea only |
| Gate IDs + phase-gate command | adapt | Thin script recording a verdict → [[game-studio-review-modes-and-verdicts]] |
| 7-phase catalogue (`workflow-catalog.yaml` not read) | reference-only | Insufficient evidence |
| 70+ skills; skill-name shadowing | reject | Brittle (fix releases) → [[game-studio-framework-churn-risk]] |
| Skill-quality rubric / `/skill-test` | adapt | Regression checks for our skills; automation unverified |
| One rigor dial → knobs, default minimal | adopt (dial: adapt) | → [[game-studio-configurable-rigor]] |
| solo/lean/full review modes, NOT ASSESSED ≠ pass | adopt | → [[game-studio-review-modes-and-verdicts]] |
| 30-document standard flow as default | reject | Reported worse outcome (P) |
| Per-task token budgets | reference-only | Unmeasured |
| Deny-list of destructive commands | adopt | + Godot paths → [[game-studio-path-scoped-safety]] |
| Warn-only hooks | adapt | Block a few; mirror in CI |
| Subagent audit hooks / toast hook | reference-only / reject | Claude events / Windows only |
| Session checkpoint file, rotation | adopt | Portable → [[game-studio-session-lifecycle]] |
| Scripts over reading, read guard | adapt | → [[game-studio-token-efficient-workflows]] |
| Launch, capture, retain, staleness hash | adopt | → [[game-studio-evidence-driven-visual-qa]] |
| OBSERVED / NOT VERIFIED / N/A | adopt | Same note |
| Regression test must fail first | adopt | → [[game-studio-automated-vs-player-quality]] |
| "A still does not prove feel" | adopt | Same note |
| Model-judged visual inspection as pass criterion | unverified | Reliability unmeasured |

## Scope of this repo
`godot-knowledge` keeps the principles, patterns, decisions and this comparison. Concrete implementations (skills, scripts, config schema) are out of scope here; if built elsewhere they should be reimplemented from these paraphrased designs — no CCGS code copied, no mandatory dependency.

## Open
Agent definitions, individual skills, rules (other than test standards), roster path (404 at the guessed location), `workflow-catalog.yaml`, whether the repo's tests run anywhere, star-count anomaly.

## See also
- [[game-studio-architecture-proposal]] — overall proposal
