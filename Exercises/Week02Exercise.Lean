import Mathlib

open Set

variable {α β : Type}

--Basic Practice

example (A B : Set α) : A ∩ B = B ∩ A := by
  ext x
  constructor
  · intro h
    exact ⟨h.2, h.1⟩
  · intro h
    exact ⟨h.2, h.1⟩

example (A B : Set α) : A ∪ B = B ∪ A := by
  ext x
  constructor
  · intro h
    cases h with
    | inl hA => exact Or.inr hA
    | inr hB => exact Or.inl hB
  · intro h
    cases h with
    | inl hB => exact Or.inr hB
    | inr hA => exact Or.inl hA

example (A B C : Set α) : A ⊆ B → B ⊆ C → A ⊆ C := by
  intro hAB hBC x hxA
  have hxB : x ∈ B := hAB hxA
  have hxC : x ∈ C := hBC hxB
  exact hxC

example (A B : Set α) : A ⊆ A ∪ B := by
  intro x hxA
  exact Or.inl hxA

example (A B : Set α) : A ∩ B ⊆ A := by
  intro x hx
  exact hx.1


--function

--Injection
example (f : α → β) : Function.Injective f → ∀ x y, f x = f y → x = y := by
  intro h x y hxy
  exact h hxy
--满射
example (f : α → β) : Function.Surjective f → ∀ y, ∃ x, f x = y := by
  intro h y
  exact h y

--Subinjection
example (A B C : Set α) : A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C) := by
  ext x
  constructor
  · intro h
    cases h.2 with
    | inl hB => exact Or.inl ⟨h.1, hB⟩
    | inr hC => exact Or.inr ⟨h.1, hC⟩
  · intro h
    cases h with
    | inl hAB => exact ⟨hAB.1, Or.inl hAB.2⟩
    | inr hAC => exact ⟨hAC.1, Or.inr hAC.2⟩

--Additional Practice
example (A B C : Set α) : A ∪ (B ∩ C) = (A ∪ B) ∩ (A ∪ C) := by
  ext x
  constructor
  · intro h
    cases h with
    | inl hA => exact ⟨Or.inl hA, Or.inl hA⟩
    | inr hBC => exact ⟨Or.inr hBC.1, Or.inr hBC.2⟩
  · intro h
    cases h.1 with
    | inl hA => exact Or.inl hA
    | inr hB => cases h.2 with
      | inl hA => exact Or.inl hA
      | inr hC => exact Or.inr ⟨hB, hC⟩

