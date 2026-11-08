---
id: src-gs-godot-mcp-servers
type: source
domain: game-studio
source:
  url: "https://github.com/Erodenn/godot-mcp-runtime"
  urls:
    - "https://github.com/Erodenn/godot-mcp-runtime"
    - "https://github.com/hi-godot/godot-ai"
    - "https://github.com/Coding-Solo/godot-mcp"
    - "https://github.com/ZemDen/godot-ai-workbench"
  title: "Godot MCP server repos (README + GitHub API metadata)"
  retrieved: 2026-11-08
  version: "as of 2026-11-08; no tagged releases seen"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

| Repo | License | Last push / stars | Editor needed | Runtime interaction |
|---|---|---|---|---|
| Erodenn/godot-mcp-runtime | MIT | 2026-10-30 / 97 | No (headless, per README) | screenshot (960x540 + full PNG), key/mouse/UI input, live GDScript, profiling |
| hi-godot/godot-ai | MIT | 2026-11-08 / 3.4k | Yes (live editor plugin; Godot 4.7+, uv) | not described in README read; 46 tools / 120+ ops |
| Coding-Solo/godot-mcp | MIT | 2026-04-16 / 6.6k | not stated | console output only |
| ZemDen/godot-ai-workbench | Apache-2.0 | 2026-07-09 / 5 (created 2026-07-07) | Yes (addon + local server :8765; README says Windows 10+) | claims 21 runtime tools incl. screenshot/playtest |
- All expose arbitrary-code-execution surfaces (`run_script` etc.). Erodenn gates `run_script`/`run_project` behind confirmation, localhost bridge (docs/security.md not read). hi-godot claims loopback transport, rotating credentials, blocks `project.godot` writes; telemetry opt-out.
- "Godot AI Workbench" exists (asset-library 5353). "Godot AI Toolkit" not found under that name (closest: "Godot AI Guard Toolkit").
- Not read: Erodenn docs/tools.md, hi-godot docs/TOOLS.md. Releases/dates `unverified`.
