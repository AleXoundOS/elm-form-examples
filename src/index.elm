module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Utils


exampleVersion : String
exampleVersion =
    "index"



-- VIEWS


view : Html msg
view =
    Utils.viewSimple exampleVersion viewIndex


viewIndex : Html msg
viewIndex =
    ul []
        [ li [] [ a [ href "Example_1.html" ] [ text "Example_1.html" ] ]
        , li [] [ a [ href "Example_2.html" ] [ text "Example_2.html" ] ]
        , li [] [ a [ href "Example_3.html" ] [ text "Example_3.html" ] ]
        , li [] [ a [ href "Example_4.html" ] [ text "Example_4.html" ] ]
        , li [] [ a [ href "Example_5.html" ] [ text "Example_5.html" ] ]
        , li [] [ a [ href "Example_6.html" ] [ text "Example_6.html" ] ]
        , li [] [ a [ href "Example_7.html" ] [ text "Example_7.html" ] ]
        , li [] [ a [ href "Example_8.html" ] [ text "Example_8.html" ] ]
        ]


main : Html msg
main =
    view
