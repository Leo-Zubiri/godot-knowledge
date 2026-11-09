---
id: src-gd-pck-encryption-dedicated-server-iap-plugins-decompiler
type: source
domain: godot
source:
  url: "https://docs.godotengine.org/en/4.7/engine_details/development/compiling/compiling_with_script_encryption_key.html"
  urls:
    - "https://docs.godotengine.org/en/4.7/engine_details/development/compiling/compiling_with_script_encryption_key.html"
    - "https://docs.godotengine.org/en/4.7/tutorials/export/exporting_for_dedicated_servers.html"
    - "https://github.com/godotengine/godot-google-play-billing"
    - "https://github.com/godotengine/godot-ios-plugins"
    - "https://github.com/GDRETools/gdsdecomp"
  title: "Godot 4.7: Compiling with PCK encryption key, Exporting for dedicated servers; godot-google-play-billing (now under godot-sdk-integrations), godot-ios-plugins, GDRE Tools (gdsdecomp) README pages"
  retrieved: 2026-11-08
  version: "4.7 (page headers: Godot Engine 4.7 documentation in English; the encryption page lives under engine_details/ — the contributing/ path requested returned 404); GitHub READMEs as shown on 2026-11-08 (no commit pinned — the pages did not expose a SHA)"
  capture: paraphrased
  retrieved_via: "fetch-time summarizer (WebFetch); not verbatim"
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> Preserved pointer + key points (conventionally immutable). **Basis:** two official Godot 4.7 pages and three GitHub README pages fetched on 2026-11-08 through a summarizing fetch tool — a **paraphrased extraction**; quoted fragments are what the tool reported as quotations. Repository state is **not pinned to a commit** (the fetch showed no SHA), so plugin claims are date-stamped only. Nothing was built or run. Re-fetch before promoting dependent notes to `verified`. No synthesis here.

- **Compiling with PCK encryption key (4.7, `engine_details/development/compiling/…`):** "It is absolutely required to compile your own export templates to use PCK encryption"; "This will not work if you use official, precompiled export templates." Generate "a 256-bit AES key in hexadecimal format" (`openssl rand -hex 32`), set it as the `SCRIPT_AES256_ENCRYPTION_KEY` environment variable when compiling (the build prints a notice), then set the **same** key in the export preset's Encryption tab (CLI exports: `GODOT_SCRIPT_ENCRYPTION_KEY`). Include filters are empty by default, so "nothing will be encrypted" until filters are added. **Security limit:** "the key needs to be stored in the binary"; a compiled, optimized, symbol-stripped build means "it would take some effort to find it" — not that it is hidden. Troubleshooting: `ERROR: open_and_parse: … Returning: ERR_FILE_CORRUPT` means "the key wasn't properly included in your Godot build" (export can encrypt, runtime cannot read). The page covers PCK encryption only; no Android-specific notes (*not on the page*).
- **Exporting for dedicated servers (4.7):** run "a Godot binary on any platform with the `--headless` command line argument" (since 4.0; "You do not need to use a specialized server binary anymore, unlike Godot 3.x"); prefer an export template over the editor binary. Export preset → Resources → **Export as dedicated server** adds the `dedicated_server` feature tag (or add it in Features; "This will also force `--headless`"). Detect with `OS.has_feature("dedicated_server")` ("Feature tags are case-sensitive"), `DisplayServer.get_name() == "headless"`, or a custom `--server` user argument. Resource modes: **Strip Visuals** (textures/materials replaced by placeholders — recommended "whenever possible"), **Keep**, **Remove** (scenes referencing removed files fail to load); audio has no placeholder, so remove the reference and `load()` from script. The page does not discuss multiplayer authority (*not on the page*).
- **godot-google-play-billing (redirects to `godot-sdk-integrations/godot-google-play-billing`):** "Godot Android plugin for the Google Play Billing library"; MIT; master "supports Godot 4.2 and above", "For older Godot versions, use the 1.x branch and 1.x releases"; install by unzipping a release into `addons/GodotGooglePlayBilling/`, enabling the plugin, and turning on Gradle builds for Android export; API documented externally at `godot-sdk-integrations.github.io/godot-google-play-billing` (not read — method names, signals and the Play Billing Library version are *unverified*); no archived banner; 81 commits, 1 open issue, 2 open PRs on the day read; explicit 4.7 compatibility **not stated**.
- **godot-ios-plugins:** no repository description; MIT; `master` "is the current development branch and can introduce breaking changes"; `3.3` branch keeps the pre-new-plugin-system interface; Godot 4.x builds require checking out a matching engine tag (example `4.4-stable`; versions below 4.4 need a cherry-pick) and `./scripts/generate_xcframework.sh <plugin_name> <debug|release|release_debug> 4.0`; copy the `.gdip` and `.xcframework` into `res://ios/plugin` and enable in the iOS preset; `Engine.HasSingleton("InAppStore")` mentioned in the C# section. The README does **not** list the plugins or the InAppStore API (*unverified*: `purchase`, `restore_purchases`, `finish_transaction`, `request_product_info`); no maintenance or 4.7 statement.
- **GDRE Tools (gdsdecomp):** "Full project recovery" from APK, PCK or embedded EXE, a PCK extractor/creator, a "GDScript batch decompiler", resource text/binary converter; "has support for decompiling Godot 4.x, 3.x, and 2.x projects"; `--key` takes "The Key to use if project is encrypted as a 64-character hex string" (the README does not say how a key is obtained — extracting it from a binary is *not stated there*); GDExtension/GDNative scripts not converted; MIT; no legal/ethical disclaimer on the page.
