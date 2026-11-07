---
id: god-autoload
type: anti-pattern
domain: godot
status: unreviewed
summary: Funnelling most game state and logic into one ever-growing Autoload creates a global "god object" that couples everything and resists testing.
aliases: [god object, global singleton abuse, manager autoload]
sources:
  - claim: "Autoloads are globally addressable from any script; this reach is what makes an over-grown autoload couple the whole project."
    ref: src-singletons-autoload
    retrieved: 2026-11-06
    version: "4.7"
related:
  - contradicts: "[[autoload-singletons]]"            # the disciplined use this warns against overusing
  - relates-to: "[[node-vs-resource-vs-autoload]]"    # choosing a narrower home avoids this
created: 2026-11-06
updated: 2026-11-06
created_by_type: agent
---

## The anti-pattern
Because an [[autoload-singletons|Autoload]] is reachable from anywhere by name, it is tempting to keep adding to one
`Game`/`Global` autoload until it holds most state and much of the logic: player data, UI references, enemy registries,
scene flow, audio, settings — all in one node that everything reads and writes.

## Why it fails
- **Hidden, pervasive coupling:** any script can read/write it, so dependencies become implicit and the "blast radius"
  of a change is the whole project.
- **Hard to test or reuse:** a scene that secretly depends on `Global.whatever` can't be exercised in isolation.
- **Ordering/lifetime hazards:** global mutable state accessed from many lifecycle phases invites race-like ordering
  bugs (see [[node-lifecycle-callbacks]]).
- **Growth has no natural limit** — "just add it to Global" is always the path of least resistance.

*(Status `unreviewed`: this is a widely-held community design caution synthesised here; it is editorial guidance rather
than a single official rule, pending human review against primary sources.)*

## Do this instead
- Keep autoloads **narrow and purposeful** ([[autoload-singletons]]): one clear responsibility each.
- Use **signals** ([[gdscript-signals]]) for events instead of poking a global.
- Put reusable data in a **Resource** and pick homes with [[node-vs-resource-vs-autoload]].

## See also
- [[autoload-singletons]] — the disciplined version
- [[node-vs-resource-vs-autoload]] — choosing the least-global home
