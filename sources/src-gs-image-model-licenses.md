---
id: src-gs-image-model-licenses
type: source
domain: game-studio
source:
  url: "https://huggingface.co/black-forest-labs/FLUX.1-schnell ; https://huggingface.co/black-forest-labs/FLUX.1-dev ; https://huggingface.co/black-forest-labs/FLUX.2-dev ; https://huggingface.co/Qwen/Qwen-Image ; https://huggingface.co/stabilityai/stable-diffusion-3.5-large"
  title: "Image model cards: FLUX.1/FLUX.2, Qwen-Image, SD 3.5 Large"
  retrieved: 2026-11-08
  version: "model cards as of 2026-11-08"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Preservation basis:** points below were extracted on 2026-11-08 by a read-only research subagent that fetched the URL(s); they are a *paraphrased extraction, not verbatim text*, and were not re-fetched by the main agent. Items marked `unverified` were not confirmed on the page. Re-fetch the URL before promoting any dependent note to `verified`. No synthesis here; notes cite this source by `id`.

- FLUX.1 [schnell]: Apache-2.0 (card says personal, scientific, commercial). 12B BF16.
- FLUX.1 [dev]: FLUX.1 [dev] Non-Commercial License; card says outputs may be used commercially "as described in the license" — license text not read, commercial use `unverified`.
- FLUX.2 [dev]: FLUX Non-Commercial License; card says commercial open-weight use falls under "Self-Hosted Commercial License Terms" (not described on the page). 32B BF16; 4-bit RTX 4090 example with remote text encoder. FLUX.2 [pro] is a hosted API under separate terms.
- Qwen-Image: Apache-2.0; ~20B BF16 (repo not separately read).
- SD 3.5 Large: Stability Community License (under US$1M annual revenue for commercial use, else Enterprise); 8B BF16; NF4 quantization mentioned.
- VRAM requirements not stated on these cards. SDXL not fetched.
