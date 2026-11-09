---
id: src-gd-error-logging-crash-engine
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/classes/class_projectsettings.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/classes/class_projectsettings.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_os.html"
    - "https://docs.godotengine.org/en/4.7/classes/class_engine.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/scripting/debug/overview_of_debugging_tools.html"
  title: "Godot 4.7: ProjectSettings file-logging keys, OS crash/has_feature/is_debug_build, Engine.print_error_messages / get_version_info, overview of debugging tools"
  retrieved: 2026-11-08
  version: "4.7 (pages headed 'Godot Engine 4.7 documentation in English')"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); ProjectSettings page truncated at 100k of 742k chars (logging keys were within the read portion); not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** four official Godot 4.7 pages fetched 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Nothing was run in the engine. The ProjectSettings class page carries the key names and defaults but, per the fetch, "lists no per-property description text", so defaults are quoted and descriptions are not. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

- **ProjectSettings — file logging (keys + defaults, no description text on the page):**
  - `debug/file_logging/enable_file_logging` = `false`; `debug/file_logging/enable_file_logging.pc` = `true` (per-platform override for desktop/PC).
  - `debug/file_logging/log_path` = `"user://logs/godot.log"`.
  - `debug/file_logging/max_log_files` = `5`.
  - `application/run/flush_stdout_on_print` = `false`; `application/run/flush_stdout_on_print.debug` = `true`.
  - `application/config/version` = `""` (project version string).
  - `application/config/project_settings_override` = `""`; general override: "Any project setting can be overridden by creating a file named `override.cfg` in the project's root directory"; related `application/config/disable_project_settings_override` = `false`.
  - Other stdout/verbosity keys: `application/run/disable_stdout` = `false`, `application/run/disable_stderr` = `false`, `debug/settings/stdout/verbose_stdout` = `false`, `debug/settings/stdout/print_fps` = `false`.
- **OS class:**
  - `OS.crash(message)`: "Crashes the engine (or the editor if called within a `@tool` script)." "This method should *only* be used for testing the system's crash handler, not for any other purpose."
  - `OS.has_feature(tag_name)`: "Returns `true` if the feature for the given feature tag is supported in the currently running instance." Tag names are case-sensitive. The standard tag named on this page is `"template"` (checks for an export template); the full tag list is on a separate Feature Tags page. Web adds `web_android`, `web_ios`, `web_linuxbsd`, `web_macos`, `web_windows`.
  - `OS.is_debug_build()`: "Returns `true` if the Godot binary used to run the project is a *debug* export template, or when running in the editor"; `false` for release templates. For export-template checks use `OS.has_feature("template")`.
  - `OS.get_name()`: "Returns the name of the host platform" — e.g. `"Windows"`, `"macOS"`, `"Linux"`, `"Android"`, `"iOS"`, `"Web"`, BSD variants.
  - `OS.alert(text, title)`: modal dialog via the host platform; blocks execution until closed.
  - The OS page does **not** document a stack-trace method (`get_memory_info()` only lists `"stack"` = current thread stack size in bytes). The GDScript built-in `get_stack()` lives on a different page (*unverified* here — not fetched).
- **Engine class:**
  - `Engine.print_error_messages` (default `true`): "If `false`, stops printing error and warning messages to the console and editor Output log." Note: does not affect the editor's Errors tab when running from the editor; setting it `false` can hide errors from other scripts. Related `print_to_stdout` (default `true`) stops regular prints but not script errors/warnings.
  - `Engine.get_version_info()`: "Returns the current engine version information as a Dictionary" with keys `major`, `minor`, `patch`, `hex`, `status`, `build`, `hash`, `timestamp`, `string`. `hex` packs one byte each of major/minor/patch for quick comparisons.
  - `max_fps` = `0` (uncapped), `physics_ticks_per_second` = `60`, `max_physics_steps_per_frame` = `8`.
- **Overview of debugging tools:**
  - Debug menu: "Deploy with Remote Debug" (deployed build connects back to your computer; "You don't need to enable it to use the GDScript debugger locally"), "Small Deploy with Network Filesystem", "Synchronize Scene/Script Changes", "Keep Debug Server Open" (keeps the editor's debug server listening for sessions started outside the editor).
  - `breakpoint` keyword in GDScript stores a breakpoint in the script itself and "is persistent across different machines when using version control".
  - Launch arguments via the Customize Run Instances dialog, read with `get_cmdline_args` / `get_cmdline_user_args` (user args after `--`). The intro notes Godot can "monitor essential metrics".
