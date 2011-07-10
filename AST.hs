module AST where

data AST = Juxtapose AST AST
         | Block     AST
         | Label     String
         | Empty

data Execution = Pristine AST
               | Execution UnzippedAST

data UnzippedAST = Top
                 | Left        AST UnzippedAST
                 | Right Thing     UnzippedAST

type Thing = MVar ThingType
data ThingType = Fork  [Thing]
               | Exec  [Thing] Execution
               | Label [Thing] String