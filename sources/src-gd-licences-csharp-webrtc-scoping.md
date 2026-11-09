---
id: src-gd-licences-csharp-webrtc-scoping
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/about/complying_with_licenses.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/about/complying_with_licenses.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/scripting/c_sharp/index.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/networking/webrtc.html"
  title: "Godot 4.7: Complying with licenses, C#/.NET platform support, WebRTC (signaling and native plugin)"
  retrieved: 2026-11-08
  version: "4.7 (page headers: Godot Engine 4.7 documentation in English; the WebRTC page carries a 'not yet updated for 4.7, may be outdated' banner)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** three official Godot 4.7 documentation pages fetched on 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**; short strings in quotes were reported by the tool as quotations. Nothing was run in the engine. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

- **Complying with licenses (4.7):** the MIT licence's "only requirement is to include the license text somewhere in your game or derivative project"; the game itself may use any licence. One of these placements suffices: a credits screen (often at the bottom), a "Third-party Licenses"/"Open Source Licenses" screen in settings, printing it to the output log with `print()` (desktop, Android, HTML5 — "not iOS"), an accompanying licence file in desktop builds, a printed manual, or a link to `godotengine.org/license` in documentation or credits (the developers consider the link acceptable). **Third-party components:** "Godot itself contains software written by third parties, which is compatible with, but not covered by Godot's MIT license"; many require attribution (copyright statement + licence text); the editor's full list is `COPYRIGHT.txt`, which the page suggests shipping renamed (e.g. `GODOT_COPYRIGHT.txt`). **API:** `Engine.get_license_text()` (engine licence), `Engine.get_license_info()` (third-party licences), `Engine.get_copyright_info()` (third-party copyright) — read from the running binary so they stay current across versions.
- **C#/.NET (4.7):** since Godot 4.2 C# projects export to Windows, Linux, macOS, plus Android and iOS — "Android support is currently experimental"; "iOS support is currently experimental and has a few limitations" (iOS simulator templates only `x64`; exporting to iOS only from macOS). **Web:** "projects written in C# cannot be exported to the web platform". C# needs the separate ".NET version" of the editor; the page does not name a specific .NET version and does not use the term "Mono".
- **WebRTC (page not updated for 4.7):** for low-latency secure peer-to-peer links (VoIP, fast games) via `WebRTCPeerConnection`, `WebRTCDataChannel` and `WebRTCMultiplayerPeer` (high-level multiplayer). Peers must first exchange session descriptions through "a so-called WebRTC Signaling Server" (e.g. a WebSocket server) and may disconnect from it afterwards. The page mentions ICE, DTLS and SDP, says WebRTC tries to find a direct route to "avoid a relaying server", and **does not mention STUN or TURN by name nor relay cost** (*not on the page*). Web exports get the classes built in; native platforms "require an external GDExtension plugin" (webrtc-native). Android needs the `INTERNET` permission in the export preset. The page calls the minimal single-app example "not very useful in real life".
