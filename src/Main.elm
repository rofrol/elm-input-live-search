module Main exposing (..)

import Html exposing (Html, div, text, input, ul, li)
import Html.App as App
import Html.Events exposing (onInput)
import Html.Attributes exposing (..)
import String


main =
    App.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { search : String
    , searchedCities : List String
    }


cities =
    [ "Warsaw"
    , "Washington"
    , "Piaseczno"
    , "Pitsburg"
    ]


model : Model
model =
    { search = ""
    , searchedCities = []
    }



-- UPDATE


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newSearch ->
            let
                newSearchTrimmed =
                    String.trim newSearch

                citiesWhenSearchEmpty =
                    if newSearchTrimmed == "" then
                        []
                    else
                        cities
            in
                { model | search = newSearch, searchedCities = List.filter (String.startsWith newSearchTrimmed) citiesWhenSearchEmpty }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ input [ placeholder "City", onInput Change ] [] ]
        , ul [] (List.map (\city -> li [] [ text city ]) model.searchedCities)
        , div [] [ text (toString model) ]
        ]
