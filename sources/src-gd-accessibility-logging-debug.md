---
id: src-gd-accessibility-logging-debug
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/stable/tutorials/ui/creating_applications.html"
  urls:
    - "https://docs.godotengine.org/en/stable/tutorials/ui/creating_applications.html"
    - "https://docs.godotengine.org/en/stable/classes/class_accessibilityserver.html"
    - "https://docs.godotengine.org/en/stable/classes/class_inputmap.html"
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/logging.html"
    - "https://docs.godotengine.org/en/stable/tutorials/scripting/debug/overview_of_debugging_tools.html"
    - "https://docs.godotengine.org/en/stable/classes/class_engine.html"
  title: "Godot 4.7: screen-reader (AccessKit) support, InputMap runtime remapping, logging, debugging tools"
  retrieved: 2026-11-08
  version: "headers 4.7 per subagent for logging, debugging tools, AccessibilityServer, Engine; creating_applications and InputMap headers not reported"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch) and research-subagent extraction; not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** official pages fetched on 2026-11-08 by research subagents and summarized by a fetch-time summarizer — a **paraphrased extraction, not verbatim text**; not re-read by the main agent. Fees, prices, shares, deadlines and product defaults are recorded *only as the page wrote them on that date* and change; items marked UNV/unverified were not read on an official page (404, blocked, search-snippet only). Not legal advice. Re-fetch before promoting dependent notes to `verified`.

- **Screen reader (creating_applications):** Godot uses AccessKit; support turns on automatically when a screen reader is detected, controlled by `accessibility/general/accessibility_support` (default 0; the Auto/Always Active/Disabled labels come from a search result, UNV on exact mapping); labels via `Control.accessibility_name` and `Control.accessibility_description`; examples of testing: NVDA (Windows), VoiceOver (macOS), Orca (Linux); works even with the Dummy audio driver; the page says good usability takes significant effort and recommends testing on each platform; lists no limitations or supported-platform list. **AccessibilityServer (4.7):** server interface for screen-reader support; nodes get elements automatically so manual `create_element()` is generally unnecessary; methods seen `create_element(window_id, role)`, `create_sub_element`, `update_set_name`, `update_set_role`, `update_add_action`, `is_supported()`, `free_element`; enums AccessibilityRole/AccessibilityAction; no experimental notice and no statement of how support is enabled. Other accessibility items (colour-blind modes, text size, captions) not checked.
- **InputMap (runtime remapping):** methods `add_action(action, deadzone = 0.2)`, `erase_action`, `has_action`, `action_add_event`, `action_erase_event`, `action_erase_events`, `action_has_event`, `action_get_events`, `action_set_deadzone`, `action_get_deadzone`, `get_actions`, `event_is_action(event, action, exact_match = false)`, `get_action_description`, `load_from_project_settings()` (clears and reloads actions, discarding runtime changes). The page does not say whether runtime changes persist across runs — persistence is the game's job (by absence).
- **Logging (4.7):** desktop default log file `user://logs/godot.log`; settings `debug/file_logging/enable_file_logging` (default false on non-PC variants, true for the `.pc` variant), `log_path`, `max_log_files` (default 5); new file per session, old files rotated. `print()` is flushed on each call in debug builds only; in release it flushes at exit or crash unless `application/run/flush_stdout_on_print` is enabled; `printerr()`, `push_error()`, `push_warning()` write to stderr and flush every time; custom loggers do not receive `push_error`/`push_warning` messages. A crash backtrace goes to stderr and the log file (not the Output panel); useful backtraces need debugging symbols, which official binaries lack (a custom build is needed); a script can search the previous log for "Program crashed with signal" on the next launch; the Crash Handler message is configurable. `--verbose` overrides the project setting; `print_verbose()` prints only in verbose mode; `--quiet` and `--print-fps` exist; `--log-file` not mentioned.
- **Debugging tools (4.7):** "Deploy with Remote Debug", "Keep Debug Server Open", "Small Deploy with Network Filesystem"; `breakpoint` keyword stored in script; main Run Args vs per-instance args; `get_cmdline_args`/`get_cmdline_user_args` (user args after `--`); the page does not cover `--remote-debug` or error-output format. **Engine:** `Engine.print_error_messages` can suppress console/Output errors (useful in tests, can hide errors project-wide). No official guidance found on third-party crash reporting.
