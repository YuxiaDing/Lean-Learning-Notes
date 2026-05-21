# Week 6: Introduction to MeasureTheory

## 6.1 Weekly Goal

Begin the probability-theory prerequisites needed for the CLT. The goal this week is not to prove difficult probability theorems right away. The goal is to learn how to read the types of measure-theoretic objects in Lean.

Focus on:

```lean
MeasurableSpace Ω
Measurable
Measurable X
Measure
Measure Ω
Measure.map
∫ x, f x ∂μ
```

By the end of the week, you should be able to explain the following lines in ordinary mathematical language:

```lean
variable [MeasurableSpace Ω]
variable (X : Ω → ℝ)
variable (hX : Measurable X)
variable (μ : Measure Ω)
```

## 6.2 Content

### Sample spaces, measurable spaces, and random variables

In probability theory, a probability space is often written as:

```text
(Ω, 𝓕, P)
```

where:

- `Ω` is the sample space.
- `𝓕` is a sigma-algebra on `Ω`, meaning the collection of measurable events.
- `P` is a probability measure.

In Lean, these pieces are represented by different objects. First:

```lean
Ω : Type
```

means that `Ω` is a type. You can think of it as the space where sample points live. If:

```lean
ω : Ω
```

then `ω` is a sample point.

But `Ω : Type` alone is not enough. To talk about measurable sets, measurable functions, and measures, Lean also needs a measurable-space structure on `Ω`:

```lean
[MeasurableSpace Ω]
```

This says that the current context contains a measurable-space structure on `Ω`. Mathematically, you can read it as the sigma-algebra `𝓕`.

Thus:

```lean
variable [MeasurableSpace Ω]
```

can be read as:

```text
Assume that Ω is equipped with a measurable-space structure.
```

In textbook language:

```text
(Ω, 𝓕) is a measurable space.
```

### What does `X : Ω → ℝ` mean?

In measure-theoretic formalization, a random variable can be viewed as a function:

```lean
X : Ω → ℝ
```

where:

- `Ω` is the sample space.
- `ℝ` is the value space.
- `X ω` is the value of the random variable at the sample point `ω`.

Mathematically, this says:

```text
X is a function from the sample space Ω to the real numbers ℝ.
```

But a function alone is not enough; it must also be measurable.

### What does `Measurable X` mean?

```lean
Measurable X
```

is a proposition. It means:

```text
X is a measurable function.
```

More explicitly, if `X : Ω → ℝ`, then `Measurable X` says that for every measurable set `B` in `ℝ`, the preimage:

```text
X⁻¹(B) = {ω ∈ Ω | X(ω) ∈ B}
```

is measurable in `Ω`.

This is exactly the measure-theoretic definition of a random variable.

### What does `hX : Measurable X` mean?

In Lean, one often sees:

```lean
variable [MeasurableSpace Ω]
variable (X : Ω → ℝ)
variable (hX : Measurable X)
```

Line by line:

```lean
variable [MeasurableSpace Ω]
```

means that `Ω` has a measurable-space structure.

```lean
variable (X : Ω → ℝ)
```

means that `X` is a function from `Ω` to `ℝ`.

```lean
variable (hX : Measurable X)
```

means that `hX` is a proof of the proposition `Measurable X`. In other words, `hX` is the assumption that `X` is measurable.

Important: `hX` is not another random variable and not another function. It is a proof object.

In ordinary mathematical language, the three Lean lines above can be read as:

```text
Let X : Ω → ℝ be a measurable function.
```

or:

```text
Let X be a real-valued random variable.
```

Lean splits that phrase into two parts:

```lean
X : Ω → ℝ
hX : Measurable X
```

The first line gives the function. The second line gives the measurability proof needed for that function to count as a random variable.

### What does `Measure Ω` mean?

```lean
μ : Measure Ω
```

means that `μ` is a measure on `Ω`. Mathematically:

```text
μ is a measure defined on the measurable subsets of Ω.
```

If we want to say that `μ` is a probability measure, we usually need an additional assumption:

```lean
IsProbabilityMeasure μ
```

Thus:

```lean
μ : Measure Ω
```

only says that `μ` is a measure, while:

```lean
IsProbabilityMeasure μ
```

further says that the total mass is one.

### Distribution / law

The distribution of a random variable `X` is often written:

```text
Law(X)
```

In Lean, this is commonly represented as a pushforward measure:

```lean
Measure.map X μ
```

where:

- `μ : Measure Ω` is a measure on the sample space.
- `X : Ω → ℝ` is the random variable.
- `Measure.map X μ : Measure ℝ` is the measure induced on `ℝ`.

Mathematically:

```text
(Measure.map X μ)(B) = μ({ω | X ω ∈ B})
```

That is:

```text
the mass assigned by the distribution of X to B
= the μ-mass of the sample points whose X-value lies in B.
```

This is the core meaning of the distribution of a random variable.

### Expectation

Mathematically:

```text
E[X] = ∫ X dμ
```

In Lean, integrals appear in forms such as:

```lean
∫ x, X x ∂μ
```

Here:

- `x` is the integration variable, representing a sample point.
- `X x` is the value of the random variable at that sample point.
- `∂μ` means that the integration is with respect to the measure `μ`.

So:

```lean
∫ x, X x ∂μ
```

can be read as:

```text
Integrate the function X over the sample space with respect to μ.
```

In probability language, this is the expectation of `X`.

## 6.3 Examples and Exploration

The goal this week is not to prove difficult theorems. The main task is to use `#check` to inspect the types of objects and translate Lean types into mathematics.

```lean
import Mathlib

open MeasureTheory

variable {Ω α : Type}
variable [MeasurableSpace Ω]
variable [MeasurableSpace α]

#check Measurable
#check Measure
#check Measure.map
#check measure_univ
#check lintegral_const
#check integral_const
```

Practice reading these as follows:

```text
Measurable:
a predicate saying that a function is measurable.

Measure:
the type of measures on a measurable space.

Measure.map:
pushes a measure forward along a function.
```

A simple skeleton:

```lean
import Mathlib

open MeasureTheory

variable {Ω : Type}
variable [MeasurableSpace Ω]

example (f : Ω → ℝ) (hf : Measurable f) : Measurable f := by
  exact hf
```

Explanation:

```lean
example (f : Ω → ℝ) (hf : Measurable f) : Measurable f := by
```

declares a very simple statement: if `f` is a function from `Ω` to `ℝ`, and `hf` is a proof that `f` is measurable, then the goal is to prove that `f` is measurable.

The context already contains:

```lean
hf : Measurable f
```

and the goal is:

```lean
⊢ Measurable f
```

Therefore:

```lean
exact hf
```

finishes the proof directly.

The point is not the theorem itself. The point is to understand that:

```text
hf is a proof that f is measurable.
```
