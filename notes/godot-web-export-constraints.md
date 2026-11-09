---
id: godot-web-export-constraints
type: concept
domain: godot
status: proposed
summary: "Godot 4.7 web export: single-threaded by default, threads need cross-origin isolation headers, WebGL 2 (Compatibility) only, no C# web export, compression and input-event requirements."
tags: [dept/delivery, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Web export page for Godot 4.7 (per research subagent)"
    ref: src-gd-export-and-platforms
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-export-platform-notes]]"   # other platforms
  - relates-to: "[[godot-renderer-feature-matrix]]"   # Compatibility renderer limits
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7* per research subagent, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine or a build: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Single-threaded export is the default since 4.3** and needs no special headers. **Thread support** needs SharedArrayBuffer: HTTPS plus `Cross-Origin-Opener-Policy: same-origin` and `Cross-Origin-Embedder-Policy: require-corp` (a PWA service worker can simulate the headers).
- **Only WebGL 2.0 (Compatibility renderer).** Safari has WebGL 2 issues.
- **Godot 4 C# projects cannot export to the web.**
- Serve `.wasm` as `application/wasm` and compress it; hosts without on-the-fly compression need precompressed `.pck`/`.wasm`. Name the main file `index.html`; do not edit the generated HTML (use a Custom HTML shell).
- Audio autoplay, fullscreen and cursor capture need an input event; `user://` persistence depends on cookies/IndexedDB; networking is limited to HTTP, WebSocket and WebRTC.
- For itch.io specifically (HTML5 limits: ZIP, 1,000 files, 500 MB extracted) see [[game-studio-delivery-platforms-and-fees]].

## What an agent can and cannot check
An agent can check the thread option and a hosting config's headers by reading files; real browser behaviour (Safari, mobile) needs a browser.

## See also
- [[godot-export-platform-notes]] — other platforms
- [[godot-renderer-feature-matrix]] — Compatibility renderer limits
