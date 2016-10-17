module Types exposing (..)

import Http


type alias News =
    { headline : String, url : Maybe String }


type alias Account =
    { id : String, fullname : String, team : String, location : String }


type FetchedData a
    = Loading
    | Failed Http.Error
    | Succeed a


type alias Model =
    { news : FetchedData (List News)
    , searchText : String
    }


type Msg
    = GetNewsResponse (FetchedData (List News))
    | GetAccountResponse (FetchedData (List Account))
    | SearchTextEntered String
