module View.Header exposing (view)

import Html exposing (Attribute, Html, text)
import Html.Attributes exposing (style)
import Messages exposing (Msg)


mainHeaderStyle : List (Attribute msg)
mainHeaderStyle =
    [ style "text-align" "center"
    , style "padding" "24px 12px 8px 12px"
    , style "border-bottom" "1px solid rgba(0,0,0,0.4)"
    ]


view : Html Msg
view =
    Html.h1
        mainHeaderStyle
        [ text "Foolproof Global Defense Systems" ]
