# 01 Basic Syntax

## 1. Variables

In Lean, we can declare variables as follows:

```lean
variable (α β : Type)
variable (a b : α)
```

Here, `α` and `β` are types, while `a` and `b` are terms of type `α`.

## 2. Propositions

```lean
variable (P Q : Prop)
```

Here, `P` and `Q` are propositions.

## 3. A Simple Theorem

```lean
theorem example1 (hP : P) (hPQ : P → Q) : Q := by
  exact hPQ hP
```

This theorem says that if `P` is true and `P → Q` is true, then `Q` is true.

## 4. Notes

- `Prop` is the type of propositions.
- `Type` is the type of mathematical objects.
- A theorem in Lean is also a term with a type.
- A proof is a construction of a term of the required type.
