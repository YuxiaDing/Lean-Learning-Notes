# Week 5: Topology, Limits, and Filters

## 5.1 Weekly Goal

The conclusion of the CLT is fundamentally a convergence statement. In Lean, convergence is usually expressed with `Tendsto`.

Focus on:

```lean
Tendsto
Filter.atTop
𝓝
Continuous
```

## 5.2 Content

### `Tendsto`

Mathematically:

```text
u_n → a
```

In Lean:

```lean
Tendsto u atTop (𝓝 a)
```

Here:

- `u : ℕ → ℝ` is a sequence.
- `atTop` means `n → ∞`.
- `𝓝 a` is the neighborhood filter of `a`.
- The whole statement means that `u` tends to `a` as `n → ∞`.

### Constant sequences converge

```lean
Tendsto (fun n : ℕ => c) atTop (𝓝 c)
```

can be proved by:

```lean
exact tendsto_const_nhds
```

### Limits of functions at a point

Mathematically:

```text
as x → 0, x + 1 → 1
```

In Lean:

```lean
Tendsto (fun x : ℝ => x + 1) (𝓝 0) (𝓝 1)
```

## 5.3 Examples

```lean
import Mathlib

open Filter
open scoped Topology

example : Tendsto (fun n : ℕ => (1 : ℝ)) atTop (𝓝 1) := by
  exact tendsto_const_nhds
```

Explanation: the constant sequence `1, 1, 1, ...` converges to `1`.

```lean
example (c : ℝ) : Tendsto (fun n : ℕ => c) atTop (𝓝 c) := by
  exact tendsto_const_nhds
```

Explanation: any constant sequence converges to that same constant.

```lean
def convergesToZero (u : ℕ → ℝ) : Prop :=
  Tendsto u atTop (𝓝 0)

example : convergesToZero (fun n : ℕ => (0 : ℝ)) := by
  unfold convergesToZero
  exact tendsto_const_nhds
```

Explanation:

First we define our own predicate:

```lean
def convergesToZero (u : ℕ → ℝ) : Prop := ...
```

Later, when proving a statement involving this predicate, we can use:

```lean
unfold convergesToZero
```

to expand the definition back into a `Tendsto` statement.


## 5.4 Meaning of the `#check` Commands

In Lean, `#check` asks Lean to display the type of a definition, theorem, or expression.  
It does not prove anything and does not change the file. It is mainly used for exploration and learning.

```lean
#check Tendsto
```

`Tendsto` is the basic predicate for convergence in terms of filters.

Roughly, its type is:

```lean
Tendsto (f : α → β) (l₁ : Filter α) (l₂ : Filter β) : Prop
```

This means that the function `f` tends from the filter `l₁` on the domain to the filter `l₂` on the codomain.

---

```lean
#check tendsto_const_nhds
```

`tendsto_const_nhds` is the theorem saying that a constant function tends to the neighborhood filter of its constant value.

Roughly, it states:

```lean
Tendsto (fun _ => x) f (𝓝 x)
```

In words: for any filter `f`, the constant function `fun _ => x` tends to `x`.

---

```lean
#check Continuous
```

`Continuous` is the predicate saying that a function is continuous.

Roughly:

```lean
Continuous (f : X → Y) : Prop
```

It means that the function `f` is continuous on its whole domain.

---

```lean
#check Filter.atTop
```

`Filter.atTop`, usually written as `atTop`, is the filter describing “going to infinity”.

For example, on natural numbers `ℕ`, `atTop` represents `n → ∞`.

So a sequence limit is often written as:

```lean
Tendsto u atTop (𝓝 a)
```

This means that the sequence `u n` tends to `a` as `n → ∞`.

---

```lean
#check nhds
```

`nhds` means the neighborhood filter of a point.

The expression:

```lean
nhds x
```

is usually written using notation as:

```lean
𝓝 x
```

It represents the filter of all neighborhoods of the point `x`.
