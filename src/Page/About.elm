module Page.About exposing (Model, Msg, Data, page)

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
import Widgets.ImageText exposing (aboutLarge, aboutMobile)
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
    { title = "About"
    , body = 
        Elem.column
            [ Elem.width Elem.fill
            , Elem.height Elem.fill
            --, Elem.paddingXY 20 20
            --, Elem.scrollbars
            --, Border.width 1
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
                , body = aboutMobile viewSettings--Elem.none 
                } 

        _ ->
            desktop
                { viewSettings = viewSettings 
                , title = headLine viewSettings
                , body = aboutLarge viewSettings --Elem.none  
                }  


headLine : ViewSettings -> Elem.Element msg 
headLine viewSettings =
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
        (Elem.text "About Me")


aboutArea : ViewSettings -> Elem.Element msg 
aboutArea viewSettings =
    let
        allContent =
            Elem.column 
                [ Elem.width (Elem.fill |> Elem.maximum 700)
                --, Elem.paddingXY 20 0
                , Elem.centerX
                , Elem.centerY
                --, Border.width 1
                ]
                [ textColumn 
                , paragraphEn
                ] 

                
        textColumn =
            Elem.textColumn 
                [ Elem.width Elem.fill
                ]
                [ paragraphPt 
                ]

        paragraphPt =
            Elem.paragraph
                [ Font.size viewSettings.font.size.medium
                , Font.family
                    [ Font.typeface "FreeMono"     
                    ]
                ]
                [ image 
                , Elem.text aboutPt
                ]


        columnPt =
            Elem.column
                [ Elem.width  Elem.fill 
                , Font.size viewSettings.font.size.medium
                , Font.family
                    [ Font.typeface "FreeMono"     
                    ]
                ]
                [ image 
                , Elem.text aboutPt
                ]
        

        image =
            Elem.image 
                [ Elem.width  Elem.fill --(Elem.fill |> Elem.maximum 400) --(Elem.px viewSettings.spacing.width)
                , Elem.height  Elem.fill --(Elem.fill |> Elem.maximum 400) --(Elem.px viewSettings.spacing.height) 
                , Elem.alignLeft
                , Font.size viewSettings.font.size.xLarge
                --, Elem.centerX
                ]
                { src = "/images/Foto-Ines.jpg"
                , description = "Portrait of Ines"
                }

        paragraphEn =
            Elem.paragraph
                [ Font.size viewSettings.font.size.medium
                , Font.family
                    [ Font.typeface "FreeMono"     
                    ]
                , Font.color (Elem.rgb255 120 120 120)
                ]
                [ Elem.text aboutEn
                ]
        
    in
    Elem.column 
        [ Elem.width (Elem.fillPortion 4)
        , Elem.height Elem.fill
        , Elem.paddingXY 10 0
        --, Border.width 1
        ]
        [ allContent
        ]
    

aboutPt : String 
aboutPt =
    """
    Natural de Lisboa, vivo actualmente
    no Concelho de Peniche. Licenciada
    em Arquitectura pela Universidade
    Lusíada (2001-2006) e Mestrado em
    Arquitectura
    pela
    mesma
    Universidade (2009-2011).
    Tendo colaborado em diferentes
    ateliers de arquitectura ao longo
    dos ano, criei o meu atelier em
    2019.
    Para além da Arquitectura, os objectos de desgin, mobiliário
    fotografia, literatura, música e viagens despertam a minha
    curiosidade e interesse.
    """


aboutEn : String 
aboutEn =
    """
    Born in Lisbon, I currently live in the municipality of Peniche.
    Degree in Architecture from Universidade Lusíada (2001-2006)
    and Master in Architecture from the same University (2009-2011).
    Having collaborated in different architectural studios over the
    years, I created my studio in 2019.
    In addition to architecture, the objects of design, furniture,
    photography, literature, music and travel arouse my curiosity and
    interest.
    """

