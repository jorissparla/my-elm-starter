module Types exposing (..)

import Http


type alias News =
    { headline : String, url : Maybe String }


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
    | SearchTextEntered String
