---
id: src-gs-blender-mcp
type: source
domain: game-studio
source:
  url: "https://www.blender.org/lab/mcp-server/"
  urls:
    - "https://www.blender.org/lab/mcp-server/"
    - "https://projects.blender.org/lab/blender_mcp"
    - "https://github.com/ahujasid/blender-mcp"
  title: "Blender MCP: official Blender Lab and community (ahujasid)"
  retrieved: 2026-11-08
  version: "official add-on v1.0.3 (dates unverified); community repo recency unverified"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Official (Blender Lab): requires Blender 5.1+ plus add-on; page lists example tasks only (tool names not listed); runs LLM code "without any guards", recommends a VM; license not stated on the page (`unverified`); headless not mentioned. Release dates (v1.0.0 2026-04-27, v1.0.3 2026-09-11) come from a vendor blog — `unverified`.
- Community (ahujasid): MIT; 33.7k stars, 266 commits; needs running Blender GUI + add-on socket server (Blender 3.0+, Py 3.10+); 9 tools incl. `execute_blender_code`, `look`, `get_scene_info`, `generate_3d`, asset search/import (Poly Haven, Sketchfab, Poly Pizza); socket unauthenticated/unencrypted; optional `BLENDER_MCP_SAFE_MODE=1` off by default; minimal telemetry default (`DISABLE_TELEMETRY=true`). Reported rename/non-affiliation is from a secondary source — `unverified`.
