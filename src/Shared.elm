module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import Browser.Dom
import Browser.Events
import Browser.Navigation
import DataSource
import Element as Elem
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Layout exposing (sharedDesktop, sharedMobile)
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Path exposing (Path)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import ViewSettings exposing (ViewSettings)
import View exposing (View)
import Task 


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Just OnPageChange
    }


type Msg
    = OnPageChange
        { path : Path
        , query : Maybe String
        , fragment : Maybe String
        }
    | SharedMsg SharedMsg
    | SizeChange Int Int


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    { showMobileMenu : Bool
    , viewSettings : ViewSettings
    }


init :
    Maybe Browser.Navigation.Key
    -> Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : Path
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Cmd Msg )
init navigationKey flags maybePagePath =
    ( { showMobileMenu = False 
      , viewSettings = ViewSettings.forSize 1920 1080  
      }
    , Task.perform
        (\viewport ->
            SizeChange 
                (round viewport.scene.width)
                (round viewport.scene.height) 
        )
        Browser.Dom.getViewport
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPageChange _ ->
            ( { model | showMobileMenu = False }
            , Cmd.batch 
                [ Task.perform (\_ -> SharedMsg NoOp) (Browser.Dom.setViewport 0 0) ]
            )

        SharedMsg globalMsg ->
            (model, Cmd.none)

        SizeChange w h ->
            ({ model | viewSettings = ViewSettings.forSize w h}, Cmd.none)


subscriptions : Path -> Model -> Sub Msg
subscriptions _ _ =
    Browser.Events.onResize SizeChange


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


view :
    Data
    ->
        { path : Path
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : Html msg, title : String }
view sharedData page model toMsg pageView =
    { title = pageView.title
    , body = 
        Elem.layout
            [ Elem.width Elem.fill
            , Elem.height Elem.fill
            ]
            <|
            Elem.column
                [ Elem.width Elem.fill
                , Elem.height Elem.fill
                , Elem.padding 10
                , Elem.spacingXY 0 10
                --, Border.width 5
                --, toggleLightDark model
                ]
                [ layout model.viewSettings
                , pageView.body
                ]
    }


layout : ViewSettings -> Elem.Element msg
layout viewSettings =
    case viewSettings.size of 
        ViewSettings.Small ->
            sharedMobile 
                { viewSettings = viewSettings 
                , title = Elem.none --String 
                , body = navLinks viewSettings --Elem.none --Elem.Element msg  
                } 

        _ ->
            sharedDesktop
                { viewSettings = viewSettings 
                , title = Elem.none
                , body = navLinks viewSettings --Elem.none  --Elem.Element msg  
                } 


navLinks : ViewSettings -> Elem.Element msg 
navLinks viewSettings =
    Elem.row
        [ Elem.width (Elem.fillPortion 4)
        , Elem.height Elem.fill
        --, Elem.paddingXY 10 0
        , Elem.spaceEvenly
        , Elem.spacingXY 5 0
        --, Border.width 1
        ]
        (List.map3 navLink urls labels [viewSettings, viewSettings, viewSettings, viewSettings])


urls : List String 
urls = 
    [ "/about", "/projects", "/contact" ]


labels : List String 
labels = 
    [ "About", "Projects", "Contact" ]


navLink : String -> String -> ViewSettings -> Elem.Element msg
navLink url label viewSettings =
    Elem.el
        [ Elem.width Elem.fill 
        , Elem.centerX
        --, Elem.paddingXY 5 0
        --, Border.width 1
        ]
        (Elem.link
            [ Elem.width Elem.fill
            , Font.center
            , Font.family
                [ Font.typeface "FreeMono"]
            , Font.letterSpacing 1
            , Font.size viewSettings.font.size.large
            , Elem.mouseOver [Elem.scale 1.05]
            , Elem.focused []
            ]
            { url = url
            , label = Elem.text label
            }
        )

