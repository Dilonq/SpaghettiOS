os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

term.clear()
term.setCursorPos(1,1)

print('SpaghettiOS v'..info.getStrVersion()..' Lua Shell')
print('Type "quit" to exit the shell')

while true do
    local cmd = read()
    if cmd == 'quit' then
        break
    else
        pcall(function() load(cmd)() end)
    end
end

os.run({},"os/main.lua")