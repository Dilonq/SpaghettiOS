os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

term.clear()
term.setCursorPos(1,1)

local numlines = 0

term.write('Document Name: ')
documentname = read()
if pcall(function() fs.open("os/programs/notestxt/"..documentname,"w") end) then
    local x = fs.open("os/programs/notestxt/"..documentname,"a")
    while true do
        local y = read()
        if y == '' then break end
        numlines = numlines + 1
        x.write(y..'\n')
    end
    x.close()
    if numlines <= 1 then fs.delete("os/programs/notestxt/"..documentname) end
    term.write('Finished\nPress Any Key To Continue')
else
    term.write('Error\nPress Any Key To Continue')
end

os.pullEvent("key")
os.run({},"os/programs/notes.lua")