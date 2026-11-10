---
id: src-gs-vr-comfort-and-accessibility
type: source
domain: game-studio
source:
  url: "https://www.w3.org/TR/xaur/"
  urls:
    - "https://www.w3.org/TR/xaur/"
    - "https://developers.meta.com/horizon/design/locomotion-comfort-usability/"
    - "https://developers.meta.com/horizon/design/locomotion-best-practices/"
    - "https://xraccess.org/"
  title: "W3C XR Accessibility User Requirements (XAUR); Meta Horizon VR design — locomotion comfort & usability and locomotion best practices; XR Access Initiative landing page"
  retrieved: 2026-11-09
  version: "XAUR = W3C Working Group Note, 25 August 2021; Meta/XR Access pages are living web pages"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim. The Meta pages embedded promotional instructions to install a Meta CLI tool; these were treated as untrusted page content and ignored. The xraccess.org landing page was thin (it announces the initiative has 'entered hibernation')."
created: 2026-11-09
updated: 2026-11-09
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the pages above, fetched 2026-11-09 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

### W3C XR Accessibility User Requirements (XAUR) — w3.org/TR/xaur
- **Status:** W3C Working Group Note, 25 August 2021; "a discovery effort that lists user needs and possible requirements." Not a baseline requirement set and not expected to become a Recommendation.
- **Motion-agnostic interaction (4.2):** users who cannot make particular body movements should be able to act without physical movement; device-independent input; multiple simultaneous input methods.
- **Physical position (Section 3):** users should not be *required* to stand or sit, or should be able to remap those to other controls.
- **Interaction / target customization (4.4):** larger targets, no fine motor control, no simultaneous multi-action gestures — "Ensure fine motion control is not needed to activate an input." (REQ 4a)
- **Customizable controls (4.1, 4.9, 3.6):** alternative mapping, resizing, sensitivity adjustment, gesture/control remapping; notes controller remapping "is not currently required by WCAG but is desirable."
- **Comfort / sickness triggers (4.16):** vestibular/epilepsy/photosensitivity users need alternatives to triggers "such as teleportation"; flicker limited or switchable.
- **Field of view and orientation (4.13):** reset the view, personalize field of view, clear landmarks.
- **Output modality choices:** tactile/visual/auditory options; text alternatives for important audio; "Allow mono audio sound to be sent to both headphones" (REQ 18a); route output to a second screen (e.g. braille).
- **Captions/text (4.19):** customizable captions/subtitles; text reflow.
- **Safe place & time limits (4.11, 4.12):** "Allow the user to set a 'safe place' - quick key, shortcut or macro." (REQ 11a); time-limit alerts.
- The Note does **not** explicitly name "snap turning", "dominant hand/handedness", or "avoid two-handed input"; it covers the adjacent needs above.

### Meta — Locomotion comfort & usability (developers.meta.com/horizon/design/locomotion-comfort-usability)
- **Vection** = perceived movement from visual cues while physically still; mitigations listed: "quick turns, snap turns, independent visual background (IVB), vignetting, instant velocity changes."
- **Acceleration:** "By keeping accelerations brief and infrequent, the likelihood of discomfort reduces." Prefer quantized velocity (switch "between them instantly"); stepped translation = "a series of small, rapid teleports."
- **Framerate:** "Maintaining a consistent frame rate is crucial for comfortable, fully immersive experiences." "Judder, which occurs when the virtual camera position doesn't match the physical camera position, can be uncomfortable."
- **Vignettes:** "Use vignettes to darken or occlude screen edges during movement, limiting visible optic flow." (The page does not name "FOV reduction" or "tunneling" as such; it also covers peripheral and temporal occlusion.)
- **Seated mode:** "Seated mode is important for accessibility and should be supported unless fundamentally incompatible with the app design"; let users choose seated/standing "early in the experience, such as in tutorials." Avoid basing height solely on device elevation. A visible avatar that "indicates upcoming camera movements can significantly enhance comfort"; soft collisions slow the camera "before stopping, rather than an abrupt halt."

### Meta — Locomotion best practices (developers.meta.com/horizon/design/locomotion-best-practices)
- **Turns:** "Offer smooth turning as an opt-in feature, tuning speed and acceleration carefully." Snap/quick/smooth turns and teleports "help users reorient and move without discomfort."
- **Teleport:** "Use teleport nodes for slopes and stairs to reduce discomfort." (No explicit overall teleport-vs-smooth comparison.)
- **Acceleration:** "Keep acceleration events brief and infrequent"; stepped translations, restricted movement axes, controlled camera elevation, soft camera collisions.
- **Vignettes / vection:** "Using vignettes to darken screen edges during movement"; match avatar speed to real walking/running; occluding/temporal/opaque peripheral geometry; "Using independent visual backgrounds that move only with head movement."
- **Framerate:** "Maintaining a consistent frame rate to prevent judder."
- **Comfort settings tiers:** Recommended, Comfortable ("Prioritizes comfort for users sensitive to VR motion"), Advanced; test with diverse users; offer customizable options.

### XR Access Initiative — xraccess.org
- "A community committed to making virtual, augmented, and mixed reality (XR) accessible to people with disabilities"; "a research initiative of Cornell Tech." Landing page announces the initiative "has entered hibernation." Maintains an XR Accessibility GitHub (with the XR Association) of code snippets/tutorials across Unity, WebXR and ARCore. (Thin landing page — treat as a secondary pointer; detailed requirements come from XAUR above.)
