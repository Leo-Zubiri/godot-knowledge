---
id: src-gs-observability-prometheus-otel-grafana
type: source
domain: game-studio
source:
  url: "https://prometheus.io/docs/introduction/overview/"
  urls:
    - "https://prometheus.io/docs/introduction/overview/"
    - "https://opentelemetry.io/docs/what-is-opentelemetry/"
    - "https://grafana.com/docs/grafana/latest/introduction/"
  title: "Prometheus overview, What is OpenTelemetry, Grafana introduction — generic observability building blocks"
  retrieved: 2026-11-08
  version: "pages as written 2026-11-08; Grafana page is 'latest', not version-pinned"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** three vendor/project introduction pages fetched 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. These are generic infrastructure references, not game-specific. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

- **Prometheus (prometheus.io/overview):** "open-source systems monitoring and alerting toolkit" (originally SoundCloud). Data model: time series, each value stored with its timestamp, "alongside optional key-value pairs called labels." Collection: "time series collection happens via a pull model over HTTP" — targets found via service discovery or static config; short-lived jobs can push through a gateway. Query language: PromQL. "Prometheus works well for recording any purely numeric time series." Limitation: "If you need 100% accuracy, such as for per-request billing, Prometheus is not a good choice." Governance/licence: joined the CNCF in 2016; "All components are available under the Apache 2 License." (The overview page links to, but does not describe, the counter/gauge/histogram/summary metric types.)
- **OpenTelemetry (opentelemetry.io/what-is):** an "observability framework and toolkit" for generating, exporting and collecting telemetry; "Open source, as well as vendor- and tool-agnostic"; works with backends including Jaeger and Prometheus. Signals: traces, metrics, logs. OTLP is "A standard protocol that defines the shape of telemetry data." Crucially: "OpenTelemetry is **not** an observability backend itself" — "The backend (storage) and the frontend (visualization) of telemetry data are intentionally left to other tools." A CNCF project (merger of OpenTracing + OpenCensus). The page does not name a specific licence (*unverified*; commonly Apache-2.0).
- **Grafana (grafana.com introduction):** "enables you to query, visualize, alert on, and explore your metrics, logs, and traces wherever they are stored." Turns time-series data into graphs; plugin framework connects to many data sources. Dashboards reusable via template variables, shareable across teams/environments. Grafana Alerting sends notifications "through a number of different alert notifiers" (PagerDuty, email, OpsGenie, Slack); "Visually define alert rules for your most important metrics." The intro page does not state the licence (*unverified* here; Grafana OSS is commonly AGPLv3) and does not explicitly name Prometheus as a source in the excerpt read.
