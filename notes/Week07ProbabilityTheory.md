# Week 7: ProbabilityTheory and Independence

## 7.1 Weekly Goal

The basic assumptions of the CLT are:

```text
X₁, X₂, ... are i.i.d.
E[X] = 0
Var(X) = 1
```

In Lean / Mathlib, gradually become familiar with:

```lean
ProbabilityTheory
iIndepFun
IdentDistrib
Measure.map
central_limit
```

## 7.2 Content

### Probability spaces

Mathematically, a probability space is:

```text
(Ω, F, P)
```

In Lean, common components are:

```lean
Ω : Type
[MeasurableSpace Ω]
μ : Measure Ω
IsProbabilityMeasure μ
```

This means:

- `Ω` is the sample space.
- `[MeasurableSpace Ω]` gives the measurable structure.
- `μ` is a measure.
- `IsProbabilityMeasure μ` says that `μ` is a probability measure.

### Independence

Independence has many levels in Lean: independence of events, functions, sigma-algebras, and so on. For CLT, the common object is independence of a family of random variables:

```lean
ProbabilityTheory.iIndepFun
```

This roughly corresponds to:

```text
X₁, X₂, ... are mutually independent.
```

### Identical distribution

Identical distribution is usually related to equality of pushforward measures:

```lean
Measure.map X μ = Measure.map Y μ
```

Mathlib also has a dedicated predicate:

```lean
IdentDistrib
```

## 7.3 Breaking Down the Statement of the Central Limit Theorem

The main theorem in `CLT.lean` is:

```lean
theorem central_limit (hX : ∀ n, Measurable (X n))
    {P : ProbabilityMeasure Ω} (h0 : P[X 0] = 0) (h1 : P[X 0 ^ 2] = 1)
    (hindep : iIndepFun X P) (hident : ∀ (i : ℕ), IdentDistrib (X i) (X 0) P P) :
    Tendsto (fun n : ℕ => P.map (aemeasurable_invSqrtMulSum n hX)) atTop (𝓝 stdGaussian)
```

This is a formal Lean statement of the central limit theorem.

In ordinary mathematical language, it says:

Let `X₀, X₁, X₂, ...` be measurable, independent, identically distributed real-valued random variables on a probability space. Assume that `X₀` has mean `0` and second moment `1`.

Then the distribution of

```math
\frac{1}{\sqrt n}\sum_{i=0}^{n-1} X_i
```

converges to the standard Gaussian distribution `N(0, 1)`.

### Random Variables

```lean
variable {Ω : Type*} {mΩ : MeasurableSpace Ω} {X : ℕ → Ω → ℝ}
```

Here:

```lean
X : ℕ → Ω → ℝ
```

means that `X` is a sequence of real-valued random variables.

For each natural number `n`,

```lean
X n : Ω → ℝ
```

is one random variable.

Mathematically, this is the sequence:

```text
X₀, X₁, X₂, ...
```

### Measurability

```lean
hX : ∀ n, Measurable (X n)
```

This says that every random variable `X n` is measurable.

Mathematically:

```text
Xₙ : Ω → ℝ is measurable for every n ∈ ℕ.
```

This is required so that each `X n` is a valid random variable in measure theory.

### Probability Measure

```lean
P : ProbabilityMeasure Ω
```

This means that `P` is a probability measure on the sample space `Ω`.

Mathematically:

```text
P(Ω) = 1.
```

### Mean Zero Assumption

```lean
h0 : P[X 0] = 0
```

This says that the expectation of `X 0` is zero.

Mathematically:

```text
E[X₀] = 0.
```

Since all the random variables are assumed to be identically distributed, this also means every `Xᵢ` has mean zero.

### Unit Second Moment Assumption

```lean
h1 : P[X 0 ^ 2] = 1
```

This says that the second moment of `X 0` is one.

Mathematically:

```text
E[X₀²] = 1.
```

Together with `E[X₀] = 0`, this implies that the variance is one:

```text
Var(X₀) = 1.
```

### Independence

```lean
hindep : iIndepFun X P
```

This says that the sequence of random variables `X` is independent under the probability measure `P`.

Mathematically:

```text
X₀, X₁, X₂, ... are mutually independent random variables.
```

### Identical Distribution

```lean
hident : ∀ (i : ℕ), IdentDistrib (X i) (X 0) P P
```

This says that every `X i` has the same distribution as `X 0`.

Mathematically:

```text
Xᵢ has the same distribution as X₀ for every i ∈ ℕ.
```

Together, `hindep` and `hident` express the usual iid assumption:

```text
X₀, X₁, X₂, ... are iid.
```

### Normalized Sum

The normalized sum is defined earlier as:

```lean
abbrev invSqrtMulSum {Ω} (X : ℕ → Ω → ℝ) (n : ℕ) (ω : Ω) : ℝ :=
  (√n)⁻¹ * ∑ i : Fin n, X i ω
```

This represents:

```text
(1 / √n) * ∑_{i = 0}^{n - 1} Xᵢ(ω).
```

The term:

```lean
∑ i : Fin n, X i ω
```

means that Lean sums over the finite type `Fin n`, which corresponds to the indices:

```text
0, 1, ..., n - 1.
```

The factor:

```lean
(√n)⁻¹
```

means:

```text
1 / √n.
```

So the whole expression is the normalized partial sum:

```text
Sₙ = (1 / √n) * ∑_{i = 0}^{n - 1} Xᵢ.
```

### Distribution of the Normalized Sum

The normalized sum is a random variable:

```lean
invSqrtMulSum X n : Ω → ℝ
```

Mathematically, this is:

```text
Sₙ = (1 / √n) * ∑_{i = 0}^{n - 1} Xᵢ.
```

The expression

```lean
P.map (aemeasurable_invSqrtMulSum n hX)
```

means the probability distribution of `Sₙ` under the probability measure `P`.

In measure-theoretic language, this is the pushforward measure:

```text
P ∘ Sₙ⁻¹.
```

This means that for a measurable set `A ⊆ ℝ`,

```text
(P.map Sₙ)(A) = P({ω ∈ Ω | Sₙ(ω) ∈ A}).
```

So `P.map Sₙ` does not describe the value of `Sₙ` for one particular outcome `ω`.  
Instead, it describes the whole probability law of the random variable `Sₙ`.

In probability notation, this is written as:

```text
Law(Sₙ).
```

Therefore, the function

```lean
fun n : ℕ => P.map (aemeasurable_invSqrtMulSum n hX)
```

is the sequence of probability distributions:

```text
Law(S₀), Law(S₁), Law(S₂), ...
```

The central limit theorem is about the convergence of these distributions:

```text
Law(Sₙ) → N(0, 1).
```

This is convergence in distribution, not convergence in probability.

In Lean, this is expressed by saying that the sequence of probability measures

```lean
fun n : ℕ => P.map (aemeasurable_invSqrtMulSum n hX)
```

tends to

```lean
stdGaussian
```

as `n → ∞`.
### Standard Gaussian Limit

```lean
stdGaussian
```

This is defined as:

```lean
abbrev stdGaussian : ProbabilityMeasure ℝ :=
  ⟨gaussianReal 0 1, inferInstance⟩
```

It represents the standard Gaussian distribution:

```text
N(0, 1).
```

### Convergence Statement

```lean
Tendsto (fun n : ℕ => P.map (aemeasurable_invSqrtMulSum n hX)) atTop (𝓝 stdGaussian)
```

This is the conclusion of the theorem.

It says that as `n` tends to infinity, the distribution of the normalized sum tends to the standard Gaussian distribution.

Mathematically:

```text
Law((1 / √n) * ∑_{i = 0}^{n - 1} Xᵢ) → N(0, 1).
```

Here:

```lean
atTop
```

means:

```text
n → ∞.
```

And:

```lean
𝓝 stdGaussian
```

means the neighborhood filter of the standard Gaussian distribution.

So the full conclusion is:

```text
Law(Sₙ) → N(0, 1) as n → ∞.
```

### Summary

The Lean theorem:

```lean
theorem central_limit ...
```

corresponds to the classical central limit theorem in the normalized iid case:

```text
(1 / √n) * ∑_{i = 0}^{n - 1} Xᵢ ⇒ N(0, 1).
```

The Lean assumptions encode:

- each `X n` is measurable,
- `P` is a probability measure,
- `E[X₀] = 0`,
- `E[X₀²] = 1`,
- the random variables are independent,
- the random variables are identically distributed.

The Lean conclusion encodes convergence in distribution of the normalized sums to the standard Gaussian law.
