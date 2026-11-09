---
id: godot-export-platform-notes
type: reference
domain: godot
status: proposed
summary: "Godot 4.7 per-platform export requirements for desktop (signing, notarization), Android (SDK, keystore, AAB), iOS (macOS and Xcode) and web; no console documentation exists in the export index."
tags: [dept/delivery, tool/godot]
applies-to:
  min: "4.0"
  tested: "4.7 (documentation only; not run in the engine)"
sources:
  - claim: "Windows, Linux, macOS, Android, Gradle, iOS and web export pages for Godot 4.7"
    ref: src-gd-export-and-platforms
    retrieved: 2026-11-08
related:
  - depends-on: "[[godot-export-fundamentals]]"   # presets and templates
  - relates-to: "[[godot-web-export-constraints]]"   # web specifics
  - relates-to: "[[godot-renderer-feature-matrix]]"   # renderer limits per platform
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** distilled from the official Godot documentation (pages headed *Godot Engine 4.7* per research subagent, retrieved 2026-11-08, paraphrased extractions — see the cited source). Nothing here was run in the engine or a build: behaviour is *documented*, not *experimentally validated*. Items marked *unverified* were not found on the pages read. Status `proposed`.


| Platform | Documented requirements and pitfalls |
|---|---|
| **Windows** | x86_64 default; x86_32 not advised; arm64 will not run on x86_64 Windows; embedded PCK limit ≈3.75 GB; signing needs the Windows SDK or `osslsigncode` plus a certificate; environment variables override export menu values |
| **Linux** | seven architectures listed; **no official templates for rv64, ppc64, loongarch64**; glibc compatibility, PCK embedding and Flatpak not discussed |
| **macOS** | Universal 2 `.app`; signing and notarization (`codesign`/`notarytool` on macOS, `rcodesign` elsewhere); DMG creation needs macOS; Apple ID **or** API credentials, not both; Debugging entitlement must be off for notarization; an `.app` exported from Windows loses its executable flag (`chmod +x`) |
| **Android** | JDK (OpenJDK 17 recommended), Android SDK (Platform-Tools 35.0.0+, Build-Tools 35.0.1, Platform 35, NDK r28b, CMake 3.10.2.4988404), not a distro-packaged SDK; release keystore via `keytool` (key and keystore passwords must currently match); **Google Play needs an AAB, which requires the Gradle build and a non-debug keystore**; folders starting with an underscore are left out of the APK; C# experimental since 4.2; target SDK, architectures and CLI export not covered |
| **iOS** | **export must run on macOS with Xcode**; output is an Xcode project; 10-character Team ID and unique Bundle Identifier; simulator supports only the Compatibility renderer; C# experimental |
| **Web** | see [[godot-web-export-constraints]] |
| visionOS, consoles | visionOS page not read; **no console documentation in the export index** |

Secrets: platform pages offer environment variables for keystore paths/passwords, the encryption key and macOS certificates, so credentials need not live in files.

## What an agent can and cannot check
**By reading files:** preset options (bundle IDs, keystore variables), architecture lists, Web thread option versus hosting headers. **Needs a device or build:** signing and notarization results, Gradle build outcomes, store acceptance, Safari and mobile browser behaviour.

## See also
- [[godot-web-export-constraints]] — web
- [[godot-export-fundamentals]] — presets and templates
- [[godot-renderer-feature-matrix]] — renderer limits per platform
