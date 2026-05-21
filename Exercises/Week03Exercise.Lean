import Mathlib

-- Basic Practice

example (a b c : ℝ) (h : a = b) : a + c = b + c := by
  rw [h]

example (a b : ℝ) : (a + b)^2 = a^2 + 2*a*b + b^2 := by
  ring

example (x : ℝ) : x^2 + 2*x + 1 = (x + 1)^2 := by
  ring

example (a b : ℝ) (h : a ≤ b) : a + 1 ≤ b + 1 := by
  linarith

example (a b c : ℝ) (h1 : a ≤ b) (h2 : b ≤ c) : a ≤ c := by
  linarith

example (x : ℝ) : x^2 ≥ 0 := by
  nlinarith

example (x y : ℝ) (hx : 0 ≤ x) (hy : 0 ≤ y) : 0 ≤ x + y := by
  linarith
