# Week 2: Types, Sets, Functions, and Quantifiers

## 2.1 Weekly Goal

Focus on:

```lean
Type
Set α
x ∈ A
A ⊆ B
A ∩ B
A ∪ B
Aᶜ
Function.Injective
Function.Surjective
∀ x, ...
∃ x, ...
```

## 2.2 Content

### What is `Type`?

In Lean:

```lean
α : Type
```

means that `α` is a type. Roughly, it is the ambient space in which objects live.

If:

```lean
x : α
```

then `x` is an object of type `α`. This is similar to writing `x ∈ α` informally in mathematics, but Lean emphasizes types rather than sets.

### `α` and `β`

```lean
variable {α β : Type}
```

means that `α` and `β` are arbitrary types. They could be `ℕ`, `ℝ`, `Student`, `Score`, or many other mathematical spaces.

Thus:

```lean
f : α → β
```

is a function from `α` to `β`.

### `Set α`

```lean
A : Set α
```

means that `A` is a set whose elements have type `α`.

### `A ⊆ B`

```lean
A ⊆ B
```

means:

```text
For every x, if x ∈ A, then x ∈ B.
```

In Lean, subset inclusion is essentially:

```lean
∀ x, x ∈ A → x ∈ B
```

So to prove `A ⊆ B`, you usually write:

```lean
intro x hx
```

### Set equality

To prove:

```lean
A = B
```

the most common method is:

```lean
ext x
```

This turns set equality into elementwise equivalence. Then `constructor` splits the two directions.

## 2.3 Examples

```lean
import Mathlib

open Set

variable {α β : Type}

example (A B : Set α) : A ∩ B = B ∩ A := by
  ext x
  constructor
  · intro hx
    exact And.intro hx.2 hx.1
  · intro hx
    exact And.intro hx.2 hx.1
```

Explanation:

```lean
ext x
```

turns set equality into an elementwise statement about an arbitrary element `x`.

```lean
constructor
```

splits the equivalence into two directions.

In the first direction, after:

```lean
intro hx
```

we have:

```lean
hx : x ∈ A ∩ B
```

This is equivalent to having both:

```lean
hx.1 : x ∈ A
hx.2 : x ∈ B
```

To prove:

```lean
x ∈ B ∩ A
```

we construct the pair in the opposite order:

```lean
And.intro hx.2 hx.1
```

The second direction is exactly the same argument with `A` and `B` interchanged.

```lean
example (A B C : Set α) : A ⊆ B → B ⊆ C → A ⊆ C := by
  intro hAB hBC
  intro x hxA
  exact hBC (hAB hxA)
```

Explanation:

```lean
hAB : A ⊆ B
```

is essentially:

```lean
∀ x, x ∈ A → x ∈ B
```

Thus:

```lean
hAB hxA
```

uses `hxA : x ∈ A` to produce a proof of `x ∈ B`.

Similarly:

```lean
hBC (hAB hxA)
```

produces a proof of `x ∈ C`.
