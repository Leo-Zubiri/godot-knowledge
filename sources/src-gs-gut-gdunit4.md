---
id: src-gs-gut-gdunit4
type: source
domain: game-studio
source:
  url: "https://github.com/bitwes/Gut ; https://github.com/MikeSchulze/gdUnit4 ; https://gut.readthedocs.io/en/latest/Command-Line.html ; https://godot-gdunit-labs.github.io/gdUnit4/latest/advanced_testing/cmd/"
  title: "GUT and gdUnit4 repos + command-line docs"
  retrieved: 2026-11-08
  version: "GUT 9.7.1 (Godot 4.7.x); gdUnit4 master v7.0.0 (tag unverified)"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- GUT: MIT (README; GitHub API license detection missed it). Pushed 2026-08-18, 2.8k stars. Versions: 9.7.1 for 4.7.x, 9.6.1 for 4.6, 9.5.0 for 4.5, 9.4.0 for 4.3–4.4. CLI: `godot -d -s --path "$PWD" addons/gut/gut_cmdln.gd`; JUnit XML via `-gjunit_xml_file`; exit 0 pass / 1 fail. Input simulation not in README (`unverified`).
- gdUnit4: MIT. Pushed 2026-11-08, 1.3k stars. master v7.0.0 for 4.7/4.7.1/4.8dev; v6.2.x for 4.5–4.7.1; v5.x for 4.3–4.4.1. CLI `./addons/gdUnit4/runtest.sh -a <dir>` with `GODOT_BIN`; JUnit `results.xml` + HTML; exit 0 pass / 100 fail / 101 warnings. Scene runner: mouse, keyboard, touch, actions, signal waits. gdunit4-action on GitHub Marketplace. Releases section empty on repo page — check tags before pinning.
- gdtoolkit (gdlint/gdformat, MIT, https://github.com/Scony/godot-gdscript-toolkit): last push 2025-10-09; 4.7 syntax support `unverified`; README warns gdformat can lose data.
