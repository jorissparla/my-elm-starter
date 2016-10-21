module App exposing (..)

import Html.App
import Account.State
import Account.View


main : Program Never
main =
    Html.App.program
        { init = Account.State.init
        , update = Account.State.update
        , subscriptions = Account.State.subscriptions
        , view = Account.View.root
        }
