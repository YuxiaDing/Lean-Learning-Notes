# Week 04: Finite Sums in Lean — Exercise Notes

## Exercise 1: Sum of zeros

```lean
example (n : ℕ) : (Finset.range n).sum (fun _ => (0 : ℝ)) = 0 := by
  simp
```

This statement says that the sum of `n` zeros is still zero.

$$
\sum_{k=0}^{n-1} 0 = 0
$$

The proof uses `simp`, because Lean already knows that a finite sum of zeros is zero.

---

## Exercise 2: Sum of ones

```lean
example (n : ℕ) : (Finset.range n).sum (fun _ => (1 : ℝ)) = (n : ℝ) := by
  simp
```

This statement says that summing `1` over `Finset.range n` gives `n`.

$$
\sum_{k=0}^{n-1} 1 = n
$$

The term `(n : ℝ)` casts the natural number `n : ℕ` into a real number, since the left-hand side has type `ℝ`.

---

## Exercise 3: Sum of a constant

```lean
example (n : ℕ) (a : ℝ) :
    (Finset.range n).sum (fun _ => a) = (n : ℝ) * a := by
  simp
```

This statement says that the sum of `n` copies of a constant `a` is `n * a`.

$$
\sum_{k=0}^{n-1} a = n a
$$

The notation `fun _ => a` means that the summand is always `a` and does not depend on the index.

---

## Exercise 4: Sum distributes over addition

```lean
example (n : ℕ) (f g : ℕ → ℝ) :
    (∑ k ∈ Finset.range n, f k + g k)
      =
    (∑ k ∈ Finset.range n, f k) + (∑ k ∈ Finset.range n, g k) := by
  rw [Finset.sum_add_distrib]
```

This statement expresses the linearity of finite sums with respect to addition.

$$
\sum_{k=0}^{n-1} (f(k)+g(k))
=
\sum_{k=0}^{n-1} f(k)
+
\sum_{k=0}^{n-1} g(k)
$$

The proof uses `rw [Finset.sum_add_distrib]`, which rewrites the sum of a pointwise addition as the addition of two sums.

---

## Exercise 5: Definition of `normalizedSum`

```lean
noncomputable section

def normalizedSum (X : ℕ → ℝ) (n : ℕ) : ℝ :=
  (1 / Real.sqrt n) * ∑ k ∈ Finset.range n, X k
```

This defines the normalized finite sum of a real sequence `X`.

$$
\mathrm{normalizedSum}(X,n)
=
\frac{1}{\sqrt n}
\sum_{k=0}^{n-1} X_k
$$

The keyword `noncomputable` is needed because `Real.sqrt` is a mathematical function that Lean does not treat as directly computable.

---

## Exercise 6: Normalized sum with zero terms

```lean
example (X : ℕ → ℝ) : normalizedSum X 0 = 0 := by
  simp [normalizedSum]
```

This statement says that when `n = 0`, the normalized sum is zero because the sum is taken over the empty set.

$$
\sum_{k \in \mathrm{Finset.range}\ 0} X_k = 0
$$

The proof `simp [normalizedSum]` unfolds the definition and simplifies the empty sum.

---

## Exercise 7: Normalized sum of the zero sequence

```lean
example (n : ℕ) : normalizedSum (fun _ => 0) n = 0 := by
  simp [normalizedSum]
```

This statement says that if every term of the sequence is zero, then the normalized sum is zero.

$$
\frac{1}{\sqrt n}
\sum_{k=0}^{n-1} 0
=
0
$$

The proof unfolds `normalizedSum` and uses the fact that a finite sum of zeros is zero.

---

## Key Lean ideas

- `Finset.range n` represents the finite set `{0, 1, ..., n - 1}`.
- `(n : ℝ)` casts a natural number into a real number.
- `simp` proves many basic simplification facts automatically.
- `rw [theorem_name]` rewrites the goal using a known theorem.
- `simp [definition_name]` unfolds a definition and then simplifies it.
