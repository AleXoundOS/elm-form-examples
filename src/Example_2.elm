module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Utils


exampleVersion : String
exampleVersion =
    "2"


type alias Model =
    { email : String
    , password : String
    , response : Maybe String
    }


initialModel : Model
initialModel =
    { email = ""
    , password = ""
    , response = Nothing
    }


type Msg
    = NoOp
    | SubmitForm
    | SetEmail String
    | SetPassword String
    | Response (Result Http.Error String)


type FormField
    = Email
    | Password



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "msg" msg of
        NoOp ->
            ( model, Cmd.none )

        SubmitForm ->
            ( { model | response = Nothing }
            , Http.send Response (postRequest model)
            )

        SetEmail email ->
            ( { model | email = email }, Cmd.none )

        SetPassword password ->
            ( { model | password = password }, Cmd.none )

        Response (Ok response) ->
            ( { model | response = Just response }, Cmd.none )

        Response (Err error) ->
            ( { model | response = Just (toString error ++ " - See the Console for more details.") }, Cmd.none )



--HELPERS


formUrlencoded : List ( String, String ) -> String
formUrlencoded object =
    object
        |> List.map
            (\( name, value ) ->
                Http.encodeUri name
                    ++ "="
                    ++ Http.encodeUri value
            )
        |> String.join "&"


postRequest : Model -> Http.Request String
postRequest model =
    let
        body =
            formUrlencoded
                [ ( "email", model.email )
                , ( "password", model.password )
                ]
                |> Http.stringBody "application/x-www-form-urlencoded"
    in
    Http.request
        { method = "POST"
        , headers = []
        , url = Utils.urlMirrorService
        , body = body
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = False
        }



-- VIEWS


view : Model -> Html Msg
view model =
    Utils.view model exampleVersion viewForm


viewForm : Model -> Html Msg
viewForm model =
    Html.form
        [ onSubmit SubmitForm
        , class "form-container"
        ]
        [ label []
            [ text "Email"
            , input
                [ type_ "text"
                , placeholder "Email"
                , onInput SetEmail
                , value model.email
                ]
                []
            ]
        , label []
            [ text "Password"
            , input
                [ type_ "password"
                , placeholder "Password"
                , onInput SetPassword
                , value model.password
                ]
                []
            ]
        , button
            []
            [ text "Submit" ]
        ]



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
