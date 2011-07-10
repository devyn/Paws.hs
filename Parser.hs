module Parser where
import AST
import Text.Parsec
import Text.Parsec.String
import Control.Applicative hiding ((<|>), many)

parser :: String -> Either ParseError AST
parser = parse (spaces *> expr <* eof) ""

expr, chain, term, paren, block, symbol :: Parser AST
expr   = chain <|> term
chain  = foldl Juxtapose Self <$> many term
term   = paren <|> block <|> symbol
paren  = Juxtapose Self <$> (lexeme (char '(') *> expr <* lexeme (char ')'))
block  = Block <$> (lexeme (char '{') *> expr <* lexeme (char '}'))
symbol = Symbol <$> lexeme (many1 (noneOf "\"") <|> char '"' *> many1 (noneOf "\"") <* char '"')

lexeme :: Parser a -> Parser a
lexeme p = p <* spaces