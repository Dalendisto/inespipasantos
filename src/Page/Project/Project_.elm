module Page.Project.Project_ exposing (Model, Msg, Data, page)

import DataSource exposing (DataSource)
import Data.Projects as Projects
import Element as Elem
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Head
import Head.Seo as Seo
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
    { project : String }

page : Page RouteParams Data
page =
    Page.prerender
        { head = head
        , routes = routes
        , data = data
        }
        |> Page.buildNoState { view = view }


routes : DataSource (List RouteParams)
routes =
    Projects.projectFiles
        |> DataSource.map
            (List.map (\repo -> { project = repo.slug }))
    --DataSource.succeed []


data : RouteParams -> DataSource Data
data routeParams =
    DataSource.map2 Data
        (Projects.getProjectContent routeParams.project)
        (Projects.getSingleFm routeParams.project)
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


type alias Data =
    { content : Projects.Content Msg
    , metadata : Projects.ProjectFm
    }
    --()


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { title = "Project"
    , body = 
        Elem.column
            [ Elem.width Elem.fill
            , Elem.height Elem.fill
            , Elem.paddingXY 10 20
            , Elem.spacingXY 0 30
            --, Elem.scrollbars
            , Elem.clipX
            ]
            [ projectTitle sharedModel.viewSettings static
            , projectBody sharedModel.viewSettings static
            ]
    , fillHeight = False
    }


projectTitle : ViewSettings -> StaticPayload Data RouteParams -> Elem.Element msg 
projectTitle viewSettings static =
    let
        pageTitle = 
            Elem.paragraph 
                [ Elem.width (Elem.fill |> Elem.maximum 400)
                , Elem.centerX
                , Font.center
                , Font.size viewSettings.font.size.xLarge
                , Font.family 
                    [ Font.typeface "FreeMono" ]
                --, Border.width 1
                ]
                [ Elem.text  static.data.metadata.title ]
    in
    Elem.el 
        [ Elem.width Elem.fill 
        ]
        pageTitle


projectBody : ViewSettings -> StaticPayload Data RouteParams -> Elem.Element Msg 
projectBody viewSettings static = 
    let
        content = 
            Elem.paragraph  
                [ Elem.width (Elem.fill |> Elem.maximum 1300)
                , Elem.height Elem.fill 
                , Elem.paddingXY 10 0
                , Elem.centerX
                , Elem.scrollbars
                --, Elem.scale 0.7
                --, Elem.clipX
                , Font.size viewSettings.font.size.medium
                , Font.family 
                    [ Font.typeface "FreeMono" ]
                --, Border.width 1
                ]
                [ static.data.content.content ]
    in
    Elem.column 
        [ Elem.width Elem.fill 
        , Elem.height Elem.fill
        , Elem.centerX
        --, Border.width 1
        ]
        [ content ]
