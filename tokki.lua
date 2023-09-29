-- Syntax Analyzer - Lua
-- Alexis Leon, David Ponce De Leon, Levi Wicks

-- Global declarations
-- Variables




-- Character classes
LETTER = 0 
DIGIT = 1
UNKNOWN = 99

-- Token codes
INT_LIT = 10
IDENT = 11
ASSIGN_OP = 20
ADD_OP = 21
SUB_OP = 22
MULT_OP = 23
DIV_OP = 24
LEFT_PAREN = 25
RIGHT_PAREN = 26

-- used in place of a switch statement
lookupTable = {
	'(' = LEFT_PAREN,
	')' = RIGHT_PAREN,
	'+' = ADD_OP,
	'-' = SUB_OP,
	'*' = MULT_OP,
	'/' = DIV_OP,
}

function addChar(lexeme, lexLen, nextChar)
	if lexLen <= 98
		lexeme[lexLen + 1] = nextChar
		lexLen = lexLen + 1
		lexeme[lexLen + 1] = '\0'
	else
		print("Error - Lexeme is too long")
	end

function getChar()
	local nextChar = io.read(1)
	if nextChar == nil then
		charClass = EOF
	elseif string.match(nextChar, "%a") then
		charClass = LETTER
	elseif string.match(nextChar, "%d") then
		charClass = DIGIT
	else
		charClass = UNKNOWN
	end
end
