port module Main exposing (..)

import Html exposing (Html, text, div, img, input, button)
import Html.Events exposing (onInput, onClick)


---- MODEL ----


type alias Model =
    { word : String
    , suggestions : List String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" [], Cmd.none )



---- PORT ----
-- port for sending strings out to JavaScript


port check : String -> Cmd msg



---- UPDATE ----


type Msg
    = Change String
    | Check
    | Suggest (List String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change newWord ->
            ( Model newWord [], Cmd.none )

        Check ->
            ( model, check model.word )

        Suggest newSuggestion ->
            ( Model model.word newSuggestion, Cmd.none )



---- Subscription ---
-- port for listening for suggestions from JavaScript


port suggestions : (List String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    suggestions Suggest



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "Input number of sentences desired" ]
        , div [] [ text "The Donald markov sentence generator" ]
        , input [ onInput Change ] []
        , button [ onClick Check ] [ text "Generate" ]
        , div [] [ text (String.join " " model.suggestions) ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
