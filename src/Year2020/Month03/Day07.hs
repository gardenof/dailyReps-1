{--

Eq
  | Eq is a typeclass for types that can be compared for equality.

- Write out the Eq "Laws"
  * Note that the Haskell Report that defines the official Haskell language
    does not give an official laws for Eq. Despite this, there are customary
    laws given in the docs for Eq that represent the general expected practice
    for implementing Eq. The laws given in the answer here are those, with
    one omission (Substitutivity), for simplicities sake.
  - Reflexivity
  - Symmetry
  - Transitivity
  - Negation

- Define an enum type and provide an Eq instance for it
- Define a record type and provide an Eq instance for it
- Define another enum type and derive Eq for it
- Define another record type and derive Eq for it

--}

{--
  Newtypes
    | A "newtype" is a type defined with tha `newtype` keyword. It is a
    | trivial wrapper around an existing type that creates a brand new type
    | out of it that the compiler will treat as different from the original
    | type. This is useful for many things, including distinguishing between
    | values that would otherwise be the same simple type. The compiler
    | removes newtype wrappers at compile time so that there is littre to
    | no runtime cost associated with having many newtypes.

- Define a type using newtype to represent a person's Name
- Define a type using newtype to represent a person's Hometown
- Define a type using newtype to represent a person's Age
- Define a Person record using these three types.
- Construct a value of type Person.
- Implement a function nameToString to convert a Name to String
- Implement a function hometownToString to convert a Hometown to String
- Implement a function to create a String introducing a Person by stating their
  name and where they are from. Be polite and omit their age from the
  introduction

| Newtypes can also be used create a wrapper for the purpose of providing
| a new typeclass instance for a type that already has one. We will use this
| technique in these reps occasionally to allow us to re-write the typeclass
| implementations in common libraries as a way to understand them better.


- define an Eq instance for Hometown that is equivalent to the one for String
- define an Eq instance for Name that compares names in a case-insensitive manner.

--}
module Year2020.Month03.Day07 where

import qualified Data.Char as Char

{-
  Eq "Laws" (without Substitutivity)
    Reflexivity
      (x == x) = True

    Symmetry
      (x == y) = (y == x)

    Transitivity
      if (x == y) and (y == z) then (x == z)

    Negation
      x /= y = not (x == y)
-}

data Biscuits
  = Cheddar
  | Buttermilk
  | Dumplings

instance Eq Biscuits where
  left == right =
    case (left, right) of
      (Cheddar, Cheddar) -> True
      (Buttermilk, Buttermilk) -> True
      (Dumplings, Dumplings) -> True
      _ -> False

data Cow =
  Cow
    { cowName :: String
    , cowWeight :: Int
    }

instance Eq Cow where
  left == right =
    cowName left == cowName right
    && cowWeight left == cowWeight right

data Cakes
  = PoundCake
  | CarrotCake
  | Genoise
  deriving Eq

data Frosting =
  Frosting
    { frostingFlavor :: String
    , frostingColor :: String
    } deriving Eq

newtype Name =
  Name String

nameToString :: Name -> String
nameToString (Name nameString) =
  nameString

newtype Hometown =
  Hometown String

hometownToString :: Hometown -> String
hometownToString (Hometown hometownString) =
  hometownString

newtype Age =
  Age Int

data Person =
  Person
    { personName :: Name
    , personHometown :: Hometown
    , personAge :: Age
    }

aPerson :: Person
aPerson =
  Person
    { personName = Name "Bob"
    , personHometown = Hometown "Saskatchewan"
    , personAge = Age 33
    }

introduction :: Person -> String
introduction person =
  nameToString (personName person)
  ++ " from "
  ++ hometownToString (personHometown person)

instance Eq Hometown where
  left == right =
    hometownToString left == hometownToString right

instance Eq Name where
  left == right =
    let
      toLowerCaseString = map Char.toLower . nameToString
    in
      toLowerCaseString left == toLowerCaseString  right


