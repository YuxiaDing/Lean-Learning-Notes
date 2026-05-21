## Week 06 Exercise Explanation

The goal of this section is to practice reading Lean statements from measure theory. Focus on translating each Lean object into ordinary mathematical language.

```lean
#check Measurable
#check Measure
#check Measure.map
#check measure_univ
#check lintegral_const
#check integral_const
```

### `#check Measurable`

`Measurable` is the predicate used to say that a function is measurable.

If Lean shows something morally like:

```lean
Measurable f
```

you should read it as:

```text
f is a measurable function.
```

For example, if:

```lean
f : Ω → ℝ
```

then:

```lean
Measurable f
```

means that `f` is measurable as a function from the measurable space `Ω` to the measurable space `ℝ`.

Mathematically, this means that the preimage of every measurable set is measurable.

---

### `#check Measure`

`Measure Ω` is the type of measures on `Ω`.

If you see:

```lean
μ : Measure Ω
```

you should read it as:

```text
μ is a measure on Ω.
```

This does not automatically mean that `μ` is a probability measure. To say that `μ` is a probability measure, Lean usually needs an additional assumption such as:

```lean
IsProbabilityMeasure μ
```

So the usual probability-space pattern is:

```lean
variable [MeasurableSpace Ω]
variable (μ : Measure Ω)
variable [IsProbabilityMeasure μ]
```

This corresponds to a probability space in mathematics.

---

### `#check Measure.map`

`Measure.map` is the pushforward of a measure along a function.

If:

```lean
X : Ω → ℝ
μ : Measure Ω
```

then:

```lean
Measure.map X μ
```

is the measure on `ℝ` induced by `X`.

In probability language, this is the distribution, or law, of the random variable `X`.

Mathematically:

```text
(Measure.map X μ)(B) = μ({ω | X ω ∈ B})
```

So `Measure.map X μ` answers the question:

```text
What is the probability distribution of the values of X?
```

This object is central in probability formalization because many statements about random variables are really statements about their induced distributions.

---

### `#check measure_univ`

`measure_univ` is a theorem about the measure of the whole space.

For a measure `μ : Measure Ω`, the expression:

```lean
μ Set.univ
```

means:

```text
the measure of the whole space Ω.
```

In probability theory, for a probability measure, this value should be `1`.

So `measure_univ` is related to facts of the form:

```text
μ(Ω) = 1
```

or, more generally, to simplifying the measure of the universal set.

When reading probability-theory code, `measure_univ` often appears when Lean needs to use the fact that the total mass of the space is known.

---

### `#check lintegral_const`

`lintegral_const` is a theorem about the Lebesgue integral of a constant function for the nonnegative extended real-valued integral.

The symbol `lintegral` refers to a version of integration often written mathematically as:

```text
∫⁻ x, f x ∂μ
```

It is used for functions taking values in `ℝ≥0∞`, the extended nonnegative real numbers.

The theorem `lintegral_const` says, morally:

```text
The integral of a constant function is the constant times the measure of the whole space.
```

Mathematically, it corresponds to:

```text
∫⁻ x, c ∂μ = c * μ(Ω)
```

This is useful because many measure-theoretic arguments first reduce to constant functions.

---

### `#check integral_const`

`integral_const` is the corresponding theorem for the usual Bochner integral.

Morally, it says:

```text
The integral of a constant function is the constant multiplied by the measure of the whole space.
```

In a probability space, since the whole space has measure `1`, this becomes:

```text
∫ x, c ∂μ = c
```

So in probability language:

```text
The expectation of a constant random variable is that constant.
```

This is one of the basic sanity checks for interpreting integrals as expectations.

---

## Exercise 2: Sum of Measurable Functions

```lean
example (f g : Ω → ℝ) (hf : Measurable f) (hg : Measurable g) :
    Measurable (fun x => f x + g x) := by
  sorry
```

This statement says:

```text
If f and g are measurable real-valued functions on Ω,
then their pointwise sum is also measurable.
```

Here:

```lean
f g : Ω → ℝ
```

means that both `f` and `g` are real-valued functions on the sample space `Ω`.

```lean
hf : Measurable f
```

means that `f` is measurable.

```lean
hg : Measurable g
```

means that `g` is measurable.

The target is:

```lean
Measurable (fun x => f x + g x)
```

The expression:

```lean
fun x => f x + g x
```

is the function sending each `x : Ω` to the real number `f x + g x`.

So the whole goal says:

```text
The function x ↦ f(x) + g(x) is measurable.
```

Mathematically, this is the standard theorem:

```text
The sum of two measurable real-valued functions is measurable.
```

A Lean proof can be:

```lean
example (f g : Ω → ℝ) (hf : Measurable f) (hg : Measurable g) :
    Measurable (fun x => f x + g x) := by
  exact hf.add hg
```

The proof works because `hf.add hg` applies the theorem that the sum of measurable functions is measurable.

You can also let Lean automation find the measurability proof:

```lean
example (f g : Ω → ℝ) (hf : Measurable f) (hg : Measurable g) :
    Measurable (fun x => f x + g x) := by
  measurability
```

---

## Exercise 3: Scalar Multiple of a Measurable Function

```lean
example (f : Ω → ℝ) (c : ℝ) (hf : Measurable f) :
    Measurable (fun x => c * f x) := by
  sorry
```

This statement says:

```text
If f is a measurable real-valued function and c is a real constant,
then the scalar multiple x ↦ c f(x) is measurable.
```

Here:

```lean
f : Ω → ℝ
```

means that `f` is a real-valued function on `Ω`.

```lean
c : ℝ
```

means that `c` is a real constant.

```lean
hf : Measurable f
```

means that `f` is measurable.

The target is:

```lean
Measurable (fun x => c * f x)
```

The expression:

```lean
fun x => c * f x
```

is the function sending each `x : Ω` to `c * f x`.

So the whole goal says:

```text
The function x ↦ c f(x) is measurable.
```

Mathematically, this is the standard theorem:

```text
A constant multiple of a measurable real-valued function is measurable.
```

A Lean proof can be:

```lean
example (f : Ω → ℝ) (c : ℝ) (hf : Measurable f) :
    Measurable (fun x => c * f x) := by
  exact Measurable.const_mul hf c
```

Depending on the local Mathlib version, another possible proof style is:

```lean
example (f : Ω → ℝ) (c : ℝ) (hf : Measurable f) :
    Measurable (fun x => c * f x) := by
  exact hf.const_mul c
```

The automation tactic usually handles this goal as well:

```lean
example (f : Ω → ℝ) (c : ℝ) (hf : Measurable f) :
    Measurable (fun x => c * f x) := by
  measurability
```

---

## Summary

The main translation pattern is:

```text
Mathematics:
f is a measurable function.

Lean:
f : Ω → ℝ
hf : Measurable f
```

For random variables, this means:

```text
A random variable is represented as a function plus a measurability proof.
```

The two main closure principles practiced here are:

```text
If f and g are measurable, then f + g is measurable.
If f is measurable and c is constant, then c f is measurable.
```

These facts are basic, but they become important later because expressions built from random variables must also be shown to be measurable.
