import Lean
import Mathlib.Data.Nat.Basic

open Lean Meta
open Nat

def ExtendedEuclideanAlgorithm (a b : ℕ) : StateT (ℕ × ℕ × ℕ × ℕ) MetaM (ℕ × ℕ × ℕ) := do
  -- Set initial values
  set (1, 0, 0, 1)
  -- Calculate gcd(a, b)
  let rec
  gcd (a b : ℕ) := do
    let q := a / b
    let r := a % b
    let mut out := 0
    if b = 0 then
      out := a
    else
      let state ← get
      set (state.2.2.1, state.2.2.2, state.1 - q * state.2.2.1, state.2.1 - q * state.2.2.2)
      out ← (gcd b r)
    pure out
  termination_by b
  decreasing_by {refine mod_lt a ?_; (expose_names; exact zero_lt_of_ne_zero h)}

  let mut d := 0
  if a > b then
    d ← gcd a b
  else
    d ← gcd b a

  -- Back substitute to find x, y s.t. ax + by = d
  let state ← get
  let x := state.2.2.1
  let y := state.2.2.2
  logInfo
  pure (x, y, d)


-- Checker: check that d|a, d|b, ax + by = d
