---
id: src-gd-engine-license-copyright-api
type: source
kind: hands-on-verification
domain: godot
retrieved: 2026-11-10
engine: "Godot 4.7.2.stable.mono, Mobile renderer"
method: "ran in-engine (headless + xvfb real display), inspected return values and rendered output"
---

# Source — `Engine` runtime licence/copyright API (hands-on, Godot 4.7.2)

**Not a web page.** This records what a small `About/Licenses` implementation actually returned and rendered when
executed in Godot 4.7.2 (Mobile), headless and under a real `xvfb` display. Method **signatures and return shapes are
confirmed by execution**, not by reading the class reference this session. Nothing here is legal advice.

## What was called and what it returned
- `Engine.get_license_info()` → **`Dictionary`** mapping a component name (`String`) to its full licence **text**
  (`String`). Iterating the keys and rendering `name + text` produced real third-party licence blocks — observed:
  **Godot's Apache-2.0**, a **BSD-2-clause**, and further engine third-party components. (So the engine already carries
  the text needed to discharge its own and its dependencies' notices.)
- `Engine.get_copyright_info()` → **`Array`** of parts; each part is a `Dictionary` with a **`"name"`** key (and nested
  `"parts"`). `part.get("name", "")` yielded one line per component — usable for a short copyright strip.
- Reading project add-on licences: `DirAccess.open("res://addons")` + `d.get_directories()`, then
  `FileAccess.file_exists()` / `FileAccess.get_file_as_string()` on `res://addons/<addon>/LICENSE[.txt|.md]`, returns the
  bundled add-on licence text at runtime. Works from `res://` without an `.import` step for plain text files.

## Also in the family (documented, NOT exercised here — treat as unverified)
- `Engine.get_license_text()` → the engine's own **MIT** licence as a single `String`.
- `Engine.get_author_info()`, `Engine.get_donor_info()` → credits data (names only verified to exist by the docs, not
  run this session).

## Rendering note (observed)
The collected `{name, text}` list rendered fine inside a scrollable text control (a `ScrollContainer` /
`RichTextLabel`-style surface) filling the panel; licence bodies are long, so the screen needs scrolling and a back
affordance. A `Control` built this way is navigable by keyboard/gamepad and is natively touch-capable.

## What this source does and does not establish
**Establishes (by execution):** the three collection calls above exist, their return shapes, and that they yield real
licence text at runtime in 4.7.2. **Does not establish:** the exact per-method docs wording, the full set of keys in
each copyright part, `get_license_text/author/donor` behaviour, or any legal sufficiency of the resulting screen.
Re-read the Godot 4.7 `Engine` class reference to promote the unverified items.
