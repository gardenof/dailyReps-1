{-

- safeHead
- safeTail
- safeLast
- list of names
- Use map to find length of names
- Use sum to total of the length of names
- Use intercalate to join list of names
- Function to determine if name is long
- Use `and` to find if all names are long
- Use `all` to find if all names are long
- Use `or` to find if any names are long
- Use `any` to find if any names are long
- Filter out all the long names
- partition long and short nomes
- Check if a particular name is elem of long names
- `find` a long name
- Write a function to truncate a name to make it short using `take`
- Write a function to show the remainder after tuncating a name using `drop`.
- Write a function to truncate and return remained of a name using `splitAt`.
- Use `elem` to implement isEnglishVowel
- Drop leading vowels
- Take leading vowels
- Take leading vowels with leftovers
- Take leading consonants with leftovers

-}
module Year2020.Month04.Day01 where

import qualified Data.List as List

safeHead :: [a] -> Maybe a
safeHead as =
  case as of
    [] ->
      Nothing

    a : _ ->
      Just a

safeTail :: [a] -> Maybe [a]
safeTail as =
  case as of
    [] ->
      Nothing

    _ : rest ->
      Just rest

safeLast :: [a] -> Maybe a
safeLast as =
  case as of
    [] ->
      Nothing

    [a] ->
      Just a

    _ : rest ->
      safeLast rest

names :: [String]
names =
  [ "Art", "Angelica", "Alfred", "Anderson", "Allison", "Alicia" ]

lengthsOfNames :: [Int]
lengthsOfNames =
  map length names

totalLengthOfNames :: Int
totalLengthOfNames =
  sum lengthsOfNames

rollCall :: String
rollCall =
  List.intercalate ", " names

isLongName :: String -> Bool
isLongName name =
  length name > 7

allNamesAreLong1 :: Bool
allNamesAreLong1 =
  and (map isLongName names)

allNamesAreLong2 :: Bool
allNamesAreLong2 =
  all isLongName names

anyNamesAreLong1 :: Bool
anyNamesAreLong1 =
  or (map isLongName names)

anyNamesAreLong2 :: Bool
anyNamesAreLong2 =
  any isLongName names

justLongNames :: [String]
justLongNames =
  filter isLongName names

longNames, shortNames :: [String]
(longNames, shortNames) =
  List.partition isLongName names

isAllisonLong :: Bool
isAllisonLong =
  "Allison" `elem` longNames

aLongName :: Maybe String
aLongName =
  List.find isLongName names

truncateName :: String -> String
truncateName =
  take 7

nameRemainder :: String -> String
nameRemainder =
  drop 7

truncateNameWithRemainder :: String -> (String, String)
truncateNameWithRemainder =
  splitAt 7

isEnglishVowel :: Char -> Bool
isEnglishVowel char =
  char `elem` "AaEeIiOoUu"

dropLeadingVowels :: String -> String
dropLeadingVowels =
  dropWhile isEnglishVowel

takeLeadingVowels :: String -> String
takeLeadingVowels =
  takeWhile isEnglishVowel

splitOffLeadingVowels :: String -> (String, String)
splitOffLeadingVowels =
  span isEnglishVowel

splitOffLeadingConsonants :: String -> (String, String)
splitOffLeadingConsonants =
  break isEnglishVowel
