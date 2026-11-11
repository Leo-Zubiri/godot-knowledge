---
id: godot-localization-workflow
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 localization: gettext PO/MO first (CSV unread), tr() with context and plurals, font fallbacks, RTL, and testing with --language or Preview Translation."
tags: [dept/game-dev, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Internationalizing games and gettext pages for Godot 4.7; CSV import page returned 404"
    ref: src-gd-localization
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-ui-layout-and-themes]]"   # fonts and longer strings
  - relates-to: "[[game-studio-accessibility-minimums]]"   # subtitles and text size
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7*, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Setup:** register translations in Project Settings > Localization; Remaps swap assets per locale; fallback is the fallback locale or `en`. Button/Label translate keys automatically (disable Auto Translate for names); code uses `tr()`; `TranslationServer` switches locale at runtime.
- **Grammar:** named placeholders via `.format()`; context as `tr()`'s second argument; `tr_n()` for plurals (non-negative integers only).
- **Gettext:** `.po` and binary `.mo`; POT template generated or hand-written; plurals `msgid_plural`/`msgstr[n]`; `msgctxt` for context; tools `msginit`, `msgmerge`, `msgfmt --check`; `.pot` `msgstr` stays empty; regenerate after adding strings; fuzzy strings are ignored until reviewed; the extraction plugin reads constant strings only; keep `.po` in version control.
- **Pitfalls:** default font covers only part of Latin-1 (use e.g. Noto via a Theme); remaps do not work with DynamicFonts (use font fallback); UI must fit longer strings (pseudolocalization); Arabic/Hebrew mirror most UI but icons and non-UI nodes need manual handling; languages without spaces need break-iterator data (~4 MB); Locale Test must be empty before committing.
- **Testing:** editor Preview Translation, or `godot --language fr`.
- CSV import: page returned 404 — format and options **unverified**.
- **Verified in-engine 2026-11-10 (Godot 4.7.2):** `.po` files listed in `project.godot` under
  `internationalization/locale/translations=PackedStringArray("res://…/en.po", …)` load at runtime with **no
  separate `.import` file** (Godot reads the `.po` straight from the setting), so a key-based catalog works headless;
  `TranslationServer.set_locale("es")` then `tr("KEY")` returns the translated string live. `TranslationServer.
  pseudolocalization_enabled = true` toggles the **built-in** pseudolocalization and transforms the returned text
  (so overflow/missing-key detection needs no external tool). A **toolchain-free key-coverage check** (no gettext):
  parse `msgid`/`msgstr` from each `.po` and assert every `.pot` key is present and non-empty in each locale — this
  is runnable in a unit test and in CI without `msgfmt`.

## What an agent can and cannot check
An agent can run `msgfmt --check`, compare keys across locale files, grep scripts for hard-coded UI strings and for `tr()` calls with computed keys (the extractor skips them). Translation quality and truncation need a native reviewer.

## See also
- [[godot-ui-layout-and-themes]] — fonts and longer strings
- [[game-studio-accessibility-minimums]] — subtitles and text size
