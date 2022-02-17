module Widgets.ImageText exposing (..)

import Element as Elem
import Element.Border as Border
import Element.Background as Background
import Element.Font as Font
import ViewSettings exposing (ViewSettings)


aboutLarge : ViewSettings -> Elem.Element msg 
aboutLarge viewSettings =
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
                [ Font.size viewSettings.font.size.medium
                , Font.family
                    [ Font.typeface "FreeMono"     
                    ]
                ]
                [ image 
                , Elem.text aboutPt
                ]
        

        image =
            Elem.image 
                [ Elem.width (Elem.px viewSettings.spacing.width) --(Elem.fill |> Elem.maximum 400)
                , Elem.height (Elem.px viewSettings.spacing.height) --(Elem.fill |> Elem.maximum 400) 
                , Elem.alignLeft
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


aboutMobile : ViewSettings -> Elem.Element msg 
aboutMobile viewSettings =
    let
        allContent =
            Elem.column 
                [ Elem.width (Elem.fill |> Elem.maximum 700)
                , Elem.centerX
                , Elem.centerY
                , Elem.spacingXY 0 5
                ]
                [ image --textColumn 
                , textColumn
                ] 

                
        textColumn =
            Elem.textColumn 
                [ Elem.width Elem.fill
                , Elem.spacingXY 0 5
                ]
                [ columnPt --paragraphPt
                , paragraphEn 
                ]

        --paragraphPt =
        --    Elem.paragraph
        --        [ Font.size viewSettings.font.size.medium
        --        , Font.family
        --            [ Font.typeface "FreeMono"     
        --            ]
        --        ]
        --        [ image 
        --        , Elem.text aboutPt
        --        ]


        image =
            Elem.image 
                [ Elem.width (Elem.px viewSettings.spacing.width) --(Elem.fill |> Elem.maximum 400)
                , Elem.height (Elem.px viewSettings.spacing.height) --(Elem.fill |> Elem.maximum 400) 
                , Elem.alignLeft
                , Elem.centerX
                ]
                { src = "/images/Foto-Ines.jpg"
                , description = "Portrait of Ines"
                }


        columnPt =
            Elem.paragraph
                [ Font.size viewSettings.font.size.medium
                , Font.family
                    [ Font.typeface "FreeMono"     
                    ]
                ]
                [ Elem.text aboutPt
                ]

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
