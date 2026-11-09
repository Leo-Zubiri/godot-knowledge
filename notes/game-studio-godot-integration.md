---
id: game-studio-godot-integration
type: reference
domain: game-studio
status: proposed
summary: "Godot as the integration and final authority: CLI/headless operations, testing, screenshot limits, and where MCP servers fit."
tags: [dept/game-dev, dept/qa, tool/godot]
sources:
  - claim: "Godot CLI flags, headless, export, write-movie"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
  - claim: "Headless renderer cannot produce screenshots; Xvfb recipe unverified"
    ref: src-gs-godot-headless-render-limit
    retrieved: 2026-11-08
  - claim: "Godot MCP servers' editor requirement and runtime tools"
    ref: src-gs-godot-mcp-servers
    retrieved: 2026-11-08
  - claim: "gdUnit4/GUT CLI, reports, input simulation"
    ref: src-gs-gut-gdunit4
    retrieved: 2026-11-08
  - claim: "3D import: suffixes, post-import, retargeting"
    ref: src-gs-godot-3d-import
    retrieved: 2026-11-08
related:
  - depends-on: "[[game-studio-readiness-classification]]"   # readiness flags used
  - relates-to: "[[game-studio-acceptance-criteria]]"   # validation steps feed acceptance
  - relates-to: "[[game-studio-blender-pipeline]]"   # assets arrive via GLB import
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** documentary research only (2026-11-08); nothing was installed or executed. Items marked `unverified` were not confirmed on an official page. Ratings are *preliminary recommendations*, not approved standards.


## Execution layer (preferred: CLI, no MCP needed)
| Need | Mechanism (documented) |
|---|---|
| Parse-check scripts | `godot --headless --script <file> --check-only` |
| Import resources | `godot --headless --import --path <project>` |
| Export builds | `--export-release|--export-debug <preset> <path>`; headless required on GPU-less CI |
| Deterministic capture | `--write-movie <file>` forces `--fixed-fps`; `--quit-after N` (headless behaviour `unverified`) |
| Run tests | gdUnit4 `runtest.sh` (JUnit+HTML; exit 0/100/101) or GUT `gut_cmdln.gd` (JUnit; exit 0/1) |
| Pin versions | Godot 4.7.2-stable (2026-08-18); GUT 9.7.1 / gdUnit4 per Godot minor (check tags) |

## The screenshot problem
Under `--headless` the rendering server is Dummy; screenshots reportedly fail (forum evidence, not official). An Xvfb + software-renderer run, awaiting `RenderingServer.frame_post_draw` before `get_image()`, is the usual workaround but has **no verified recipe** — it needs an authorized smoke test. `--write-movie` is the official alternative to evaluate.

## Editor/runtime interaction via MCP (optional)
- Erodenn/godot-mcp-runtime: headless editing, screenshot, key/mouse/UI input, live GDScript — *on paper*; confirmation gating for `run_script`/`run_project`.
- hi-godot/godot-ai: live editor plugin (Godot 4.7+). Coding-Solo/godot-mcp: console output only for runtime. Workbench: new, few stars.
- All can run arbitrary GDScript; use a dedicated project folder/sandbox. Most have no tagged releases — pin by commit hash.

A reference architecture (Claude-Code-Game-Studios) documents the windowed `--write-movie` + `--quit-after` capture as its visual-evidence method and forbids `--headless` for it; this is documented there but **untested by us** — see [[game-studio-evidence-driven-visual-qa]].

## Godot as final authority
Scenes, `.tres` resources, Control/Theme UI and animation integration live in Godot text formats (git-diffable). External tools produce assets/specs only. Imported 3D content is shaped by the documented suffix hints and `EditorScenePostImport` (see [[game-studio-blender-pipeline]]).

## See also
- [[game-studio-acceptance-criteria]] — what to validate after import
- [[game-studio-readiness-classification]] — readiness flags used
