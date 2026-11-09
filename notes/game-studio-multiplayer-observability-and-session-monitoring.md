---
id: game-studio-multiplayer-observability-and-session-monitoring
type: guide
domain: game-studio
status: proposed
summary: "How to monitor a live multiplayer Godot game: which session/match and health signals to emit (CCU, match lifecycle, RTT, disconnects, errors, server tick/CPU/memory), where authority emits them (server-authoritative host, a --headless dedicated server, or a Nakama backend), and the generic observability stack (metrics/logs/traces, Prometheus/OpenTelemetry/Grafana) with a solo-dev minimal tier — consent and privacy throughout."
aliases: [multiplayer monitoring, server observability, match monitoring, CCU, telemetry, three pillars]
tags: [dept/qa, tool/godot, dept/game-dev]
sources:
  - claim: "Godot dedicated server: --headless since 4.0, 'Export as dedicated server' adds the dedicated_server feature tag, OS.has_feature('dedicated_server')/DisplayServer 'headless' detection, enable flush_stdout_on_print so journald collects logs"
    ref: src-gd-dedicated-server-export
    retrieved: 2026-11-08
  - claim: "Prometheus = pull/scrape time-series metrics with labels, Apache-2.0/CNCF, not for 100% accuracy; OpenTelemetry = vendor-neutral traces/metrics/logs, 'not an observability backend itself'; Grafana = query/visualize/alert over data stored elsewhere"
    ref: src-gs-observability-prometheus-otel-grafana
    retrieved: 2026-11-08
  - claim: "Nakama relayed vs authoritative matches, match lifecycle (ends when all participants offline), presence = per-match list of presences, the multiplayer page does not expose presence events or a way to monitor active matches, metrics.prometheus_port (0 disables)/namespace/reporting_freq_sec, logger JSON levels"
    ref: src-gs-nakama-multiplayer-and-metrics
    retrieved: 2026-11-08
  - claim: "OWASP logging: record when/where/who/what, never session ids/tokens/PII; tamper detection"
    ref: src-gs-backend-nakama-stripe-idempotency-owasp-logging
    retrieved: 2026-11-08
related:
  - depends-on: "[[godot-lan-host-authoritative-turn-based]]"   # physics isn't deterministic so the host is the source of truth that emits events
  - relates-to: "[[godot-error-crash-reporting-and-enriched-logging]]"   # structured error logs are one of the three observability pillars
  - relates-to: "[[game-studio-anti-cheat-and-purchase-integrity]]"   # same server-authority and never-log-secrets rules
  - relates-to: "[[game-studio-delivery-steam-store-privacy-notes]]"   # telemetry consent and store privacy obligations
  - relates-to: "[[game-studio-session-lifecycle]]"   # name-collision disambiguation only: that note is AI-AGENT sessions, not multiplayer sessions
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** Godot dedicated-server, Nakama and observability-tool facts are *documented* from official pages retrieved 2026-11-08 (paraphrased — see sources). The signal catalogue, the solo-dev-vs-full-stack tiering and alerting thresholds are *interpretation*. Tool licences marked *unverified* (OpenTelemetry, Grafana) were not confirmed on the pages read; Nakama Godot-client 4.7 support is *unverified*. Status `proposed`.

## Scope
Monitoring a **live multiplayer game** — sessions, matches, connected players, health — so you can see what is happening in production and be alerted when it breaks. **Not** the same as the agent-ops note [[game-studio-session-lifecycle]]: that is **AI-agent** session memory/compaction, which only shares the word "session". This note is about **player/match sessions** on a game server. **Evidence classes:** emitted metrics (numeric time series), structured event logs (match/session events), traces (a request/match across services), and server host health.

## 1. What to monitor (define each as an emitted event/metric)
| Signal | Shape | Notes |
|---|---|---|
| **CCU** — concurrent players | gauge | the headline health number; alert on a sharp drop |
| **Session/match lifecycle** | events: `created → started → ended → abandoned` | one structured record per transition with match id + timestamp |
| **Round/turn counts** | counter / histogram | per match; detect stuck matches (no progress) |
| **RTT / latency** | histogram per player | tail (p95/p99) matters more than mean |
| **Disconnects & reconnects** | counters | spikes signal network or build problems |
| **Errors per match** | counter by severity | feed from the error module (§4) |
| **Server health** (dedicated server) | gauges: CPU, memory, frame time, **physics/network tick budget** | tick overrun = the server can't keep up |

Nakama frames the lifecycle: a match is "kept in-memory and exist[s] on the server until their last participant has left", and for passive turn-based games "once all participants are offline, the server writes the match state to the database and terminates the match" (*documented*). **Presence** = per-match "list of presences"; note the multiplayer page "does not mention presence events or any way to monitor active matches" (*documented*) — so match monitoring is something **you build** from metrics + logs, not a turnkey feature.

## 2. Where authority and emission live
Emit from **whoever owns the truth**:
- **Server-authoritative host** (LAN or dedicated): because physics isn't deterministic the **host is the source of truth** ([[godot-lan-host-authoritative-turn-based]]) — so the host, not clients, emits match/session events. Trusting client-reported metrics invites the same cheating problem as [[game-studio-anti-cheat-and-purchase-integrity]].
- **Godot dedicated server** (`--headless` since 4.0; "Export as dedicated server" adds the `dedicated_server` feature tag; detect with `OS.has_feature("dedicated_server")` or `DisplayServer.get_name() == "headless"`) writing **structured logs** plus an optional metrics endpoint. Enable `application/run/flush_stdout_on_print` so a service manager (journald) captures complete logs (*documented*).
- **Backend (Nakama)** exposing match listing, presence and metrics: `metrics.prometheus_port` ("Default value is '0' which disables Prometheus exports"), `metrics.namespace`, `metrics.reporting_freq_sec` (default 60), JSON `logger` with levels (*documented*). Nakama client SDKs include Godot, though **4.7 support is unverified** here.

## 3. Generic observability building blocks (the three pillars)
Honest one paragraph each — framed as **metrics + logs + traces**:
- **Metrics** (Prometheus): "open-source systems monitoring and alerting toolkit"; time series with **labels**, collected "via a pull model over HTTP" (it *scrapes* an endpoint your server exposes); Apache-2.0/CNCF. Caveat it states itself: "If you need 100% accuracy, such as for per-request billing, Prometheus is not a good choice" — fine for CCU/latency, not for money (*documented*).
- **Instrumentation** (OpenTelemetry): a "vendor- and tool-agnostic" standard for **traces, metrics, logs** over OTLP, but "OpenTelemetry is **not** an observability backend itself" — "backend (storage) and … frontend (visualization) … are intentionally left to other tools" (*documented*; licence *unverified*).
- **Dashboards & alerts** (Grafana): "query, visualize, alert on, and explore your metrics, logs, and traces wherever they are stored" — it **reads data stored elsewhere** (e.g. Prometheus), it is not the store; Grafana Alerting notifies via PagerDuty/email/Slack/etc. (*documented*; licence *unverified*).
- **Structured event logs** are the fourth workhorse — reuse the in-game [[godot-error-crash-reporting-and-enriched-logging]] module's JSON-lines for match/session events, following OWASP: record *when/where/who/what*, never session ids/tokens/PII (*documented*).

**Label cardinality caution:** Prometheus labels multiply series — a label like `match_id` or `player_id` can explode memory. Keep high-cardinality identifiers in the **event logs**, and keep metric labels low-cardinality (region, build, outcome) (*interpretation* from the pull/time-series model above). A minimal CCU metric looks like `game_players_online{build="release"} 37`; a match event is a log line, not a metric.

**Pick by scale.** *Solo-dev minimal tier:* structured log lines (JSON-lines to `user://logs/` or stdout→journald) **plus a few in-memory counters printed periodically** (CCU, matches, errors) — zero extra infrastructure, greppable, enough to answer "is anything on fire?". *Full stack:* expose a Prometheus endpoint, scrape it, dashboard + alert in Grafana, optionally OpenTelemetry traces across services. Start minimal; graduate only when a measured need appears.

## 4. Privacy, consent, alerting
Telemetry is **opt-in** and **minimized** — no PII, OWASP logging rules, tamper-evident storage (*documented*); carries store-page/age-rating duties ([[game-studio-delivery-steam-store-privacy-notes]]); Nakama's own docs warn metrics exports "contain sensitive server information" and must be protected (*documented*). **Alerting basics:** set thresholds on a **CCU drop**, an **error-rate** spike, and **tick overrun** (server can't hold its physics/network budget); route to one channel you actually read. Keep thresholds few and meaningful — noisy alerts get ignored (*interpretation*).

## What an agent can and cannot check
**By reading files/CLI:** that lifecycle/health events are emitted server-side (not from clients); the dedicated-server preset/feature tag exists and `flush_stdout_on_print` is on; that a metrics endpoint/port and Nakama `metrics`/`logger` config exist; that logs carry no secrets/PII (grep); that alert rules and thresholds are defined. **Needs a running deployment/human:** real CCU/latency/tick numbers under load, that scrapes and dashboards actually populate, that alerts fire and reach someone, reconnect behaviour under real network loss, and the privacy/legal adequacy of what is collected.

## See also
- [[godot-lan-host-authoritative-turn-based]] — the host is the authoritative source of truth that emits events
- [[godot-error-crash-reporting-and-enriched-logging]] — the structured-log pillar; the in-game module feeding these events
- [[game-studio-anti-cheat-and-purchase-integrity]] — shared server-authority and never-log-secrets rules
- [[game-studio-delivery-steam-store-privacy-notes]] — telemetry consent and store privacy obligations
- [[game-studio-session-lifecycle]] — disambiguation only: that note is AI-agent sessions, not multiplayer
