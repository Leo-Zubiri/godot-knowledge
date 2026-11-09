---
name: scope-game
description: Scope a new Godot game or a new feature by asking the right questions first. Use when a user says "make a game of X", "add feature Y", or when a project has no docs/project-profile.md. Produces the profile, ASSUMED defaults, open questions and ADR stubs.
---

# Scope a game or a feature

Question bank with rationale, options, defaults and blocking flags: note
`game-design-scoping-questions-for-new-game-or-feature` (read it; do not restate it here).

1. **Read before asking.** `docs/project-profile.md`, existing ADRs, `project.godot`, README. Never ask what the
   repo already answers. Decide: new game (greenfield), feature (brownfield) or re-scope.
2. **Tier 0 (stack-changing).** From the note's Tier 0 table pick the ≤ 5 questions whose answer is both
   irreversible and unknown; ask them in **one** message with 2–4 structured options each and a recommended default.
   Blocking = `yes` → wait; `conditional`/`soft`/`no` → proceed with `ASSUMED:`.
3. **Assume the rest.** Write every unanswered question as `ASSUMED: <question> → <default> (why)` in
   `docs/plans/<date>_<slug>/open-questions.md` (or the profile if no plan exists yet).
4. **Tier 1 (design).** Draft answers with the note's defaults; confirm in batches of ≤ 5; record in the GDD or
   the plan's design section.
5. **Feature variant.** Use the note's feature section: user problem, ADRs touched, affected modules, data/save
   compatibility, tunables, input per device, multiplayer impact, acceptance tests, non-goals; default = smallest
   slice behind a flag.
6. **Write outputs.** `docs/project-profile.md` from `playbook/templates/project-profile.md`; one ADR stub per closed
   Tier 0 answer (`playbook/templates/adr.md`); re-ask triggers noted (new platform, money, > 1 player, external
   service, licence change).
7. **Self-check before presenting** (`playbook/checklists/plan-review.md`): platform? language? money? attribution
   (engine licence text must ship)? native touch? online cost? physics precision? too many modules/agents/docs?

Cite the note id in the profile (`always_notes`) so later sessions reuse it.
