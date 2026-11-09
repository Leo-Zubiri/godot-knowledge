---
name: review-acceptance
description: Review a plan, a phase or a deliverable of a Godot project against the playbook checklists and give an evidence-based verdict. Use when the user asks "is this done?", "review this", or before closing a plan phase.
---

# Review against checklists

Checklists: `$GODOT_KNOWLEDGE_PATH/playbook/checklists/` — `plan-review.md` (before approving a plan),
`phase-exit.md` (closing a phase), `module-extraction.md`, `input-mapping.md`, `purchase-integrity.md`.
Acceptance principles: `game-studio-acceptance-criteria`, `game-studio-review-modes-and-verdicts`.

1. **Pick the checklist** for the object under review; read the phase's own exit criteria too.
2. **Collect evidence**, never impressions: command + literal output, test report, file list, screenshot/movie
   path, note ids cited. If evidence is missing, the item is *not verified*, not "probably fine".
3. **Verdict format** (one line per item): `PASS | FAIL | NOT VERIFIED — <evidence or what is missing>`.
   Then an overall verdict: `ACCEPT`, `ACCEPT WITH FOLLOW-UPS` (list them, each with an owner role), or `REJECT`
   (blocking items first).
4. **Human gates.** Mark items that only a human can accept (visual quality, fun, licence decisions, outward-facing
   actions) as `HUMAN GATE` and do not accept them yourself.
5. **Write back.** Tick the phase checklist with the evidence reference; update `active.md`; route generic
   findings to `write-back-knowledge`.
