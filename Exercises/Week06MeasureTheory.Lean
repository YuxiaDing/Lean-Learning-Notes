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
#check Measurable.add
#check Measurable.const_mul

example (f : Ω → ℝ) (hf : Measurable f) : Measurable f := by
  exact hf

example (f g : Ω → ℝ) (hf : Measurable f) (hg : Measurable g) :
    Measurable (fun x => f x + g x) := by
  exact Measurable.add hf hg

example (f : Ω → ℝ) (c : ℝ) (hf : Measurable f) :
    Measurable (fun x => c * f x) := by
  exact hf.const_mul c
