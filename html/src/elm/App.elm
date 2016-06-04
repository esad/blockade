module App exposing (main)

import Html exposing (Html,div)
import Html.Attributes exposing (id, class, classList)
import Html.App as Html
import Html.Events exposing (..)

import Time
import Random
import Maybe

import Turmite

type Msg 
  = Tick Time.Time
  | Init Turmite.Turmite

type alias Model =
  { turmite : Maybe Turmite.Turmite
  }

type alias Flags =
  { width : Int
  , height : Int }

blockSize : Int
blockSize = 10

init : Flags -> (Model, Cmd Msg)
init flags = 
  ( { turmite = Nothing }
  , Random.generate Init (Turmite.random (flags.width//blockSize) (flags.height//blockSize) 8 2)
  )

update : Msg -> Model -> (Model, Cmd Msg)  
update msg model =
  case msg of
    Init t ->
      ({ model | turmite = Just t }, Cmd.none)
    Tick time ->
      ({ model | turmite = Maybe.map Turmite.step model.turmite}, Cmd.none)

subs : Model -> Sub Msg  
subs model =  
  Time.every (20*Time.millisecond) Tick

main : Program Flags
main =
  Html.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subs
    }

view : Model -> Html Msg
view model =
  let 
    colors =
      Maybe.map Turmite.toList model.turmite
      |> Maybe.withDefault []
    cell c =
      div
        [class <| "cell color" ++ (toString c)]
        []
    row r = 
      div
        [class "row"]
        (List.map cell r)
  in
    div
      [id "turmite"]
      (List.map row colors)
