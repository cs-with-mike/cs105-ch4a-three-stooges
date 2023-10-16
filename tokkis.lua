-- Syntax Analyzer Full Implementation - Lua
-- Alexis Leon, David Ponce De Leon, Levi Wicks

-- Global declarations
-- Variables
nextToken = ""
ff = arg[1]
running = true
parseCount = 0

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
        local str = ""
        for i = 1, depth do
                str = str .. "="
        end
        if nextToken ~= "EOF" then
                print(str .. " " .. nextToken .. " [ " .. lexeme .. " ]")
        elseif nextToken == "EOF" then
                print(str .. " " .. nextToken .. " [ " .. "EOF" .. " ]")
        else
                return
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
            parseCount = parseCount + 1
            lex(depth)
            term(depth + 1)
        end
        
        if running == false then
            return  -- Exit the function if 'running' is false
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
            parseCount = parseCount + 1
            lex(depth)
            factor(depth + 1)
        end

        if running == false then
            return  -- Exit the function if 'running' is false
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
            parseCount = parseCount + 1
            lex(depth)
        else
            if nextToken == "LEFT_PAREN" then
                parseCount = parseCount + 1
                lex(depth)
                expr(depth + 1)
                if nextToken == "RIGHT_PAREN" then
                    parseCount = parseCount + 1
                    lex(depth)
                elseif running == false then
                    return
                else
		            print("Error - invalid tokki syntax at: " .. parseCount)
                    running = false
                    return
                end
            elseif running == false then
                return
            else
                print("Error - invalid tokki syntax at:")
		        running = false
                return
            end
        end
        str = ""
        for i = 1, depth do
                str = str .. "<"
        end
        print(str .. " factor")
    end
    


-- main loop
function main()
    char = f:read(1)
    lex(0)
    expr(1)
end

if ff then
    f = io.open(ff, "r")
    if f then
        main()
        f:close()
    else
        print("Error")
        f:close()
    end
else
    print("Error")
    f:close()
end