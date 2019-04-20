module Main exposing (Model, Msg(..), view)

import Browser
import Browser.Events
import Html exposing (..)
import Html.Attributes as Attrs exposing (..)
import Utils exposing (isJust)


type alias Model =
    { columns : List Column
    }


type alias Column =
    { title : String, cards : List Card }


type alias Card =
    { title : String
    }


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case Debug.log "msg " msg of
        NoOp ->
            model


view : Model -> Html Msg
view model =
    Html.div
        [ Attrs.class "Board" ]
        [ viewColumns model.columns ]


viewCard : Card -> Html Msg
viewCard card =
    Html.div [ Attrs.class "Card" ]
        [ Html.h4 [ Attrs.class "Card__Title" ] [ Html.text card.title ]
        ]


viewColumn : Column -> Html Msg
viewColumn col =
    Html.div [ Attrs.class "Column" ]
        [ Html.h2 [ Attrs.class "Column__Title" ] [ text col.title ]
        , Html.div [ Attrs.class "Column__Cards" ] <| List.map viewCard col.cards
        , Html.input [ Attrs.class "Column__Input" ] []
        ]


viewColumns : List Column -> Html Msg
viewColumns =
    Html.div [ Attrs.class "Columns" ] << List.map viewColumn


init : Model
init =
    { columns = [ Column "Todo" (initColumn "todo"), Column "Done" (initColumn "done") ]
    }


initColumn : String -> List Card
initColumn prefix =
    let
        card : Int -> Card
        card i =
            Card (prefix ++ String.fromInt i)
    in
    List.map card <| List.range 1 3


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
