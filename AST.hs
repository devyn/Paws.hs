module AST where
import Control.Concurrent

data AST = Juxtapose AST AST
         | Block     AST
         | Symbol    String
         | Self deriving (Show)

data Execution = Pristine AST
               | Execution UnzippedAST

data UnzippedAST = Top
                 | First        AST UnzippedAST
                 | Second Thing     UnzippedAST

type Thing = MVar ThingType
data ThingType = Fork  [Thing]
               | Exec  [Thing] Execution
               | Label [Thing] String