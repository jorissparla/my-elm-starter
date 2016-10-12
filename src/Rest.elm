module Rest exposing (..)

import Http
import Json.Decode exposing (..)
import Task
import Types exposing (..)


decodeNewsItem : Decoder News
decodeNewsItem =
    object2 News
        ("title" := string)
        (maybe ("url" := string))


decodeNews : Decoder (List News)
decodeNews =
    "hits" := (list decodeNewsItem)


endpoint : String
endpoint =
    "https://hn.algolia.com/api/v1/search_by_date?tags=story&hitsPerPage=50"


getNews : Cmd Msg
getNews =
    Http.get decodeNews endpoint
        |> Task.perform Failed Succeed
        |> Cmd.map GetNewsResponse
