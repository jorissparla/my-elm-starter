module State exposing (..)

import Rest exposing (..)
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { searchText = ""
      , accounts = Loading
      }
    , getAccounts
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "action" msg of
        GetAccountResponse response ->
            ( { model | accounts = response }
            , Cmd.none
            )

        SearchTextEntered str ->
            ( { model | searchText = str }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
