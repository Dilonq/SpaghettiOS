os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

term.clear()
term.setCursorPos(1,1)

pcall(function() for _, filex in ipairs(fs.list("os/programs/notestxt/")) do
    print(filex)
end end)

term.write('Finished\nPress Any Key To Continue')
os.pullEvent("key")
shell.run("os/programs/notes.lua")