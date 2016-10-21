module Account.State exposing (..)

import Account.Rest exposing (..)
import Account.Types exposing (..)


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

        EditAccount accid ->
            ( { model | searchText = accid }
            , Cmd.none
            )

        DeleteAccount accid ->
            ( { model | searchText = "" }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
