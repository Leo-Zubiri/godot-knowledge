---
id: src-gs-vr-openxr-standard-and-distribution
type: source
domain: game-studio
source:
  url: "https://www.khronos.org/openxr/"
  urls:
    - "https://www.khronos.org/openxr/"
    - "https://partner.steamgames.com/doc/features/steamvr/info"
  title: "Khronos OpenXR landing page; Steamworks 'SteamVR' developer info page"
  retrieved: 2026-11-09
  version: "n/a (living web pages)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim. The Khronos registry (registry.khronos.org/OpenXR/) was NOT fetched; Steam's VR support-declaration / store-category fields were NOT on the page read (a separate 'Application Settings for Virtual Reality' page was linked but not fetched)."
created: 2026-11-09
updated: 2026-11-09
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the two pages above, fetched 2026-11-09 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

### Khronos — OpenXR (khronos.org/openxr)
- OpenXR is "a royalty-free, open standard that provides a common set of APIs for developing XR applications" that run across many AR and VR devices.
- "OpenXR standardizes the use of a range of cross-platform XR device capabilities" — headsets, controllers, base stations, and body, hand, object and eye trackers.
- Maintained by the Khronos Group: "The Khronos OpenXR Working Group is actively driving the evolution of the standard."
- Problem solved: before OpenXR, developers wrote separate proprietary code paths per device; OpenXR offers "a single high-performance cross-platform API," so you build once and port to more devices.
- (The Khronos **registry** — the formal spec and extensions list — was not fetched this session; treat specific extension names as *unverified* until read.)

### Steamworks — SteamVR info (partner.steamgames.com/doc/features/steamvr/info)
- SteamVR is "a runtime included with the Steam client that powers virtual reality experiences"; it installs automatically when Steam detects a connected headset, or manually. It can also run standalone (enterprise) without the Steam client.
- User-facing features documented: room setup, device status/management, firmware, audio, mirroring, **Motion Smoothing**.
- In-app purchases use the same microtransactions API as other Steam apps. Overlay apps are distributed by enabling the "Launch SteamVR Overlay" launch option (development details on the OpenVR wiki).
- **NOT on this page (so *unverified* here):** VR store categories such as "VR Only" / "VR Supported", headset-compatibility fields, seated/standing/roomscale play-area declaration, and OpenXR-vs-SteamVR runtime requirements. A separate linked page "Application Settings for Virtual Reality" was not reviewed. Any Steam VR support flags, review bar, or fees for VR titles must be confirmed against Steamworks before acting.
