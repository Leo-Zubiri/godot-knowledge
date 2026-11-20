---
id: game-studio-slice-cc0-voice-clips-and-make-them-nasal-with-ffmpeg
type: workflow
domain: game-studio
status: unreviewed
summary: "To get many short character voice lines from a long CC0 recording: detect silences with ffmpeg `silencedetect`, cut the active segments between long gaps (min/max length, split long ones at their longest inner pause), then run one fixed filter chain per clip — pitch change without speed change (`asetrate`+`atempo`), high-pass ~230 Hz, a notch at ~480 Hz and narrow peaks near 1.15 and 1.8 kHz for the 'pinched nose' timbre, low-pass ~5.6 kHz, soft-clip, light compression, loudnorm and a limiter — with a different pitch factor (and vibrato on some) per clip. Make the script idempotent (remove its own previous catalog entries) and write provenance (source URL, author, licence, how it was processed) to the asset registry. Site previews may be public while the original needs a login: the licence on the page (CC0) is what counts, and a 96 kbps preview is acceptable after heavy processing."
aliases: [slice audio ffmpeg, silencedetect, nasal voice filter, gnome laugh, cc0 audio provenance, audio catalog merge]
tags: [dept/audio, tool/ffmpeg]
applies-to:
  min: "Godot 4.0"
  tested: "Ginomo: 13 laughs of 0.5–1.2 s from two CC0 clips; levels matched to the existing laughs (mean ≈ -18 dB)"
sources: []
related:
  []
created: 2026-11-20
updated: 2026-11-20
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Built and tested in Ginomo (Godot 4.7.2); not checked against engine source.

## Notes
- `silencedetect=noise=-32dB:d=0.10` on a mono mix; boundaries are silences ≥ 0.22 s; keep segments 0.45–1.6 s (shorter ones are slaps or breaths).
- `loudnorm` on very short clips is only approximate; check `volumedetect` against the existing set.
- Merging into an existing generated catalog: rewrite it in the SAME one-entry-per-line format so the diff only shows what is new.
- Registered via the project's register script; the asset lint then passes.
