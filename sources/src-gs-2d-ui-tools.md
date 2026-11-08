---
id: src-gs-2d-ui-tools
type: source
domain: game-studio
source:
  url: "https://rodzill4.github.io/material-maker/doc/command_line.html"
  urls:
    - "https://rodzill4.github.io/material-maker/doc/command_line.html"
    - "https://github.com/RodZill4/material-maker"
    - "https://docs.krita.org/en/reference_manual/linux_command_line.html"
    - "https://inkscape.org (man page via mirrors manpath.be, mankier.com/1/inkscape)"
    - "https://github.com/penpot/penpot"
    - "https://github.com/armory3d/armortools"
  title: "Material Maker, Krita, Inkscape, Penpot, ArmorPaint (CLI/automation facts)"
  retrieved: 2026-11-08
  version: "as of 2026-11-08; Inkscape official man page blocked (403)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Material Maker: MIT (README); release 1.8 (25 Oct, year not shown); 6.2k stars; documented CLI `material_maker --export-material --target <blender|godot|unity|unreal> -o <out> <.ptex files>` (wildcards); Godot output files undocumented on that page; headless-on-Linux without display `unverified`; no MCP found.
- Krita: `krita in --export --export-filename out.png` documented; Python API (LibKis) exists but headless scripting `unverified`; license `unverified`; no official MCP found.
- Inkscape: via mirrored 1.4.2 man page: `--export-type`, `-o`, `--export-id`, `--export-id-only`, `--actions "file-open:a.svg;export-type:png;export-do"`, `--action-list`; license `unverified`.
- Penpot: MPL-2.0 (README, verified); 62k stars; self-host (Docker/Kubernetes) or SaaS; REST API with access tokens, plugins API, webhooks; official MCP now in `penpot/penpot/tree/develop/mcp` (standalone repo archived 2026-02-03), bridges via WebSocket to a browser plugin (needs live browser); tool surface disputed (5 vs ~20) `unverified`.
- ArmorPaint (armortools): 6,779 commits, 5.5k stars; license zlib-family per secondary sources, LICENSE fetch 404 — `unverified`; CLI/headless/scripting/MCP not documented; distributed binaries paid (itch.io from $19), free if built from source.
- Pixelorama: no documented CLI (feature request discussion #579 open). Aseprite: `--batch --sheet x.png --data x.json` (https://aseprite.org/docs/cli), proprietary EULA; commercial reference only. LibreSprite/LMMS/Hydrogen/ffmpeg/sox not researched.
