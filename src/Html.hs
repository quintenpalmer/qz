{-# LANGUAGE OverloadedStrings #-}

module Html (
    BaseHtmlExtention,
    generateQzPage,
    indexHtml,
    friendsHtml,
    gameHtml
) where

import Control.Monad (forM_)

import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5 ((!), Html)
import qualified Text.Blaze.Html5.Attributes as A

data BaseHtmlExtention = BaseHtmlExtention Html Html

indexHtml :: BaseHtmlExtention
indexHtml = BaseHtmlExtention "QZ Homepage" $ do
    H.h1 $ "Hi!"
    H.p $ H.a ! A.href "/friends" $ "Friend List"
    H.p $ H.a ! A.href "/game" $ "Play a game"

gameHtml :: BaseHtmlExtention
gameHtml = BaseHtmlExtention "QZ Friendlist" $ do
    H.h1 $ "Play a game!"
    H.div ! A.id "map" $ ""

friendsHtml :: BaseHtmlExtention
friendsHtml = BaseHtmlExtention "QZ Friendlist" $ do
    H.h1 $ "Look at your friends"
    H.ul $ forM_ ["Bob" :: String, "Fred" :: String] (H.li . H.toHtml)

baseHtml :: BaseHtmlExtention -> Html
baseHtml (BaseHtmlExtention title body) = H.docTypeHtml $ do
    H.head $ do
        H.title title
        H.script ! H.customAttribute "type" "text/javascript" ! A.src "/static/js/jquery-2.1.3.min.js" $ ""
        H.script ! H.customAttribute "type" "text/javascript" ! A.src "/static/js/main.js" $ ""
        H.link ! A.href "static/css/style.css" ! A.rel "stylesheet"
    H.body $ do
        H.div ! A.id "titleBar" ! A.class_ "pageWidth" $ H.h1 $ H.a ! A.href "/" $ "Quinten, Zac, and a Robot"
        H.div ! A.id "container" ! A.class_ "pageWidth" $ body

generateQzPage :: BaseHtmlExtention -> Html
generateQzPage = baseHtml
