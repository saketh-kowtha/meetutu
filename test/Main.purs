module Test.Main where

import Prelude
import Node.Buffer
import Node.Encoding
import Node.FS (FS)
import Node.FS.Sync
import DOM.HTML
import DOM.HTML.Window
import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Test.SVG as SvgTest
import Test.Unit (test)
import Test.Unit.Assert (equal)
import Test.Unit.Console (TESTOUTPUT)
import Test.Unit.Main (runTest)
import Text.Smolder.HTML (title) as T
import Text.Smolder.HTML (body, h3,h1 ,script, embed,head, html, img, link, meta, p,a,button,input,form,br,hr,div,select,option)
import Text.Smolder.HTML.Attributes (charset,src,content, title,pattern,href,onclick, httpEquiv,selected,lang,style, name,id, rel, placeholder,required,width,height, type',className,method,action,onclick)
import Text.Smolder.Markup (on, (#!), Markup, text, (!))
import Text.Smolder.Renderer.String (render)
--import Text.Smolder.Renderer.DOM as N
abc :: String
abc = "$"
screen1 :: forall a e. Markup (a -> Eff (console :: CONSOLE | e) Unit)
screen1 = html ! lang "en" $ do
  head $ do
    T.title $ text "Project By Saketh"
    link ! rel "stylesheet" ! href "style.css"


  body $ do
    div ! id "login" ! style "border-style : solid;border-width : 2px;" $ do
      h3 $ text "Register"
      hr
      img ! src "img.png" ! width "100px" ! height "100px"
      form !
        method "post" ! action "screen2.html" $ do
        input ! type' "email" ! required "yes" ! placeholder "Enter Email" ! style "margin-top : 20px"
        br
        input ! type' "text" ! required "yes" ! placeholder "Enter Username"
        br
        input ! type' "text" ! required "yes" ! placeholder "Enter Phone Number (XXXXX-XXXXX)" ! pattern ("\\d{5}-\\d{5}"<>abc) ! title "Format : XXXXX-XXXXX"
        br
        select $ do
          option  $ text "Learner" ! selected "yes"
          option $ text "Teacher"
        br
        input ! type' "text" ! required "yes" ! placeholder "Enter What You Know / Can"
        br
        button $ text "Register!"

  --    button #! on "click"  (\event -> log "ok") $ text "ok"

screen2 :: forall a e. Markup (a -> Eff (console :: CONSOLE | e) Unit)
screen2 = html ! lang "en" $ do
          link ! rel "stylesheet" ! href "style.css"
          div ! style "float : left ; width : 70%;" $ do
              embed ! src "http://maps.google.com/maps?q=12.927923,77.627108&z=15&output=embed" ! width "100%" ! height "100%" ! style "postion : absolute"
          div ! style "float : left;width : 30%;text-align : center;" $ do
              h3 $ text  "Contact" ! style "position : right;"
              p ! style "font-size : 12px;" $ text ("Name     : " <> "Ramesh")
              p ! style "font-size : 12px;" $ text ("Address  : " <> "XYZ Street")
              a ! href ("https://api.whatsapp.com/send?phone=+917207270470&text='I Want Teacher For C,C++,Java'") ! className "btn" $ text ("Click To Send Whatsapp Message")
              br
              a ! href ("https://api.whatsapp.com/send?phone=+917207270470&text='http://maps.google.com/maps?q=12.927923,77.627108&z=15'") ! className "btn" $ text "Share Location"

              p ! style "font-size : 12px;" $ text ("Name     : " <> "Ravi")
              p ! style "font-size : 12px;" $ text ("Address  : " <> "Koramangal Street")
              a ! href ("https://api.whatsapp.com/send?phone=+917207270470&text='I Want Teacher For C,C++,Java'") ! className "btn" $ text ("Click To Send Whatsapp Message")
              br
              a ! href ("https://api.whatsapp.com/send?phone=+917207270470&text='http://maps.google.com/maps?q=12.927923,77.627108&z=15'") ! className "btn" $ text "Share Location"

              p ! style "font-size : 12px;" $ text ("Name     : " <> "Shyam")
              p ! style "font-size : 12px;" $ text ("Address  : " <> "SN Puram")
              a ! href ("https://api.whatsapp.com/send?phone=+917207270470&text='I Want Teacher For C,C++,Java'") ! className "btn" $ text ("Click To Send Whatsapp Message")
              br
              a ! href ("https://api.whatsapp.com/send?phone=+917207270470&text='http://maps.google.com/maps?q=12.927923,77.627108&z=15'") ! className "btn" $ text "Share Location"

main :: forall e. Eff (console :: CONSOLE, avar :: AVAR, testOutput :: TESTOUTPUT, buffer :: BUFFER, fs :: FS,  exception :: EXCEPTION| e) Unit
main = do
  -- log (render screen1)
  s1 <- (fromString (render screen1) Binary)
  writeFile "index.html" s1
  s2 <- (fromString (render screen2) Binary)
  writeFile "screen2.html" s2
  --N.render "#app" screen1
  --window >>= alert "Hello from PSCi!"
  pure unit
  --log (render screen2)
  --_ <- writeFile "index.html" buf
  --pure unit
