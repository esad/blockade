module Ruleset exposing (..)

import List
import Array
import Random

import Direction

-- Ruleset is basically a transition table (State, Color) -> (State, Color, Direction.Turn)
-- (State, Color) tuple is encoded as a single integer so that we can use it as array index:
type alias Ruleset = 
  { nStates : Int
  , transitions : Array.Array (Int, Int, Direction.Turn)
  }

-- Generate a ruleset with a random transition for each of the n states and n colors
random : Int -> Int -> Random.Generator Ruleset
random nStates nColors =
  Random.map3
    (,,)
    (Random.int 0 (nStates-1))
    (Random.int 0 (nColors-1))
    Direction.randomTurn
  |> Random.list (nStates*nColors)
  |> Random.map (\ts -> { nStates = nStates, transitions = Array.fromList ts})

transition : Int -> Int -> Ruleset -> (Int, Int, Direction.Turn)
transition state color ruleset =
  ruleset.transitions
  |> Array.get (color * ruleset.nStates + state)
  |> Maybe.withDefault (state, color, Direction.None)