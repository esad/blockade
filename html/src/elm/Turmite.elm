module Turmite exposing (..)

import Random
import Random.Extra
import String
import List
import Array

import Direction
import Ruleset

type alias Turmite =
  { x : Int
  , y : Int
  , w : Int
  , h : Int
  , state : Int
  , direction : Direction.Direction
  , ruleset : Ruleset.Ruleset
  , canvas : Array.Array Int
  }

random w h nStates nColors =
  Random.map3
    (\d s r ->
      { x = w//2
      , y = h//2
      , w = w
      , h = h
      , state = s
      , direction = d
      , ruleset = r
      , canvas = Array.repeat (w*h) 0 -- start with all pixels having color 0
      }
    )
    --(Random.int 0 (w-1))
    --(Random.int 0 (h-1))
    Direction.random
    (Random.int 0 (nStates-1))
    (Ruleset.random nStates nColors)
  |> Random.Extra.filter (boring >> not)

step : Turmite -> Turmite
step t =
  let
    currentCanvasIndex t =
      t.y * t.w + t.x
    currentColor t =
      t.canvas
      |> Array.get (currentCanvasIndex t)
      |> Maybe.withDefault 0
    (state, color, turn) = 
      Ruleset.transition t.state (currentColor t) t.ruleset
    direction = 
      Direction.turn t.direction turn
    (dx,dy) =
      Direction.toVector direction
  in
    { t 
    | direction = direction
    , state = state
    , x = (t.x + dx) % t.w -- wrap
    , y = (t.y + dy) % t.h
    , canvas = Array.set (currentCanvasIndex t) color t.canvas
    }

-- Dumb heuristic: a generate turmite is boring if canvas stays the same between 9th and the 10th step
boring : Turmite -> Bool
boring t =
  let
    iterate f x n =
      if n <= 0 then
        x
      else
        iterate f (f x) (n-1)
    t' =
      iterate step t 9
    t'' =
      step t'
  in
    (toList t') == (toList t'')

toList : Turmite -> List (List Int)
toList t = 
  let
    groupsOf n xs =
      case xs of
        [] -> []
        _  -> List.take n xs :: groupsOf n (List.drop n xs)
  in
    t.canvas
    |> Array.toList
    |> groupsOf t.w