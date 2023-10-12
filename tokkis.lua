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

function lex(depth)
        -- bypass whitespace
        if char == " " then
            repeat
                char = f:read(1)
            until not (char == " ")
        end
    
        local lexeme = ""
    
        if char == nil then
            nextToken = "EOF"
        elseif char:match("%a") then -- if the next character is a letter
            nextToken = "IDENT"
            repeat -- loop until the end of the lexeme (when the next char is not a letter or digit)
                lexeme = lexeme .. char
                char = f:read(1)
                if char == nil then
                    break
                end
            until not (char:match("%a") or char:match("%d"))
        elseif char:match("%d") then -- if the next character is a digit
            nextToken = "INT_LIT"
            repeat -- loop until the end of the lexeme (when the next character is not a digit)
                lexeme = lexeme .. char
                char = f:read(1)
                if char == nil then
                    break
                end
            until not (char:match("%d"))
        else -- use the lookup table
            nextToken = lookupTable[char]
            lexeme = char
            char = f:read(1)
        end
    
        if nextToken ~= "EOF" then
                local str = ""
                for i = 1, depth do
                        str = str .. "="
                end
                print(str .. " " .. nextToken .. " [ " .. lexeme .. " ]")
        else
                local str = ""
                for i = 1, depth do
                        str = str .. "="
                end
                nextToken = "EOF"
                print(str .. " " .. nextToken .. " [ " .. nextToken .. " ]")
        end
    end

function expr(depth)
        local str = ""
        for i = 1, depth do
                str = str .. ">"
        end
        print(str .. " expr")
        term(depth + 1)
    
        while nextToken == "ADD_OP" or nextToken == "SUB_OP" do
            lex(depth)
            term(depth + 1)
        end
        
        str = ""
        for i = 1, depth do
                str = str .. "<"
        end
        print(str .. " expr")
    end
    
function term(depth)
        local str = ""
        for i = 1, depth do
                str = str .. ">"
        end
        print(str .. " term")
        factor(depth + 1)
        while nextToken == "MULT_OP" or nextToken == "DIV_OP" do
            lex(depth)
            factor(depth + 1)
        end

        local str = ""
        for i = 1, depth do
                str = str .. "<"
        end
        print(str .. " term")
    end
    
function factor(depth)
        local str = ""
        for i = 1, depth do
                str = str .. ">"
        end
        print(str .. " factor")
        if nextToken == "IDENT" or nextToken == "INT_LIT" then
            lex(depth)
        else
            if nextToken == "LEFT_PAREN" then
                lex(depth)
                expr(depth + 1)
                if nextToken == "RIGHT_PAREN" then
                    lex(depth)
                else
                    print("| Error - invalid tokki syntax at: ")
                    return
                end
            else
                print("Error")
            end
        end
        str = ""
        for i = 1, depth do
                str = str .. "<"
        end
        print(str .. " factor")
    end
    


-- main loop
function main ()
        char = f:read(1)
        lex(0)
        expr(1)
        
end

main()
f:close()