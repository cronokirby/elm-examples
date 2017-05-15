module SimpleCounter where

import Prelude
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE

type State = Int

data Query a
   = Increment a
   | Decrement a

button :: forall m. H.Component HH.HTML Query Unit Void m
button =
  H.component
    { initialState: const 0
    , render
    , eval
    , receiver: const Nothing
    }

render :: State -> H.ComponentHTML Query
render state =
  HH.div []
    [ HH.button [ HE.onClick (HE.input_ Increment) ] [ HH.text "+" ]
    , HH.div [] [ HH.text (show state) ] 
    , HH.button [ HE.onClick (HE.input_ Decrement) ] [ HH.text "-" ]
    ]

eval :: forall m. Query ~> H.ComponentDSL State Query Void m
eval = case _ of
  Increment next -> 
    H.modify ((+) 1) $> next
  Decrement next -> 
    H.modify (flip (-) 1) $> next
