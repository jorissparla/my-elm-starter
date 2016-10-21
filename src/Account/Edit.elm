module Account.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Account.Types as Types


view : Types.Account -> Html Types.Msg
view model =
    div [ class "", style [ ( "justify-content", "center" ), ( "align-items", "center" ), ( "display", "flex" ) ] ]
        [ div [ class "is-upgraded mdl-js-textfield mdl-textfield" ]
            [ input [ type' "text", class "mdl-textfield__input", style [ ( "outline", "none" ) ] ]
                []
            , label [ class "mdl-textfield__label" ]
                [ text "Labelled" ]
            , div []
                []
            ]
        ]
