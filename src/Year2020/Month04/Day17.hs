{-

- Construct a Maybe Integer value as usual
- Demonstrate a trivial use a do with Maybe defining the same value as above
- Demonstrate a similar trivial use of do with List
- Demonstrate a trivial polymorphic use of do using `pure` (i.e. one that works for all Applicatives)
- Use do syntax to define a function that adds 1 to a `Maybe Integer`
- Use do syntax to define a function that adds takes a list of Integers and adds 1 and 2 to each one, creating a single list of results
- Use do syntax to define a polymorphic function that adds 1 to an Integer within any Monad
- Use do syntax to define a function that takes two lists and returns a list that contains the sums and products of all the combinations of items from the two list.
- Use do syntax to define a function that adds two Integer values within any Monad
- Use do syntax to define a function that returns the pair of the product and sum of two Integer within a Monad
  * use let inside the two to assign variables names for the sum and product
- Define an alias foar `getLine` with the correct type signature
+ Define an IO operation that finds the length of a line of input from the user
  - once using do syntax
  - once using fmap
- Define an alias for `putStrLn` with the correct type signature
+ Define a function that takes a string and builds an IO that show it as a prompt on the screen, then gets a line of input in three ways:
  - once explicitly ignoring the result of printing the prompt (i.e. using `_ <-`)
  - once implicitly ignoring the result of printing (i.e. without using `<-`)
  - once explicitly pattern matching on the result of printing the line (i.e. using `() <-`)

- Define a function that takes a secret string and a prompt string. It should first
  ask the user to ender the secret. If the secret they enter matches the secret given to
  the function, then use do syntax to show the prompt, get their answer and return it.
  If the secret doesn't match, use do syntax to print a message telling them so
  and then return Nothing from the operation.

-}
module Year2020.Month04.Day17 where

just10 :: Maybe Integer
just10 =
  Just 10

trivialMaybeDo :: Maybe Integer
trivialMaybeDo = do
  Just 10

trivialListDo :: [Integer]
trivialListDo = do
  [10, 11]

trivialPolymorphicDo :: Applicative m => m Integer
trivialPolymorphicDo = do
  pure 10

maybeAddOne :: Maybe Integer -> Maybe Integer
maybeAddOne maybeInt = do
  int <- maybeInt
  Just (int + 1)

addOneAndTwoToAll :: [Integer] -> [Integer]
addOneAndTwoToAll ints = do
  int <- ints
  [int + 1, int + 2]

polymorphicAddOne :: Monad m => m Integer -> m Integer
polymorphicAddOne mInt = do
  int <- mInt
  pure (int + 1)

allSumsAndProducts :: [Integer] -> [Integer] -> [Integer]
allSumsAndProducts as bs = do
  a <- as
  b <- bs
  [a + b, a * b]

polymorphicSum :: Monad m => m Integer -> m Integer -> m Integer
polymorphicSum mA mB = do
  a <- mA
  b <- mB
  pure (a + b)

polymorphicSumAndProduct :: Monad m => m Integer -> m Integer -> m (Integer, Integer)
polymorphicSumAndProduct mA mB = do
  a <- mA
  b <- mB

  let
    sumAB = a + b
    productAB = a * b

  pure (sumAB, productAB)

getUserInput :: IO String
getUserInput =
  getLine

doLengthOfLine :: IO Int
doLengthOfLine = do
  line <- getLine
  pure (length line)

fmapLengthOfLine :: IO Int
fmapLengthOfLine =
  fmap length getLine

printLineToScreen :: String -> IO ()
printLineToScreen =
  putStrLn

askUserForInput1 :: String -> IO String
askUserForInput1 prompt = do
  _ <- putStrLn prompt
  getLine

askUserForInput2 :: String -> IO String
askUserForInput2 prompt = do
  putStrLn prompt
  getLine

askUserForInput3 :: String -> IO String
askUserForInput3 prompt = do
  () <- putStrLn prompt
  getLine

secretlyPromptUser :: String -> String -> IO (Maybe String)
secretlyPromptUser realSecret prompt = do
  putStrLn "Before I ask you a questions, please tell me the secret:"
  userSecret <- getLine

  if userSecret == realSecret
     then do
       putStrLn prompt
       answer <- getLine
       pure (Just answer)
     else do
       putStrLn "Sorry, that wasn't the real secret"
       pure Nothing
