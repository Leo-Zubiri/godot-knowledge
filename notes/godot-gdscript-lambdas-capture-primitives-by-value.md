---
id: godot-gdscript-lambdas-capture-primitives-by-value
type: pitfall
domain: godot
status: unreviewed
summary: "In GDScript 4 a lambda captures local variables of primitive types (float, int, bool, String…) BY VALUE at the moment it is created, so assigning to such a variable inside the lambda never changes the outer one — a `_wait_until(func(): peak = maxf(peak, x) …)` test helper then reports peak 0. Arrays and Dictionaries are references, so the usual workaround is a one-element array (`var peak := [0.0]`). Related: `var x := some_dict[...]` fails to parse (type cannot be inferred), declare the type."
aliases: [lambda capture, closure by value, gdscript closure, wait_until peak, one element array trick, cannot infer the type]
tags: [dept/gameplay, dept/testing, tool/godot]
applies-to:
  min: "Godot 4.0"
  tested: "Godot 4.7.2, gdUnit4 headless: hit twice while writing tests (peak value stayed 0; 'Cannot infer the type of credit variable')"
sources: []
related:
  - relates-to: "[[game-studio-composable-effect-resources-for-swappable-gameplay-items]]"   # where the tests that hit it live
created: 2026-11-17
updated: 2026-11-17
created_by_type: agent
---

> **Evidence status — `unreviewed`.** Observed behaviour in this project's tests, not checked against the engine source or a changelog.

## Symptom
```gdscript
var peak := 0.0
await _wait_until(func():
    peak = maxf(peak, node.value)      # assigns the lambda's own copy
    return node.done)
assert_float(peak).is_greater(0.8)     # fails: peak is still 0.0 outside
```
The test condition itself works (the lambda runs), but the outer `peak` is never updated.

## Fix
Share a reference type: `var peak := [0.0]` … `peak[0] = maxf(peak[0], node.value)` … `assert_float(peak[0])`. The same trick is already used for
flags (`var struck := [false]`) in this project's suites. A member variable of the test class also works.

## Related parse error
`var credit := Licenses.attribution_credits()[0]` → "Cannot infer the type of 'credit' variable because the value doesn't have a set type" (the array
holds Variants). Write `var credit: Dictionary = …`.

## Also seen
- A `Tween.tween_method` callback that mutates an outer primitive has the same problem: keep the previous value in a one-element array.
- Do not test timing with a lambda-captured float; sample inside the lambda and store into an array.
