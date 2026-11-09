---
id: src-gs-nakama-multiplayer-and-metrics
type: source
domain: game-studio
source:
  url: "https://heroiclabs.com/docs/nakama/concepts/multiplayer/"
  urls:
    - "https://heroiclabs.com/docs/nakama/concepts/multiplayer/"
    - "https://heroiclabs.com/docs/nakama/getting-started/configuration/"
  title: "Nakama: multiplayer concept (relayed vs authoritative, match lifecycle, presence) and server configuration (metrics/Prometheus, logger)"
  retrieved: 2026-11-08
  version: "pages as written 2026-11-08; not version-pinned"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** two Nakama documentation pages fetched 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Separate from `src-gs-backend-nakama-stripe-idempotency-owasp-logging` (which preserves Nakama's IAP-validation page and server/client READMEs). Nothing was deployed or run. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

- **Multiplayer concept — relayed vs authoritative:**
  - Relayed (client-authoritative): Nakama acts as a relay "with no insight into the data or whether it is correct"; clients create/join/leave matches by sending messages and the server routes data between opponents. Relayed matches are "kept in-memory and exist on the server until their last participant has left."
  - Authoritative: developer-written server runtime code defines rules such as "how many players can join, whether matches can be joined in progress"; the server "validates and broadcasts all gameplay data", which usually needs a high tick rate. Passive/turn-based authoritative matches "can use the lowest tick rate, 1."
- **Match lifecycle:** for passive turn-based games the match loop can end — "once all participants are offline, the server writes the match state to the database and terminates the match."
- **Presence:** for relayed matches "The only information maintained by the server are the ID of each match and a list of presences for each match." Authoritative passive matches keep the participant list in match state and keep the loop running while any participant is online.
- **Match listing / matchmaking:** match listing shows existing matches to join (can support a lobby); results filterable by match labels and queries. The matchmaker is a separate method that finds opponents/teammates. Scale: "A single Nakama node can run hundreds (or thousands) of matches, depending on the gameplay."
- **Gaps on the multiplayer page:** it does not describe the Match Handler API (links out), and "does not mention presence events or any way to monitor active matches" (*so monitoring is built from metrics + your own logs, not promised by this page*).
- **Server configuration — metrics (`metrics` section):**
  - `metrics.prometheus_port`: "Port to expose Prometheus. Default value is '0' which disables Prometheus exports."
  - `metrics.namespace`: "Namespace for Prometheus or prefix for Stackdriver metrics. It will always prepend node name." (default empty).
  - `metrics.prefix`: "Prefix for metric names. Default is 'nakama', empty string '' disables the prefix."
  - `metrics.reporting_freq_sec`: how often metrics are exported; default 60 seconds.
  - The page warns metrics exports "contain sensitive server information" and should be protected.
- **Server configuration — logger (`logger` section):** `logger.level` (debug/info/warn/error, default info); `logger.format` (JSON or Stackdriver, default JSON); `logger.stdout` (default true); `logger.file`; `logger.rotation` (default false), `logger.max_size` (MB, default 100), `logger.max_age`, `logger.max_backups`, `logger.compress` (gzip). No health-check endpoint key is documented on the configuration page (*unverified*).
