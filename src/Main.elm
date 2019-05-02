module Main exposing (Model, Msg(..), view)

import Browser
import Browser.Events
import Html exposing (..)
import Html.Attributes as Attrs
import Html.Events as Ev
import Json.Decode as JD


type alias Model =
    { columns : List Column
    , nextId : Int
    }


type alias Column =
    { id : Int
    , title : String
    , cards : List Card
    , field : String
    }


type alias Card =
    { title : String
    , id : Int
    }


type Msg
    = OnFieldChange Int String
    | AddCard Int
    | EnterSubmit Int Int
    | RemoveCard Int


update : Msg -> Model -> Model
update msg model =
    case Debug.log "msg " msg of
        OnFieldChange idx str ->
            let
                updateField : Column -> Column
                updateField column =
                    if column.id == idx then
                        { column | field = str }

                    else
                        column
            in
            { model | columns = List.map updateField model.columns }

        AddCard colIdx ->
            let
                addCard : Column -> Column
                addCard column =
                    if column.id == colIdx then
                        { column
                            | cards = Card column.field model.nextId :: column.cards
                            , field = ""
                        }

                    else
                        column
            in
            { model
                | columns = List.map addCard model.columns
                , nextId = model.nextId + 1
            }

        RemoveCard cardId ->
            let
                filterColumn : Column -> Column
                filterColumn column =
                    { column | cards = List.filter (\card -> card.id /= cardId) column.cards }
            in
            { model | columns = List.map filterColumn model.columns }

        EnterSubmit i code ->
            if code == 13 then
                update (AddCard i) model

            else
                model


view : Model -> Html Msg
view model =
    Html.div
        [ Attrs.class "Board" ]
        [ viewColumns model.columns ]


viewCard : Card -> Html Msg
viewCard card =
    Html.div [ Attrs.class "Card" ]
        [ Html.p [ Attrs.class "Card__Title" ] [ Html.text card.title ]
        , Html.button [ Attrs.class "Card__Remove", Ev.onClick (RemoveCard card.id) ] [ Html.text "Remove" ]
        ]


viewColumn : Int -> Column -> Html Msg
viewColumn idx col =
    Html.div [ Attrs.class "Column" ]
        [ Html.h2 [ Attrs.class "Column__Title" ] [ text col.title ]
        , if List.isEmpty col.cards then
            Html.text ""

          else
            Html.div [ Attrs.class "Column__Cards" ] <| List.reverse <| List.map viewCard col.cards
        , viewAddField idx col
        ]


viewAddField : Int -> Column -> Html Msg
viewAddField idx col =
    div [ Attrs.class "Column__Form" ]
        [ Html.input
            [ Attrs.value col.field
            , Ev.onInput (OnFieldChange idx)
            , Ev.on "keydown" (JD.map (EnterSubmit idx) Ev.keyCode)
            ]
            []
        , Html.button
            [ Attrs.disabled <| String.isEmpty <| col.field
            , Ev.onClick <| AddCard idx
            ]
            [ Html.text "Add Card" ]
        ]


viewColumns : List Column -> Html Msg
viewColumns =
    Html.div [ Attrs.class "Columns" ] << List.indexedMap viewColumn


init : Model
init =
    { columns = [ Column 0 "Todo" (List.range 0 2 |> List.indexedMap (initCard "todo")) "", Column 1 "Done" [] "" ]
    , nextId = 3
    }


initCard : String -> Int -> Int -> Card
initCard prefix idx suffix =
    Card (prefix ++ String.fromInt suffix) idx


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
