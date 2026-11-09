# Checklist — purchase integrity and anti-cheat posture

Reference: `game-studio-anti-cheat-and-purchase-integrity`; saves: `godot-save-game-serialization`; export:
`godot-export-fundamentals`.

- [ ] Threat model written (assets × adversaries × impact × mitigation) and the posture stated to the owner:
      local-only (unprotected, no promises) / LAN host-authoritative / online server-authoritative.
- [ ] Anything with monetary value or ranking lives on a server; clients send intents only.
- [ ] Single grant function keyed by the platform transaction id with a unique constraint (idempotent; replay-safe).
- [ ] Receipts verified server-side per store; bound to the account; package/bundle id and environment checked;
      consumable vs durable handled; restore purchases implemented where required.
- [ ] Refund/revoke notifications handled and tested in sandbox; entitlements revocable.
- [ ] Rate limits on purchase, intent and login endpoints.
- [ ] Logs: transaction id, account, outcome, reason; no full tokens or PII; alert on grant-without-verification.
- [ ] No secrets, API keys or signing keys in the export; credentials files ignored by git.
- [ ] Save files never deserialize objects from untrusted data; local saves accepted as editable if offline.
- [ ] Out-of-reach measures (kernel anti-cheat, attestation, full replay validation, 24/7 bans) explicitly not
      promised.
