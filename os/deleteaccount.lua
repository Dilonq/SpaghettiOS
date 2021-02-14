os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

term.clear()
term.setCursorPos(1,1)

term.write('Username: ')
usernametoedit = read()
if pcall(function() fs.delete("os/users/"..usernametoedit..".lua") end) then
    term.write('Finished\nPress Any Key To Continue')
else
    term.write('Error\nPress Any Key To Continue')
end

os.pullEvent("key")
shell.run("os/accountmanager.lua")