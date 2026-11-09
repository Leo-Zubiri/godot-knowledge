---
id: godot-logging-and-crash-evidence
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 logging as an evidence source for automated QA: log file path and rotation, print flushing differences, crash markers and backtraces, verbose flags, remote debug, and error suppression."
tags: [dept/qa, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Logging and debugging tools pages for Godot 4.7; Engine.print_error_messages (per research subagent)"
    ref: src-gd-accessibility-logging-debug
    retrieved: 2026-11-08
related:
  - relates-to: "[[game-studio-acceptance-criteria]]"   # logs as evidence
  - relates-to: "[[game-studio-evidence-driven-visual-qa]]"   # other evidence kinds
  - relates-to: "[[godot-build-metadata-and-feature-tags]]"   # debug vs release behaviour
  - relates-to: "[[godot-error-crash-reporting-and-enriched-logging]]"   # the in-game module that writes the logs this note reads forensically
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7* per research subagent, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine or a build: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


- **Log file:** desktop default `user://logs/godot.log`; settings `debug/file_logging/enable_file_logging` (default false on non-PC variants, true for the `.pc` variant), `log_path`, `max_log_files` (default 5); a new file per session with rotation.
- **Flushing:** `print()` is flushed on each call in debug builds only; in release it flushes at exit or crash unless `application/run/flush_stdout_on_print` is enabled; `printerr()`, `push_error()` and `push_warning()` write to stderr and flush every time. Custom loggers do not receive `push_error`/`push_warning` messages.
- **Crashes:** the backtrace goes to stderr and the log file (not the Output panel). Useful backtraces need debugging symbols, which official binaries lack (a custom build is needed). A script can search the previous log for the crash marker "Program crashed with signal" on the next launch.
- **Verbosity:** `--verbose` overrides the project setting; `print_verbose()` prints only in verbose mode; `--quiet` and `--print-fps` exist; `--log-file` is not mentioned.
- **Debugging exports:** remote debug options in the editor, `breakpoint` keyword, `get_cmdline_args`/`get_cmdline_user_args` (user arguments after `--`). `Engine.print_error_messages` can suppress console errors (handy in tests, but can hide errors project-wide).
- No official guidance on third-party crash reporting was found (*unverified*).

## What an agent can and cannot check
**By reading files:** logging settings in `project.godot`; scanning a produced `godot.log` from a CI or local run for error lines and crash markers; checking that no code disables error output. **Needs a build and run:** actual crashes, symbolized backtraces, remote-debug connections.

## See also
- [[game-studio-acceptance-criteria]] — where log evidence is recorded
- [[game-studio-evidence-driven-visual-qa]] — other evidence kinds
- [[godot-build-metadata-and-feature-tags]] — debug vs release behaviour
- [[godot-error-crash-reporting-and-enriched-logging]] — the in-game module that writes the logs this note reads forensically
