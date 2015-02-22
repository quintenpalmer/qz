{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative ((<|>))
import System.FilePath.Posix (joinPath)

import qualified Snap.Core as Snap
import Snap.Core (Snap)
import qualified Snap.Http.Server as SnapS
import qualified Snap.Util.FileServe as SnapF

import Text.Blaze.Html.Renderer.Utf8 (renderHtml)
import Clay (renderWith, compact)

import Data.Map (Map, fromList)
import Data.Aeson (encode, ToJSON)

import Html (BaseHtmlExtention, generateQzPage)
import qualified Html
import Css (style)

main :: IO ()
main = SnapS.quickHttpServe site

site :: Snap ()
site =
    Snap.ifTop (snapHtml Html.indexHtml) <|>
    Snap.route [
        ("/friends", snapHtml Html.friendsHtml),
        ("/game", snapHtml Html.gameHtml),
        ("rest/1.0/map", Snap.method Snap.GET getMapHandler),
        ("rest/1.0/tileInfo", Snap.method Snap.GET getTileInfoHandler),
        ("static/css/style.css", Snap.writeLazyText $ renderWith compact [] style)
    ] <|>
    Snap.dir "static" (SnapF.serveDirectory "static")

snapHtml :: BaseHtmlExtention -> Snap ()
snapHtml ext = do
    Snap.modifyResponse $ Snap.setContentType "text/html; charset=utf-8"
    Snap.writeLBS $ renderHtml $ generateQzPage ext

getMapHandler :: Snap ()
getMapHandler = do
    Snap.modifyResponse $ Snap.setContentType "application/json"
    Snap.writeLBS $ encode (fromList [("data", [[1,2,1,2], [2,2,2,2], [2,2,2,4], [3,3,4,4]])] :: Map String [[Int]])

getTileInfoHandler :: Snap ()
getTileInfoHandler = do
    Snap.modifyResponse $ Snap.setContentType "application/json"
    Snap.writeLBS $ encode $ withData (fromList [
        ("1", "dirt"),
        ("2", "grass"),
        ("3", "rock"),
        ("4", "water")] :: Map String String)

withData :: ToJSON a => a -> Map String a
withData val = fromList [("data", val)]
