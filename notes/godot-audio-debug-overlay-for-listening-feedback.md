---
id: godot-audio-debug-overlay-for-listening-feedback
type: pattern
domain: godot
status: unreviewed
summary: "An on-screen audio debug overlay for tuning sound with a non-technical owner who cannot name what they hear: the audio bus emits one signal per started or dropped sound (file or synthetic name, what and intensity, bus, volume, pitch, reason), a CanvasLayer lists the last 16 numbered, colour-coded by bus, F9 toggles it, so the owner can say \"number 12 is the bad one\"."
aliases: [audio debug overlay, show playing sounds on screen, sound feedback tool, which sound is this, audio bus signal, listening feedback]
tags: [dept/audio, dept/qa, tool/godot]
applies-to:
  min: "4.0"
  tested: "Godot 4.7.2.stable.mono; unit tests plus a recorded run (xvfb, --write-movie) with a frame extracted to confirm the text is readable"
sources: []
related:
  - relates-to: "[[godot-audio-buses-and-adaptive-music]]"   # the bus whose signal feeds the overlay
  - relates-to: "[[godot-physics-driven-impact-audio-for-rigid-body-games]]"   # the sounds the owner kept describing vaguely
  - relates-to: "[[game-studio-categorised-audio-catalog-pattern]]"   # file names / ids shown by the overlay
created: 2026-11-15
updated: 2026-11-15
created_by_type: agent
---

> **Evidence status — own pattern, `unreviewed`.** Built and run in one project: tests pass and a recorded run showed the overlay lines readable. An agent
> cannot hear the result, so this is the *tool that lets the human tell it which sound is wrong*.

## Problem
Tuning audio with a non-technical owner stalls on vocabulary: "a long dirty noise", "other sounds overlapped" — which one? An agent cannot listen, so it guesses
(and in one project guessed wrong twice). The owner needs a way to point at a sound.

## Solution
1. **One signal from the audio bus.** Every call that plays a sound reports `{label, tag, bus, volume_db, pitch, started, reason}`:
   `label` = the file name for streams loaded from disk, or the stream's `resource_name` for synthetic ones (set it when generating: `synth:ball:hard:2`);
   `tag` = what the caller means (`BALL medium`, `UI ui.accept`, `STARTUP long laugh`) — callers pass it as an optional argument; `started=false` plus a
   `reason` for sounds the bus refused (`duplicate within 12 ms`, `no free quieter voice`). Skip the work when nothing is connected.
2. **An overlay** (`CanvasLayer`, layer 100, a `RichTextLabel` with BBCode on a translucent `ColorRect`, mouse filter ignore): the last **16** lines, each
   `#12  BALL medium · impact_ball_medium_07.wav · -6.2 dB · x1.03 · Sfx`, numbered (the counter keeps growing), coloured per bus, faded over the last 3 s of a
   10 s lifetime, **dropped sounds dimmed with the reason**, plus the number of active voices in the header.
3. **Toggle:** F9 anywhere (`_unhandled_input` on the bus autoload) and a `--audio-debug` command-line flag; **on by default while tuning** (one constant to flip
   off at the end of the phase).
4. The owner watches, says "number 12", and the label tells you exactly which file/variant/bus it was.

## Notes
- View-only and cheap: it only reads a signal; no effect on gameplay or networking.
- Place it where it does not cover the HUD: in the first version it overlapped the player card at the top-left until it was moved down (found by recording
  the running game with `--write-movie` under `xvfb-run` and extracting a frame with `ffmpeg -ss <t> -i out.avi -frames:v 1 frame.png`).
- Tests that matter: line formatting (file, dB, bus, "did not play" with the reason), label resolution (file vs `resource_name` vs "synthetic"), the line cap and
  numbering, the bus really emitting for started *and* dropped sounds, and the toggle. In gdUnit string asserts use `not_contains`, not `does_not_contain`.
- Generalises to any game: the same overlay can show music cues, ambience layers or voice lines.

## See also
- [[godot-physics-driven-impact-audio-for-rigid-body-games]] — the sounds being tuned.
- [[godot-audio-buses-and-adaptive-music]] — buses and what fails silently.
- [[game-studio-categorised-audio-catalog-pattern]] — the ids shown in the labels.
