module Types exposing (..)

import Http


type alias Account =
    { uic : String, fullname : String, team : String, location : String, region : String, date_changed : String, workload : Int }


type FetchedData a
    = Loading
    | Failed Http.Error
    | Succeed a


type alias Model =
    { searchText : String
    , accounts : FetchedData (List Account)
    }


type Msg
    = GetAccountResponse (FetchedData (List Account))
    | SearchTextEntered String
