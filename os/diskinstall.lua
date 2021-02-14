os.pullEvent = os.pullEventRaw
local w,h = term.getSize()
os.loadAPI("disk/os/osapi.lua")
os.loadAPI("disk/os/info.lua")

local nOption = 1

local function install()
    for _,file in ipairs(fs.list("/")) do
        if not fs.isReadOnly(file) then
            pcall(function() fs.delete(file) end)
        end
    end
    fs.makeDir("os/")
    for _, file in ipairs(fs.list("disk/os/")) do
        fs.copy("disk/os/"..file, "os/"..file)
    end
    fs.delete("os/diskinstall.lua")
    fs.copy("disk/startup.lua", "os/diskinstall.lua")
    fs.copy("disk/comstartup.lua", "startup.lua")
end

local function drawMenu()
    term.clear()
    term.setCursorPos(1,1)
    term.write("SpaghettiOS v"..info.getStrVersion())
    term.setCursorPos(1,2)
    term.write("ID: "..tostring(os.getComputerID()))

    term.setCursorPos(w-11,1)
    if nOption == 1 then
        term.write("Install")
    elseif nOption == 2 then
        term.write("Exit")
    end
end

local function drawFrontend()
    osapi.printCentered( math.floor(h/2) - 3, "")
    osapi.printCentered( math.floor(h/2) - 2, "Install Menu" )
    osapi.printCentered( math.floor(h/2) - 1, "")
    osapi.printCentered( math.floor(h/2) + 0, ((nOption == 1) and "[ Install  ]") or "Install " )
    osapi.printCentered( math.floor(h/2) + 1, ((nOption == 2) and "[ Exit     ]") or "Exit    " )
    osapi.printCentered( math.floor(h/2) + 4, "")
end

term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)
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
    install()
    drawMenu()
    osapi.printCentered( math.floor(h/2) - 2, "Installation Finished" )
    osapi.printCentered( math.floor(h/2) - 1, "")
    osapi.printCentered( math.floor(h/2) + 0, "Remove Disk And Reboot" )
else
    os.shutdown()
end

os.pullEvent("key")
term.setBackgroundColor(colors.black)
term.setCursorPos(1,1)
term.setTextColor(colors.white)
term.clear()