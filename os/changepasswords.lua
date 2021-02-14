os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

term.clear()
term.setCursorPos(1,1)

term.write('Username: ')
usernametoedit = read()
if pcall(function() local x = fs.open("os/users/"..usernametoedit..".lua","r") x.close() end) then
    fs.delete("os/users/"..usernametoedit..".lua")
    local hFile = fs.open("os/users/"..usernametoedit..".lua", "w")
    term.write('Password: ')
    hFile.write(encryptionapi.hash(read()))
    hFile.close()
    term.write('Finished\nPress Any Key To Continue')
else
    term.write('Error\nPress Any Key To Continue')
end

os.pullEvent("key")
os.run({},"os/accountmanager.lua")