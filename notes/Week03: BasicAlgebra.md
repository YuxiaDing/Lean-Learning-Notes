# Week 3: Algebra, Order, and Automation Tactics

## 3.1 Weekly Goal

Become familiar with Lean tools for algebraic equalities and inequalities:

```lean
simp
rw
ring
linarith
nlinarith
norm_num
positivity
calc
```

## 3.2 Content

### `rw`

`rw [h]` rewrites using an equality `h`.

If:

```lean
h : a = b
```

then `rw [h]` replaces occurrences of `a` by `b` in the goal.

### `ring`

`ring` proves polynomial identities in commutative rings, such as expansions of squares.

### `linarith`

`linarith` handles linear arithmetic and linear inequalities.

### `nlinarith`

`nlinarith` handles some nonlinear arithmetic, especially when squares and nonnegativity are involved.

## 3.3 Examples

```lean
import Mathlib

example (a b c : ℝ) (h : a = b) : a + c = b + c := by
  rw [h]
```

Explanation: `rw [h]` uses `h : a = b` to rewrite the left-hand occurrence of `a` as `b`, so the goal becomes an identity.

```lean
example (a b : ℝ) : (a + b)^2 = a^2 + 2*a*b + b^2 := by
  ring
```

Explanation: this is a pure algebraic identity. Lean's `ring` tactic expands and normalizes both sides.

```lean
example (a b c : ℝ) (h1 : a ≤ b) (h2 : b ≤ c) : a ≤ c := by
  linarith
```

Explanation: this is transitivity of a linear inequality. `linarith` can combine `h1 : a ≤ b` and `h2 : b ≤ c` and derive `a ≤ c`.
