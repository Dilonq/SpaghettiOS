os.pullEvent = os.pullEventRaw
local w,h = term.getSize()
 
local nOption = 1
 
local function drawMenu()
    term.clear()
    term.setCursorPos(1,1)
    term.write("SpaghettiOS v"..info.getStrVersion())
    term.setCursorPos(1,2)
    term.write("ID: "..tostring(os.getComputerID()))
    
    term.setCursorPos(w-11,1)
    if nOption == 1 then
        term.write("Command")
    elseif nOption == 2 then
        term.write("Programs")
    elseif nOption == 3 then
        term.write("Accounts")
    elseif nOption == 4 then
        term.write("Shutdown")
    end
end
 
--GUI
term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)

local function drawFrontend()
    osapi.printCentered( math.floor(h/2) - 3, "")
    osapi.printCentered( math.floor(h/2) - 2, "Start Menu" )
    osapi.printCentered( math.floor(h/2) - 1, "")
    osapi.printCentered( math.floor(h/2) + 0, ((nOption == 1) and "[ Command  ]") or "Command " )
    osapi.printCentered( math.floor(h/2) + 1, ((nOption == 2) and "[ Programs ]") or "Programs" )
    osapi.printCentered( math.floor(h/2) + 2, ((nOption == 3) and "[ Accounts ]") or "Accounts" )
    osapi.printCentered( math.floor(h/2) + 3, ((nOption == 4) and "[ Shutdown ]") or "Shutdown" )
    osapi.printCentered( math.floor(h/2) + 4, "")
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
            if nOption < 4 then
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
    shell.run("os/command.lua")
elseif nOption == 2 then
    shell.run("os/programs.lua")
elseif nOption == 3 and user == 'root' then
    shell.run("os/accountmanager.lua")
elseif nOption == 4 then
    os.shutdown()
else
    shell.run("os/main.lua")
end