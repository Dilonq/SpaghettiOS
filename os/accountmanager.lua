os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

local nOption = 1
 
local function drawMenu()
    term.clear()
    term.setCursorPos(1,1)
    term.write("SpaghettiOS v"..info.getStrVersion())
    term.setCursorPos(1,2)
    term.write("ID: "..tostring(os.getComputerID()))
    
    term.setCursorPos(w-14,1)
    if nOption == 1 then
        term.write("Change Root")
    elseif nOption == 2 then
        term.write("Change Guest")
    elseif nOption == 3 then
        term.write("Back")
    end
end
 
--GUI
term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)

local function drawFrontend()
    osapi.printCentered( math.floor(h/2) - 3, "")
    osapi.printCentered( math.floor(h/2) - 2, "Account Manager" )
    osapi.printCentered( math.floor(h/2) - 1, "")
    osapi.printCentered( math.floor(h/2) + 0, ((nOption == 1) and "[ Change Root   ]") or "Change Root  " )
    osapi.printCentered( math.floor(h/2) + 1, ((nOption == 2) and "[ Change Guest  ]") or "Change Guest " )
    osapi.printCentered( math.floor(h/2) + 2, ((nOption == 3) and "[ Back          ]") or "Back         " )
    osapi.printCentered( math.floor(h/2) + 3, "")
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
            if nOption < 3 then
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

--Conditions
if nOption == 1 then
    shell.run("os/rootchange.lua")
elseif nOption == 2 then
    shell.run("os/guestchange.lua")
elseif nOption == 3 then
    shell.run("os/main.lua")
else
    shell.run("os/accountmanager.lua")
end