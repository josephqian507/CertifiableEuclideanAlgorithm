import Lean

open Lean

def ExterndedEuclideanAlgorithm (a b : ℕ) : (ℕ × ℕ × ℕ) :=
  -- Calculate gcd(a, b)
  gcd (a b : ℕ) (d : ℤ) := do
    r := a % b
    if r = 0 then
      pure b
    else
      Nat.gcd


  if a > b then
    d ← gcd(a b)
  else
    d ← gcd(b a)

  -- Back substitute to find x, y s.t. ax + by = d


-- Checker: check that d|a, d|b, ax + by = d
