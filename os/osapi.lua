os.pullEvent = os.pullEventRaw

w,h = term.getSize()

function tableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function printCentered( y,s )
    local x = math.floor((w - string.len(s)) / 2)
    term.setCursorPos(x,y)
    term.clearLine()
    term.write( s )
end

function findModem()
    for _, v in pairs( rs.getSides() ) do
        if peripheral.isPresent( v ) and peripheral.getType( v ) == "modem" then
            return true, v
        end
    end
    return false, nil
end

function checkCreds(table, user,pass)
    for i=1,tableLength(table) do
        if table[i][1] == user and table[i][2] == pass then
            return true
        end
    end
    return false
end

function centerText(text)
    local x2,y2 = term.getCursorPos()
    term.setCursorPos(math.floor((w / 2) - (text:len() / 2) + 0.5), y2)
    write(text)
end

function readN(len, replaceChar)
    len = len or 10
    local input=""
    local key = 0
    term.setCursorBlink(true)
    local e,p1 = os.pullEvent()
    while p1 == os.pullEvent() do e,p1 = os.pullEvent() sleep(0.05) end
    repeat
        e,p1 = os.pullEvent()
        if e=="char" then
            if #input < len then
                input = input .. p1
                term.write(replaceChar or p1)
            end
        elseif e=="key" and p1==keys.backspace and #input > 0 then
            input = input:sub(1,#input-1)
        local x,y = term.getCursorPos()
        term.setCursorPos(x-1,y)
        term.write(" ")
        term.setCursorPos(x-1,y)
        end
    until p1==keys.enter
    term.setCursorBlink(false)
    return input
end