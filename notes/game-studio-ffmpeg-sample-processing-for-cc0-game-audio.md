---
id: game-studio-ffmpeg-sample-processing-for-cc0-game-audio
type: guide
domain: game-studio
status: unreviewed
summary: "Working ffmpeg 8 command patterns to turn downloaded CC0 recordings into unique game audio without sox, numpy or a DAW: mono mix, silence-based segment detection, trimming, fades without knowing the length, pitch-up without changing speed, a 'nasal' character-voice chain, multi-note UI blips from one sound, joining segments, WAV mono 44.1 kHz output, and measurement-based QA — including the honest finding that a boosted EQ did not raise the nasal band's share and that ffmpeg cannot tell what a recording contains."
aliases: [ffmpeg audio recipes, pitch shift ffmpeg, silencedetect segments, nasal voice eq, game sfx from samples, loudnorm game audio, batch audio processing]
tags: [dept/audio, dept/assets, tool/godot]
applies-to:
  min: "ffmpeg 6"
  tested: "ffmpeg 8 on Linux; outputs imported by Godot 4.7.2 and played in tests; no sox, no numpy/scipy on the machine; timbre NOT judged by ear"
sources: []
related:
  - relates-to: "[[game-studio-2d-ui-audio-materials]]"   # WAV vs Ogg rules; says ffmpeg/sox CLI behaviour was not researched
  - relates-to: "[[game-studio-artcraft-evaluation]]"   # SoundCraft cannot write Ogg/MP3; ffmpeg was the working baseline instead
  - relates-to: "[[game-studio-loudness-targets]]"   # the loudness numbers used here are not a verified platform target
  - relates-to: "[[game-studio-categorised-audio-catalog-pattern]]"   # where the processed files are registered
created: 2026-11-15
updated: 2026-11-15
created_by_type: agent
---

> **Evidence status — mixed, `unreviewed`.** The commands below were *run* (ffmpeg 8) and their outputs were measured with ffmpeg itself and
> imported and played by Godot's test suite. **Not verified by ear:** whether the "nasal" chain actually sounds nasal, whether the pitched
> voices sound natural, whether the UI blips are pleasant. The measurement findings (below) are real; the aesthetic claims are not. Loudness
> targets are the author's choice, not a sourced standard ([[game-studio-loudness-targets]]).

## Goal
Make short CC0 recordings (laughs, a drop, jingles) into *this game's own* sound set, repeatably, with one script and the tools already installed.

## Recipes (all `ffmpeg -hide_banner -loglevel error -y -i IN ... OUT.wav`)
- **Any input** (mp3, m4a/AAC, flac, 24-bit 96 kHz wav) decodes without extra flags. Always normalize the format at the end:
  `-ar 44100 -ac 1 -c:a pcm_s16le`.
- **Mono mix:** `-af "pan=mono|c0=0.5*c0+0.5*c1"` (average the channels; `-ac 1` alone also works but hides the gain choice).
- **Find the useful bits of a long file** (e.g. 8 laughs in 17 s):
  `ffmpeg -nostats -i in.mp3 -af silencedetect=noise=-32dB:d=0.12 -f null - 2>&1 | grep silence_` prints `silence_start` / `silence_end`. The
  **non-silent intervals** are `[silence_end_i, silence_start_{i+1}]` (the first starts at the first `silence_end`, the last ends at the last
  `silence_start`). Tune `noise` and `d` until the segments match what you hear/see; pad each by ~30 ms.
- **Trim:** `atrim=start=2.10:end=3.10,asetpts=PTS-STARTPTS` (reset timestamps, or later filters/concat misbehave).
- **Fade-out without knowing the duration:** `areverse,afade=t=in:d=0.03,areverse`. Fade-in is simply `afade=t=in:d=0.008`.
- **Pitch up without changing speed:** `asetrate=44100*K,aresample=44100,atempo=1/K` (K = 1.2 ≈ +3 semitones). Compute `1/K` in the shell
  (`awk`). `atempo` accepts 0.5–2 per instance. **Caveat:** this scales formants too (voices get "smaller"/chipmunk).
- **A "nasal" character-voice chain** (one filter string): `highpass=f=320, equalizer=f=480:t=q:w=1.0:g=-9` (notch the chesty low-mids),
  `equalizer=f=1250:t=q:w=1.3:g=11, equalizer=f=1900:t=q:w=1.5:g=6` (narrow peaks where a nasal voice resonates), `equalizer=f=2800:t=q:w=1.5:g=-3`,
  `lowpass=f=6000`, optional `vibrato=f=6.5:d=0.22` (warble), `asoftclip=type=tanh`, `acompressor=threshold=0.125:ratio=3:attack=4:release=70`,
  `loudnorm=I=-18:TP=-2:LRA=7`, `alimiter=limit=0.89`. Vary **K, vibrato and which segments** per output so no two variants match.
- **Several notes from ONE sound** (UI blips from a single drop): `-filter_complex "[0:a]pan=mono|c0=0.5*c0+0.5*c1,asplit=2[x0][x1];[x0]asetrate=44100*1.0,aresample=44100,adelay=0|0[n0];[x1]asetrate=44100*1.4983,aresample=44100,adelay=75|75[n1];[n0][n1]amix=inputs=2:normalize=0,alimiter=limit=0.89"`.
  Ratios: 1.4983 = a fifth up, 1.1225 = a tone, 0.5946 = a tritone down. Add `aecho=0.8:0.55:55:0.3` for a bell-like tail. `amix=...:normalize=0` keeps the
  levels (default normalizing halves them).
- **Join segments:** a `filter_complex` with `[s0][s1]...concat=n=N:v=0:a=1`, each segment trimmed and faded first.
- **Jingle excerpts:** `atrim=0:2.6,asetpts=PTS-STARTPTS,<fade-out>,loudnorm=I=-20:TP=-2:LRA=7`.

## QA by measurement (the only QA an agent can do)
- Level: `ffmpeg -nostats -i f.wav -af volumedetect -f null - 2>&1 | grep max_volume` — check peaks sit at −1…−9 dB, not 0.
- **Per-band profile relative to the total** (script pattern): for each band `lo hi`, run
  `-af "pan=mono|c0=0.5*c0+0.5*c1,highpass=f=lo,lowpass=f=hi,astats=metadata=1:measure_overall=RMS_level:measure_perchannel=none,ametadata=print:key=lavfi.astats.Overall.RMS_level:file=-"`,
  take the last `RMS_level=` line, subtract the full-band value. Compare source vs processed for 150–400, 400–700, 700–1000, 1000–1600, 1600–2500,
  2500–4000, 4000–8000 Hz. (Do this from a script file: long one-liners with loops are fragile in restricted shells.)
- `aspectralstats=measure=centroid` + `ametadata=print` gives the spectral centroid per frame (average with awk).
- Duration: `ffprobe -v error -show_entries format=duration -of csv=p=0 f.wav`.

## Findings worth keeping
1. **Measure, don't assume.** A first chain (notch 480 Hz −6, +8 dB at 1.2 kHz, +5 at 2.3 kHz, lowpass 7.8 kHz) did **not** raise the relative share of the
   1.0–1.6 kHz band: −5.9 dB (source) → −6.3 dB (processed) versus the full band, and the spectral centroid *fell* (3744 → ~2875 Hz). The source was already
   mid-heavy, and the pitch shift moved highs up. A stronger chain (above) gave a **modest** measurable change: lows (150–400 Hz) ≈ −7 dB, 700–1600 Hz
   ≈ +1.2 dB, 2.5–4 kHz lower. Real, but small.
2. **Whether it sounds "nasal" is a human judgement.** Treat "nasal" as a *spectral shape* (low-mid notch + narrow mid peaks + rolled-off highs + raised pitch) you
   can measure, and leave the verdict to a listener; iterate one parameter at a time.
3. **ffmpeg cannot tell you what a recording contains.** Per-slice spectral centroid and peak did not separate cue hit vs ball clack vs pocket drop in a 1.2 s
   pool recording (centroids 1.2–3.0 kHz overlapped). Slices classified by order and level are **inferences**: tag them `inferred` in the catalog and gate them
   behind a feature flag until a human approves ([[game-studio-categorised-audio-catalog-pattern]]).
4. Keep everything in **one build script** reading a folder of originals and writing the outputs, so "same originals → same files". Originals are not committed.

## See also
- [[game-studio-2d-ui-audio-materials]] — WAV for short SFX, Ogg for music and loops (WAV supports loop points).
- [[game-studio-artcraft-evaluation]] — SoundCraft's limits; ffmpeg was the baseline here.
- [[game-studio-categorised-audio-catalog-pattern]] — registering the outputs with categories and provenance.
- [[game-studio-sourcing-cc0-audio-with-a-logged-in-browser]] — getting the originals.
