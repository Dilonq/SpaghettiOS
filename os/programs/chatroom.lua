os.pullEvent = os.pullEventRaw
local w,h = term.getSize()
 
local function isInt(n)
    return(type(n) == "number") and (math.floor(n) == n)
end

local function getTarget()
    write("Target ID: ")
    target = tonumber(read())
    if not isInt(target) then target = nil end
end
local function getKey()
    write("Encryption Key: ")
    key = read('*')
end

local function getInput()
    while msg ~= 'quit' do
        msg = read()
        if target ~= nil then
            rednet.send(target, encryptionapi.encrypt(msg,key))
        else
            rednet.broadcast(encryptionapi.encrypt(msg,key))
        end
    end
    os.reboot()
end

local function getMessage()
    while true do
        id, msg = rednet.receive()
        msg = encryptionapi.decrypt(msg,key)
        if target == nil or id == target then print(msg) end
    end
end

local function drawMenu()
    term.clear()
    term.setCursorPos(1,1)
    term.write("SpaghettiOS v"..info.getStrVersion())
    term.setCursorPos(1,2)
    term.write("ID: "..tostring(os.getComputerID()))
end
 
--GUI
term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)

local modemExists, side = osapi.findModem()

local target = -1
local key = ''
local msg = ''

local function main()
    drawMenu()
    term.setCursorPos(1,3)
    if modemExists then
        rednet.open(side)
        print("Modem Found")
        getTarget()
        getKey()
        parallel.waitForAll(getInput, getMessage)
    else
        print("Modem Not Found, Exiting...")
        sleep(1)
        shell.run('/os/programs.lua')
    end
end

main()