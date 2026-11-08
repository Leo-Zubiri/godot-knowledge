---
id: src-gs-free-tool-licenses
type: source
domain: game-studio
source:
  url: "https://github.com/godotengine/godot/blob/master/LICENSE.txt ; https://github.com/Scony/godot-gdscript-toolkit ; https://invent.kde.org/graphics/krita/-/blob/master/COPYING ; https://gitlab.com/inkscape/inkscape/-/blob/master/COPYING ; https://github.com/Ardour/ardour/blob/master/COPYING ; https://ffmpeg.org/legal.html ; https://sourceforge.net/projects/sox/ ; https://github.com/audacity/audacity ; https://github.com/LMMS/lmms ; https://github.com/hydrogen-music/hydrogen ; https://github.com/Orama-Interactive/Pixelorama ; https://github.com/LibreSprite/LibreSprite ; https://github.com/Aseprite/aseprite/blob/main/EULA.txt ; https://github.com/armory3d/armortools/blob/main/license.md"
  title: "Licences of open-source production tools (Godot, gdtoolkit, Krita, Inkscape, Ardour, ffmpeg, sox, Audacity, LMMS, Hydrogen, Pixelorama, LibreSprite, ArmorPaint) and the Aseprite EULA"
  retrieved: 2026-11-08
  version: "as of 2026-11-08; release dates mostly not confirmed"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim legal text**; items marked `unverified` or `sec` (secondary source) were not read on an official page (403/404/TLS error). **Not legal advice.** Terms change; have a human read the actual licence before relying on any item. Libre-first project preference: see the cost/openness classification note.

- **Godot (LICENSE.txt, per research agent):** MIT-style; © Godot Engine contributors 2014–present, Linietsky and Manzur 2007–2014; text covers "the Software" only.
- **gdtoolkit (README, per research agent):** MIT; `gdlint` linter, `gdformat` formatter (`--check`, pre-commit hooks); Godot 4 via `pip install "gdtoolkit==4.*"`; README warns formatting may lose data (use git).
- **Krita (COPYING, read):** GNU GPL version 3, 29 June 2007 (research agent: GPL-3.0-only). CLI export covered in earlier sources.
- **Inkscape (COPYING, read):** the file states most source code is GPL v2 or later while the complete binaries are GPL v3 or later (it is not the licence text itself).
- **Ardour (COPYING, read):** GNU GPL version 2 (June 1991) plus an Ardour clarification that plugins loaded through third-party APIs (VST, LV2, CLAP) do not create a derivative relationship with the host and are not bound by Ardour's GPL. Headless Lua tools per earlier sources.
- **ffmpeg (legal.html, read):** LGPL 2.1+ by default; some optional components and optimizations are GPL 2+ and enabling any makes the GPL apply to the whole build; no commercial/other licence offered. LGPL checklist: build without GPL/nonfree options, link dynamically, supply matching source with binaries (diff of changes, build-configuration text file, same web server), credit FFmpeg and its LGPL in download pages/about box/EULA, remove reverse-engineering bans, avoid GPL libraries such as libx264. Record the build configuration.
- **sox (SourceForge, per research agent):** GPLv2 and LGPLv2; last listed update 2024-11-28 (sox-14.4.2); maintenance status not stated, reviews mixed — treat as low-maintenance.
- **Audacity (README, per research agent):** GPLv3 (most files GPLv2+; `au3/lib-src` and VST3 code excepted; docs CC BY 3.0). **LMMS:** GPL-2.0 (OS/CLI and output-licence terms not on the page; FAQ 404). **Hydrogen:** GPLv2+; Linux/macOS/Windows; automation via MIDI or an OSC API; no CLI mentioned.
- **Pixelorama (repo, read):** MIT; targets Godot 4.7.1; exports PNG, animated PNG, spritesheet, GIF, video; command-line scripted export mentioned for bulk work (syntax not given); Windows/Linux/macOS/Web.
- **LibreSprite (repo, read):** GPL-2.0; forked from the last GPLv2 Aseprite commit (Aseprite went proprietary 2016); independent since; ~8.8k stars, ~5,460 commits, 75 open issues; scripting docs in SCRIPTING.md (unread); no CLI mentioned on the page.
- **Aseprite (EULA, read):** may compile/modify source only for personal use or to propose a contribution; may not pass copies to third parties (evaluation versions may be shared); says nothing about commercial use of work created with it; content accessed through the software belongs to its owners. Not libre despite visible source.
- **ArmorPaint/armortools (license.md, read):** zlib/libpng licence — any purpose incl. commercial, modify and redistribute, mark altered versions, keep the notice, no claiming authorship, credit appreciated not required; prebuilt binaries are paid (earlier source). CLI/headless not documented.
