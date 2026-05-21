# Week 4: Finite Sums, Sequences, and Standardized Expressions

## 4.1 Weekly Goal

The CLT frequently uses finite sums, for example:

```text
S_n = 1 / sqrt(n) * Σ_{k=0}^{n-1} X_k
```

This week focuses on:

```lean
Finset.range n
∑ k in Finset.range n, f k
open BigOperators
```

## 4.2 Content

### `Finset.range n`

```lean
Finset.range n
```

is the finite set:

```text
{0, 1, 2, ..., n - 1}
```

It does not include `n`.

### Finite sums

```lean
∑ k in Finset.range n, f k
```

means:

```text
f 0 + f 1 + ... + f (n - 1)
```

Usually write:

```lean
open BigOperators
```

before using sum notation.

### Why CLT needs this

The standardized CLT sum often has the form:

```text
(1 / sqrt n) * Σ_{k=0}^{n-1} X_k
```

In Lean, first define:

```lean
def normalizedSum (X : ℕ → ℝ) (n : ℕ) : ℝ :=
  (1 / Real.sqrt n) * ∑ k in Finset.range n, X k
```

Then prove later theorems about `normalizedSum`, instead of expanding the formula every time.

## 4.3 Examples

```lean
import Mathlib

open BigOperators

example (n : ℕ) : (∑ k in Finset.range n, (0 : ℝ)) = 0 := by
  simp
```

Explanation: a finite sum of zeros is zero. Here `simp` knows how to simplify this standard finite-sum expression.

```lean
example (n : ℕ) : (∑ k in Finset.range n, (1 : ℝ)) = n := by
  simp
```

Explanation: adding `1` exactly `n` times gives `n`. The right-hand side `n` is coerced from `ℕ` to `ℝ` automatically.

```lean
noncomputable section

def normalizedSum (X : ℕ → ℝ) (n : ℕ) : ℝ :=
  (1 / Real.sqrt n) * ∑ k in Finset.range n, X k

example (X : ℕ → ℝ) : normalizedSum X 0 = 0 := by
  simp [normalizedSum]

end
```

Explanation:

- `noncomputable section`: functions such as `Real.sqrt` are usually not computational objects in Lean, so definitions involving them often live in a noncomputable section.
- `def normalizedSum ...`: introduces a named object for the standardized finite sum.
- `simp [normalizedSum]`: unfolds the definition of `normalizedSum` and lets `simp` simplify the sum over `Finset.range 0`.


What's more, the statement

```lean
normalizedSum X 0 = 0
```

does **not** mean that all values of `X` are zero. Instead, it means that when the number of terms is `0`, the normalized sum is equal to `0`.

By definition,

```lean
normalizedSum X 0
= (1 / Real.sqrt 0) * ∑ k in Finset.range 0, X k
```

But

```lean
Finset.range 0 = ∅
```

so the summation is an empty sum:

```lean
∑ k in Finset.range 0, X k = 0
```

Therefore,

```lean
normalizedSum X 0
= (1 / Real.sqrt 0) * 0
= 0
```

The important point is that no term of the form `X k` is actually used in the sum, because `Finset.range 0` contains no elements.

So the result holds for **any** function `X : ℕ → ℝ`, regardless of the values of `X 0`, `X 1`, `X 2`, and so on.
