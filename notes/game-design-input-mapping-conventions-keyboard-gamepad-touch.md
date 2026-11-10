---
id: game-design-input-mapping-conventions-keyboard-gamepad-touch
type: reference
domain: game-design
status: proposed
summary: "Default control conventions per device (keyboard-mouse, gamepad, touch) and per genre, the physical face-button equivalence across Xbox/PlayStation/Nintendo, touch target sizes, Steam Deck input requirements, remapping minimums, and the Godot 4.7 bridge (JoyButton positions, ui_* defaults as read in the 4.7-stable source, joypad API, safe area)."
aliases: [input conventions, control scheme defaults, button mapping, gamepad layout, touch controls layout, input prompts]
tags: [dept/design, dept/ui-ux, dept/game-dev, tool/godot]
applies-to:
  min: "Godot 4.5 for the SDL3 statement; enums as documented in 4.7"
  tested: "4.7 documentation and 4.7-stable source read; nothing run in the engine"
sources:
  - claim: "JoyButton constants map to physical positions (A = bottom: Sony Cross, Xbox A, Nintendo B); Input joypad API; gui/common/swap_cancel_ok semantics; ui_* descriptions; DisplayServer.get_display_safe_area; in 4.7-stable source ui_accept and ui_cancel have no joypad default, ui_select is bound to JoyButton::Y, ui_left/right/up/down to the D-pad and left stick"
    ref: src-gd-joypad-buttons-ui-defaults-safe-area
    retrieved: 2026-11-08
  - claim: "Microsoft and Apple UI conventions for A/B/shoulders/Menu; Apple touch control sizes 44/28 pt and control-size table; Android 48 dp targets; WCAG 2.5.8 24 px / 2.5.5 44 px; Steam Deck input review items; Steam Input action sets and glyph API; SDL_GameControllerDB field names and Zlib licence; Kenney Input Prompts CC0; Hoober 2013 grip study and its author's later retraction of the thumb-zone drawings"
    ref: src-gs-input-platform-conventions
    retrieved: 2026-11-08
related:
  - depends-on: "[[input-handling]]"   # everything here is expressed as InputMap actions
  - refines: "[[godot-ui-focus-and-gamepad-navigation]]"   # menu conventions sit on top of focus handling
  - relates-to: "[[godot-touch-input-and-virtualjoystick]]"   # the engine nodes that implement the touch layouts described here
  - relates-to: "[[godot-screen-reader-and-input-remapping]]"   # runtime remapping that the requirements section demands
  - relates-to: "[[game-studio-accessibility-minimums]]"   # broader accessibility floor; this note only covers input
  - relates-to: "[[game-design-scoping-questions-for-new-game-or-feature]]"   # question 0.9 sends the agent here
  - relates-to: "[[game-studio-vr-standards-comfort-and-distribution]]"   # VR controllers are another device profile on this same action model
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** two evidence classes are mixed and labelled throughout. *Documented* = an official page retrieved 2026-11-08 (Godot 4.7 docs and the 4.7-stable source, Microsoft UWP gamepad guidance, Apple HIG, Android/WCAG target sizes, Steamworks pages, SDL DB, Kenney). *Convention/interpretation* = widely used genre defaults with **no public standard behind them** — there is no public console certification text, so nothing here is a certification requirement. Items marked *unverified* were not found on a page read. Status `proposed`.

## Scope
Defaults an agent can propose when a project says only "support keyboard, gamepad and touch". It does not cover focus mechanics ([[godot-ui-focus-and-gamepad-navigation]]), touch nodes ([[godot-touch-input-and-virtualjoystick]]) or the remapping UI ([[godot-screen-reader-and-input-remapping]]).

## Physical button equivalence
| Position | Xbox | PlayStation | Nintendo | Godot constant (*documented*) |
|---|---|---|---|---|
| bottom | A | Cross | B | `JOY_BUTTON_A` = 0 |
| right | B | Circle | A | `JOY_BUTTON_B` = 1 |
| left | X | Square | Y | `JOY_BUTTON_X` = 2 |
| top | Y | Triangle | X | `JOY_BUTTON_Y` = 3 |

Confirm is the **bottom** button on Xbox and PlayStation and the **right** button (A) on Nintendo; cancel is the opposite one (*convention*; Microsoft and Apple both document A = activate, B = back/cancel for their own platforms — *documented*). Because Godot's constants are **positional** (`JOY_BUTTON_A` is the bottom button on every pad — *documented*), a game that binds confirm to `JOY_BUTTON_A` puts confirm on Nintendo's *cancel* position. Rule: **follow the platform, offer a swap toggle** (*interpretation*). Two facts an agent must not confuse: (1) in the 4.7-stable source `ui_accept` and `ui_cancel` carry **no joypad binding at all** (only Enter/KP Enter/Space and Escape) while `ui_select` is bound to `JoyButton::Y` and `ui_*` directions to D-pad + left stick — so gamepad confirm/cancel in menus is something the project must add (*documented*, source read directly); (2) `gui/common/swap_cancel_ok` only orders the Cancel/OK **buttons in AcceptDialog** by desktop convention (OK first on Windows/KDE/LXQt, Cancel first on macOS) — it is not a face-button swap (*documented*).

## Universal actions
| Action | Keyboard / mouse | Gamepad (Xbox names) | Touch |
|---|---|---|---|
| confirm / activate | Enter, Space, LMB | A (bottom; Nintendo: right) | tap |
| cancel / back | Esc, RMB in menus | B (right; Nintendo: bottom) | back button, edge swipe where the OS owns it |
| pause / menu | Esc | Menu/Start (Godot `START` = 6) | visible pause button |
| map / secondary | Tab, M | View/Back (Godot `BACK` = 4) | button |
| focus navigation | arrows, Tab/Shift-Tab | D-pad and left stick | n/a (direct tap) |
| **never bind** | OS shortcuts | Guide/Home (`GUIDE` = 5), Share/capture (`MISC1` = 15) — "Reserved for system controls" (Apple, *documented*) | OS gestures (home, multitasking, notification edges) |

## Genre variants (convention unless marked)
| Genre | Keyboard / mouse | Gamepad | Touch |
|---|---|---|---|
| Action / shooter | WASD move, mouse aim, LMB fire, RMB aim, Space jump, Shift sprint, Ctrl crouch, E/F interact, R reload, 1–9 hotbar | left stick move, right stick aim, RT fire, LT aim, A jump, B crouch/dodge, X reload/interact, Y swap, L3 sprint, R3 melee, LB/RB cycle, D-pad items | left dynamic stick (Apple HIG: "wherever the player lands their thumb" — *documented*), right-side drag to aim ("direct touch to pan the camera" — *documented*), fire button, **auto-fire option** |
| Racing | W/S throttle-brake, A/D steer, Space handbrake, Shift/Ctrl gears | RT/LT throttle-brake, left stick steer, X handbrake, LB/RB gears, Y camera, B look back | tilt or on-screen steer, pedals as two buttons |
| Puzzle / point-and-click | mouse-first; Z or Ctrl+Z undo, R restart, H hint | cursor emulation **or** snap-to-interactable (Microsoft's "mouse mode" vs XY focus — *documented*); B undo | tap, long-press for secondary |
| Turn-based / tabletop | click select, Enter confirm, Esc/RMB cancel, Space end turn, Tab cycle units, RMB-drag orbit, wheel zoom | A select/confirm, B cancel, Y end turn, LB/RB cycle, right stick orbit, triggers zoom | tap select, button confirm, swipe cycle, two-finger drag orbit, pinch zoom; **pass-and-play: a per-player confirm step** |
| Menus | hover = focus, click, Esc back | D-pad + stick focus, A accept, B back, LB/RB tabs (Microsoft: bumpers page left/right — *documented*), X/Y secondary, Start closes pause; **visible A/B hint bar** | tap; large targets (below) |

## Touch layout
| Rule | Source class |
|---|---|
| Frequently used controls ≥ 44x44 pt, secondary ≥ 28x28 pt (iOS); 44 pt is Apple's *default* control size, 28 pt the minimum | *documented* (Apple HIG) |
| ≥ 48x48 dp with ≥ 8 dp spacing | *documented* (Android accessibility help; the Material 3 page 404'd) |
| ≥ 24x24 CSS px minimum, 44x44 enhanced | *documented* (WCAG 2.2 SC 2.5.8 / 2.5.5) |
| Keep controls inside `DisplayServer.get_display_safe_area()`; notches via `get_display_cutouts()` | *documented* (Godot 4.7) |
| Thumb zones: Hoober's 2013 observation (49 % one-handed, 36 % cradled, 15 % two-handed) is a dated study, **not a standard**, and the author later retracted the reach drawings | *documented* (with retraction) |
| Offer a mirrored / left-handed layout | *convention* |
| No essential action gesture-only; provide a button alternative | *documented* (Apple HIG accessibility) |
| Landscape: sticks/buttons in the bottom corners; portrait: bottom third only | *interpretation* |

## Steam and Steam Deck
Deck review (*documented*): the game "must support Steam Deck's physical controls"; the default configuration must reach all content with no in-game setting change; on-screen glyphs must match the active device and must not show mouse/keyboard glyphs when a controller is active; text entry needs the Steamworks on-screen keyboard or a controller-only entry; launchers must be fully navigable. The store's "Full"/"Partial Controller Support" labels were **not defined on the pages read** (*unverified*); Steam Input's "full support" criteria include controller-specific glyphs and action-set configs (*documented*). Steam Input itself (action sets, `GetGlyphForActionOrigin`) is only reachable from Godot through a third-party binding such as GodotSteam (MIT — *unverified here*, not fetched); without it Steam presents configured controllers as Xbox input (*documented*).

## Accessibility and remapping requirements
| Requirement | Class |
|---|---|
| Every gameplay action remappable (Apple: "Let players customize key bindings") | *documented* for keyboard; *convention* for pads |
| Hold ↔ toggle for sprint/aim/crouch | *convention* |
| Sensitivity, invert Y, per-action deadzone (Godot default 0.5 — *documented*) | *documented/convention* |
| Vibration off or scaled (Godot tutorial recommends a slider — *documented*) | *documented* |
| No required chords; single-key commands preferred (Apple — *documented*) | *documented* |
| Same input works in menus and gameplay; keyboard-only and pad-only completeness | *convention* (Deck review enforces pad-only — *documented*) |
| Prompts follow the active device; symbols over text (Apple, Deck — *documented*) | *documented* |
| Target sizes per the touch table | *documented* |

## Godot bridge (4.7)
| Item | Fact (*documented* unless marked) |
|---|---|
| Built-in `ui_*` defaults (4.7-stable source) | `ui_accept` Enter/KP Enter/Space; `ui_select` Space + `JoyButton::Y`; `ui_cancel` Escape; `ui_focus_next/prev` Tab / Shift+Tab; `ui_left/right/up/down` arrows + D-pad + left stick axis; `ui_page_up/down`, `ui_home/end`; `ui_cut/copy/paste/undo/redo` Cmd-or-Ctrl combos; `ui_menu` Menu key. **No `JoyButton::A`/`B` anywhere.** `ui_*` actions cannot be removed, their events can be changed |
| JoyButton 0–25 / JoyAxis 0–5 | see the equivalence table; `BACK` 4, `GUIDE` 5, `START` 6, `LEFT_STICK` 7, `RIGHT_STICK` 8, `LEFT_SHOULDER` 9, `RIGHT_SHOULDER` 10, D-pad 11–14, `MISC1` 15, paddles 16–19, `TOUCHPAD` 20; axes `LEFT_X/Y` 0–1, `RIGHT_X/Y` 2–3, `TRIGGER_LEFT/RIGHT` 4–5 |
| Device API | `Input.get_connected_joypads()`, `get_joy_name()`, `get_joy_guid()`, `add_joy_mapping(sdl_string)`, `remove_joy_mapping()`, `is_joy_known()`, signal `joy_connection_changed(device, connected)`, `start_joy_vibration()` |
| Active-device detection | no API; use the class of the last `InputEvent` (`InputEventJoypadButton/Motion` vs `InputEventKey/Mouse*` vs `InputEventScreenTouch/Drag`) with a motion threshold to avoid stick noise (*interpretation*) |
| Analog read | `Input.get_vector()` with circular deadzone averaged from the actions, or an explicit 5th argument |
| Safe area | `DisplayServer.get_display_safe_area()`, `get_display_cutouts()`, `is_touchscreen_available()` |
| Vendor layouts | glyph names should follow `get_joy_name()`/GUID heuristics; mapping strings use SDL field names (`a b x y back guide start leftstick rightstick leftshoulder rightshoulder dpup… leftx… lefttrigger righttrigger`) |
| Glyph art | Kenney Input Prompts, CC0, 64x64 tiles covering Xbox, PlayStation, Nintendo, Steam, keyboard/mouse, touch |

## What an agent can and cannot check
**By reading files:** that every gameplay verb is an InputMap action with a keyboard, a joypad and (where relevant) a touch binding; that no action binds `GUIDE`/`MISC1`; that `ui_accept`/`ui_cancel` were given joypad events; that a swap option and deadzone/vibration settings exist in the settings resource; that touch controls are positioned relative to the safe area; that glyph assets have a licence file. **Needs a device or a human:** that defaults feel right per genre, actual thumb reach on a given phone, Steam Deck review outcomes, whether a vendor's glyph matches the pad in hand, and any platform certification requirement (none is public).

## See also
- [[input-handling]] — everything here is expressed as InputMap actions
- [[godot-ui-focus-and-gamepad-navigation]] — menu conventions sit on top of focus handling
- [[godot-touch-input-and-virtualjoystick]] — the engine nodes that implement the touch layouts described here
- [[godot-screen-reader-and-input-remapping]] — runtime remapping that the requirements section demands
- [[game-studio-accessibility-minimums]] — broader accessibility floor; this note only covers input
- [[game-design-scoping-questions-for-new-game-or-feature]] — question 0.9 sends the agent here
- [[game-studio-vr-standards-comfort-and-distribution]] — VR controllers are another device profile on this same action model
