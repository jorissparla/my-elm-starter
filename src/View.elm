module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import String


root : Model -> Html Msg
root model =
    div []
        [ h1 [ style [ ( "font-family", "Roboto" ) ] ]
            [ text "Accounts!" ]
        , searchField
        , div []
            [ -- , label [ class "inputlabel" ] [ text "Search" ]
              case model.accounts of
                Loading ->
                    text "Loading"

                Failed error ->
                    div [ class "alert alert-danger" ]
                        [ text (toString error) ]

                Succeed accounts ->
                    div [ class "mdl-grid" ]
                        [ div [ class "mdl-cell mdl-cell--6-col" ]
                            [ ul []
                                (accounts
                                    |> List.filter (matchSearch model.searchText)
                                    |> List.map accountItem
                                )
                            ]
                        ]
            ]
        ]


matchSearch : String -> Account -> Bool
matchSearch str account =
    let
        fi =
            account.fullname
    in
        String.contains str fi


searchField =
    div [ class "mdl-textfield mdl-js-textfield" ]
        [ input [ onInput SearchTextEntered, placeholder "Search.", class "mdl-textfield__input", id "sample1", type' "text", style [ ( "left-margin", "30px" ) ] ]
            []
        ]


accountItem accounts =
    li [ class "mdl-list__item--two-line mdl-list__item" ]
        [ div [ class "mdl-typography--title-color-contrast mdl-color-text--accent-contrast mdl-color--red-500", attribute "style" "margin-right: 2rem; height: 36px; width: 36px; justify-content: center; align-items: center; display: flex;" ]
            [ text (getCapitalItemName accounts.region) ]
        , span [ class "mdl-list__item-primary-content" ]
            [ span [ class "" ]
                [ text (getNameandLocation accounts) ]
            , span [ class "mdl-list__item-sub-title" ]
                [ text accounts.team ]
            ]
        , span [ class "mdl-list__item-secondary-content" ]
            [ text accounts.date_changed ]
        ]


getNameandLocation accounts =
    accounts.fullname ++ "(" ++ accounts.location ++ ")"


getCapitalItemName item =
    String.slice 0 1 item |> String.toUpper
