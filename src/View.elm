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
            [ text "News!" ]
        , searchField
        , div []
            [ -- , label [ class "inputlabel" ] [ text "Search" ]
              case model.news of
                Loading ->
                    text "Loading"

                Failed error ->
                    div [ class "alert alert-danger" ]
                        [ text (toString error) ]

                Succeed news ->
                    div [ class "mdl-grid" ]
                        [ div [ class "mdl-cell mdl-cell--6-col" ]
                            [ ul []
                                (news
                                    |> List.filter (matchSearch model.searchText)
                                    |> List.map newsItem3
                                )
                            ]
                        ]
              -- div [ class "j-list" ] (List.map newsItem2 news)
            ]
        ]


matchSearch : String -> News -> Bool
matchSearch str news =
    let
        fi =
            news.headline
    in
        String.contains str fi


searchField =
    div [ class "mdl-textfield mdl-js-textfield" ]
        [ input [ onInput SearchTextEntered, placeholder "Search.", class "mdl-textfield__input", id "sample1", type' "text", style [ ( "left-margin", "30px" ) ] ]
            []
        ]


newsItem : News -> Html Msg
newsItem news =
    li [ class ".j-list__item--three-line" ]
        [ div [ class "card", style [ ( "width", "70%" ), ( "float", "right" ) ] ]
            [ text (Debug.log "Showing" news.headline) ]
        , div []
            [ img [ href (Maybe.withDefault "No val" news.url), alt "avatar", class "j-list__item-avatar", src "http://autokadabra.ru/system/uploads/users/18/18340/small.png?1318432918" ]
                []
            ]
        ]


newsItem2 news =
    div [ class "col s12 m7" ]
        [ div [ class "card horizontal small" ]
            [ div [ class "card-image" ]
                [ img [ src "https://unsplash.it/150?random" ]
                    []
                ]
            , div [ class "card-stacked" ]
                [ div [ class "card-content" ]
                    [ p []
                        [ text news.headline ]
                    ]
                , div [ class "card-action" ]
                    [ a [ href (Maybe.withDefault "No val" news.url) ]
                        [ text "This is a link" ]
                    ]
                ]
            ]
        ]


getCapitalItemName item =
    String.slice 0 1 item |> String.toUpper


newsItem3 news =
    li [ class "mdl-list__item--two-line mdl-list__item" ]
        [ div [ class "mdl-typography--title-color-contrast mdl-color-text--accent-contrast mdl-color--red-500", attribute "style" "margin-right: 2rem; height: 36px; width: 36px; justify-content: center; align-items: center; display: flex;" ]
            [ text (getCapitalItemName news.headline) ]
        , span [ class "mdl-list__item-primary-content" ]
            [ span [ class "" ]
                [ text "Frederikssund" ]
            , span [ class "mdl-list__item-sub-title" ]
                [ text news.headline ]
            ]
        , span [ class "mdl-list__item-secondary-content" ]
            [ text "15:01" ]
        ]
