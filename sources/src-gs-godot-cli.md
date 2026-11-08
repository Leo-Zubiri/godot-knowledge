---
id: src-gs-godot-cli
type: source
domain: game-studio
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/editor/command_line_tutorial.html"
  title: "Godot command line tutorial"
  retrieved: 2026-11-08
  version: "4.7 (4.7.2-stable, 2026-08-18)"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- `--headless`: headless display driver, Dummy audio; intended for servers/`--script`; export docs say required on GPU-less CI.
- `--script/-s`: runs a `.gd` extending `SceneTree` or `MainLoop`. `--check-only` (with `--script`): parse for errors and exit.
- `--import`: open editor, import resources, quit. `--export-release` / `--export-debug <preset> <path>`; `--export-debug` implies `--import`.
- `--write-movie <file>` forces `--fixed-fps`; `--quit-after N` sets frame count. `--path` = project dir.
- `--rendering-driver`, `--rendering-method` (`forward_plus`, `mobile`, `gl_compatibility`); `--debug-server <uri>`; `--remote-debug <uri>`.
- Latest stable per GitHub API: 4.7.2-stable, 2026-08-18 (https://api.github.com/repos/godotengine/godot/releases/latest).
