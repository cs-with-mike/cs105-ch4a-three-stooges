-- Syntax Analyzer - Lua
-- Alexis Leon, David Ponce De Leon, Levi Wicks

-- Global declarations
-- Variables
nextToken = nil



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

-- in place of EOF character

-- used in place of a switch statement
lookupTable = {
	'(' = LEFT_PAREN,
	')' = RIGHT_PAREN,
	'+' = ADD_OP,
	'-' = SUB_OP,
	'*' = MULT_OP,
	'/' = DIV_OP,
}

function lookup(char)
	nextToken = lookupTable[char]

