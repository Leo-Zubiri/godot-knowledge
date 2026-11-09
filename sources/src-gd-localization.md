---
id: src-gd-localization
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/i18n/internationalizing_games.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/i18n/internationalizing_games.html"
    - "https://docs.godotengine.org/en/stable/tutorials/i18n/localization_using_gettext.html"
  title: "Godot 4.7 localization: internationalizing games and gettext"
  retrieved: 2026-11-08
  version: "4.7 (headers reported by subagent); CSV import page returned 404"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official Godot documentation pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**. **Version:** page headers say *Godot Engine 4.7 documentation* — confirmed by the main agent on the pages listed under "re-read", reported by research subagents for the others; pages carrying their own "may be outdated for 4.7" notice are flagged. Documentation only: nothing here was run in the engine, so behaviour claims are *documented*, not *experimentally validated*. Re-fetch before promoting dependent notes to `verified`.

- **Setup:** register translations in Project Settings > Localization > Translations; the Remaps tab swaps assets per locale; fallback uses the locale fallback setting or `en` when empty. **Lookup:** Button and Label translate matching keys automatically (set Auto Translate Mode to Disabled for content such as player names); code uses `tr()`; `TranslationServer` changes locale at runtime. **Grammar:** named placeholders with `.format()` let translators reorder words; context as the second argument of `tr()` separates identical strings; `tr_n()` handles plurals (non-negative integers only).
- **Pitfalls:** the default font covers only part of Latin-1 (use a font like Noto through a Theme); resource remapping does not work with DynamicFonts (use the font fallback system); UI must handle longer strings (pseudolocalization can test); Arabic and Hebrew mirror most UI automatically but directional icons and non-UI nodes need manual handling; languages without spaces need break-iterator data ("Include Text Server Data", ~4 MB); Locale Test must be empty before committing. **Testing:** editor "Preview Translation" or `godot --language fr`.
- **Gettext:** Godot loads `.po` and binary `.mo`; a POT template is generated in Project Settings or written by hand; plurals use `msgid_plural`/`msgstr[n]`; `msgctxt` carries context; tools `msginit`, `msgmerge`, `msgfmt --check`, `msgfmt -o` (binary only recommended for very large projects), `msgunfmt` (loses comments and fuzzy strings); `.pot` `msgstr` must stay empty; regenerate the template after adding strings; fuzzy strings are ignored until reviewed; the extraction plugin reads constant strings only; keep `.po` files in version control.
- CSV import page returned 404, so the CSV format and options are unverified.
