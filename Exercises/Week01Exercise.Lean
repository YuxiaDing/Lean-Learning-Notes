import Mathlib

example (P Q : Prop) : P ∧ Q → Q ∧ P := by
  intro h
  cases h with
  | intro h1 h2 =>
    exact And.intro h2 h1

example (P Q R : Prop) : P ∧ (Q ∧ R) → (P ∧ Q) ∧ R := by
  intro h
  constructor
  · constructor
    · exact h.1
    · exact h.2.1
  · exact h.2.2

example (P Q : Prop) : P → P ∨ Q := by
  intro hP
  left
  exact hP

example (P Q : Prop) : Q → P ∨ Q := by
  intro hQ
  right
  exact hQ

example (P Q : Prop) : ¬  (P ∨ Q) → ¬ P ∧ ¬ Q := by
  intro h
  constructor
  · intro hP
    exact h (Or.inl hP)
  · intro hQ
    exact h (Or.inr hQ)


--Basic Practice:

example (P Q : Prop) : P ∧ Q → P := by
  intro h
  exact h.1

example (P Q : Prop) : P ∧ Q → Q := by
  intro h
  exact h.2

example (P Q : Prop) : P → Q → P ∧ Q := by
  intro hP hQ
  constructor
  · exact hP
  · exact hQ

example (P Q : Prop) : P → P ∨ Q := by
  intro hP
  exact Or.inl hP

--Or.inl is left injection into an or, if h : a, then Or.inl h : a ∨ b

example (P Q : Prop) : Q → P ∨ Q := by
  intro hQ
  exact Or.inr hQ

--Additional Practice:

example (P Q R : Prop) : P ∧ (Q ∧ R) → (P ∧ Q) ∧ R := by
  intro h
  constructor
  · constructor
    · exact h.1
    · exact h.2.1
  · exact h.2.2

example (P Q R : Prop) : (P ∧ Q) ∧ R → P ∧ (Q ∧ R) := by
  intro h
  constructor
  · exact h.1.1
  · constructor
    · exact h.1.2
    · exact h.2

example (P Q : Prop) : ¬ (P ∨ Q) → ¬ P ∧ ¬ Q := by
  intro h
  constructor
  · intro hP
    exact h (Or.inl hP)
  · intro hQ
    exact h (Or.inr hQ)

example (P Q : Prop) : ¬ P ∧ ¬ Q → ¬ (P ∨ Q) := by
  intro h hPQ
  cases hPQ with
  | inl hP =>
    exact h.1 hP
  | inr hQ =>
    exact h.2 hQ
