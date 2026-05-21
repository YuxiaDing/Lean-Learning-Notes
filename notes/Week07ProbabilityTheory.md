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
