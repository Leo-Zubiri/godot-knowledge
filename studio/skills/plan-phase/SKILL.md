---
name: plan-phase
description: Create or update a dated plan for a Godot project under docs/plans/YYYY-MM-DD_<slug>/ with phases, numbered steps per folder, commands, exit criteria and cited knowledge notes. Use when the user asks for a plan, roadmap, next phase, or when a project profile exists but no active plan.
---

# Plan an initiative in phases

Prerequisite: `docs/project-profile.md` exists (else run `scope-game`).

1. **Folder.** `<plans_dir>/<YYYY-MM-DD>_<slug>/` (date = creation date, ISO). Copy
   `studio/templates/plan.md` → `plan.md`; one `phase-NN-<slug>.md` per phase from `studio/templates/phase.md`.
   Set `active_plan` in the profile.
2. **Shape.** Phases ordered by *what unblocks the next decision*: foundation → decision spikes (throwaway) →
   core → vertical slice → content → identity → export → optional post-v1. Each phase: goal in one sentence,
   roles, notes to consult (ids), numbered steps grouped by folder, commands, exit criteria with evidence, knowledge
   gaps to write back. Guidance: `game-studio-prototype-vs-vertical-slice`, `gs-adr-living-design-docs`.
3. **Scope discipline.** Only modules the current phase forces; extract on second use
   (`godot-reusable-module-packaging`). ≤ 4 roles. Documents ≤ 150 lines except phase files; each with a
   `status / updated / owner` header; ADRs immutable (supersede).
4. **Decisions.** Every architectural choice → `adr_dir/NNNN-<slug>.md` (`studio/templates/adr.md`) citing note
   ids; open choices → marked *open until phase X* with the spike that closes them.
5. **Critique.** Run `studio/checklists/plan-review.md`; add a "Critical review" table (weakness → risk →
   adjustment) to `plan.md` before presenting. Present the plan; ask only blocking questions.
6. **Close a phase.** `review-acceptance` with `studio/checklists/phase-exit.md`; update `plan.md` status table,
   `active.md`, and write back generic findings (`write-back-knowledge`).
