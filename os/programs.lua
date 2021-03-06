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
        term.write("Menu")
    elseif nOption == 2 then
        term.write("Chatroom")
    elseif nOption == 3 then
        term.write("Notes")
    elseif nOption == 4 then
        term.write("Games")
    elseif nOption == 5 then
        term.write("Run")
    elseif nOption == 6 then
        term.write("Install")
    elseif nOption == 7 then
        term.write("Uninstall")
    end
end
 
--GUI
term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)

local function drawFrontend()
    printCentered( math.floor(h/2) - 3, "")
    printCentered( math.floor(h/2) - 2, "Programs" )
    printCentered( math.floor(h/2) - 1, "")
    printCentered( math.floor(h/2) + 0, ((nOption == 1) and "[ Menu     ]") or "Menu     " )
    printCentered( math.floor(h/2) + 1, ((nOption == 2) and "[ Chatroom ]") or "Chatroom " )
    printCentered( math.floor(h/2) + 2, ((nOption == 3) and "[ Notes    ]") or "Notes    " )
    printCentered( math.floor(h/2) + 3, ((nOption == 4) and "[ Games    ]") or "Games    " )
    printCentered( math.floor(h/2) + 4, ((nOption == 5) and "[ Run      ]") or "Run      " )
    printCentered( math.floor(h/2) + 5, ((nOption == 6) and "[ Install  ]") or "Install  " )
    printCentered( math.floor(h/2) + 6, ((nOption == 7) and "[ Uninstall]") or "Uninstall" )
    printCentered( math.floor(h/2) + 7, "")
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
            if nOption < 7 then
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
    os.run({},"os/main.lua")
elseif nOption == 2 then
    os.run({},"os/programs/chatroom.lua")
elseif nOption == 3 then
    os.run({},"os/programs/notes.lua")
elseif nOption == 4 then
    os.run({},"os/games.lua")
elseif nOption == 5 then
    os.run({},"os/programs/run.lua")
elseif nOption == 6 then
    os.run({},"os/install.lua")
elseif nOption == 7 and user == 'root' then
    os.run({},"os/uninstall.lua")
else
    os.run({},"os/programs.lua")
end