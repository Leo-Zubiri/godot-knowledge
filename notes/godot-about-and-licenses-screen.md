---
id: godot-about-and-licenses-screen
type: reference
domain: godot
status: proposed
summary: "Build an in-app About/Licenses screen in Godot from the engine's own runtime API: Engine.get_license_info() (component → licence text), Engine.get_copyright_info() (copyright parts), plus reading res://addons/*/LICENSE at runtime; render the collected text in a scrollable, focus-navigable Control. This discharges the engine's and add-ons' notice obligations."
tags: [dept/ui-ux, dept/delivery, tool/godot, scope/licensing]
applies-to:
  min: "4.0"
  tested: "4.7.2 (API shapes confirmed by execution; see source)"
sources:
  - claim: "Engine.get_license_info() returns a Dictionary {component: licence text}; Engine.get_copyright_info() returns an Array of parts each with a 'name'; res://addons/*/LICENSE[.txt|.md] is readable at runtime via DirAccess/FileAccess; the collected list renders in a scrollable Control and showed Godot's Apache-2.0 and a BSD-2-clause"
    ref: src-gd-engine-license-copyright-api
    retrieved: 2026-11-10
related:
  - relates-to: "[[game-studio-font-licensing-and-sourcing]]"   # OFL/Apache fonts are discharged by exactly this screen
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # the screen is where bundled-asset notices surface
  - relates-to: "[[godot-ui-layout-and-themes]]"   # the Control/Theme surface the screen is built on
  - relates-to: "[[godot-ui-focus-and-gamepad-navigation]]"   # long text + back button must be focus-navigable
created: 2026-11-10
updated: 2026-11-10
created_by_type: agent
---

> **Evidence status:** the collection API below was **exercised in Godot 4.7.2** (headless + real `xvfb` display) and
> rendered real licence text — shapes confirmed by execution, not by reading the class ref this session (see
> [[src-gd-engine-license-copyright-api]]). Items marked *unverified* (e.g. `get_license_text`) were not run. Status
> `proposed`; **not legal advice.**

## Why this screen exists
Shipping a game redistributes the engine (MIT) and usually add-ons and assets under **OFL / Apache / BSD / MIT**, all of
which require their notice/licence text to travel with the product. An in-app **About / Licenses** screen is the cheap,
standard way to discharge every one of those at once — the same screen that discharges OFL/Apache **fonts**
([[game-studio-font-licensing-and-sourcing]]) and bundled-asset notices
([[game-studio-asset-license-and-provenance-policy]]). The engine hands you most of the text for free.

## Collecting the text (engine + add-ons)
- **`Engine.get_license_info()` → `Dictionary` `{component: text}`** — iterate the keys; each value is a full licence
  body for an engine component/dependency (Godot's **Apache-2.0**, a **BSD-2-clause**, etc. observed). This alone covers
  the engine and its third-party code.
- **`Engine.get_copyright_info()` → `Array`** of parts, each a `Dictionary` with a **`"name"`** (and nested `"parts"`) —
  use `part.get("name", "")` for a compact one-line-per-component copyright strip.
- **Add-ons:** walk `res://addons/` with `DirAccess.open(...).get_directories()`, and for each addon read the first of
  `LICENSE`, `LICENSE.txt`, `LICENSE.md` via `FileAccess.get_file_as_string()` (plain text is readable from `res://`
  with no `.import` step). Append `{name: "addon: <x>", text: ...}`.
- Return the merged, name-sorted `Array` of `{ "name": String, "text": String }` from a static helper; **keep collection
  data-only and let the screen render it** (testable headless: assert the list is non-empty and includes the engine).
- *Also available, unverified here:* `Engine.get_license_text()` (engine's own MIT text as one `String`),
  `Engine.get_author_info()`, `Engine.get_donor_info()`.

## Rendering it
- Feed the list into a **`ScrollContainer` + `RichTextLabel`/`Label`** that fills the panel — licence bodies are long, so
  scrolling and a **Back** control are mandatory. Build the panel as a normal themed `Control`
  ([[godot-ui-layout-and-themes]]); it is then keyboard/gamepad-navigable (grab focus on the scroll region or Back —
  [[godot-ui-focus-and-gamepad-navigation]]) and natively touch-capable.
- Labels/titles should use **i18n keys**; the licence bodies themselves are legal text and stay verbatim (untranslated).

## What an agent can and cannot check
**By reading files/running:** that a licenses screen exists and is reachable from the menu; that `collect()` returns a
non-empty list including the engine and every bundled add-on that has a `LICENSE*`; that each `addons/<x>/` with code has
a licence file. **Needs a human / legal judgement:** whether the screen is legally *sufficient*, whether every asset
(fonts, audio, art) that needs a notice is actually represented, and the precise wording obligations of each licence.

## See also
- [[game-studio-font-licensing-and-sourcing]] — OFL/Apache fonts are discharged by this very screen
- [[game-studio-asset-license-and-provenance-policy]] — where bundled-asset notices must surface
- [[godot-ui-layout-and-themes]] · [[godot-ui-focus-and-gamepad-navigation]] — the Control/Theme/focus surface it is built on
- [[src-gd-engine-license-copyright-api]] — the hands-on verification backing this note
