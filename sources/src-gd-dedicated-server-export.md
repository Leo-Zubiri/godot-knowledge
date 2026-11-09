---
id: src-gd-dedicated-server-export
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/tutorials/export/exporting_for_dedicated_servers.html"
  title: "Godot 4.7: Exporting for dedicated servers"
  retrieved: 2026-11-08
  version: "4.7 (page headed 'Godot Engine 4.7 documentation in English')"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** the official Godot 4.7 "Exporting for dedicated servers" page fetched 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction, not verbatim text**. Nothing was run. Re-fetch before promoting dependent notes to `verified`. No synthesis here; notes cite this source by `id`.

- **Headless mode:** servers on machines without a GPU/display use the headless display server and the Dummy audio driver. Since Godot 4.0, running any platform's binary with `--headless` does this, so no special server binary is needed (unlike Godot 3.x).
- **Binary choice:** export templates are recommended for servers (no editor features, smaller, more optimized); the editor binary can run a server but is discouraged.
- **Export approaches:** either a dedicated export preset, or export only a PCK and run it with a renamed export template binary — both should produce identical output.
- **"Export as dedicated server" mode:** selected in the export preset's Resources tab; it automatically adds the `dedicated_server` feature tag.
- **Manual feature tag:** adding `dedicated_server` in the preset's Features tab also forces headless mode, without using the export mode.
- **Strip Visuals:** replaces textures and materials with placeholder classes keeping only image size; recommended wherever possible unless the server needs actual pixel data. "Keep"/"Remove" control whether a resource is exported.
- **Detecting server mode:** `OS.has_feature("dedicated_server")` (feature tags are case-sensitive); `DisplayServer.get_name() == "headless"`; a custom `--server` argument via `OS.get_cmdline_user_args()`.
- **Deployment:** on Linux a systemd service can restart the server after crashes or reboots; **enable `application/run/flush_stdout_on_print` so journald collects logs**. Docker containers are suggested for scaling.
