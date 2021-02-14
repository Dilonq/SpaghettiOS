os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

term.clear()
term.setCursorPos(1,1)

local numlines = 0

term.write('Document Name: ')
documentname = read()
if pcall(function() fs.open("os/programs/notestxt/"..documentname,"r") end) then
    file = io.open("os/programs/notestxt/"..documentname, "r")
    if file then
        for line in file:lines() do
            print(line)
            numlines = numlines + 1
            if numlines >= 10 then
                term.write('Press Any Key To Continue')
                os.pullEvent("key")
                numlines = 0
            end
        end
    end
    term.write('Finished\nPress Any Key To Continue')
else
    term.write('Error\nPress Any Key To Continue')
end

os.pullEvent("key")
os.run({},"os/programs/notes.lua")