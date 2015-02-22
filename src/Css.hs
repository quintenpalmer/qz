{-# LANGUAGE OverloadedStrings #-}

module Css (
    style
) where

import qualified Clay as C
import Clay (Css, (?))

style :: Css
style = do
    C.a ? do
        C.textDecoration C.none
    C.body ? do
        C.backgroundImage $ C.url "/static/images/background.png"
        C.color ("#000" :: C.Color)
        C.fontFamily ["Inconsolata"] [C.serif, C.sansSerif]
        C.fontFamily ["Inconsolata"] [C.monospace]
        C.fontSize $ C.pct 100.0
        C.border C.solid (C.px 5) C.black
        C.margin (C.px 0) (C.px 0) (C.px 0) (C.px 0)
    ".pageWidth" ? do
        C.border C.solid (C.px 5) C.black
        C.backgroundImage $ C.url "/static/images/container.png"
        C.width $ C.px 800
        C.marginLeft C.auto
        C.marginRight C.auto
        C.paddingLeft $ C.px 15
        C.paddingRight $ C.px 15
    "#titleBar " ? do
        C.height $ C.px 100
        C.marginTop $ C.px 5
        C.paddingTop $ C.px 2
        C.marginBottom $ C.px 20
    "#container" ? do
        C.height $ C.other "100vh"
        C.paddingTop $ C.px 2
    ".cell" ? do
        C.background ("#222" :: C.Color)
        C.height $ C.px 64
        C.width $ C.px 64
        C.padding (C.px 0) (C.px 0) (C.px 0) (C.px 0)
        C.margin (C.px 0) (C.px 0) (C.px 0) (C.px 0)
    ".nowrap" ? do
        C.display C.inlineBlock
    ".short" ? do
        C.fontSize (C.px 0)
        C.paddingTop (C.px 0)
        C.paddingBottom (C.px 0)
        C.marginTop (C.px 0)
        C.marginBottom (C.px 0)
