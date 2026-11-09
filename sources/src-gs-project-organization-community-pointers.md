---
id: src-gs-project-organization-community-pointers
type: source
domain: godot
source:
  url: "https://forum.godotengine.org/t/folder-structure-for-large-game-in-godot-4-5/119115"
  urls:
    - "https://forum.godotengine.org/t/folder-structure-for-large-game-in-godot-4-5/119115"
    - "https://github.com/abmarnie/godot-architecture-organization-advice"
    - "https://gut.readthedocs.io/en/latest/Command-Line.html"
    - "https://github.com/MikeSchulze/gdUnit4"
  title: "Community and third-party organization pointers (preference, not engine fact): forum thread on folder structure, abmarnie advice repository, GUT and gdUnit4"
  retrieved: 2026-11-08
  version: "pages as seen on 2026-11-08; no version or date recorded for the forum thread"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and search-result summaries; paraphrase, not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** these are **community or third-party** pages summarized by a fetch-time summarizer; they record preferences and are **not evidence of engine behaviour**. The gdUnit4 repository page and the search-based claims were not read. Re-fetch before relying on any point.

- **Forum thread "Folder structure for large game in Godot 4.5":** the original poster relayed a by-type layout (assets, scenes, scripts, materials, shaders, prefabs, ui, lighting, data, tests, addons) for a 3D game with large unique levels and asked about per-level folders. One answerer recommends organizing by feature (textures beside models, scripts beside scenes) and calls it "a matter of opinion"; another organizes by type from a web-development background and warns that grouping by feature makes reused assets hard to find. The thread reaches no consensus; no hybrid was proposed in the thread (per the summary).
- **abmarnie/godot-architecture-organization-advice (MIT, personal advice repository):** scene-first folders with a scene and its exclusive resources together, inherited scenes nested in the base scene's folder, shared resources in a sibling folder named for the data type (central folder named for the scene type when shared within one scene type), scene name as filename prefix for exclusive files, a single `src/` folder for shared code explicitly as a personal VSCode preference ("mostly subjective"), third-party code and licences in `addons/`; scenes self-contained with dependencies injected from an ancestor (signal, public method or settable property); limited use of scene inheritance (most useful for imported `.blend`/`.gltf` scenes); autoloads reserved for cross-cutting systems; statics or custom resources for shared data; the author says the advice is not step-by-step, "architecture scales with the size and complexity of your project", and a short game jam can ignore architecture.
- **GUT (MIT; docs read for the command-line page):** options `-gdir` (directories to search; subfolders need `-ginclude_subdirs`), `-gtest` (specific scripts), `-gprefix` (default `test_`), `-gsuffix` (default `.gd`), config file default `res://.gutconfig.json` selected with `-gconfig`; the docs use `res://test/unit/` and `res://test/integration/` only as examples and recommend no folder. **gdUnit4 (MIT, Godot 4.3+ per search snippet; repository not read):** no official folder convention seen. No official Godot test framework was found.
- **Low-quality pages not used as evidence:** AI-skill registry pages that propose folder layouts.
