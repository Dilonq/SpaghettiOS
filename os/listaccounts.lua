os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

term.clear()
term.setCursorPos(1,1)

for _, file in ipairs(fs.list("os/users/")) do
    local hFile = fs.open("os/users/"..file, "r")
    local p = hFile.readLine()
    hFile.close()
    for i=1,4 do file = file:sub(1, -2) end
    print(file.." > "..p)
end

os.pullEvent("key")
shell.run("os/accountmanager.lua")