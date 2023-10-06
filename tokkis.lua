-- Syntax Analyzer Full Implementation - Lua
-- Alexis Leon, David Ponce De Leon, Levi Wicks

-- Global declarations
-- Variables
nextToken = ""
f = assert(io.open(arg[1], "r")); -- attempts to open file, throws error if nil

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

function lex()
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
        print(string.format("%s [ %s ]", nextToken, lexeme));
end

function expr()
        print("Enter <expr>")
        term()

        while nextToken == ADD_OP or nextToken == SUB_OP do
                lex()
                term()
        end
end

function term()
        print("Enter <term>")
        factor()
        while nextToken == MULT_OP or nextToken == DIV_OP do
                lex()
                factor()
        end
end

function factor()
        print("Enter <factor>")
        if nextToken == IDENT or nextToken == INT_LIT then
                lex()
        else
                if nextToken == LEFT_PAREN then
                        lex()
                        expr()
                        if nextToken ==  RIGHT_PAREN then
                                lex()
                        else
                                print("error")
                        end
                else
                        print("error")
                end
        end

        print("Exit <factor>")

end



-- main loop
function main ()
        char = f:read(1);
        lex();
        expr();
end

main();
f:close();