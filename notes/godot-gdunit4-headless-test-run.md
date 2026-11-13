---
id: godot-gdunit4-headless-test-run
type: guide
domain: godot
status: proposed
summary: "How to run gdUnit4 unit tests from the command line on Godot 4.7.2: invoke GdUnitCmdTool.gd with --ignoreHeadlessMode (gdUnit4 refuses --headless otherwise, exit 103), point it at a test dir with -a, and read exit codes 0 pass / 100 fail / 101 warnings; verified by running gdUnit4 6.2.3 on 4.7.2."
aliases: [gdUnit4 CLI, GdUnitCmdTool, headless tests, ignoreHeadlessMode, godot test runner]
tags: [tool/godot, dept/qa]
applies-to:
  min: "4.5 (gdUnit4 6.2.x)"
  tested: "Godot 4.7.2.stable.mono + gdUnit4 6.2.3 (run in the engine this session)"
sources:
  - claim: "gdUnit4 version matrix (v6.2.x for 4.5–4.7.1), CLI entrypoint and exit codes 0/100/101, scene runner simulates mouse/keyboard/touch/actions"
    ref: src-gs-gut-gdunit4
    retrieved: 2026-11-08
  - claim: "--headless runs a dummy display/audio driver intended for servers and --script"
    ref: src-gs-godot-cli
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-logging-and-crash-evidence]]"   # headless logs as the place test output lands
  - relates-to: "[[godot-ci-export-documented-limits]]"   # headless/CI constraints
created: 2026-11-10
updated: 2026-11-12
created_by_type: agent
---

> **Evidence status:** the invocation, the `--ignoreHeadlessMode` requirement, the exit code and the report path
> below were **run in the engine this session** on `Godot 4.7.2.stable.mono` with gdUnit4 **6.2.3** (evidence class
> *verified-in-engine*, this environment only). The version matrix and scene-runner capabilities are *documented*
> (cited). Status `proposed`: a human still reviews before `verified`.

## The command (unit tests, no UI)
```
<godot> --headless --path . -s res://addons/gdUnit4/bin/GdUnitCmdTool.gd --ignoreHeadlessMode -a res://tests
```
- `-s res://addons/gdUnit4/bin/GdUnitCmdTool.gd` runs gdUnit4's command-line tool (a `SceneTree` script).
- `-a <dir>` adds a directory (or file) of test suites; repeatable.
- **`--ignoreHeadlessMode` is required.** Without it gdUnit4 prints *"Headless mode is not supported!"* and aborts
  with internal code 103, because Godot does not deliver `InputEvent`s in headless mode. For **unit** tests that do
  not simulate input this is safe; tests that drive the scene runner's mouse/keyboard/touch need a real display
  (Xvfb or a windowed run) — see `src-gs-gut-gdunit4`.
- Exit codes: **0 pass / 100 fail / 101 warnings** (so CI can gate on them). `--headless` is still passed to Godot
  itself; only gdUnit4's own guard needs the override.

## Notes verified this session
- gdUnit4 writes a JUnit `results.xml` + HTML under `reports/report_N/` in the project root — **gitignore it**.
- The upstream repository moved to `godot-gdunit-labs/gdUnit4`; latest release at the time was **v6.2.3**
  (no zip asset — the source tarball carries `addons/gdUnit4/`). 6.2.3 loads and runs on 4.7.2 although the matrix
  lists 6.2.x against 4.5–4.7.1.
- gdUnit4 is an editor plugin (`addons/gdUnit4/plugin.cfg`); the CLI runner works **without** enabling the plugin,
  but enabling it (`editor_plugins/enabled`) is needed for the in-editor panel.
- A plain `godot --headless --path . --check-only -s <file>.gd` parse-checks one script; its stderr carries the
  version banner, so gate on the **exit code**, not on whether stderr is empty.
- **Advancing frames headless:** `await get_tree().physics_frame` (and `process_frame`) do advance under
  `--ignoreHeadlessMode` — verified 2026-11-10 (`Engine.get_physics_frames()` increments). So lifecycle/physics-tick
  tests run without a window; only `InputEvent`-driven scene-runner tests need a display.
- **Physics integration tests (verified 2026-11-12, 27 tests with Jolt):** `async` test functions that
  `await get_tree().physics_frame` work under `--ignoreHeadlessMode` and can run a real physics world with a pure-logic
  layer on top. Two costs to plan for: physics runs at **real time** (simulated seconds = wall-clock seconds), and every
  scene added in one test shares **one** physics world — free a scene before building the next. Details and the
  measure-N-ms-after-the-event technique: [[godot-physics-engine-options-and-ball-sim]] ("Testing physics").
- **Restore global engine state in `after()`/`after_test()`.** A suite that mutates `Engine.physics_ticks_per_second`,
  `time_scale`, autoload singletons or `ProjectSettings` must restore them even when an assert fails, or it poisons
  every later suite in the same run. Capture in `before_test()`, restore in `after_test()`.

## What an agent can and cannot check
- Can: run the command and assert exit 0; confirm `reports/` is produced; confirm `--ignoreHeadlessMode` is present.
- Verified on 4.7.2 (proposed, unreviewed): under `--headless` GUI events (touch, mouse over `Control`s) are NOT delivered to the GUI, so UI-input suites need a display: run them with `xvfb-run -a godot ... GdUnitCmdTool.gd --ignoreHeadlessMode -a tests/ui` (no `--headless`) and keep them in a separate directory from the headless unit/integration suites.
- Cannot: validate input-simulation tests headlessly (they need a display); confirm compatibility on Godot or
  gdUnit4 versions other than those tested above.

## See also
- `[[godot-logging-and-crash-evidence]]` — reading headless logs/crash output
- `[[godot-ci-export-documented-limits]]` — documented headless/CI limits
