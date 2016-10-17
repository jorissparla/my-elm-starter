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


decodeAccountItem : Decoder Account
decodeAccountItem =
    object4
        Account
        ("id" := string)
        ("fullname" := string)
        ("team" := string)
        ("location" := string)


decodeAccount : Decoder (List Account)
decodeAccount =
    (list decodeAccountItem)


getAccounts =
    Http.get decodeAccount accountendpoint
        |> Task.perform Failed Succeed
        |> Cmd.map GetAccountResponse


accountendpoint =
    "http://localhost:3000/api/accounts"
