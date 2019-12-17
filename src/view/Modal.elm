module View.Modal exposing (modalView)

import Html exposing (Attribute, Html, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models exposing (Model)


maskStyle : List (Attribute msg)
maskStyle =
    [ style "position" "fixed"
    , style "top" "0"
    , style "left" "0"
    , style "height" "100%"
    , style "width" "100%"
    , style "background" "rgba(0,0,0,0.4)"
    ]


modalStyle : List (Attribute msg)
modalStyle =
    [ style "position" "absolute"
    , style "top" "50%"
    , style "left" "50%"
    , style "transform" "translate(-50%, -50%)"
    , style "background" "white"
    , style "border-radius" "5px"
    , style "box-shadow" "0px 3px 6px rgba(0,0,0,0.5)"
    , style "height" "200px"
    , style "width" "400px"
    ]


modalHeaderStyle : List (Attribute msg)
modalHeaderStyle =
    [ style "padding" "10px"
    , style "margin" "0px"
    , style "border-bottom" "1px solid rgba(0,0,0,0.3)"
    ]


modalBodyStyle : List (Attribute msg)
modalBodyStyle =
    [ style "padding" "10px" ]


modalView : Model -> Html Msg
modalView model =
    if model.isConfirmationRequested then
        Html.div []
            [ Html.div maskStyle []
            , Html.div modalStyle
                [ Html.h1 modalHeaderStyle [ text "hi" ]
                , Html.div modalBodyStyle
                    [ Html.button [ onClick ConfirmWorldDestruction ] [ text "Confirm" ]
                    , Html.button [ onClick AbortWorldDestruction ] [ text "Cancel" ]
                    ]
                ]
            ]

    else
        Html.div [ style "display" "none" ] []
