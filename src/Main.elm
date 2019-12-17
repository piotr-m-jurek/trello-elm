module Main exposing (main)

import Browser
import Html exposing (Html)
import Messages exposing (Msg(..))
import Models exposing (Model, model)
import View


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        RequestConfirmation ->
            ( { model | isConfirmationRequested = True }, Cmd.none )

        AbortWorldDestruction ->
            ( { model | isConfirmationRequested = False }, Cmd.none )

        ConfirmWorldDestruction ->
            let
                newModel =
                    { model | isConfirmationRequested = False, isWorldDestroyed = True }
            in
            ( newModel, Cmd.none )


view : Model -> Html Msg
view model =
    View.view model


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


init : flags -> ( Model, Cmd msg )
init _ =
    ( model, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
