---
id: godot-screen-reader-and-input-remapping
type: concept
domain: godot
status: proposed
summary: "Godot 4.7 screen-reader support through AccessKit (accessibility names/descriptions on Controls, auto-enabled when a reader is detected) and runtime InputMap remapping, whose persistence is the game's job."
tags: [dept/ui-ux, dept/qa, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Screen reader page, AccessibilityServer and InputMap class pages (per research subagent; creating_applications and InputMap headers not reported)"
    ref: src-gd-accessibility-logging-debug
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-accessibility-minimums]]"   # remappable controls and non-visual cues
  - relates-to: "[[input-handling]]"   # input actions
  - relates-to: "[[godot-ui-layout-and-themes]]"   # Controls carry the accessibility properties
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7* per research subagent, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine or a build: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Screen reader:** Godot uses AccessKit; support is controlled by `accessibility/general/accessibility_support` (default 0; the labels of its values came from a search result — *unverified mapping*). Set `Control.accessibility_name` and `Control.accessibility_description`. Test on each platform (examples named: NVDA on Windows, VoiceOver on macOS, Orca on Linux). The page lists no limitations or supported-platform list and says good usability takes significant effort. `AccessibilityServer` elements are created automatically for nodes, so manual `create_element()` is generally unnecessary.
- **Runtime remapping with InputMap:** `add_action(action, deadzone = 0.2)`, `action_add_event`, `action_erase_event(s)`, `action_get_events`, `event_is_action(event, action, exact_match = false)`, `load_from_project_settings()` (clears and reloads actions, **discarding runtime changes**). The page does not say whether runtime changes persist across runs, so **saving and restoring bindings must be implemented by the game**.
- Other accessibility features (colour-blind modes, text size, captions) were not checked.

## What an agent can and cannot check
An agent can statically check that accessibility names/descriptions are set on interactive Controls and that actions exist. Reading order and usability need a device with a screen reader and a human.

## See also
- [[game-studio-accessibility-minimums]] — baseline considerations
- [[input-handling]] — input actions
- [[godot-ui-layout-and-themes]] — Controls carry the accessibility properties
