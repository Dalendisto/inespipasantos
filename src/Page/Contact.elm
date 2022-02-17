module Page.Contact exposing (Model, Msg, Data, page)

import DataSource exposing (DataSource)
import Element as Elem
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Head
import Head.Seo as Seo
import Layout exposing (desktop, mobile)
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)
import ViewSettings exposing (ViewSettings)


type alias Model =
    ()


type alias Msg =
    Never

type alias RouteParams =
    {}

page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


type alias Data =
    ()


data : DataSource Data
data =
    DataSource.succeed ()


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { title = "Contact"
    , body = 
        Elem.column
            [ Elem.width Elem.fill
            , Elem.height Elem.fill
            , Elem.paddingXY 0 20
            ]
            [ layout sharedModel.viewSettings
            ]
    , fillHeight = False
    }


layout : ViewSettings -> Elem.Element msg
layout viewSettings =
    case viewSettings.size of 
        ViewSettings.Small ->
            mobile                 
                { viewSettings = viewSettings 
                , title = headLine viewSettings
                , body = contactArea viewSettings--Elem.none 
                } 

        _ ->
            desktop
                { viewSettings = viewSettings 
                , title = headLine viewSettings
                , body = contactArea viewSettings --Elem.none  
                }  


headLine : ViewSettings -> Elem.Element msg 
headLine viewSettings=
    Elem.el
        [ Font.family
            [ Font.typeface "FreeMono"
                
            ]
        , Font.size viewSettings.font.size.xLarge
        , Font.letterSpacing 1
        , Elem.paddingXY 20 10 
        , Elem.centerX
        --, Font.italic
        ]
        (Elem.text "Contact")
                


contactArea : ViewSettings -> Elem.Element msg 
contactArea viewSettings =
    let
        fields =
            [ "NAME:  ", "EMAIL: " , "PHONE: "]

        infos =
            [ "Ines Pipa Santos", "inespipa@mail.com", "0351 123 567 89"]

        styling field info =
            Elem.column
                [ Font.letterSpacing 2
                , Font.size viewSettings.font.size.large
                , Font.family
                    [ Font.typeface "FreeMono"     
                    ]
                , Elem.spacingXY 0 2
                ]
                [ Elem.text (field)
                , Elem.text (info)
                ]

        contact =
            Elem.column
                [ Elem.centerX
                , Elem.centerY
                , Elem.spacingXY 0 10
                --, Border.width 1
                ]
                (List.map2 styling fields infos)
    in
    Elem.column 
        [ Elem.width (Elem.fillPortion 4)
        , Elem.height Elem.fill
        , Elem.paddingXY 10 0
        --, Border.width 1
        ]
        [ contact     
        ]
