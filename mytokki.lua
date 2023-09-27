-- Syntax Analyzer - Lua
-- Alexis Leon, David Ponce De Leon, Levi Wicks

-- Global declarations
-- Variables
nextToken = ""

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
	['('] = LEFT_PAREN,
	[')'] = RIGHT_PAREN,
	['+'] = ADD_OP,
	['-'] = SUB_OP,
	['*'] = MULT_OP,
	['/'] = DIV_OP,
}


function lex(infile)
	-- attempts to open file, throws error if nil
	local f = assert(io.open(infile, "r"));
	local char = f:read(1);
	-- main logic loop
	while not (char == nil) do
		-- bypass whitespace
		if char == " " then
			repeat 
				char = f:read(1)
			until not (char == " ")
		end 

		local lexeme = "";
		-- if the next character is a letter
		if char:match("%a") then 
			nextToken = IDENT
			repeat 
				lexeme = lexeme .. char;
				char = f:read(1);
				if char == nil then
					break
				end
			until not (char:match("%a") or char:match("%d")) 
		elseif char:match("%d") then
			nextToken = INT_LIT
			repeat
				lexeme = lexeme .. char;
				char = f:read(1);
				if char == nil then
					break
				end
			until not (char:match("%d")) 
		else
			lexeme, nextToken = char, lookupTable[char];
			char = f:read(1);
		end
		print("Next token is: " .. nextToken .. ", Next lexeme is: " .. lexeme);
	end
	print("Next token is: -1, Next lexeme is: EOF");
	f:close();
end 
-- main loop
function main ()
	lex(arg[1]);
end

main();
