Citizen.CreateThread(function()
    Wait(1000)
    Citizen.InvokeNative(0xF6BEE7E80EC5CA40, -1)
    end)
    
    Citizen.CreateThread(function()
        Wait(1000)
        Citizen.InvokeNative(0xF02A9C330BBFC5C7, 2)
    end)