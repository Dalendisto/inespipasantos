module Page.Index exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Element as Elem
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Head
import Head.Seo as Seo
import Page exposing (Page, StaticPayload)
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


type alias Data =
    ()


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { title = "inespipasantos.com"
    , body = 
        Elem.column
            [ Elem.width Elem.fill
            , Elem.height Elem.fill
            ]
            [ logoRow sharedModel.viewSettings
            ]
    , fillHeight = False
    }


logoRow : ViewSettings -> Elem.Element msg 
logoRow viewSettings =
    Elem.column
        [ Elem.height (Elem.fill |> Elem.maximum 500)
        , Elem.width (Elem.fill |> Elem.maximum 500)
        , Elem.centerX
        , Elem.centerY
        , Elem.paddingXY 10 20
        --, Border.width 1
        ]
        [ image viewSettings
        ]


image : ViewSettings -> Elem.Element msg
image viewSettings =
    Elem.row 
        [ Elem.height Elem.fill 
        , Elem.width Elem.fill 
        , Elem.centerX
        , Background.uncropped "images/Ines-Logo.jpg"
        , Elem.alignTop 
        --, Border.width 1
        ]
        []
