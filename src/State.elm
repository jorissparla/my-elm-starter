module State exposing (..)

import Rest exposing (..)
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { news = Loading
      , searchText = ""
      }
    , getNews
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "action" msg of
        GetNewsResponse response ->
            ( { model | news = response }
            , Cmd.none
            )

        SearchTextEntered str ->
            ( { model | searchText = str }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
