# Checklist — input mapping across keyboard, gamepad and touch

Conventions and Godot bridge: `game-design-input-mapping-conventions-keyboard-gamepad-touch`; engine notes:
`input-handling`, `godot-touch-input-and-virtualjoystick`, `godot-ui-focus-and-gamepad-navigation`,
`godot-screen-reader-and-input-remapping`; floor: `game-studio-accessibility-minimums`.

- [ ] Gameplay code references InputMap actions only; no key codes, joy buttons or touch coordinates in logic.
- [ ] Confirm/cancel follow the platform convention (bottom/right on Xbox-style; swap offered); Guide/Home/Share
      never bound.
- [ ] Every gameplay action remappable; menus and game use the same navigation inputs.
- [ ] Keyboard-only and gamepad-only completeness: the whole game is playable with each alone.
- [ ] Touch: targets ≥ 44 pt / 48 dp, safe area respected, no essential action gesture-only, mirror/left-handed
      option considered, layout hides when a non-touch device is active.
- [ ] Prompts/glyphs follow the active device; glyph assets have acceptable licences.
- [ ] Deadzones, sensitivity, invert and hold/toggle exposed as settings; vibration can be disabled.
- [ ] Focus: initial focus set deferred; focus neighbours explicit; focus restored when panels switch.
- [ ] Tests: simulated touch → action; device switch hides/shows touch layer.
