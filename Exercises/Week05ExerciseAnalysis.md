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
## Definition and Examples: `convergesToZero`

```lean
def convergesToZero (u : ℕ → ℝ) : Prop :=
  Tendsto u atTop (𝓝 0)
```

This defines a predicate called `convergesToZero`.

The input `u : ℕ → ℝ` is a real-valued sequence.  
The output is a proposition saying that `u` converges to `0`.

In mathematical notation:

```text
u n → 0 as n → ∞
```

In Lean, this is written as:

```lean
Tendsto u atTop (𝓝 0)
```

Here:

- `atTop` means `n → ∞`,
- `𝓝 0` means the neighborhood filter of `0`.

---

```lean
example : convergesToZero (fun _ : ℕ => (0 : ℝ)) := by
  unfold convergesToZero
  exact tendsto_const_nhds
```

This proves that the constant zero sequence converges to zero.

The command

```lean
unfold convergesToZero
```

replaces `convergesToZero` with its definition, turning the goal into:

```lean
Tendsto (fun _ : ℕ => (0 : ℝ)) atTop (𝓝 0)
```

Then

```lean
exact tendsto_const_nhds
```

finishes the proof, because a constant function always tends to its constant value.

---

```lean
example (u : ℕ → ℝ) (h : Tendsto u atTop (𝓝 0)) :
    convergesToZero u := by
  unfold convergesToZero
  exact h
```

This example says: if we already know that `u` tends to `0`, then `u` satisfies `convergesToZero`.

The assumption

```lean
h : Tendsto u atTop (𝓝 0)
```

is exactly the unfolded meaning of:

```lean
convergesToZero u
```

So after unfolding the definition, the goal becomes exactly `h`, and `exact h` completes the proof.
