module Layout exposing (..)

import Element as Elem
import Element.Border as Border
import Element.Background as Background
import Element.Font as Font
import Data.Projects as Projects
import ViewSettings exposing (ViewSettings)
--import Widgets.ImageText exposing (aboutLarge, aboutMobile) 



sharedDesktop :
    { viewSettings : ViewSettings 
    , title : Elem.Element msg 
    , body : Elem.Element msg  
    } 
    -> Elem.Element msg
sharedDesktop {viewSettings, title, body } =
    let
        headerRow =
            Elem.row
                [ Elem.width Elem.fill
                , Elem.height (Elem.fill |> Elem.maximum 80)
                ]
                [ logo
                , navContainer
                ]

        logo =
            Elem.el 
                [ Elem.width (Elem.fillPortion 2)
                , Elem.height Elem.fill
                --, Border.width 1
                ]
                (Elem.link --image
                    [ Elem.width (Elem.px viewSettings.font.size.width) --(Elem.px 60)
                    , Elem.height (Elem.px viewSettings.font.size.height) --(Elem.px 60)
                    , Background.image "images/IP-Logo.jpg"
                    , Elem.mouseOver [ Elem.scale 1.05 ]
                    --, Elem.centerX
                    --, Elem.paddingXY 20 0
                    ]
                    { url = "/" --"images/IP-Logo.jpg"
                    , label = Elem.none --"Logo image"
                    }
                )

        navContainer =
            Elem.row 
                [ Elem.width (Elem.fillPortion 4)
                , Elem.height Elem.fill
                --, Border.width 1
                ]
                [ navLinks ]

        navLinks =
            Elem.row
                [ Elem.width Elem.fill
                , Elem.height Elem.fill
                , Elem.scale 0.96
                --, Border.width 1
                ]
                [body]

    in
    Elem.column 
        [ Elem.width Elem.fill
        --, Elem.height Elem.fill
        ]
        [ headerRow
        ]


sharedMobile : 
    { viewSettings : ViewSettings 
    , title : Elem.Element msg 
    , body : Elem.Element msg  
    }  
    -> Elem.Element msg 
sharedMobile { viewSettings, title, body } =
    let
        headerRow =
            Elem.column
                [ Elem.width Elem.fill
                , Elem.height (Elem.fill |> Elem.maximum 160)
                , Elem.spacingXY 0 10
                ]
                [ logo
                , navLinks
                ]
    
        logo =
            Elem.el 
                [ Elem.width (Elem.fillPortion 2)
                , Elem.height Elem.fill
                --, Elem.mouseOver [Background.color (Elem.rgb255 10 10 10)]
                --, Border.width 1
                ]
                (Elem.link
                    [ Elem.width (Elem.px viewSettings.font.size.width) --(Elem.px 60)
                    , Elem.height (Elem.px viewSettings.font.size.height) --(Elem.px 60)
                    , Elem.centerX
                    , Background.image "images/IP-Logo.jpg"
                    , Elem.mouseOver [ Elem.scale 1.05 ]
                    --, Elem.paddingXY 20 0
                    --, Border.width 1
                    ]
                    { url = "/"
                    , label = Elem.text "" --Elem.none
                    }
                )
                                
    
        navLinks =
            body
            --Elem.row 
            --    [ Elem.width Elem.fill
            --    , Elem.height Elem.fill
            --    , Border.width 1
            --    ]
            --    [body]
    
        in
        Elem.column 
            [ Elem.width Elem.fill
            --, Elem.height Elem.fill
            ]
            [ headerRow
            ]
        


desktop :
    { viewSettings : ViewSettings 
    , title : Elem.Element msg 
    , body : Elem.Element msg  
    }  
    -> Elem.Element msg
desktop { viewSettings, title, body } =
    let
        headLine =
            Elem.el 
                [ Elem.width (Elem.fillPortion 2)
                , Elem.height Elem.fill
                , Elem.centerX
                , Elem.centerY
                --, Border.width 1
                ]
                (Elem.el
                    [ Elem.width (Elem.fill |> Elem.maximum 300)
                    , Elem.height (Elem.px 60)
                    , Elem.centerX
                    , Elem.centerY
                    --, Border.width 1
                    ]
                    title
                )
                
                
        contentBox =
            Elem.column
                [ Elem.width (Elem.fillPortion 4)
                , Elem.height Elem.fill
                , Elem.scrollbarY
                , Border.widthEach
                    { top = 0
                    , right = 0
                    , bottom = 0
                    , left = 1
                    }
                ]
                [ content ]

        content =
            Elem.column 
                [ Elem.width Elem.fill --|> Elem.maximum 800)
                , Elem.height Elem.fill
                , Elem.scale 0.96
                --, Border.width 1
                ]
                [ body ]
                --[ aboutLarge viewSettings ]
    in
    Elem.row 
        [ Elem.width Elem.fill
        , Elem.height Elem.fill
        , Elem.alignTop
        , Elem.scrollbarY
        --, Border.width 1
        ]
        [ headLine
        , contentBox
        ]


mobile :
    { viewSettings : ViewSettings 
    , title : Elem.Element msg 
    , body : Elem.Element msg  
    }  
    -> Elem.Element msg 
mobile { viewSettings, title, body } =
    let
        headLine =
            Elem.el 
                [ Elem.width Elem.fill
                , Elem.height (Elem.fill |> Elem.maximum 80)
                --, Border.width 1
                ]
                (Elem.el
                    [ Elem.width (Elem.fill |> Elem.maximum 300)
                    , Elem.height (Elem.px 60)
                    , Elem.centerX
                    , Elem.centerY
                    --, Border.width 1
                    ]
                    title
                )
                    
        contentBox =
            Elem.column
                [ Elem.width Elem.fill
                , Elem.height Elem.fill
                --, Border.width 1
                ]
                [ content ]

        content =
            Elem.column 
                [ Elem.width Elem.fill --|> Elem.maximum 800)
                , Elem.height Elem.fill
                --, Elem.scale 0.96
                --, Border.width 1
                ]
                [ body ]
    in
    Elem.column
        [ Elem.width Elem.fill
        , Elem.height Elem.fill
        , Elem.scrollbarY
        ]
        [ headLine
        , contentBox
        ]
