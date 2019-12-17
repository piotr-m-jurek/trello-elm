module View.Main exposing (view)

import Html exposing (Attribute, Html, button, div, h2, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))


mainBodyStyle : List (Attribute msg)
mainBodyStyle =
    [ style "padding" "10px"
    , style "margin" "0 auto"
    , style "width" "80%"
    , style "max-width" "1200px"
    ]


outlineButtonStyle : List (Attribute msg)
outlineButtonStyle =
    [ style "padding" "12px, 16px"
    , style "background" "rgb(255,255,255)"
    , style "color" "rgb(54,137,218)"
    , style "border" "2px solid rgb(54,137,218)"
    , style "cursor" "pointer"
    , style "font-size" "1em"
    ]


view : Html Msg
view =
    div mainBodyStyle
        [ h2 [] [ text "What would you like to do today?" ]
        , button
            (onClick RequestConfirmation :: outlineButtonStyle)
            [ text "Blow up the world!" ]
        ]
