---
id: godot-error-crash-reporting-and-enriched-logging
type: guide
domain: godot
status: proposed
summary: "A reusable in-game module pattern for Godot 4.7 that centralizes errors, warnings and crashes into enriched structured logs (user://logs/), with an optional external sink (sentry-godot or a custom HTTPRequest/Nakama POST), consent-gated and privacy-aware; complements QA log forensics and release-side crash dashboards."
aliases: [error reporter, telemetry autoload, crash reporting, structured logging, enriched logs, bug report]
tags: [tool/godot, dept/qa, dept/game-dev]
sources:
  - claim: "ProjectSettings file-logging keys/defaults (enable_file_logging(.pc), log_path user://logs/godot.log, max_log_files=5, flush_stdout_on_print(.debug)); OS.crash() is only for testing the crash handler; OS.has_feature/is_debug_build; Engine.print_error_messages / get_version_info; debugging-tools overview"
    ref: src-gd-error-logging-crash-engine
    retrieved: 2026-11-08
  - claim: "sentry-godot is the MIT-licensed Sentry SDK for Godot, a C++ GDExtension, requires Godot 4.5+ (1.x/2.x), captures crash reports/script errors/hardware info/attachments, releases up to 2.4.0 on 2026-11-08"
    ref: src-sentry-godot-sdk
    retrieved: 2026-11-08
  - claim: "OWASP: log when/where/who/what; never log session ids, access tokens, passwords, card data, encryption keys or PII; build tamper detection; Nakama is Apache-2.0 and exposes client SDKs incl. Godot; idempotency-key pattern (client-generated unique key)"
    ref: src-gs-backend-nakama-stripe-idempotency-owasp-logging
    retrieved: 2026-11-08
related:
  - relates-to: "[[godot-logging-and-crash-evidence]]"   # that note is the QA-side forensic read of logs; this one is the in-game module that writes them
  - relates-to: "[[game-studio-post-release-and-crash-reporting]]"   # that note covers release-side dashboards/licence gaps; this is the client that feeds them
  - relates-to: "[[godot-reusable-module-packaging]]"   # the ErrorReporter autoload is an addons/ extraction candidate
  - relates-to: "[[game-studio-delivery-steam-store-privacy-notes]]"   # telemetry consent and store privacy obligations
  - relates-to: "[[game-studio-anti-cheat-and-purchase-integrity]]"   # shares the "never log secrets/PII" OWASP rules and idempotent server writes
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** Godot keys, `OS.crash()`, `Engine.print_error_messages`, feature tags and the sentry-godot facts are *documented* from official pages/READMEs retrieved 2026-11-08 (paraphrased/excerpted — see sources). The module shape, severity scheme, offline-queue design and "solo-dev reach" judgements are *interpretation*. `get_stack()` details, exact 4.7.2 behaviour, and sentry-godot stability on 4.7 are *unverified* (not run). Not legal advice. Status `proposed`.

## Goal & scope
Give any Godot 4.7 game or simulation **one** place that catches failures (script errors, warnings, handled exceptions, crashes) and writes **enriched, structured** logs locally — optionally shipping them to an external system. This **complements**, and does not replace, two neighbours: [[godot-logging-and-crash-evidence]] is the QA-side *forensic read* of Godot's logs (flush timing, crash markers, verbose flags); [[game-studio-post-release-and-crash-reporting]] is the release-side *dashboard/licence* view. This note is the **in-game module that produces** the evidence both consume. **Evidence classes handled:** (1) engine errors/warnings (`push_error`/`push_warning`), (2) your own handled failures, (3) hard crashes/signals, (4) explicit user bug reports.

## 1. The module pattern — a narrow autoload
Create a single autoload singleton (e.g. `ErrorReporter` / `Telemetry`) that is the **one route** for `push_error`/`push_warning` and your own `report(severity, msg, ctx)`. Keep it narrow so it is a clean [[godot-reusable-module-packaging]] extraction candidate (move to `addons/<prefix>_telemetry/` when a second game needs it). It attaches **context** to every record:
- active scene / node path, and a stable **per-run session id** (generate once at startup);
- `application/config/version` (read it; also `Engine.get_version_info()` for engine build) — *documented*;
- build/platform tags via `OS.has_feature(...)` (`"template"`, `"dedicated_server"`, `OS.get_name()`, `OS.is_debug_build()`) — *documented*;
- a call stack **in debug builds** via GDScript's `get_stack()` (empty in release; exact behaviour *unverified* — not fetched). Godot's own crash backtrace needs debug symbols that official binaries lack (see [[godot-logging-and-crash-evidence]]).

Custom `Logger` objects do **not** receive `push_error`/`push_warning` (*documented*, see the QA note), so route those through your own API rather than relying solely on a custom logger.

## 2. Enriched / structured logs
Godot already writes `user://logs/godot.log` with rotation: `debug/file_logging/enable_file_logging` (`false`, but `.pc` = `true`), `log_path` = `"user://logs/godot.log"`, `max_log_files` = `5` — *documented*. **Build on it, don't fight it:** have the module append its own **JSON-lines** (one JSON object per line) or `key=value` records to a file under `user://logs/`, rotating by size/count yourself. Points to respect (all *documented*):
- **Flushing:** `print()` flushes per-call only in debug; in release it flushes at exit/crash unless `application/run/flush_stdout_on_print` (`.debug` = `true`) is on. `push_error`/`push_warning`/`printerr` write to stderr and flush every time.
- **Severity levels:** pick a small ordered set (DEBUG/INFO/WARN/ERROR/FATAL) and map `push_warning`→WARN, `push_error`→ERROR. `Engine.print_error_messages = false` silences console/Output errors globally — avoid it outside tests, it hides *other scripts'* errors.
- **Never log secrets/PII:** OWASP — record *when/where/who/what*, but never session ids, access tokens, passwords, card data, encryption keys or PII; mask/hash instead; build tamper detection and restrict read access (*documented*). Same rule as [[game-studio-anti-cheat-and-purchase-integrity]].

A JSON-lines record is easy to emit, grep and parse back in tests (shape is *interpretation*):
```json
{"ts":"2026-11-08T12:00:00Z","sev":"ERROR","session":"a1b2","ver":"1.2.0","scene":"res://game/Main.tscn","os":"Linux","build":"release","msg":"nil accessed in Enemy.gd:42","stack":["Main._ready","Enemy.take_hit"]}
```
Size the rotation yourself (e.g. keep N files of M MB) so a long session cannot fill `user://`; Godot's own `max_log_files` (default 5) governs only `godot.log`, not your file.

## 3. Testing the pipeline
- `OS.crash("test")` exercises the **system crash handler** — "only … for testing the system's crash handler, not for any other purpose" (*documented*). Trigger it behind a hidden dev flag in a **sandbox build only**.
- Assert a report file is written: after a simulated error, read back `user://logs/…` and check the record exists and parses (JSON-lines makes this trivial).
- **CI/headless:** run with `--headless`; enable `flush_stdout_on_print` so logs are complete at exit, then grep the produced file for ERROR/crash markers (ties to [[godot-logging-and-crash-evidence]]). A test that greps for the crash marker `"Program crashed with signal"` in the *previous* log on next launch confirms the handler fired (*documented* in the QA note).
- **Regression guard:** assert the autoload is the only writer of the structured-log path, so a stray `print()` elsewhere does not bypass severity/scrubbing.

## 4. Local vs external sinks
**Local files always** (works offline, no consent needed for on-device logs, your support baseline). **External sink optional:**
- **sentry-godot** — the **MIT-licensed** Sentry SDK for Godot, a **C++ GDExtension** that captures "crash reports, script errors, hardware information, user feedback, attachments", with release tracking (*documented*). Requires **Godot 4.5+** for its 1.x/2.x line; latest release 2.4.0 on 2026-11-08; 4.7 is within the stated range but **4.7.2 stability is unverified** (not run). Note the *hosted service* and *self-hosted server* licensing are separate from the SDK's MIT (self-hosted Sentry is source-available/FSL — see [[game-studio-post-release-and-crash-reporting]]).
- **Custom HTTPRequest POST** to your own endpoint or a backend (e.g. **Nakama**, Apache-2.0, with a Godot client — *documented*). Build it properly: **batch** records, keep an **offline queue** on disk, **retry with backoff**, and cap payload/queue **size**. Make the server write **idempotent** (client-generated unique id per record, OWASP/Stripe idempotency pattern — *documented*) so retries don't duplicate.

## 5. Consent & privacy
External reporting is **opt-in**, off by default; **minimize** data (no PII, see §2); disclose what is collected and let the player withdraw. This carries store-page and age-rating obligations — see [[game-studio-delivery-steam-store-privacy-notes]]. On-device-only logs that never leave the machine are the privacy-safe default.

## 6. In-game "report a bug" flow
Offer a player action that, **with explicit consent**, attaches the current `user://logs/…` (scrubbed per §2) plus version/platform context and sends it through the chosen sink, or saves a zip the player can email. sentry-godot exposes user-feedback/attachments for this (*documented*); otherwise do it with the custom POST.

## What an agent can and cannot check
**By reading files/CLI:** the `ErrorReporter` autoload is registered and is the only caller of the log-write path; file-logging ProjectSettings keys; that `OS.crash` is dev-flag-gated and absent from release paths; that no secrets/PII literals are logged (grep); that an offline queue + retry + idempotency id exist; sentry-godot version and the 4.5+ requirement; CI greps the produced log. **Needs a build/run/human:** that a real crash is captured and symbolized, that the external sink actually ingests records, retry/backoff under real network loss, consent UX correctness, and the legal/privacy adequacy of what is collected.

## See also
- [[godot-logging-and-crash-evidence]] — the QA-side forensic read of the logs this module writes
- [[game-studio-post-release-and-crash-reporting]] — release-side dashboards and crash-reporter licences this feeds
- [[godot-reusable-module-packaging]] — extracting the ErrorReporter autoload into `addons/`
- [[game-studio-delivery-steam-store-privacy-notes]] — telemetry consent and store privacy obligations
- [[game-studio-anti-cheat-and-purchase-integrity]] — shared OWASP "never log secrets" rules and idempotent server writes
