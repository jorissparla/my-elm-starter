module Account.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Account.Types exposing (..)
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
                        [ div [ class "mdl-cell mdl-cell--12-col" ]
                            [ div [ class "", style [ ( "flex", "1 1 auto" ), ( "max-width", "80%" ), ( "min-width", "256px" ), ( "align-items", "center" ), ( "justify-content", "space-between" ), ( "flex-flow", "row wrap" ), ( "display", "flex" ) ] ]
                                (accounts
                                    |> List.filter (matchSearch model.searchText)
                                    |> List.map alternateView
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
    li
        [ class "mdl-list__item--three-line mdl-list__item mdl-card--border mdl-card__actions"
        ]
        [ regionHeader accounts
        , span [ class "mdl-list__item-primary-content" ]
            [ span [ class "mdl-list__item-text-body", style [ ( "font-weight", "600" ) ] ]
                [ text (getNameandLocation accounts) ]
            , span [ class "mdl-list__item-sub-title" ]
                [ text accounts.team ]
            ]
        , span [ class "mdl-list__item-secondary-content" ]
            [ text (String.left 10 accounts.date_changed) ]
        , span [ class "mdl-list__item-secondary-info " ]
            [ text (toString accounts.workload)
            , i [ class "material-icons" ]
                [ text "star_border" ]
            ]
        , editBtn2 accounts
        ]


regionColor2 region =
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


regionColor region =
    case region of
        "EMEA" ->
            "mdl-card mdl-color--light-blue-400 mdl-shadow--2dp"

        "NA" ->
            "mdl-card mdl-color--deep-orange-400 mdl-shadow--2dp"

        "APJ" ->
            "mdl-card mdl-color--green-400 mdl-shadow--2dp"

        "GLB" ->
            "mdl-card mdl-color--red-400 mdl-shadow--2dp"

        _ ->
            "mdl-card mdl-color--purple-400 mdl-shadow--2dp"


regionHeader accounts =
    div
        [ class (regionColor accounts.region)
        , attribute "style" "margin-right: 2rem; height: 36px; width: 36px; justify-content: center; align-items: center; display: flex;"
        ]
        [ text (getCapitalItemName accounts.region) ]


editBtn accounts =
    button
        [ class "btn regular"
        , onClick (EditAccount accounts.uic)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]


editBtn2 accounts =
    div [ style [ ( "text-align", "center" ), ( "margin-top", "0.6em" ), ( "margin-bottom", "0.6em" ) ] ]
        [ button [ onClick (EditAccount accounts.uic), class "mdl-js-button mdl-button mdl-button--colored mdl-button--fab mdl-shadow--8dp mdl-color--indigo-A200" ]
            [ i [ class "material-icons" ]
                [ text "edit" ]
            ]
        , div [ style [ ( "font-size", "9pt" ), ( "margin-top", "0.6em" ) ] ]
            [ text "fab colored" ]
        ]


getTeam : String -> String
getTeam team =
    if String.isEmpty team then
        "No Team entered"
    else
        team


getNameandLocation accounts =
    accounts.fullname ++ "(" ++ accounts.location ++ ")"


getCapitalItemName item =
    String.slice 0 1 item |> String.toUpper


getFullName name =
    String.append name (String.repeat (100 - (String.length name)) "_") ++ "."


alternateView : Account -> Html Msg
alternateView accounts =
    div [ class (regionColor accounts.region), style [ ( "min-height", "0px" ), ( "margin", "4px 8px 4px 0px" ), ( "height", "192px" ), ( "width", "220px" ), ( "transition", "box-shadow 250ms ease-in-out 0s" ) ] ]
        [ div [ class "mdl-card__title", style [ ( "align-items", "flex-start" ), ( "flex-direction", "column" ), ( "justify-content", "flex-end" ) ] ]
            [ h1 [ class "mdl-color-text--white mdl-card__title-text", style [ ( "align-self", "flex-start" ) ] ]
                [ text (getFullName accounts.fullname) ]
            ]
        , div [ class "mdl-color-text--white mdl-card__supporting-text" ]
            [ text (getTeam accounts.team) ]
        , div [ class "mdl-color-text--white mdl-card--border mdl-card__actions", style [ ( "align-items", "bottom" ), ( "height", "30px" ), ( "justify-content", "space-between" ), ( "display", "flex" ) ] ]
            [ span [ class "mdl-typography--caption-force-preferred-font-color-contrast", style [ ( "opacity", "0.87" ) ] ]
                [ text accounts.region ]
            , span [ class "mdl-typography--caption-force-preferred-font-color-contrast", style [ ( "opacity", "0.87" ) ] ]
                [ text accounts.location ]
            , button [ class "mdl-js-ripple-effect mdl-js-button mdl-button mdl-button--icon", onClick (EditAccount accounts.uic) ]
                [ i [ class "material-icons" ]
                    [ text "edit" ]
                , span [ class "mdl-button__ripple-container" ]
                    [ span [ class "mdl-ripple is-animating" ]
                        []
                    ]
                ]
            , button [ class "mdl-js-ripple-effect mdl-js-button mdl-button mdl-button--icon", onClick (DeleteAccount accounts.uic) ]
                [ i [ class "material-icons" ]
                    [ text "delete" ]
                , span [ class "mdl-button__ripple-container" ]
                    [ span [ class "mdl-ripple is-animating" ]
                        []
                    ]
                ]
            ]
        ]
