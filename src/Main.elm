module Main exposing(..)

import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { content : String
  , number : Int
  , result : String
  , guess : String
  }


init : Model
init =
  { content = ""
  , number = 0
  , result = ""
  , guess = ""
  }



-- UPDATE


type Msg
  = Change String
  | Num String
  | Comp String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }

    Num num ->
      { model | number = Maybe.withDefault 0 (String.toInt num) }

    Comp com ->
      { model | guess = com }


compare : Model -> Html Msg
compare model =
  if model.content == "" then
    text "Fiel Text"
  else if model.guess == model.content then
    text "Yeah"
  else
    text "No!"

show: Model -> Html Msg
show model =
  if model.number == 0 then
    text "No"
  else
    text (String.fromInt model.number)



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder "Text to reverse", value model.content, onInput Change ] []
    , text (String.reverse model.content)
    , div [] [input  [ placeholder "Compare", onInput Comp ] []]
    , div [] [ compare model ]
    , input [ placeholder "Number", onInput Num ] []
    , div [] [ show model ]
    ]
