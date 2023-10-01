-- Syntax Analyzer - Lua
-- Alexis Leon, David Ponce De Leon, Levi Wicks

-- Global declarations
-- Variables
nextToken = ""

-- Character classes
LETTER = 0 
DIGIT = 1
UNKNOWN = 99

-- used in place of a switch statement
lookupTable = {
	['('] = "LEFT_PAREN",
	[')'] = "RIGHT_PAREN",
	['+'] = "ADD_OP",
	['-'] = "SUB_OP",
	['*'] = "MULT_OP",
	['/'] = "DIV_OP",
	['='] = "ASSIGN_OP",
}

-- @param a single line instruction
-- @returns a lexed version of the instruction 
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
		if char:match("%a") then -- if the next character is a letter
			nextToken = "IDENT"
			repeat -- loop until end of lexeme (when the next char is not a letter or digit)
				lexeme = lexeme .. char;
				char = f:read(1);
				if char == nil then
					break
				end
			until not (char:match("%a") or char:match("%d")) 
		elseif char:match("%d") then -- if the next character is a digit
			nextToken = "INT_LIT";
			repeat -- loop until end of lexeme (when the next character is not a digit)
				lexeme = lexeme .. char;
				char = f:read(1);
				if char == nil then
					break
				end
			until not (char:match("%d")) 
		else -- use the lookup table
			lexeme, nextToken = char, lookupTable[char];
			char = f:read(1);
		end
		print(string.format("Next token is: %11s | Next lexeme is %s", nextToken, lexeme));
	end
	-- end of file
	print(string.format("Next token is: %11s | Next lexeme is %s", "EOF", "EOF"));
	f:close();
end


-- main loop
function main ()
	lex(arg[1]);
end

main();
