## Explanation of the Third Example

```lean
example :
    Tendsto (fun x : ℝ => x + 1) (𝓝 0) (𝓝 1) := by
  simpa using
    ((tendsto_id : Tendsto (fun x : ℝ => x) (𝓝 0) (𝓝 0)).add tendsto_const_nhds)
```

This example proves that the function

```lean
fun x : ℝ => x + 1
```

tends to `1` as `x` tends to `0`.

In mathematical notation, this is:

```text
x → 0 ⟹ x + 1 → 1
```

or equivalently:

```text
lim x → 0, x + 1 = 1
```

The statement

```lean
Tendsto (fun x : ℝ => x + 1) (𝓝 0) (𝓝 1)
```

means:

- the input variable `x` is approaching `0`,
- this is written as `(𝓝 0)`, the neighborhood filter of `0`,
- the output `x + 1` is approaching `1`,
- this is written as `(𝓝 1)`, the neighborhood filter of `1`.

The proof uses two facts.

First,

```lean
tendsto_id
```

says that the identity function tends to the same point:

```lean
Tendsto (fun x : ℝ => x) (𝓝 0) (𝓝 0)
```

In words, as `x → 0`, we have `x → 0`.

Second,

```lean
tendsto_const_nhds
```

says that a constant function tends to its constant value:

```lean
Tendsto (fun _ : ℝ => 1) (𝓝 0) (𝓝 1)
```

In words, as `x → 0`, the constant function `1` tends to `1`.

Then `.add` combines these two convergence results:

```lean
((tendsto_id : Tendsto (fun x : ℝ => x) (𝓝 0) (𝓝 0)).add tendsto_const_nhds)
```

This proves that the sum also tends to the sum of the limits:

```text
x → 0
1 → 1
therefore x + 1 → 0 + 1
```

Since `0 + 1 = 1`, Lean can simplify the result using:

```lean
simpa using ...
```

So the whole proof means:

```text
as x tends to 0, x tends to 0;
the constant function 1 tends to 1;
therefore x + 1 tends to 1.
```
