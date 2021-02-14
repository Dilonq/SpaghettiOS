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
    osapi.printCentered( math.floor(h/2) + 0, "Username:         ")
    osapi.printCentered( math.floor(h/2) + 1, "")
    osapi.printCentered( math.floor(h/2) + 2, "Password:         ")
    osapi.printCentered( math.floor(h/2) + 3, "")
end

-- for index, data in ipairs(accounts) do
--     print(index)

--     for key, value in pairs(data) do
--         print('\t', key, value)
--     end
-- end

accounts = {}

for _, file in ipairs(fs.list("os/users/")) do
    local hFile = fs.open("os/users/"..file, "r")
    local p = hFile.readLine()
    hFile.close()
    for i=1,4 do file = file:sub(1, -2) end
    table.insert(accounts,{file,p})
end

--Display
drawMenu()
drawFrontend()

while not loggedIn do
    term.setCursorPos(math.floor((h/2)) + 17, h-10)
    local user = osapi.readN(8)
    term.setCursorPos(math.floor((h/2)) + 17, h-8)
    local pass = osapi.readN(8, '*')
    if osapi.checkCreds(accounts, user, encryptionapi.hash(pass)) then
        loggedIn = true
        term.setTextColor(colors.green)
        osapi.printCentered(math.floor((h/2)) + 5, "Credentials Accepted")
        term.setTextColor(colors.white)
        drawFrontend()
        fs.delete("os/.user.lua")
        local hFile = fs.open("os/.user.lua", "w")
        hFile.write(user)
        hFile.close()
    else
        term.setTextColor(colors.red)
        osapi.printCentered(math.floor((h/2)) + 5, "Invalid Credentials")
        term.setTextColor(colors.white)
        drawFrontend()
    end
    sleep(1)
end

shell.run("os/main.lua")