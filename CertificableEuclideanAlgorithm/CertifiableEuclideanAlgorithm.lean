import Lean
import Mathlib.Data.Nat.Basic

open Lean Meta
open Nat

def ExterndedEuclideanAlgorithm (a b : ℕ) : MetaM (ℕ × ℕ × ℕ) := do
  -- Calculate gcd(a, b)
  let mut values := #[]
  let rec
  gcd (a b : ℕ) := do
    let r := a % b
    let mut out := 0
    if b = 0 then
      out := a
    else
      out ← (gcd b r)
    pure out
  termination_by -- ???

  let mut d := 0
  if a > b then
    d ← gcd a b
  else
    d ← gcd b a

  -- Back substitute to find x, y s.t. ax + by = d
  let x := a
  let y := b
  pure (x, y, d)


-- Checker: check that d|a, d|b, ax + by = d
