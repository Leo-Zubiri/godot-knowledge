---
id: src-gs-comfyui-core
type: source
domain: game-studio
source:
  url: "https://github.com/Comfy-Org/ComfyUI/blob/master/LICENSE ; https://github.com/Comfy-Org/ComfyUI/releases ; https://docs.comfy.org/development/comfyui-server/comms_routes ; https://github.com/Comfy-Org/ComfyUI-Manager"
  title: "ComfyUI license, releases, server routes, Manager"
  retrieved: 2026-11-08
  version: "v0.44.0 (2026-11-04, year inferred)"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- GPL-3.0 (LICENSE file) — application code only. Stable release ~every 2 weeks (v0.44.0 04 Nov, v0.43.0 27 Oct, v0.42.1 19 Oct). Windows/Linux/macOS; desktop app Windows/macOS only; README: "as low as 4GB vram + 8GB ram" (model-dependent). Python 3.13 recommended. README mentions paid proprietary "partner/API nodes".
- API: `POST /prompt` -> `prompt_id`/`number` or `error`/`node_errors`; `GET /history/{prompt_id}`, `GET /view`, `POST /upload/image|mask`; `/ws` events `status`, `execution_start`, `execution_cached`, `executing`, `progress`, `executed`.
- NOT confirmed on fetched pages: `--listen`, API-format JSON schema, PNG-embedded workflow metadata, determinism across hardware (`unverified`); repo contains `openapi.yaml` (unread).
- ComfyUI-Manager (GPL-3.0): auto-installs `requirements.txt` and runs `install.py` (arbitrary code); `security_level` strong/normal/normal-/weak; `allow_git_url_install` and `allow_pip_install` default false, loopback only; no safety guarantee.
