---
id: src-gs-godot-headless-render-limit
type: source
domain: game-studio
source:
  url: "https://ask.godotengine.org/150510/godot-headless-not-same-godot-window-cant-render-the-backend"
  title: "Forum: headless Godot cannot render the backend (screenshots)"
  retrieved: 2026-11-08
  version: "forum thread (not official docs)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- Under `--headless` the RenderingServer is Dummy; textures/viewport images reportedly cannot be read, so screenshots fail.
- Commonly suggested workaround: non-headless run under Xvfb with software renderer (llvmpipe), `await RenderingServer.frame_post_draw` before `get_image()`.
- Evidence quality: forum source; one poster reported Xvfb did not work. **No verified recipe — `unverified`.** Whether `--write-movie` works headless is also `unverified`.
- Companion official page (dedicated-server export): https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_dedicated_servers.html — editor binary or export-template binary can run headless; CI template installation not covered.
