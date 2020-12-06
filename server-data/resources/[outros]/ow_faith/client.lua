local Keys = {
    ["A"] = 0x7065027D, ["B"] = 0x4CC0E2FE, ["C"] = 0x9959A6F0, ["D"] = 0xB4E465B4, ["E"] = 0xCEFD9220, ["F"] = 0xB2F377E8,
    ["G"] = 0x760A9C6F, ["H"] = 0x24978A28, ["I"] = 0xC1989F95, ["J"] = 0xF3830D8E, ["K"] = "s", ["L"] = 0x80F28E95,
    ["M"] = 0xE31C6A41, ["N"] = 0x4BC9DABB , ["O"] = 0xF1301666, ["P"] = 0xD82E0BD2, ["Q"] = 0xDE794E3E,
    ["R"] = 0xE30CD707, ["S"] = 0xD27782E3, ["T"] ="s" , ["U"] = 0xD8F73058, ["V"] = 0x7F8D09B8, ["W"] = 0x8FD015D8,
    ["X"] = 0x8CC9CD42, ["Y"] ="s" , ["Z"] = 0x26E9DC00
}

  local ragdoled = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)

        if IsControlPressed(0, Keys["Z"]) then
            ragdoled = true
            if  Citizen.InvokeNative("0xAE99FB955581844A",PlayerPedId(-1), 1000, 1000, 0, 0, 0, 0) then
                ragdoled = false
                end
            end

        if ragdoled == true then
             Citizen.InvokeNative("0xAE99FB955581844A",PlayerPedId(-1), 1000, 1000, 0, 0, 0, 0)
            if IsControlJustPressed(0, Keys['X']) then
                ragdoled = false
            end
        end
    end
end)