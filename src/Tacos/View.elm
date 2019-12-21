module Tacos.View exposing (view)

import Html exposing (Attribute, Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Decode as Decode
import Tacos.Messages exposing (Msg(..))
import Tacos.Model exposing (Model)


orderDescStyle : List (Attribute msg)
orderDescStyle =
    [ style "margin" "0 0 8px 0" ]


orderInputStyle : List (Attribute msg)
orderInputStyle =
    [ style "display" "block"
    , style "width" "100%"
    , style "line-height" "24px"
    , style "margin" "0 0 8px 0"
    , style "border" "1px solid rgba(0,0,0,0.3)"
    ]


orderHeaderStyle : List (Attribute msg)
orderHeaderStyle =
    [ style "padding" "12px"
    , style "margin" "0px"
    , style "order-bottom" "1px solid rgba(0,0,0,0.3)"
    ]


orderBodyStyle : List (Attribute msg)
orderBodyStyle =
    [ style "padding" "10px"
    ]


orderButtonStyle : List (Attribute msg)
orderButtonStyle =
    [ style "display" "inline-block"
    , style "appearance" "none"
    , style "padding" "12px, 16px"
    , style "color" "rgb(54,137,218)"
    , style "background" "transparent"
    , style "border" "none"
    , style "cursor" "pointer"
    , style "font-size" "1em"
    ]


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.button [ onClick StartTacoOrder ] [ Html.text "Order Tacos" ]
        , if model.totalOrdered > 0 then
            Html.div [] [ Html.text ("Number of tacos orderd: " ++ String.fromInt model.totalOrdered) ]

          else
            Html.div [] [ Html.text "No tacos ordered yet" ]
        ]


modal : Html Msg
modal =
    Html.div []
        [ Html.h3 orderHeaderStyle
            [ Html.text "How many tacos would you like?"
            ]
        , Html.div
            orderBodyStyle
            [ Html.p
                orderDescStyle
                [ Html.text "Please remember that each taco ordered carries a $1,000,000 surcharge for taxpayers." ]
            , Html.input
                (List.append [ Html.Attributes.id "order-input", Html.Attributes.type_ "number", onInputInt UpdateOrder ] orderInputStyle)
                []
            , Html.button
                (Html.Events.onClick Tacos.Messages.CancelOrder :: orderButtonStyle)
                [ Html.text "Cancel order" ]
            , Html.button
                (Html.Events.onClick Tacos.Messages.PlaceOrder :: orderButtonStyle)
                [ Html.text "Place order" ]
            ]
        ]


onInputInt : (Int -> msg) -> Attribute msg
onInputInt tagger =
    Html.Events.on "input" (Decode.map tagger (Decode.at [ "target", "valueAsNumber" ] Decode.int))
