module Main exposing (Model, Msg(..), view)

import Browser
import Browser.Events
import Html exposing (..)
import Html.Attributes as Attrs
import Html.Events as Ev
import Utils exposing (isJust)


type alias Model =
    { columns : List Column
    }


type alias Column =
    { id : Int, title : String, cards : List Card, field : String }


type alias Card =
    { title : String
    }


type Msg
    = UpdateField Int String
    | AddCard Int


update : Msg -> Model -> Model
update msg model =
    case Debug.log "msg " msg of
        UpdateField idx s ->
            let
                updateField column =
                    if column.id == idx then
                        { column | field = s }

                    else
                        column
            in
            { model | columns = List.map updateField model.columns }

        AddCard idx ->
            let
                addCard : Column -> Column
                addCard column =
                    if column.id == idx then
                        { column | cards = Card column.field :: column.cards }

                    else
                        column
            in
            { model | columns = List.map addCard model.columns }


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


viewColumn : Int -> Column -> Html Msg
viewColumn idx col =
    Html.div [ Attrs.class "Column" ]
        [ Html.h2 [ Attrs.class "Column__Title" ] [ text col.title ]
        , Html.div [ Attrs.class "Column__Cards" ] <| List.map viewCard col.cards
        , Html.input
            [ Attrs.class "Column__Input"
            , Ev.onInput (UpdateField idx)
            ]
            []
        , Html.button
            [ Attrs.class "Column_Submit"
            , Attrs.disabled <| String.isEmpty <| col.field
            , Ev.onClick <| AddCard idx
            ]
            [ Html.text "Add Card" ]
        ]


viewColumns : List Column -> Html Msg
viewColumns =
    Html.div [ Attrs.class "Columns" ] << List.indexedMap viewColumn


init : Model
init =
    { columns = [ Column 0 "Todo" (initCards "todo") "", Column 1 "Done" (initCards "done") "" ]
    }


initCards : String -> List Card
initCards prefix =
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
