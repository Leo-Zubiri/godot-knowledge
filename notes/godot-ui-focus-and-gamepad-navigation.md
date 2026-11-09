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
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- Any Control can take focus; neighbours are set in the Inspector, and **unset ones are guessed by the engine** (unpredictable in complex layouts).
- Labels default to focus mode None, buttons to All.
- Call `grab_focus()` at scene start (deferred in `_ready()`), otherwise key/button presses do nothing; a hidden node loses focus.

## What an agent can and cannot check
An agent can check that `grab_focus()` and focus neighbours exist by reading scripts/`.tscn`; navigation feel needs a human with a gamepad.

## See also
- [[godot-ui-layout-and-themes]] — layout context
- [[input-handling]] — UI actions
