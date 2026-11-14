---
id: godot-ui-focus-and-gamepad-navigation
type: concept
domain: godot
status: proposed
summary: "Focus must be grabbed explicitly for gamepad/keyboard UI; unset neighbours are guessed; labels default to no focus and a hidden node loses focus."
tags: [dept/ui-ux, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Focus navigation page for Godot 4.7 (per research subagent)"
    ref: src-gd-ui-layout-themes
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-ui-layout-and-themes]]"   # layout context
  - relates-to: "[[input-handling]]"   # UI actions
created: 2026-11-08
updated: 2026-11-13
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- Any Control can take focus; neighbours are set in the Inspector, and **unset ones are guessed by the engine** (unpredictable in complex layouts).
- Labels default to focus mode None, buttons to All.
- Call `grab_focus()` at scene start (deferred in `_ready()`), otherwise key/button presses do nothing; a hidden node loses focus.

## Deferred focus on a UI that rebuilds itself — hands-on (4.7.2, proposed, unreviewed)
If a panel clears and rebuilds its children (a lobby that repaints on every network event), `call_deferred("grab_focus")` on a control found *before* the deferral can run after
a second rebuild has already removed that control: the engine prints `ERROR: Condition "!is_inside_tree()" is true`. Defer a **method that looks the target up when it runs**
(`first_focusable(self)`, then check `is_inside_tree()` and `is_visible_in_tree()` before `grab_focus()`), and coalesce requests with a "pending" flag so many rebuilds in one
frame produce one focus call. Also skip it when the panel itself is not visible.

## What an agent can and cannot check
An agent can check that `grab_focus()` and focus neighbours exist by reading scripts/`.tscn`; navigation feel needs a human with a gamepad.

## See also
- [[godot-ui-layout-and-themes]] — layout context
- [[input-handling]] — UI actions
