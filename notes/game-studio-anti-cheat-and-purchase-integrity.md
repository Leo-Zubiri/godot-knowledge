---
id: game-studio-anti-cheat-and-purchase-integrity
type: reference
domain: game-studio
status: proposed
summary: "Threat model and decision tree for economy and fairness in a small Godot 4.7 game: what to accept when the game is local-only, host-authoritative on LAN, or online with server-verified purchases; per-store verification facts (Google Play, Apple, Steam) as written 2026-11-08; what client hardening can and cannot do; backend options; a checklist."
aliases: [anti-cheat, purchase verification, receipt validation, IAP security, entitlements, server authority]
tags: [dept/delivery, dept/game-dev, tool/godot]
applies-to:
  min: "Godot 4.0 for --headless servers; 4.7 pages read"
  tested: "documentation only; no store sandbox or server was exercised"
sources:
  - claim: "Google: verify on a backend with purchases.products.get / subscriptionsv2.get, purchaseToken is globally unique and usable as primary key, acknowledge within three days or auto-refund, do not grant on PENDING, obfuscatedAccountId, Voided Purchases API (30-day window, quotas), RTDN types, Play Integrity verdicts and quota"
    ref: src-gs-purchase-google-play-billing
    retrieved: 2026-11-08
  - claim: "Apple: App Store Server API returns JWS-signed transactions, JWT auth from App Store Connect keys, sandbox host; Server Notifications V2 types incl. REFUND, REFUND_REVERSED, REVOKE, CONSUMPTION_REQUEST; receipts and verifyReceipt deprecated; guideline 3.1.1 restore mechanism, non-expiring currencies, loot-box odds"
    ref: src-gs-purchase-apple-app-store-server
    retrieved: 2026-11-08
  - claim: "Steam: InitTxn/FinalizeTxn are called from the purchasing server with a publisher Web API key, ISteamMicroTxnSandbox for tests, RefundTxn and Valve-initiated reversals with claw-back advice, Inventory Service as a server-less alternative where the client and its keys cannot be trusted, 14-day/2-hour refund policy and 48-hour in-game-item rule for Valve titles"
    ref: src-gs-purchase-steam-microtxn-inventory-refunds
    retrieved: 2026-11-08
  - claim: "PCK encryption needs self-compiled templates and the key is stored in the binary; --headless and dedicated_server export mode; godot-google-play-billing supports 4.2+; godot-ios-plugins need per-tag builds; GDRE Tools decompiles 2.x–4.x and accepts an encryption key"
    ref: src-gd-pck-encryption-dedicated-server-iap-plugins-decompiler
    retrieved: 2026-11-08
  - claim: "Nakama (Apache-2.0, Postgres/CockroachDB) validates Apple/Google/Huawei/Facebook receipts and flags seenBefore; nakama-godot targets Godot 4.0+; Stripe idempotency keys (UUID v4, parameter comparison); OWASP logging — what to log and what never to log"
    ref: src-gs-backend-nakama-stripe-idempotency-owasp-logging
    retrieved: 2026-11-08
related:
  - depends-on: "[[godot-lan-host-authoritative-turn-based]]"   # the host-authoritative tier of the decision tree is that pattern
  - refines: "[[godot-export-fundamentals]]"   # extends its encryption caveat with the page now read
  - relates-to: "[[godot-save-game-serialization]]"   # saves without allow_objects are the local-only mitigation
  - relates-to: "[[game-studio-delivery-platforms-and-fees]]"   # store accounts and fees behind every purchase path
  - relates-to: "[[game-studio-delivery-steam-store-privacy-notes]]"   # privacy, ratings descriptors for in-game purchases
  - relates-to: "[[game-design-scoping-questions-for-new-game-or-feature]]"   # questions 0.5–0.7 decide which tier applies
created: 2026-11-08
updated: 2026-11-08
created_by_type: agent
---

> **Evidence status:** store and engine facts are *documented* from official pages retrieved 2026-11-08 (Google Play Billing, Apple App Store Server API/Notifications/Guidelines via Apple's JSON data endpoints, Steamworks, Godot 4.7 docs, project READMEs). The threat model, tiers and the "solo-dev reach" judgement are *interpretation*. Plugin compatibility with 4.7 and several API details are *unverified*. Vendor policy changes often; dates matter. Not legal advice. Status `proposed`.

## Scope
Economy integrity (currency, entitlements, purchases, refunds) and fairness (cheating in play). **Not DRM** and not copy protection: Godot has no built-in DRM and this note does not try to add one.

## Threat model
| Asset | Adversary | Impact | Mitigation tier |
|---|---|---|---|
| soft currency, unlocks | save-file editor, memory editor | self-cheat only (local) / economy inflation (online) | local: accept; online: server-held balance |
| entitlements (paid items) | receipt replay, modded client that skips the check | revenue loss, piracy of items | server verification keyed by transaction id |
| purchases | refund abuse, chargebacks | items kept after money returned | refund/void webhooks + claw-back |
| leaderboards | modded client, bots | fake scores | server-computed scores from validated inputs; without a server **cannot be secured** |
| progression / match results | malicious host (LAN), griefer | unfair games | host-authoritative with intent validation; reports; kick/ban by host |
| accounts | credential stuffing, bots | takeover, farming | platform sign-in, rate limits per account/IP |
| peers' privacy | data in logs | leaks | OWASP logging rules |

## Decision tree
| Situation | Decision | Consequence |
|---|---|---|
| **Local-only** (single player, hot-seat) | accept that the client is hackable; promise nothing to other players; read saves with `allow_objects = false` ([[godot-save-game-serialization]]) | cheap; no online claims; achievements are advisory |
| **LAN host-authoritative** | the host is trusted; clients send **intents**, the host validates who/when/range and replicates state ([[godot-lan-host-authoritative-turn-based]]) | a cheating host can still cheat — acceptable among friends |
| **Online with money** | server-authoritative state + **platform-verified purchases** on a backend you run; grants are idempotent | hosting cost, ops, privacy obligations |
| Leaderboards | only meaningful with a server that recomputes or validates results | otherwise label them "local" |

## Principles
Never trust the client (Google: "an online chess game should validate all moves in the backend" — *documented*; Steam: "the client can't be trusted (and the keys in a client can always be captured by an attacker)" — *documented*). State lives on the server; clients send intents; validate sender, turn, range and timing; rate-limit per account and IP (*interpretation*). **Grants are idempotent**: one grant function keyed by the platform transaction identifier with a **unique database constraint** — Google says `purchaseToken` "is globally unique, so you can safely use this value as a primary key" and warns **not** to use `orderId` (promo purchases have none) (*documented*); the idempotency-key pattern (client-generated unique key, server compares parameters and errors on mismatch) is described by Stripe (*documented*). Log every grant with when/where/who/what but **never** tokens, passwords, card data or keys (OWASP — *documented*).

## Purchase verification per store (as written 2026-11-08)
| Topic | Google Play | Apple | Steam |
|---|---|---|---|
| Server check | `purchases.products.get` (`…/applications/{packageName}/purchases/products/{productId}/tokens/{token}`) or `subscriptionsv2.get`; scope `androidpublisher` | App Store Server API: Get Transaction Info / History, JWS-signed payloads; JWT from App Store Connect keys; sandbox `api.storekit-sandbox.apple.com` | server calls `InitTxn` → user approves in the overlay → `FinalizeTxn`; publisher Web API key on every call |
| Must-do | acknowledge (or consume) **within three days** or auto-refund; window starts at `PURCHASED`; never grant on `PENDING` | guideline 3.1.1: restore mechanism for restorable purchases; purchased currencies may not expire; loot-box odds disclosed | "Use ISteamMicroTxnSandbox while testing!"; reconcile `GetReport` daily |
| Binding to account | `obfuscatedAccountId`/`obfuscatedProfileId` set in the billing flow and checked on the server | `appAccountToken` (Set App Account Token endpoint) | `steamid` in `InitTxn` |
| Product classes | consumable (consume) · non-consumable (acknowledge) · subscription | consumable · non-consumable · non-renewing · auto-renewable (`ONE_TIME_CHARGE` vs `SUBSCRIBED`) | items with `itemid`/`qty`/`amount`; subscriptions via agreements |
| Refund / revoke signal | Voided Purchases API (**30-day window**, 6,000/day, 30 per 30 s) + RTDN `VoidedPurchaseNotification`, `PendingRefundReviewNotification` (answer within 24 h) | Notifications V2: `REFUND`, `REFUND_REVERSED` (reinstate), `REVOKE` (Family Sharing), `CONSUMPTION_REQUEST`; V1 deprecated | `RefundTxn` (developer), Valve reversals for fraud/chargebacks — "claw-back items … if at all possible" |
| Environment checks | `packageName` in the request; sandbox via licence testers (*unverified* on pages read) | call production, on `4040010` call sandbox; `environment` in the decoded payload | sandbox vs production interface name |
| Legacy | `developerPayload` present but superseded by obfuscated ids (*interpretation*) | receipts and `verifyReceipt` **deprecated** | — |
| Integrity add-on | Play Integrity (`appRecognitionVerdict`, `deviceIntegrity` tiers; 10,000 requests/day default; "not as your sole anti-abuse mechanism") | App Attest (*unverified* — not fetched) | — |
| Refund policy to design for | per Google policy above | per Apple notifications | 14 days / < 2 hours for games; Valve titles' in-game items 48 h unused; third parties opt in |
| Alternative | — | — | Inventory Service: Steam-hosted item definitions and inventories, no own server; trusted-server grants only when the server "is the master of the state of the game" |

## Client hardening limits in Godot 4.7
| Fact | Class |
|---|---|
| No core IAP API in 4.x; Android via `godot-google-play-billing` (README: "Godot 4.2 and above"), iOS via `godot-ios-plugins` InAppStore built per engine tag; **4.7 compatibility of both is unverified** | *documented* README / *unverified* |
| PCK encryption requires **self-compiled export templates** and "the key needs to be stored in the binary" — it raises effort, it does not hide anything; official templates do not support it | *documented* |
| GDRE Tools decompiles GDScript from 2.x–4.x PCK/EXE and accepts an encryption key | *documented* |
| Binary script tokens are cosmetic against a decompiler | *interpretation* |
| Secrets (publisher keys, service-account JSON, shared secrets) never under `res://`; `.godot/export_credentials.cfg` stays out of version control | *documented* ([[godot-export-fundamentals]]) |
| Online authority: export with "Export as dedicated server" (`dedicated_server` tag, forces `--headless`; Strip Visuals) and run the template binary | *documented* |

## Gameplay cheating
Authoritative host/server; validate turn, sender, range and timing; compute scores server-side; player reports; minimal consented telemetry; realistic anomaly checks (impossible timings, value deltas larger than any legal move). Kernel-level anti-cheat, device attestation beyond the platform APIs, full replay validation and 24/7 ban operations are **out of reach for a solo developer** and should be written down as non-goals (*interpretation*).

## Backend options
| Option | Facts | Honesty |
|---|---|---|
| Nakama | Apache-2.0; Postgres/CockroachDB; "Purchase Validation" for Apple/Google/Huawei/Facebook; duplicate receipts return `seenBefore: true` (**flagged, not rejected** — your logic must act); Godot client "4.0+" (4.7 *unverified*) | you still run a database and a server |
| Own minimal server | one grant endpoint + webhooks per store | smallest surface, all ops on you |
| Supabase / PlayFab | not fetched (*unverified*); PlayFab is proprietary | vendor lock-in vs convenience |
| None | local-only tier | say so in the store page |

## Checklist
- [ ] Threat model written; **local vs LAN vs online** stated in an ADR.
- [ ] One grant function keyed by platform transaction id with a **unique constraint**; grants idempotent.
- [ ] Receipt/transaction bound to the account (`obfuscatedAccountId` / `appAccountToken` / `steamid`).
- [ ] Package/bundle id and environment (sandbox vs production) checked server-side.
- [ ] Consumable vs durable handled (consume vs acknowledge; three-day window).
- [ ] Refund/revoke webhook (RTDN, Notifications V2, Steam reversal report) handled and **tested in sandbox**; claw-back policy staged and transparent.
- [ ] Rate limits per account and IP.
- [ ] Logs without full tokens, PII or secrets; tamper-evident storage.
- [ ] No secrets in the export; `export_credentials.cfg` ignored; no publisher key in the client.
- [ ] Saves read with `allow_objects = false`.
- [ ] Solo-dev scope and non-goals (no kernel anti-cheat, no live ban ops) stated.

## What an agent can and cannot check
**By reading files/CLI:** no secrets under `res://` or in presets; the grant function and its unique index exist; webhook handlers exist for each enabled store; `allow_objects` is false; the dedicated-server preset exists; plugin versions and READMEs. **Needs sandbox, device or human:** that verification actually succeeds against each store, refund webhooks firing, Play Integrity verdict distribution, refund policy and legal/privacy obligations, and whether the threat model matches the real player base.

## See also
- [[godot-lan-host-authoritative-turn-based]] — the host-authoritative tier of the decision tree is that pattern
- [[godot-export-fundamentals]] — extends its encryption caveat with the page now read
- [[godot-save-game-serialization]] — saves without allow_objects are the local-only mitigation
- [[game-studio-delivery-platforms-and-fees]] — store accounts and fees behind every purchase path
- [[game-studio-delivery-steam-store-privacy-notes]] — privacy, ratings descriptors for in-game purchases
- [[game-design-scoping-questions-for-new-game-or-feature]] — questions 0.5–0.7 decide which tier applies
