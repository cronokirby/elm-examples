module TextFields where

import Prelude
import Data.String (fromCharArray, toCharArray)
import Data.Array as Array
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Data.Maybe (Maybe(..))

type State = { content :: String }

data Query a = Change String a

field :: forall m. H.Component HH.HTML Query Unit Void m
field = 
  H.component
    { initialState: const {content: ""}
    , render
    , eval
    , receiver: const Nothing
    }

render :: State -> H.ComponentHTML Query
render state =
  HH.div []
    [ HH.input [ HP.placeholder "Text to reverse"
               , HE.onValueInput $ HE.input Change ] 
    , HH.div [] [ HH.text $ reverse state.content ]
    ]

eval :: forall m. Query ~> H.ComponentDSL State Query Void m
eval (Change new next) = H.modify (\x -> x { content = new }) $> next

reverse :: String -> String
reverse = fromCharArray <<< Array.reverse <<< toCharArray

