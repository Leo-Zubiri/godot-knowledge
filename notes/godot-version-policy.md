---
id: godot-version-policy
type: guide
domain: godot
status: proposed
summary: How this knowledge base scopes Godot versions — pin a full patch, cite version-matched docs, and never silently generalize one version's behavior.
aliases: [version policy, which godot version, 4.7.2, pinning]
sources:
  - claim: "Only the latest patch of a stable minor is supported; minors add features, patches are compat-safe fixes."
    ref: src-release-policy
    retrieved: 2026-11-06
    version: "4.7"
  - claim: "Godot 4 made broad breaking changes vs Godot 3 (e.g. yield→await, KinematicBody→CharacterBody); migration needs manual review."
    ref: src-upgrading-godot-4
    retrieved: 2026-11-06
    version: "4.7"
related:
  - relates-to: "[[gdscript-static-typing]]"   # an example of a version-scoped claim (applies-to)
created: 2026-11-06
updated: 2026-11-06
created_by_type: agent
---

## Goal
Keep Godot knowledge **trustworthy across versions**: make every version-dependent claim explicit, and keep the
experimental environment reproducible.

## Prerequisites
- Familiarity with the `applies-to` frontmatter field (see [`meta/methodology/metadata.md`](../meta/methodology/metadata.md)).

## Steps
1. **Pin the experimental environment to a full patch version** — currently **Godot 4.7.2 (stable)**. Only the latest
   patch of a minor is supported, so pin the exact patch, not just "4.x".
2. **Cite version-matched docs.** Link `https://docs.godotengine.org/en/4.7/…`, not the floating `/en/stable/` or
   `/en/latest/` (those change meaning when a new version ships).
3. **Tag each note's applicability** with `applies-to` (`min` / `tested`). A note tested on 4.7.2 says so.
4. **Do not silently generalize.** If behavior is known to differ across versions (e.g. Godot 3 vs 4), state it; don't
   assume 4.7.2 behavior holds for all of 4.x or for 3.x.
5. **Record the engine build** (version + build hash) in experiment metadata when a claim is validated by running Godot.

## Notes & pitfalls
- The repo's *experimental environment* (4.7.2) is narrower than its *knowledge scope*: notes **may** describe other
  versions, but must mark compatibility explicitly.
- For 3→4 differences, consult the migration source ([[gdscript-signals]] and others flag the 4-only syntax).

## See also
- [[gdscript-static-typing]] — uses `applies-to` to scope its claims
- [`meta/methodology/metadata.md`](../meta/methodology/metadata.md) — the `applies-to` field
