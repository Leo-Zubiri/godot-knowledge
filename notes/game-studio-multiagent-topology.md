---
id: game-studio-multiagent-topology
type: concept
domain: game-studio
status: proposed
summary: A large role hierarchy (directors, leads, specialists) adds coordination overhead; for a Godot studio with a human supervisor a few artifact-producing roles plus a gate role is the proposed starting topology.
sources:
  - claim: "Nine specialized agents that dispatch to skills; no agent-level evidence found"
    ref: src-gs-gp-skill-architecture
    retrieved: 2026-11-08
  - claim: "CCGS defines 49 agents in tiers (3 directors, leads, specialists incl. engine sub-specialists) and 74 skills; project-reported rigor comparison found extra process did not improve the game"
    ref: src-gs-ccgs-repo-overview
    retrieved: 2026-11-08
  - claim: "Coordination rules and model tiers of the reference hierarchy"
    ref: src-gs-ccgs-agent-topology
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-gp-reference-comparison]]"   # second reference: nine thin agents over skills
  - relates-to: "[[game-studio-delegation-boundaries]]"   # how roles hand work and escalate
  - relates-to: "[[gs-adr-no-extra-orchestration-framework]]"   # same minimalism principle
  - relates-to: "[[game-studio-ccgs-reference-comparison]]"   # classification of the reference's patterns
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (Claude-Code-Game-Studios, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale below is *proposal*, pending human review.


## The idea
CCGS (documented) uses a three-tier hierarchy — creative/technical/producer directors, department leads, specialists — with 49 agent definitions, of which many are engine-specific for Unity and Unreal. Each director gate spawns a separate agent whose context starts from its brief only (D). No cost was measured anywhere.

## What it suggests for us (proposal, not measured)
- A 49-role roster is not justified for a Godot-only studio with human supervision: **reject** as a template. The reference's own default (minimal rigor, solo review) already collapses the topology (D).
- Start with the few roles that actually *produce artifacts or decide acceptance* in our workflows: planning, gameplay/Godot programming, technical-art handoff (Blender/Material Maker/ComfyUI), QA, art/visual acceptance, and one technical gate. This count is an inference to test, not a finding.
- Add a role only when a recorded failure shows a missing responsibility.
- Model tiering "stronger model for gates, cheaper for implementation" is worth keeping in a portable form (**adapt**); the pinning mechanism itself is Claude-Code-specific.

## Second reference (GodotPrompter)
A Godot-specific plugin ships nine specialized agents (general implementer, C#, animator, UI, shader, tools, architect, reviewer, profiler) that are thin shells told to read the relevant skill first (D, one agent read). No evidence was found that they outperform skills plus a small set of roles; its own evals test skills, not agents (`unverified` agent-level value). Reinforces: skills carry the knowledge, agents add routing — see [[game-studio-gp-reference-comparison]].

## See also
- [[game-studio-delegation-boundaries]] — responsibility and escalation
- [[game-studio-ccgs-reference-comparison]] — all classifications
