---
id: src-gd-pooltool-spinning-friction
type: source
kind: web-paraphrase
domain: game-design
retrieved: 2026-11-14
method: "fetch tool summarised the theory post and a web search summarised the parameter source file; formulas quoted as returned"
---

# Source — Spinning friction (decay of spin about the vertical axis) in Pooltool (paraphrased)

- **URL 1:** https://ekiefl.github.io/2020/04/24/pooltool-theory — E. Kiefl, "pooltool theory" (ball motion states, after Marlow).
- **URL 2:** https://pooltool.readthedocs.io/en/latest/_modules/pooltool/objects/ball/params.html — ball parameter source.
- **Retrieved:** 2026-11-14 · **Capture mode:** paraphrased (a summarising fetch tool returned the formulas below).

## Key extracts
- Spinning case: `ω_z(t) = ω_0z − (5·μ_sp·g / (2R))·t`, valid until the ball stops rotating; time to stop
  `t = 2R·ω_0z / (5·μ_sp·g)`. So the deceleration of the vertical-axis spin is **constant**: `5·μ_sp·g/(2R)`.
- `ω_z` is **decoupled** from the rest: the same equation is reused in the sliding and rolling cases; `ω_z` does not influence
  the contact-point slip velocity.
- The post calls `μ_sp` a phenomenological parameter added *ad hoc*: with a single point of contact the ball would spin forever.
- Parameter file (via search summary): `u_sp = u_sp_proportionality · R`, with the default proportionality `10·2/5/9 ≈ 0.444`;
  for `R = 0.028575 m` that gives `u_sp ≈ 0.0127` (arithmetic by the summariser, re-done by the note author:
  `5·0.0127·9.81/(2·0.028575) ≈ 10.9 rad/s²`).
- Not confirmed here: any measured value of `μ_sp` for real cloth.
