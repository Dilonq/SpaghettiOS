os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

term.clear()
term.setCursorPos(1,1)

local numlines = 0

term.write('File Path: ')
torun = read()

if pcall(function() os.run(torun) end) then term.write('Finished\nPress Any Key To Continue') else term.write('Error\nPress Any Key To Continue') end

os.pullEvent("key")
os.run({},"os/programs.lua")