module Page.Projects exposing (Model, Msg, Data, page)

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
import Data.Projects as Projects
import Shared
import View exposing (View)
import ViewSettings exposing (ViewSettings)
import Widgets.Card exposing (switcher, mobileCard)


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
    List Projects.ProjectFm --()


data : DataSource Data
data =
    Projects.getProjectFm
    --DataSource.succeed ()


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
    { title = "Projects"
    , body = 
        Elem.column
            [ Elem.width Elem.fill
            , Elem.height Elem.fill
            --, Elem.paddingXY 0 20
            --, Elem.scrollbarY
            ]
            [ layout sharedModel.viewSettings static
            ]
    , fillHeight = False
    }


layout : ViewSettings -> StaticPayload Data RouteParams -> Elem.Element msg
layout viewSettings static =
    case viewSettings.size of 
        ViewSettings.Small ->
            mobile                 
                { viewSettings = viewSettings 
                , title = headLine viewSettings
                , body = projectListColumn viewSettings static
                } 
            
        _ ->
            desktop
                { viewSettings = viewSettings 
                , title = headLine viewSettings
                , body = projectListRow viewSettings static
                }  


headLine : ViewSettings -> Elem.Element msg 
headLine viewSettings =
    Elem.el
        [ Font.family
            [ Font.typeface "FreeMono"
                
            ]
        , Font.size viewSettings.font.size.xLarge
        --, Font.size 40
        , Font.letterSpacing 1
        , Elem.paddingXY 20 10 
        , Elem.centerX
        --, Font.italic
        ]
        (Elem.text "Projects")
    

projectListColumn : ViewSettings -> StaticPayload Data RouteParams -> Elem.Element msg
projectListColumn viewSettings static =
    Elem.column 
        [ Elem.width Elem.fill
        , Elem.height Elem.fill
        , Elem.centerX
        --, Elem.scrollbarY
        --, Elem.paddingXY 50 0
        , Elem.spacingXY 0 50
        --, Border.width 1
        ]
        (static.data
            |> List.map (\project -> mobileCard viewSettings project)
        )


projectListRow : ViewSettings -> StaticPayload Data RouteParams -> Elem.Element msg
projectListRow viewSettings static =
    Elem.column 
        [ Elem.width Elem.fill
        , Elem.height Elem.fill
        , Elem.centerX
        , Elem.scrollbarY
        --, Elem.paddingXY 50 0
        , Elem.spacingXY 0 100
        --, Border.width 1
        ]
        (static.data
            |> List.indexedMap (\project -> switcher viewSettings project)
        )
        
