---
id: src-gs-mixar
type: source
domain: game-studio
source:
  url: "https://github.com/Mixar-AI/mixar-app ; https://hermes-agent.nousresearch.com/docs/plugins/mixar"
  title: "Mixar (Blender fork with AI agent) repo and integration doc"
  retrieved: 2026-11-08
  version: "version numbers conflict (2.0.0 / 2.1.1 / 4.2.1); no releases seen"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Custom fork of Blender (base version differs across sources) with AI chat agent "Mixie", layered texture painting, AI 3D generation, asset search.
- Licenses: GPL-3.0-or-later (own code), GPL-2.0-or-later (Blender-derived), ucupaint-derived GPL-3.0-or-later; brand assets separate non-GPL.
- AI backend closed-source and hosted; needs Mixar account + credits; BYO-key for OpenAI/Anthropic stated. Hermes doc: backend records MCP tool-call inputs/outputs (privacy).
- Headless usage documented (`--background --factory-startup --python`); MCP support not on repo page.
