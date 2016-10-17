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

        fa =
            account.team

        fo =
            account.location
    in
        String.contains str fi || String.contains str fa || String.contains str fo


searchField =
    div [ class "mdl-grid" ]
        [ div [ class "mdl-cell--1-offset-desktop mdl-cell--3-col-desktop mdl-cell--8-col-tablet mdl-cell" ]
            [ div
                [ class "mdl-textfield mdl-js-textfield" ]
                [ input [ onInput SearchTextEntered, placeholder "Search.", class "mdl-textfield__input", id "sample1", type' "text", style [ ( "left-margin", "30px" ) ] ]
                    []
                ]
            ]
        ]


accountItem accounts =
    li [ class "mdl-list__item--two-line mdl-list__item" ]
        [ regionHeader accounts
        , span [ class "mdl-list__item-primary-content" ]
            [ span [ class "" ]
                [ text (getNameandLocation accounts) ]
            , span [ class "mdl-list__item-sub-title" ]
                [ text accounts.team ]
            ]
        , span [ class "mdl-list__item-secondary-content" ]
            [ text accounts.date_changed ]
        ]


regionColor region =
    case region of
        "EMEA" ->
            "mdl-typography--title-color-contrast mdl-color-text--accent-contrast  mdl-color--light-blue-500"

        "NA" ->
            "mdl-typography--title-color-contrast mdl-color-text--accent-contrast  mdl-color--purple-500"

        "APJ" ->
            "mdl-typography--title-color-contrast mdl-color-text--accent-contrast  mdl-color--green-500"

        "GLB" ->
            "mdl-typography--title-color-contrast mdl-color-text--accent-contrast  mdl-color--red-500"

        _ ->
            "mdl-typography--title-color-contrast mdl-color-text--accent-contrast mdl-color--orange-500"


regionHeader accounts =
    div [ class (regionColor accounts.region), attribute "style" "margin-right: 2rem; height: 36px; width: 36px; justify-content: center; align-items: center; display: flex;" ]
        [ text (getCapitalItemName accounts.region) ]


getNameandLocation accounts =
    accounts.fullname ++ "(" ++ accounts.location ++ ")"


getCapitalItemName item =
    String.slice 0 1 item |> String.toUpper
