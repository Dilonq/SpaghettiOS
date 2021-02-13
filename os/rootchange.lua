os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

local user = '        '
local pass = '        '
local loggedIn = false
 
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
end

local function drawFrontend()
    osapi.printCentered( math.floor(h/2) - 3, "")
    osapi.printCentered( math.floor(h/2) - 2, "Login")
    osapi.printCentered( math.floor(h/2) - 1, "")
    osapi.printCentered( math.floor(h/2) + 0, "Root:         ")
    osapi.printCentered( math.floor(h/2) + 1, "")
end

--Display
drawMenu()
drawFrontend()

term.setCursorPos(math.floor((h/2)) + 17, h-10)
local pass = osapi.readN(8)
fs.delete("os/root.lua")
local hFile = fs.open("os/root.lua", "w")
hFile.write(encryptionapi.hash(pass))
hFile.close()

shell.run("os/accountmanager.lua")