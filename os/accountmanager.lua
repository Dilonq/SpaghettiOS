os.pullEvent = os.pullEventRaw
local w,h = term.getSize()

local nOption = 1
 
local function drawMenu()
    term.clear()
    term.setCursorPos(1,1)
    term.write("SpaghettiOS v"..info.getStrVersion())
    term.setCursorPos(1,2)
    term.write("ID: "..tostring(os.getComputerID()))
    
    term.setCursorPos(w-14,1)
    if nOption == 1 then
        term.write("List Accounts")
    elseif nOption == 2 then
        term.write("Change Password")
    elseif nOption == 3 then
        term.write("Create Account")
    elseif nOption == 4 then
        term.write("Delete Account")
    elseif nOption == 5 then
        term.write("Back")
    end
end
 
--GUI
term.clear()
term.setTextColor(colors.white)
term.setBackgroundColor(colors.blue)

local function drawFrontend()
    osapi.printCentered( math.floor(h/2) - 3, "")
    osapi.printCentered( math.floor(h/2) - 2, "Account Manager" )
    osapi.printCentered( math.floor(h/2) - 1, "")
    osapi.printCentered( math.floor(h/2) + 0, ((nOption == 1) and "[ List Accounts    ]") or "List Accounts   " )
    osapi.printCentered( math.floor(h/2) + 1, ((nOption == 2) and "[ Change Password  ]") or "Change Password " )
    osapi.printCentered( math.floor(h/2) + 2, ((nOption == 3) and "[ Create Account   ]") or "Create Account  " )
    osapi.printCentered( math.floor(h/2) + 3, ((nOption == 4) and "[ Delete Account   ]") or "Delete Account  " )
    osapi.printCentered( math.floor(h/2) + 4, ((nOption == 5) and "[ Back             ]") or "Back            " )
    osapi.printCentered( math.floor(h/2) + 5, "")
end

--Display
drawMenu()
drawFrontend()
 
while true do
    local e,p = os.pullEvent()
    if e == "key" then
        local key = p
        if key == 17 or key == 200 then
            if nOption > 1 then
                nOption = nOption - 1
                drawMenu()
                drawFrontend()
            end
        elseif key == 31 or key == 208 then
            if nOption < 5 then
                nOption = nOption + 1
                drawMenu()
                drawFrontend()
            end
        elseif key == 28 then
            break
        end
    end
end
term.clear()

--Conditions
if nOption == 1 then
    shell.run("os/listaccounts.lua")
elseif nOption == 2 then
    shell.run("os/changepasswords.lua")
elseif nOption == 3 then
    shell.run("os/createaccount.lua")
elseif nOption == 4 then
    shell.run("os/deleteaccount.lua")
elseif nOption == 5 then
    shell.run("os/main.lua")
else
    shell.run("os/accountmanager.lua")
end