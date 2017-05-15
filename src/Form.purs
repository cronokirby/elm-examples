module Form where

import Prelude
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Data.Maybe (Maybe(..))

type State =
    { name :: String
    , password :: String
    , passwordAgain :: String
    }

init :: State
init = { name: ""
       , password: ""
       , passwordAgain: ""
       }

data Query a
   = Name String a
   | Password String a
   | PasswordAgain String a 

ui :: forall m. H.Component HH.HTML Query Unit Void m
ui =
  H.component
  { initialState: const init
  , render
  , eval
  , receiver: const Nothing
  }

render :: State -> H.ComponentHTML Query
render state =
  HH.div_
    [ HH.input [ HP.placeholder "Name"
               , HE.onValueInput $ HE.input Name ]
    , HH.input [ HP.placeholder "Re-enter Password" 
               , HP.type_ HP.InputPassword
               , HE.onValueInput $ HE.input Password ]
    , HH.input [ HP.placeholder "Re-enter Password" 
               , HP.type_ HP.InputPassword
               , HE.onValueInput $ HE.input PasswordAgain ]
    , HH.div_ [ HH.text validation ]
    ]
 where
  validation =
    if state.password == state.passwordAgain then
     "Matching"
    else 
     "Please enter matching passwords"

eval :: forall m. Query ~> H.ComponentDSL State Query Void m
eval = case _ of
  Name new next -> 
    H.modify (\s -> s { name = new }) $> next
  Password new next ->
    H.modify (\s -> s { password = new}) $> next
  PasswordAgain new next ->
    H.modify (\s -> s { passwordAgain = new }) $> next
 

