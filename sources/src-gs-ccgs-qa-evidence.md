---
id: src-gs-ccgs-qa-evidence
type: source
domain: game-studio
source:
  url: "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/run-and-observe.md"
  urls:
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/docs/run-and-observe.md"
    - "https://github.com/Donchitos/Claude-Code-Game-Studios/blob/main/.claude/rules/test-standards.md"
  title: "CCGS run-and-observe visual evidence rule and test standards"
  retrieved: 2026-11-08
  version: "v1.2.0; main@05ad7c8"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the files were fetched on 2026-11-08 from the `main` branch (HEAD at retrieval: `05ad7c8a5b8aa2aa86bbd3439ae7cf7295cac418`, committed 2026-10-19; the fetch itself was by branch name, so the pin is the HEAD observed shortly after) and summarized by a fetch-time summarizer: a **paraphrased extraction, not verbatim text**. This is a *reference architecture* studied for patterns; nothing is copied and the repo is not a dependency. Statements are **documented (D)** in the repo or **project-reported (P)**; none were tested by us. Re-fetch before promoting dependent notes to `verified`.

- **Visual verification rule (D):** any story that changes something a player sees must be launched and observed before it closes; compiling and passing tests do not show whether text fits or panels overflow. Procedure: launch windowed at 1280×720 (unless the project says otherwise), start directly in the affected scene/map, wait for real rendered frames, capture one and exit, inspect it against the acceptance criteria, keep the capture in the story's evidence folder under `production/qa/evidence/` with a hash stamp of the changed files so later edits make the evidence look stale, and report a single `Run result:` line.
- **Godot 4 recipe (D):** `--windowed --resolution 1280x720` + `--write-movie <path>.png` + `--quit-after 60`; output files get an eight-digit frame number appended (use the last); frames render at viewport size, not window size. (Unity needs a small bootstrap capture script; Unreal uses `HighResShot` with an absolute path.)
- **Result states (D):** OBSERVED (screen checked, evidence path given) · NOT VERIFIED (run could not happen: missing engine, unset run command, crash, empty capture; blocks closure of visual/UI stories by default) · N/A (nothing observable, reason stated).
- **Stated limits (D):** a still shows layout, clipping, colour, legibility, correct screen; it cannot show timing, responsiveness, animation or audio sync — those "feel" checks remain human QA.
- **Forbidden (D):** headless/batch/null-renderer launch flags (Godot `--headless`, Unity `-batchmode/-nographics`, Unreal `-nullrhi`) because they skip rendering; discarding screenshots; waiving the run at the minimal QA level (only tests are waived there, not the visual check). Whether `--write-movie` works as described under a given environment is untested by us (and conflicts in emphasis with our other sources, which treat headless screenshots as unverified).
- **Test standards (D, rules/test-standards.md):** Godot tests use gdUnit4 with `[system]_[feature]_test.gd` files and `test_[scenario]_[expected]` function names; arrange-act-assert; unit tests touch no filesystem/network/database and mock externals; integration tests clean up; test data in fixtures, never shared mutable state; performance tests state thresholds and fail when exceeded. **Regression rule:** every bug fix needs a regression test that was run against the *unfixed* code and seen failing, then passing after the fix — because a poorly built fixture can pass against the very bug; a test never observed failing proves nothing. No `--headless`/CI rules in that file.
