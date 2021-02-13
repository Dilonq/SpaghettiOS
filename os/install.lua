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
        term.write("Install On Disk")
    elseif nOption == 2 then
        term.write("Back")
    end
end

local function diskinstall()
    term.clear()
    drawMenu()
    osapi.printCentered(math.floor(h/2) - 2, "Insert Disk")
    local _, side = os.pullEvent("disk")
    if fs.exists("disk/") then
        for _, file in pairs(fs.list("disk")) do
            fs.delete("disk/"..file)
        end
        for _, file in ipairs(fs.list("os/")) do
            fs.copy("os/"..file, "disk/os/"..file)
        end
        local hFile = fs.open("disk/os/.user.lua", "w")
        hFile.close()
        fs.delete("disk/os/root.lua")
        local hFile = fs.open("disk/os/root.lua", "w")
        hFile.write('vzMfrxL6+Ujty|N7[>^?_@0($')
        hFile.close()
        fs.delete("disk/os/guest.lua")
        local hFile = fs.open("disk/os/guest.lua", "w")
        hFile.write('^nvK6+U;.Vjty|N7[>^?_@0($')
        hFile.close()
        local hFile = fs.open("os/.user.lua", "w")
        hFile.close()
        fs.copy("startup.lua", "disk/comstartup.lua")
        fs.copy("os/diskinstall.lua", "disk/startup.lua")
        disk.setLabel(side, "SpaghettiOS v"..info.getStrVersion().." Boot Disk")
    end
end
 
--GUI
term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)

local function drawFrontend()
    osapi.printCentered( math.floor(h/2) - 3, "")
    osapi.printCentered( math.floor(h/2) - 2, "Install Menu" )
    osapi.printCentered( math.floor(h/2) - 1, "")
    osapi.printCentered( math.floor(h/2) + 0, ((nOption == 1) and "[ Install On Disk  ]") or "Install On Disk " )
    osapi.printCentered( math.floor(h/2) + 1, ((nOption == 2) and "[ Back             ]") or "Back            " )
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

--Conditions
if nOption == 1 then
    diskinstall()
    shell.run("os/install.lua")
elseif nOption == 2 then
    shell.run("os/programs.lua")
else
    shell.run("os/install.lua")
end