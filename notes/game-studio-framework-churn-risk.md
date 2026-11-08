---
id: game-studio-framework-churn-risk
type: concept
domain: game-studio
status: proposed
summary: Fast-moving agent frameworks show instability signals (rapid fix releases, doc/count drift, popularity anomalies); pin versions, test skills, and avoid mandatory dependencies.
sources:
  - claim: "CCGS release timeline: fix releases within days of 1.1.0, long skills losing steps after compaction, skills failing before start outside auto mode"
    ref: src-gs-ccgs-repo-overview
    retrieved: 2026-11-08
  - claim: "Documentation drift: counts differ between README, About text and file tree"
    ref: src-gs-ccgs-repo-overview
    retrieved: 2026-11-08
  - claim: "Skill quality rubric run by a skill-test command (whether automated is unverified)"
    ref: src-gs-ccgs-workflow-rigor-and-gates
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-artcraft-evaluation]]"   # same caution applies to very young tools
  - relates-to: "[[gs-adr-no-extra-orchestration-framework]]"   # no mandatory framework dependency
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


## Signals seen (documented in releases; interpretation is ours)
- v1.1.0 (2026-09-23) was followed by fixes in v1.1.1 (skills/agents failing before start outside auto mode), v1.1.2 and v1.1.3 (long skills losing later steps after compaction) within about two weeks.
- Skill count 72 vs 74 and hook count 15 vs 18 files across documents; ~37k stars for a solo-author repo under nine months old (anomaly; manipulation not checked); no CI workflows in the repository.
- The project does ship a skill-quality rubric and test command — useful idea (**adapt**) — but whether it runs automatically is unverified.

## Counter-example signals (GodotPrompter)
A second reference shows the opposite discipline: release workflow blocks on version drift across manifests and runs a validator self-test; install by tag is documented for OpenCode. It still has gaps (a README claim that examples were compiled has no repeatable check found) — see [[game-studio-skill-validation-architecture]].

## Proposal
Treat such frameworks as *references*, not dependencies. If any component is ever used, pin by commit, test skills after each upgrade, and keep our architecture independent of it.

## See also
- [[game-studio-artcraft-evaluation]] — comparable maturity caution
