module View exposing (view)

import Html exposing (Attribute, Html, text)
import Html.Attributes exposing (style)
import Messages exposing (Msg)
import Models exposing (Model)
import View.Header as Header
import View.Main as Main
import View.Modal as Modal


deathScreenStyle : List (Attribute msg)
deathScreenStyle =
    [ style "position" "fixed"
    , style "top" "0"
    , style "left" "0"
    , style "background-color" "rgb(0,0,0)"
    , style "color" "rgb(255,0,0)"
    , style "height" "100%"
    , style "width" "100%"
    ]


deathHeaderStyle : List (Attribute msg)
deathHeaderStyle =
    [ style "position" "absolute"
    , style "top" "50%"
    , style "left" "50%"
    , style "margin-right" "-50%"
    , style "transform" "translate(-50%, -50%)"
    ]


view : Model -> Html Msg
view model =
    if not model.isWorldDestroyed then
        Html.div []
            [ Header.view
            , Main.view
            , Modal.modalView model
            ]

    else
        Html.div deathScreenStyle
            [ Html.h1 deathHeaderStyle [ text "The world has been destroyed. Have a nice day :)" ]
            ]
