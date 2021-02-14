os.pullEvent = os.pullEventRaw
os.loadAPI('os/osapi.lua')
os.loadAPI('os/info.lua')
os.loadAPI("os/encryptionapi.lua")
local w,h = term.getSize()
 
local nOption = 1
 
--GUI
term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)

local function drawMenu()
    term.clear()
    term.setCursorPos(1,1)
    term.write("SpaghettiOS v"..info.getStrVersion())
    term.setCursorPos(1,2)
    term.write("ID: "..tostring(os.getComputerID()))

    term.setCursorPos(w-11,1)
    if nOption == 1 then
        term.write("Login")
    elseif nOption == 2 then
        term.write("Shutdown")
    end
end

local function drawFrontend()
    osapi.printCentered( math.floor(h/2) - 3, "")
    osapi.printCentered( math.floor(h/2) - 2, "Welcome")
    osapi.printCentered( math.floor(h/2) - 1, "")
    osapi.printCentered( math.floor(h/2) + 0, ((nOption == 1) and "[ Login    ]") or "Login   ")
    osapi.printCentered( math.floor(h/2) + 2, ((nOption == 2) and "[ Shutdown ]") or "Shutdown")
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
 
--Conditions
if nOption == 1 then
    os.run({},"os/login.lua")
else
    os.shutdown()
end