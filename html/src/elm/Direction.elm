module Direction exposing (..)

import Random
import Random.Extra exposing (sample)

-- Turn is one of CW (clockwise, 90° right), CCW (90° left), U (180° U-turn) or N (no turn).
type Turn =  CW | CCW | U | None

type Direction = N | S | W | E

random : Random.Generator Direction
random =
  sample [N, S, W, E] |> Random.map (Maybe.withDefault N)
  
toVector : Direction -> (Int, Int)
toVector d = 
  case d of
    N -> ( 0,-1)
    S -> ( 0, 1)
    E -> (-1, 0)
    W -> ( 1, 0)

turn : Direction -> Turn -> Direction
turn d t =
  case t of 
    None ->
      d
    U ->
      case d of
        N -> S
        S -> N
        E -> W
        W -> E
    CW ->
      case d of
        N -> E
        S -> W
        E -> S
        W -> N
    CCW ->
      case d of
        N -> W
        S -> E
        E -> N
        W -> S

randomTurn : Random.Generator Turn
randomTurn =
  sample [CW, CCW, U, None] |> Random.map (Maybe.withDefault None)
