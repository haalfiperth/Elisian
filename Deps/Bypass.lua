local OriginalNameCall; OriginalNameCall = hookmetamethod(Game, "__namecall", function(Object, ...)
        local Arguments = {...}
        local NameCallMethod = getnamecallmethod()
        local CallingFromExecutor = checkcaller()
        
        if not CallingFromExecutor and NameCallMethod == "FireServer" and #Arguments > 0 and Arguments[1] == "IS_MOBILE" then
            return
        end
        
        return OriginalNameCall(Object, ...)
    end)
    
    local OriginalGetFenv; OriginalGetFenv = hookfunction(getrenv().getfenv, newcclosure(function(Level)
        if not checkcaller() then
            task.wait(15e15)
            return {sigma = function() return 0 end, balls = 1, tablehooked = {}}
        end
        return OriginalGetFenv(Level)
    end))
