module Data.Projects exposing (..)

import DataSource exposing (DataSource)
import DataSource.File as File
import DataSource.Glob as Glob
import Html.Attributes as HA
import Element as Elem
import Element.Border as Border
import OptimizedDecoder as Dec
import Markdown as Markdown


type alias Project =
    { filePath : String
    , slug : String
    }


projectFiles : DataSource (List Project)
projectFiles =
    Glob.succeed
        (\filePath slug ->
            { filePath = filePath
            , slug = slug
            }
        )
        |> Glob.captureFilePath 
        |> Glob.match (Glob.literal "content/projects/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal ".md")
        |> Glob.toDataSource


type alias ProjectFm =
    { slug : String
    , title : String
    , description : String 
    , author : String 
    , published : String 
    , image : String 
    }


getProjectFm : DataSource (List ProjectFm)
getProjectFm =
    projectFiles 
        |> DataSource.map
            (\filePaths -> 
                List.map
                    (\filePath ->
                        File.onlyFrontmatter (decodeFm filePath.slug) filePath.filePath
                    )
                filePaths
            )
        |> DataSource.resolve


decodeFm : String -> Dec.Decoder ProjectFm 
decodeFm slug =
    Dec.map5 (ProjectFm slug)
        (Dec.field "title" Dec.string)
        (Dec.field "description" Dec.string)
        (Dec.field "author" Dec.string)
        (Dec.field "published" Dec.string)
        (Dec.field "image" Dec.string)


getSingleFm : String -> DataSource ProjectFm
getSingleFm slug =
    File.onlyFrontmatter (decodeFm slug) ("content/projects/" ++ slug ++ ".md")


type alias Content msg =
    { content : Elem.Element msg }


getProjectContent : String -> DataSource (Content msg)
getProjectContent slug =
    File.bodyWithoutFrontmatter ("content/projects/" ++ slug ++ ".md")
        |> DataSource.map 
            (\item ->
                { content =
                    Elem.paragraph
                        [ Elem.width Elem.fill --(Elem.px 800)
                        , Elem.height Elem.fill
                        ]
                        [ Markdown.toHtml [ HA.list ""] item
                            |> Elem.html 
                        ]
                }
            )
