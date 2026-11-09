---
id: game-studio-third-party-addon-knowledge
type: pattern
domain: agent-ops
status: proposed
summary: Treat addon knowledge as separate, version-pinned skills researched from the tagged release source, with cited API facts and an explicit C# parity decision.
tags: [scope/reference-study, tool/godot]
sources:
  - claim: "Addon skills pin addon and minimum Godot version, research from the release tag, record dated notes with source citations, decide C# parity from what ships"
    ref: src-gs-gp-skill-architecture
    retrieved: 2026-11-08
  - claim: "Addon eval gains were small; the project concludes its edge is recency, not addon knowledge"
    ref: src-gs-gp-evals
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-godot-skill-taxonomy]]"   # addon skills are a distinct kind
  - relates-to: "[[game-studio-version-aware-godot-knowledge]]"   # same versioning discipline
  - relates-to: "[[game-studio-licensing-risks]]"   # addon licences differ per addon
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** derived from a *reference architecture* (GodotPrompter, MIT) studied for patterns only — not adopted, not copied, not a dependency. Claims are repo-**documented (D)** or **project-reported (P)**; none were tested by us. Our design rationale is *proposal*, pending human review.


## Pattern (documented in the reference; **adapt**)
1. Header pins the **addon version** and its **minimum Godot version** (may exceed the baseline).
2. Research from the **tagged release source**, not live documentation, which often describes unreleased APIs.
3. Keep a **dated notes file** with a source citation for each API fact.
4. Decide **C# parity** from what the addon actually ships; use a reasoned "not applicable" marker for gaps.
5. Keep addon content separate from core skills; test that the agent picks the addon skill rather than the core one next to it (the reference's test plan has such a category).
6. Record the **licence** of each addon (the reference does so in headers; not audited by us — `unverified`).

## Caveat
Addon eval gains were small (+0.11 on two addon cases, P) and several were at ceiling: addon skills should justify their size by measured benefit before they are added.

## See also
- [[game-studio-licensing-risks]] — licence axes
- [[game-studio-godot-skill-taxonomy]] — addon skills are a distinct kind
- [[game-studio-version-aware-godot-knowledge]] — same versioning discipline
