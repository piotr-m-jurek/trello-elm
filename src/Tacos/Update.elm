module Tacos.Update exposing (update)

import Tacos.Messages exposing (Msg(..))
import Tacos.Model exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartTacoOrder ->
            ( { model | isOrdering = True }, Cmd.none )

        UpdateOrder count ->
            ( { model | currentOrder = count }, Cmd.none )

        PlaceOrder ->
            let
                totalOrdered =
                    model.totalOrdered + model.currentOrder
            in
            ( { model
                | totalOrdered = totalOrdered
                , currentOrder = 0
                , isOrdering = False
              }
            , Cmd.none
            )

        CancelOrder ->
            let
                newModel =
                    { model
                        | currentOrder = 0
                        , isOrdering = False
                    }
            in
            ( newModel, Cmd.none )
