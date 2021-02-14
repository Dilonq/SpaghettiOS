os.pullEvent = os.pullEventRaw
 
local w,h = term.getSize()
 
function printCentered( y,s )
   local x = math.floor((w - string.len(s)) / 2)
   term.setCursorPos(x,y)
   term.clearLine()
   term.write( s )
end
 
local nOption = 1
 
local function drawMenu()
    term.clear()
    term.setCursorPos(1,1)
    term.write("SpaghettiOS v"..info.getStrVersion())
    term.setCursorPos(1,2)
    term.write("ID: "..tostring(os.getComputerID()))
    
    term.setCursorPos(w-11,1)
    if nOption == 1 then
        term.write("Back")
    elseif nOption == 2 then
        term.write("Game")
    end
end
 
--GUI
term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)

local function drawFrontend()
    printCentered( math.floor(h/2) - 3, "")
    printCentered( math.floor(h/2) - 2, "Games" )
    printCentered( math.floor(h/2) - 1, "")
    printCentered( math.floor(h/2) + 0, ((nOption == 1) and "[ Back  ]") or " Back  " )
    printCentered( math.floor(h/2) + 1, ((nOption == 2) and "[ Game  ]") or " Game  " )
    printCentered( math.floor(h/2) + 2, "")
end

--Display
drawMenu()
drawFrontend()
 
while true do
    local e,p = os.pullEvent()
    if e == "key" then
        local key = p
        if key == 17 or key == 200 then
            if nOption > 1 then
                nOption = nOption - 1
                drawMenu()
                drawFrontend()
            end
        elseif key == 31 or key == 208 then
            if nOption < 2 then
                nOption = nOption + 1
                drawMenu()
                drawFrontend()
            end
        elseif key == 28 then
            break
        end
    end
end
term.clear()

local hFile = fs.open("os/.user.lua", "r")
local user = hFile.readLine()
hFile.close()

--Conditions
if nOption  == 1 then
    shell.run("os/programs.lua")
elseif nOption == 2 then
    shell.run("os/games/game.lua")
else
    shell.run("os/games.lua")
end