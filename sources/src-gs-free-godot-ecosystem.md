---
id: src-gs-free-godot-ecosystem
type: source
domain: game-studio
source:
  url: "https://godotengine.org/license/"
  urls:
    - "https://godotengine.org/license/"
    - "https://github.com/godotengine/godot-asset-library"
    - "https://github.com/godotengine/godot-asset-library/blob/master/API.md"
    - "https://docs.godotengine.org/en/stable/community/asset_library/submitting_to_assetlib.html"
    - "https://godotshaders.com/license/"
  title: "Godot engine licence page, Godot Asset Library (API, licence field, submission rules) and Godot Shaders licence"
  retrieved: 2026-11-08
  version: "as of 2026-11-08"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** pages fetched on 2026-11-08 and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim legal text**; items marked `unverified` or `sec` (secondary source) were not read on an official page (403/404/TLS error). **Not legal advice.** Terms change; have a human read the actual licence before relying on any item. Libre-first project preference: see the cost/openness classification note.

- **Godot licence page (read):** MIT — use, study, modify, redistribute, including commercially or under a proprietary licence; redistributions must keep the copyright notice and licence statement. Games built with it are not covered by the engine licence (you keep ownership and choose your licence), but when you ship the engine binary you are distributing its software and must include the copyright notice and licence text somewhere in your documentation (linking to the licence page from docs or credits is suggested as acceptable). Bundled third-party libraries each have their own compatible licences, listed in COPYRIGHT.txt. The page says it is not legal advice.
- **Asset Library API (API.md, read):** `GET /asset` with filters type (addons/projects/any), category (ids from `/configure`), support level (official/featured/community/testing), search text, submitter, **cost = licence** (e.g. GPLv3; other libraries may put a price there), godot_version; paging up to 500 per request; sort by rating/cost/name/last update; omitting version returns only 2.1 assets and omitting type returns only addons. Reading needs no token; write actions (editing, moderation) do; login URL from `/configure` noted as unused. Assets are soft-deleted (reversible) by owner or moderators; "searchable" flag unexplained; **no rate limits documented**. Backend/frontend in maintenance mode (research agent, repo listing). No machine-readable SPDX identifier.
- **Submission rules (docs page, read):** submitter picks a licence from a dropdown of free/open-source licences (GPL v2/v3, MIT, BSD, Boost named); the chosen licence **must match** the repository's LICENSE/LICENSE.md, which needs the full text and a copyright notice with holder and year(s); copy the licence into the plugin folder so users keep it. Guarantee is only that the label matches the repo at submission — not proof the submitter owns bundled content (our reading). No Asset Library terms of service were found (`unverified`).
- **Godot Shaders (licence page, read):** shaders usable freely in personal and commercial products; each submitter picks CC0, MIT or GNU GPL v3 for their code; submitted code must be the author's own or already free to share; images must be the author's or free to use; the licence covers only the shader code/snippets, not featured images, screenshots, videos or assets shown. GPL v3 shaders raise copyleft questions for a shipped game — human review. Terms-of-service page returned 404.
