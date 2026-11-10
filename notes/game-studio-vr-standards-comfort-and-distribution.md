---
id: game-studio-vr-standards-comfort-and-distribution
type: guide
domain: game-studio
status: proposed
summary: "Industry-level VR/XR for a studio: OpenXR as the cross-vendor Khronos standard (and its runtimes SteamVR/Meta/Monado), comfort and locomotion best practices (framerate as comfort, teleport vs smooth, vignette, snap vs smooth turn, seated/standing/roomscale), interaction conventions tied to the action-based input model, VR accessibility, and distribution on SteamVR and the Meta Quest Store/App Lab — with store fees and review bars flagged unverified."
aliases: [VR standards, XR comfort, VR locomotion, VR accessibility, VR distribution, OpenXR runtimes, VR interaction conventions]
tags: [dept/design, dept/ui-ux, dept/delivery]
sources:
  - claim: "OpenXR is a royalty-free cross-vendor Khronos standard unifying headsets/controllers/trackers; SteamVR is a runtime in the Steam client; Steam VR support flags/review/fees were not on the page read"
    ref: src-gs-vr-openxr-standard-and-distribution
    retrieved: 2026-11-09
  - claim: "Comfort/locomotion best practices (consistent framerate, vignettes to limit optic flow, brief/infrequent acceleration, opt-in smooth turning, seated mode supported, choose seated/standing in tutorial) from Meta; XAUR user needs (no required stand/sit, no fine-motor/simultaneous gestures, teleport as a sickness-trigger alternative, captions/safe place)"
    ref: src-gs-vr-comfort-and-accessibility
    retrieved: 2026-11-09
  - claim: "Targeting OpenXR in Godot gives this cross-vendor reach through one engine interface"
    ref: src-gd-xr-openxr-webxr
    retrieved: 2026-11-09
related:
  - relates-to: "[[godot-xr-openxr-and-webxr]]"   # the Godot-engine companion that implements these standards
  - relates-to: "[[game-design-input-mapping-conventions-keyboard-gamepad-touch]]"   # VR controllers are another device profile on the same action model
  - relates-to: "[[game-studio-accessibility-minimums]]"   # the general accessibility floor this extends into XR
  - relates-to: "[[game-studio-delivery-platforms-and-fees]]"   # the general store/fee picture VR sits inside
  - relates-to: "[[game-studio-delivery-steam-store-privacy-notes]]"   # Steam release mechanics and privacy duties
created: 2026-11-09
updated: 2026-11-09
created_by_type: agent
---

> **Evidence status:** the OpenXR-standard and SteamVR-runtime facts are *documented* (Khronos + Steamworks, 2026-11-09, paraphrased — [[src-gs-vr-openxr-standard-and-distribution]]); comfort/locomotion and accessibility are *documented* from Meta's VR design pages and the W3C XAUR Working Group Note ([[src-gs-vr-comfort-and-accessibility]]). Comfort **thresholds** are studio-set, like [[game-studio-accessibility-minimums]] — none are invented here. Store **fees, VR support flags and review bars are *unverified*** (not on the pages read). The Meta pages embedded "install our CLI" instructions, which were ignored as untrusted content. Status `proposed`; not legal advice.

## 1. Scope and evidence classes
What a studio needs around a VR game that the engine note ([[godot-xr-openxr-and-webxr]]) does not cover: the standard, comfort, interaction conventions, accessibility and distribution. **Evidence classes:** *documented* (a cited page read this session), *convention/interpretation* (widely-used practice with no single standard behind it), *unverified* (not on a page read — especially store fees and review bars, which change and need confirming before acting).

## 2. OpenXR as the industry standard
OpenXR (Khronos) is "a royalty-free, open standard that provides a common set of APIs for developing XR applications" and "standardizes the use of a range of cross-platform XR device capabilities" — headsets, controllers, base stations and body/hand/object/eye trackers (*documented*). Before it, each device needed a proprietary code path; OpenXR gives "a single high-performance cross-platform API" so you build once and port (*documented*). An OpenXR **runtime** implements the standard on a given platform: **SteamVR** ("a runtime included with the Steam client that powers virtual reality experiences", *documented*), the **Meta** runtime on Quest, and **Monado** (the open-source runtime, common on Linux — *unverified* here, not fetched). Practical rule: **target OpenXR**, and in Godot that reach comes through the single `"OpenXR"` interface (*documented*, [[godot-xr-openxr-and-webxr]]).

## 3. Comfort and locomotion (the VR-specific design axis)
Discomfort comes largely from **vection** — perceived self-motion while physically still (*documented*, Meta). Recommendations (all *documented* unless marked; exact thresholds are studio-set):
- **Framerate is comfort.** "Maintaining a consistent frame rate is crucial for comfortable, fully immersive experiences"; judder (virtual camera not matching the physical head) "can be uncomfortable." Never drop frames — a dropped-frame budget is a comfort budget, not just a perf budget.
- **Teleport vs smooth locomotion.** Teleport (incl. stepped "a series of small, rapid teleports") avoids continuous optic flow; "Use teleport nodes for slopes and stairs to reduce discomfort." Offer smooth locomotion but treat it as the less-comfortable option.
- **Vignette / tunneling.** "Use vignettes to darken or occlude screen edges during movement, limiting visible optic flow." (Meta does not use the word "tunneling" but this is the same technique — *interpretation*.)
- **Snap-turn vs smooth-turn.** Snap/quick turns reduce rotational vection; "Offer smooth turning as an opt-in feature, tuning speed and acceleration carefully."
- **Avoid forced motion / acceleration.** "Keep acceleration events brief and infrequent"; prefer quantized (instant) velocity changes; soft camera collisions that slow "before stopping, rather than an abrupt halt"; a visible avatar hinting upcoming movement "can significantly enhance comfort."
- **Stable reference / horizon.** "Using independent visual backgrounds that move only with head movement"; maintain consistent elevation relative to the ground.
- **Play areas.** Support **seated / standing / roomscale**; "Seated mode is important for accessibility and should be supported unless fundamentally incompatible"; let the player choose seated/standing "early in the experience, such as in tutorials." Expose a **Comfortable** settings tier that "Prioritizes comfort for users sensitive to VR motion."

## 4. Interaction conventions tied to controls
Map VR interactions to the **same action-based model** as flat-screen input ([[game-design-input-mapping-conventions-keyboard-gamepad-touch]]), so a VR mode and a flat mode can share *intent* even though the device profile differs. Common conventions (*convention* unless marked): **trigger** = select/primary, **grip** = grab, **thumbstick** = locomotion/turn, a **laser-pointer ray** for far/flat UI, **direct touch** for near UI, **two-handed grabs** for large or two-point objects. In Godot these arrive as OpenXR Action-Map actions (`Bool`/`Float`/`Vector2`/`Pose`) on `XRController3D`, a separate system from the engine InputMap (*documented*, [[godot-xr-openxr-and-webxr]]) — so design the *action vocabulary* once (grab/select/move/turn/menu) and bind it per device, flat or XR (*interpretation*).

## 5. Accessibility in VR
Extends the general floor ([[game-studio-accessibility-minimums]]) with XR-specific needs, from the W3C **XAUR** Working Group Note (25 Aug 2021 — a discovery list of user needs, not a baseline requirement set) (*documented*):
- Do not **require** standing or sitting, or allow remapping those to other controls (seated mode above).
- "Ensure fine motion control is not needed to activate an input"; no simultaneous multi-action gestures (so **no required two-handed gesture**); larger targets.
- Customizable controls: alternative mapping, sensitivity, gesture/control remapping (controller remapping "is not currently required by WCAG but is desirable").
- Comfort/sickness alternatives "such as teleportation"; limit or allow switching off flicker; reset-view and personalizable field of view.
- **Captions/subtitles** customizable and reflowed; keep important audio text-alternatived; mono-audio option; a quick user-set **"safe place"** and time-limit alerts.
- *Convention* additions commonly expected but **not named** in XAUR: dominant-hand / handedness choice and **snap-turn** as a comfort option (XAUR covers the adjacent needs but not these labels — treat as *interpretation*).

## 6. Distribution
- **Steam / SteamVR:** ship an OpenXR title; SteamVR is the runtime in the Steam client that auto-installs when a headset is detected (*documented*). The store's **VR support categories, headset/play-area declaration fields, review bar and any VR-specific fees were not on the page read (*unverified*)** — confirm in Steamworks (a separate "Application Settings for Virtual Reality" page) before relying on them; general Steam release mechanics live in [[game-studio-delivery-steam-store-privacy-notes]].
- **Meta Quest:** the **Quest Store** vs **App Lab** vs sideloading are the standalone channels; store submission has a performance/comfort review. Exact fees, the comfort-rating process and acceptance criteria are *unverified* (Meta's developer pages were thin/blocked this session) — confirm on Meta's developer portal.
- **General store picture:** fees, age ratings and privacy duties follow the same rules as any build — see [[game-studio-delivery-platforms-and-fees]] and the privacy notes. VR telemetry (play-area, head/hand motion) is sensitive; keep it opt-in and minimized (*interpretation*, consistent with the privacy note).

## What an agent can and cannot check
**By reading files:** that the build targets OpenXR; that comfort options exist (teleport/smooth toggle, snap/smooth turn, vignette toggle, seated/standing choice, a Comfortable tier); that no gameplay action requires a two-handed or fine-motor gesture; that captions/subtitle and remapping settings exist; that the action vocabulary is shared between flat and XR bindings; that store metadata/age-rating fields are filled. **Needs a headset/human/store:** whether the experience is actually comfortable (per-person, vestibular-sensitive testing), real framerate under load, store review/certification outcomes, exact fees and VR support flags, and the legal adequacy of collected motion data.

## See also
- [[godot-xr-openxr-and-webxr]] — the Godot-engine companion that implements OpenXR/WebXR
- [[game-design-input-mapping-conventions-keyboard-gamepad-touch]] — VR controllers as another device profile on the same action model
- [[game-studio-accessibility-minimums]] — the general accessibility floor this extends into XR
- [[game-studio-delivery-platforms-and-fees]] — the general store and fee picture VR sits inside
- [[game-studio-delivery-steam-store-privacy-notes]] — Steam release mechanics and privacy duties
