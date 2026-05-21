import Mathlib

open scoped BigOperators

example (n : ℕ) : (Finset.range n).sum (fun _ => (0 : ℝ)) = 0 := by
  simp

example (n : ℕ) : (Finset.range n).sum (fun _ => (1 : ℝ)) = (n : ℝ) := by
  simp

example (n : ℕ) (a : ℝ) :
    (Finset.range n).sum (fun _ => a) = (n : ℝ) * a := by
  simp

example (n : ℕ) (f g : ℕ → ℝ) :
    (∑ k ∈ Finset.range n, (f k + g k))
      =
    (∑ k ∈ Finset.range n, f k) + (∑ k ∈ Finset.range n, g k) := by
  rw [Finset.sum_add_distrib]

noncomputable section

def normalizedSum (X : ℕ → ℝ) (n : ℕ) : ℝ :=
  (1 / Real.sqrt n) * ∑ k ∈ Finset.range n, X k

example (X : ℕ → ℝ) : normalizedSum X 0 = 0 := by
  simp [normalizedSum]

example (n : ℕ) : normalizedSum (fun _ => 0) n = 0 := by
  simp [normalizedSum]

end
