# Week 1: Propositional Logic and Proof Skeletons

## 1.1 Weekly Goal

Become familiar with the most basic logical proof tactics in Lean:

```lean
intro
exact
constructor
cases
rcases
left
right
by_cases
exfalso
contradiction
```

By the end of the week, you should know how to begin when you see these goal shapes:

| Goal shape | Common tactic |
|---|---|
| `P → Q` | `intro h` |
| `P ∧ Q` | `constructor` |
| `P ∨ Q`, prove the left side | `left` |
| `P ∨ Q`, prove the right side | `right` |
| `¬ P` | `intro hP`, then derive a contradiction |
| You already have a proof of the goal | `exact h` |

## 1.2 Content

In Lean:

```lean
P : Prop
```

means that `P` is a proposition. Examples include:

```text
P = "x > 0"
Q = "the function f is continuous"
R = "the random variable X is integrable"
```

Proving a proposition means constructing a proof object of that proposition.

### `intro`

If the goal is:

```lean
⊢ P → Q
```

then:

```lean
intro hP
```

changes the context to:

```lean
hP : P
⊢ Q
```

To prove "if P then Q", assume `P` and then prove `Q`.

### `constructor`

If the goal is:

```lean
⊢ P ∧ Q
```

then:

```lean
constructor
```

splits the goal into:

```lean
⊢ P
⊢ Q
```

### `left` and `right`

If the goal is:

```lean
⊢ P ∨ Q
```

then `left` changes the goal to `⊢ P`, while `right` changes it to `⊢ Q`.

## 1.3 Examples

```lean
import Mathlib

example (P Q : Prop) : P ∧ Q → Q ∧ P := by
  intro h
  constructor
  · exact h.2
  · exact h.1
```

Explanation:

- `intro h` introduces `h : P ∧ Q`.
- `constructor` splits the target `Q ∧ P`.
- `h.2 : Q` and `h.1 : P`.

```lean
example (P Q : Prop) : P → P ∨ Q := by
  intro hP
  left
  exact hP
```

```lean
example (P Q : Prop) : ¬ (P ∨ Q) → ¬ P ∧ ¬ Q := by
  intro h
  constructor
  · intro hP
    exact h (Or.inl hP)
  · intro hQ
    exact h (Or.inr hQ)
```

In Lean, `¬ P` is essentially `P → False`.
