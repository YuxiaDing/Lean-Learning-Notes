import Mathlib

open Filter
open scoped Topology

example : Tendsto (fun _ : ℕ => (1 : ℝ)) atTop (𝓝 1) := by
  exact tendsto_const_nhds

example (c : ℝ) : Tendsto (fun _ : ℕ => c) atTop (𝓝 c) := by
  exact tendsto_const_nhds

example :
    Tendsto (fun x : ℝ => x + 1) (𝓝 0) (𝓝 1) := by
  simpa using
    ((tendsto_id : Tendsto (fun x : ℝ => x) (𝓝 0) (𝓝 0)).add tendsto_const_nhds)

def convergesToZero (u : ℕ → ℝ) : Prop :=
  Tendsto u atTop (𝓝 0)

example : convergesToZero (fun _ : ℕ => (0 : ℝ)) := by
  unfold convergesToZero
  exact tendsto_const_nhds

example (u : ℕ → ℝ) (h : Tendsto u atTop (𝓝 0)) :
    convergesToZero u := by
  unfold convergesToZero
  exact h

#check Tendsto
#check tendsto_const_nhds
#check Continuous
#check Filter.atTop
#check nhds
