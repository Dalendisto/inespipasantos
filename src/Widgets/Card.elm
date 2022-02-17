module Widgets.Card exposing (..)

import Element as Elem
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Data.Projects as Projects
import ViewSettings exposing (ViewSettings)


switcher : ViewSettings ->Int -> Projects.ProjectFm -> Elem.Element msg
switcher viewSettings index static =
    case modBy 2 index == 0 of
        True ->
            imageRight viewSettings static

        False ->
            imageLeft viewSettings static  


mobileCard : ViewSettings -> Projects.ProjectFm -> Elem.Element msg
mobileCard viewSettings static =
    Elem.column 
        [ Elem.width (Elem.fill |> Elem.maximum 400) --(Elem.px 800)
        , Elem.height (Elem.px 400)
        , Elem.spacingXY 0 20
        --, Elem.spaceEvenly
        , Elem.centerX
        --, Border.width 1
        ]
        [ cardImage static 
        , infoColumn viewSettings static
        ]


imageLeft : ViewSettings -> Projects.ProjectFm -> Elem.Element msg
imageLeft viewSettings static =
    Elem.row 
        [ Elem.width (Elem.fill |> Elem.maximum 800) --(Elem.px 800)
        , Elem.height (Elem.px 250) --(Elem.fill |> Elem.maximum 250)
        , Elem.spacingXY 50 0
        , Elem.centerX
        --, Border.width 1
        ]
        [ cardImage static 
        , infoColumn viewSettings static
        ]


imageRight : ViewSettings -> Projects.ProjectFm -> Elem.Element msg
imageRight viewSettings static =
    Elem.row 
        [ Elem.width  (Elem.fill |> Elem.maximum 800) --(Elem.px 800)
        , Elem.height (Elem.px 250) --(Elem.fill |> Elem.maximum 250)
        , Elem.spacingXY 50 0
        , Elem.centerX
        --, Border.width 1    
        ]
        [ infoColumn viewSettings static
        , cardImage static 
        ]


infoColumn : ViewSettings -> Projects.ProjectFm -> Elem.Element msg
infoColumn viewSettings static =
    Elem.column 
        [ Elem.width Elem.fill
        , Elem.height(Elem.fillPortion 1) 
        , Elem.spacingXY 0 20
        , Elem.alignTop
        ]
        [ title viewSettings static
        , description viewSettings static
        , projectLink static
        ]


title : ViewSettings -> Projects.ProjectFm -> Elem.Element msg
title viewSettings static =
    Elem.paragraph 
        [ Font.size viewSettings.font.size.large
        --, Font.underline
        , Font.family
            [ Font.typeface "FreeMono"]    
        ]
        [Elem.text static.title]


description : ViewSettings -> Projects.ProjectFm -> Elem.Element msg
description viewSettings static =
    Elem.paragraph 
        [ Font.size viewSettings.font.size.medium
        , Font.family
            [ Font.typeface "FreeMono"]   
            
        ]
        [ Elem.text static.description]


projectLink : Projects.ProjectFm -> Elem.Element msg
projectLink static =
    let
        linkButton =
            Elem.link
                [ Elem.centerX
                , Elem.centerY
                , Font.family
                    [ Font.typeface "FreeMono"]
                --, Border.width 1
                ]
                { url = "/project/" ++ static.slug
                , label = Elem.text "Continue"
                }
    in
    Elem.el 
        [ Elem.width Elem.fill
        , Elem.height (Elem.px 40)
        , Elem.alignBottom
        , Border.width 1 
        ]
        linkButton


cardImage : Projects.ProjectFm -> Elem.Element msg
cardImage static =
    Elem.el  
        [ Elem.width (Elem.fillPortion 1)
        , Elem.height Elem.fill --(Elem.px 250) --(Elem.fill |> Elem.maximum 250)
        , Background.image static.image
        ]
        Elem.none


mobileImage : Projects.ProjectFm -> Elem.Element msg
mobileImage static =
    Elem.el  
        [ Elem.width (Elem.fillPortion 1) --Elem.fill
        , Elem.height Elem.fill --(Elem.px 250) --(Elem.fillPortion 1)
        , Background.image static.image
        ]
        Elem.none


img : ViewSettings -> Elem.Attribute msg
img viewSettings =
    case viewSettings.size of 
        ViewSettings.Small ->
            Elem.height (Elem.px 200)

        _ ->
            Elem.height (Elem.px 250)
