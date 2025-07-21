{-# LANGUAGE OverloadedStrings #-}

import Hakyll

main :: IO ()
main = hakyllWith config $ do
  match "images/*" $ do
    route idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route idRoute
    compile compressCssCompiler

  match "index.md" $ do
    route (setExtension "html")
    compile $ pandocCompiler 
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

  match "templates/*" $ compile templateCompiler

config :: Configuration
config = defaultConfiguration
  { destinationDirectory = "docs"
  }

