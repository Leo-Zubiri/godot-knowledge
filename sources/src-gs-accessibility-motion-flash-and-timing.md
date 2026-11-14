---
id: src-gs-accessibility-motion-flash-and-timing
type: source
domain: game-studio
source:
  url: "https://learn.microsoft.com/en-us/gaming/accessibility/xbox-accessibility-guidelines/118"
  urls:
    - "https://learn.microsoft.com/en-us/gaming/accessibility/xbox-accessibility-guidelines/118"
    - "https://learn.microsoft.com/en-us/gaming/accessibility/xbox-accessibility-guidelines/117"
    - "https://gameaccessibilityguidelines.com/full-list/"
  title: "Xbox Accessibility Guidelines 118 (photosensitivity) and 117 (motion, camera and moving content); Game Accessibility Guidelines full list (items on flashing, motion, haptics, speed, timing, sound and colour)"
  retrieved: 2026-11-14
  version: "Microsoft Learn pages dated 2026-11-13; Game Accessibility Guidelines live list"
  capture: excerpt
  retrieved_via: "WebFetch: the two Microsoft Learn pages were returned as page markdown (passages below are quoted from it); the Game Accessibility Guidelines list came through the fetch-time summarizer (item wording as returned by it)"
created: 2026-11-14
updated: 2026-11-14
created_by_type: agent
---

> Preserved excerpts (conventionally immutable). Practitioner best practices, **not** a legal or compliance checklist. The Game Accessibility Guidelines items are a summarizer extraction of the list page (wording as returned); re-read the list before relying on exact wording. Complements the older `src-gs-accessibility-and-loudness`.

## Xbox Accessibility Guideline 118 — photosensitivity
- Goal: "to help prevent players from experiencing negative or potentially harmful side effects during gameplay, including photosensitive seizures and migraine episodes."
- "A small percentage of people (approximately 1 in 4,000) can experience a seizure when they're exposed to certain visual images, including flashing lights or patterns". "eliminating game content that can potentially cause photosensitive seizures is preferred over splash-screen warnings or other methods."
- "All games should be tested for photosensitive seizure triggers, regardless of whether the game includes intentional flashing."
- **Luminance flash:** "A flash is defined as a 10% change in luminance (where 100% is the maximum luminance of a white screen)"; "The darker luminance value should be below 0.8." Failure criteria: "Flashes occur too frequently (approximately more than three per second)."; "Flashes take up a certain amount of the screen (approximately 20 percent or more)."; "Lower intensity flashing can also cause a failure if it's continued for an extended period of time." Address by reducing contrast, frequency or size.
- **Red flash:** applies when either extreme is a saturated red (R/(R + G + B) >= 0.8); same frequency and area criteria; additionally "Desaturate the red coloring."
- **Spatial pattern:** alternating high-contrast bands; fails when contrast difference is greater than 10 percent and the pattern covers about 20 percent or more of the screen.

## Xbox Accessibility Guideline 117 — motion, camera and moving content
- Goal: players "can pause or completely stop any content that scrolls, blinks, auto-updates, or otherwise moves" and "customize game settings related to field of view, camera movement and sensitivity, and other visual settings related to camera or screen movement."
- Scoping questions name: automatic changes of camera view or angle; "Camera-specific behaviors such as "camera shake" or "head bob?""; "Repetitive side-to-side or up-and-down movement of on-screen elements?"
- "Avoid the use of camera shake, camera bobbing effects, motion blur, mouse blur, and more or provide an option to turn off these behaviors." Example given: a shooter where "players can individually set the intensity or amount of radial blur, screen shake, full screen effects, and speed lines across a sliding scale from zero to 100%."
- "Avoid any repetitive side-to-side or up-and-down on-screen movement, except that which is core to game play."
- "Provide adjustable field of view settings."
- "Provide camera movement settings like the ability to adjust horizontal and vertical camera movement sensitivity and the ability to disable automatic camera movement."
- For moving, blinking, scrolling or flashing content on screens with text: "A mechanism to entirely disable this content." / "A mechanism to pause or hide this content."

## Game Accessibility Guidelines — full list, selected items (tier, category)
- Basic, Cognitive: "Avoid flickering images and repetitive patterns"
- Advanced, Cognitive: "Avoid any sudden unexpected movement or events"
- Intermediate, Vision: "Avoid (or provide option to disable) any difference between controller movement and camera movement"
- Intermediate, Cognitive and Vision: "Provide an option to turn off / hide background movement"
- Advanced, Cognitive: "Provide an option to turn off / hide all non interactive elements"
- Basic, Motor (also Intermediate, Cognitive): "Include toggle/slider for any haptics"
- Basic, Motor (also Intermediate, Cognitive): "Include an option to adjust the game speed"
- Advanced, Motor: "Do not make precise timing essential to gameplay – offer alternatives, actions that can be carried out while paused […]"
- Basic, Hearing: "Provide separate volume controls or mutes for effects, speech and background / music"
- Basic, Hearing: "Ensure no essential information is conveyed by sounds alone"
- Basic, Vision: "Ensure no essential information is conveyed by a fixed colour alone"
- The list has **no item that names screen shake**; the closest is the advanced item on sudden unexpected movement.
