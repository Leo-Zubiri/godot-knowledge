---
id: game-studio-sourcing-cc0-audio-with-a-logged-in-browser
type: guide
domain: game-studio
status: unreviewed
summary: "How to acquire CC0 / public-domain sound files from Freesound and SoundBible with a logged-in Firefox DevTools MCP browser and verify each licence from the page: where the licence link is, what a non-CC0 page looks like, the plain download href, the download-folder restriction, the pitfall that navigating away cancels an in-progress download, sites that cannot be verified (OpenGameArt via fetch, RouteNote, directory.audio), and how to record the evidence."
aliases: [freesound download, soundbible download, cc0 audio acquisition, firefox mcp download, license verification freesound, download cancelled navigation]
tags: [dept/audio, dept/assets, scope/licensing]
applies-to:
  min: "n/a"
  tested: "Freesound and SoundBible pages as they were on 2026-11-15; Firefox DevTools MCP with a human-logged-in session"
sources: []
related:
  - relates-to: "[[game-studio-asset-source-catalog]]"   # provider classes (Freesound conditional, OpenGameArt conditional)
  - relates-to: "[[game-studio-asset-license-and-provenance-policy]]"   # the rules this procedure applies
  - relates-to: "[[game-studio-ffmpeg-sample-processing-for-cc0-game-audio]]"   # what to do with the files next
  - relates-to: "[[game-studio-categorised-audio-catalog-pattern]]"   # where the evidence ends up
created: 2026-11-15
updated: 2026-11-15
created_by_type: agent
---

> **Evidence status — run once, `unreviewed`.** Procedure and pitfalls were observed in a single session (2026-11-15) against the live sites; site markup
> and policies change. Licence texts below are what the pages showed that day. This note is about *procedure*, not legal advice; the licence decision
> stays with the owner ([[game-studio-asset-license-and-provenance-policy]]).

## Goal
Get original sound files whose licence you verified yourself, with evidence recorded, using a browser a human has logged in.

## Procedure
1. **Human logs in.** Freesound requires an account to download originals. Open the login page with the browser MCP and let the owner type the
   password (never enter or store credentials yourself). After login the sound pages show an avatar and a **Download sound** button.
2. **Set the download folder first.** The MCP only allows folders under `~/.firefox-devtools-mcp/output/…` (anything else is rejected unless the server is
   started with unrestricted paths). Use e.g. `…/output/audio-inbox/` and keep originals **out of the game repository**.
3. **Verify the licence from the page, per sound** (do not trust a list or a chat message):
   - CC0: the licence block says "Creative Commons 0" and the link *Go to the full license text* has `href="http://creativecommons.org/publicdomain/zero/1.0/"`.
   - CC BY: the page says "Attribution 4.0" and "credit the author" — **exclude it when the policy is CC0-only** (one of the owner's picks was CC BY and was excluded).
   - Take a snapshot to a file (`take_snapshot` with `saveTo`) and `grep -i "creativecommons\|Download sound"` it: the licence href and the download link are both in the DOM.
4. **Download link.** It is a plain href: `https://freesound.org/people/<user>/sounds/<id>/download/<id>__<user>__<name>.<ext>`. Click it, or navigate straight
   to it. Formats vary (mp3, wav 24-bit/96 kHz, flac, m4a); all decode in ffmpeg.
5. **WAIT for each download to finish.** Navigating to another page right after clicking **cancels the in-progress download** — in the observed run only 2 of 6 files
   arrived. Either poll (`list_downloads`, or `ls` the folder) before navigating, or navigate *directly to the download URL* with `wait: none` and then sleep a few
   seconds and `ls`. Note that `list_downloads` may list only some entries; the folder is the truth. Check each with `ffprobe` (duration, rate, channels) afterwards.
6. **SoundBible:** the sound page shows `License: Public Domain` and offers `http://soundbible.com/grab.php?id=<n>&type=wav` (also `mp3`). The tag-list page shows the licence
   per sound too. A file named by artist and number (e.g. `POOL-<artist>-<number>.wav`) is what arrives.
7. **Record evidence** for every file: source URL, the licence line as shown, the date, the author. Put them in a provenance file / registry
   ([[game-studio-categorised-audio-catalog-pattern]]). Add a note if the author's page states conditions beyond the licence.

## Sources that could NOT be verified (do not use until they are)
- **OpenGameArt pages:** `WebFetch` returned HTTP 403. Open them in the logged-in browser, or ask the owner to confirm the licence; many OGA items are CC-BY or GPL, not CC0.
- **RouteNote sound-effect pages and directory.audio:** the pages did not expose a verifiable licence in the extract — treated as not usable for a CC0-only policy.
- Links pasted from a chat often carry tracking parameters (`?utm_source=...`); the plain URL is the same page.

## Respect extra conditions
One CC0 sound's page added a request not to use the sounds for training generative models and not to clone the voice. CC0 does not enforce it, but it is the author's
stated wish: playing or processing the sound as a game effect is fine; do not feed such files to a voice-cloning or training pipeline, and mention it in the provenance file.

## What an agent cannot do
- Log in, solve captchas, or accept terms on the owner's behalf.
- Judge by ear whether a sound is the one the owner meant — confirm by name and description, and let the owner listen.

## See also
- [[game-studio-asset-source-catalog]] — provider classes (Freesound conditional: filter to CC0, no scraping).
- [[game-studio-asset-license-and-provenance-policy]] — CC0/CC BY/CC BY-NC rules and evidence snapshots.
- [[game-studio-ffmpeg-sample-processing-for-cc0-game-audio]] — turning the originals into the game's own sounds.
- [[game-studio-categorised-audio-catalog-pattern]] — recording provenance next to the files.
