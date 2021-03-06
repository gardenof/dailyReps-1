module Year2020.Month02.Day28 where

import qualified Control.Applicative.Free as FreeAp
import qualified Control.Monad as Monad
import qualified Data.List as List
import qualified Data.Ord as Ord
import qualified Data.Set as Set

{--
  Data.Ord / Sorting lists

  - define an enum for player rank and build a manual Ord instance for it
  - sort a list of ranks into ascending order
  - sort a list of ranks into descinding ordering using Ord.Down
  - define a Player record with name and rank
      - Sort a list of players alphabetically using sortBy / comparing
      - Sort a list of players by rank using sortOn
  - Build a compare function for players that compares by name and then rank
      - Hint: use Ord.comparing to compare the fields
      - build one that is fully explicit
      - Then build one that uses the Ordering Semigroup
      - Then build one that uses the Ordering Semigroup and the (->) Semigroup

--}

data Rank
  = Gold
  | Silver
  | Bronze
  deriving (Show, Eq)

instance Ord Rank where
  compare left right =
    case (left, right) of
      (Gold, Gold) -> EQ
      (Silver, Silver) -> EQ
      (Bronze, Bronze) ->  EQ
      (Gold, _) -> GT
      (_, Gold) -> LT
      (Silver, _) -> GT
      (_, Silver) -> LT

ranks :: [Rank]
ranks =
  [ Silver, Gold, Bronze, Gold, Silver ]

ascendingRanks :: [Rank]
ascendingRanks =
  List.sort ranks

descendingRanks :: [Rank]
descendingRanks =
  List.sortOn Ord.Down ranks

data Player =
  Player
    { playerName :: String
    , playerRank :: Rank
    } deriving (Show, Eq)

players :: [Player]
players =
  [ Player "Sandra" Gold
  , Player "Stan" Bronze
  , Player "Xavier" Silver
  , Player "Kim" Silver
  ]

alphabeticalPlayers :: [Player]
alphabeticalPlayers =
  List.sortOn playerName players


rankedPlayers :: [Player]
rankedPlayers =
  List.sortBy (Ord.comparing playerRank) players

comparePlayers1 :: Player -> Player -> Ordering
comparePlayers1 left right =
  case Ord.comparing playerRank left right of
    LT -> LT
    GT -> GT
    EQ -> Ord.comparing playerName left right

comparePlayers2 :: Player -> Player -> Ordering
comparePlayers2 left right =
  Ord.comparing playerRank left right <> Ord.comparing playerName left right

comparePlayers3 :: Player -> Player -> Ordering
comparePlayers3 =
  Ord.comparing playerRank <> Ord.comparing playerName

{--
   Control.Applicative.Free

   - Red / Black tagging type w/ contructors Functor instance
   - ban function
   - use liftAp to build taggedPlus
   - use runAp to implement runBanned
   - use runAp_ to implement tags
   - use iterAp to implement runIter
   - use hoistAp / retractAp to implement runBanned2
--}

data Tag
  = Red
  | Black
  deriving (Show, Eq, Ord)

data Tagged a =
  Tagged Tag a
  deriving (Show, Eq)

instance Functor Tagged where
  fmap f (Tagged tag a) =
    Tagged tag (f a)

red :: a -> Tagged a
red = Tagged Red

black :: a -> Tagged a
black = Tagged Black

ban :: Tag -> Tagged a -> Maybe a
ban bannedTag (Tagged tag a) = do
  Monad.guard (tag /= bannedTag)
  pure a

taggedPlus :: Tagged Int -> Tagged Int -> FreeAp.Ap Tagged Int
taggedPlus a b =
  (+) <$> FreeAp.liftAp a <*> FreeAp.liftAp b

runBanned :: Tag -> FreeAp.Ap Tagged a -> Maybe a
runBanned bannedTag =
  FreeAp.runAp (ban bannedTag)

tags :: FreeAp.Ap Tagged a -> Set.Set Tag
tags =
  FreeAp.runAp_ extractTag
    where
      extractTag (Tagged tag _) =
        Set.singleton tag

runPlain :: FreeAp.Ap Tagged a -> a
runPlain =
  FreeAp.iterAp extractValue
    where
      extractValue (Tagged _ a) =
        a

runBanned2 :: Tag -> FreeAp.Ap Tagged a -> Maybe a
runBanned2 bannedTag =
  FreeAp.retractAp . FreeAp.hoistAp (ban bannedTag)
