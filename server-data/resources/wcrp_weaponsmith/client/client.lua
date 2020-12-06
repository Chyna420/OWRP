local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }


--menu

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, 2789.64, -1265.07, 49.79) < 2.0) then  --YOUR CHORDS FOR MENU HERE
            DrawTxt("[~e~G~q~] Craft", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then -- g
                TriggerEvent("weaponsmith:open")
                print('openedwarmenu')

            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, 1329.3005, -1321.2024, 78.0859) < 2.0) then
            DrawTxt("[~e~G~q~] Craft", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then -- g
                TriggerEvent("weaponsmith:open")
                print('openedwarmenu')

            end
        end
    end
end)



Citizen.CreateThread(function()
	local sexe =  IsPedMale(PlayerPedId())
    local checkbox2 = false
    WarMenu.CreateMenu('menu', "WeaponSmith")
    WarMenu.SetSubTitle('menu', 'Craft Weapons')
	
    WarMenu.CreateSubMenu('hgmake', 'menu', 'Armas')
	WarMenu.CreateSubMenu('hgmake2', 'menu', 'Outros')
	WarMenu.CreateSubMenu('hgmake3', 'menu', 'Outros')


    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
		local sexe =  IsPedMale(PlayerPedId())
		
        if WarMenu.IsMenuOpened('menu') then
		
		if WarMenu.MenuButton('Armas', 'hgmake') then
            end
		if WarMenu.MenuButton('Outros', 'hgmake2') then
            end	
		if WarMenu.MenuButton('Outros', 'hgmake3') then
            end	

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('hgmake') then

            if WarMenu.Button('Make Cattleman Revolver') then
		
		TriggerServerEvent("wc_cattlemanmake")
			
		elseif WarMenu.Button('Make Double Action Revolver') then
		
		TriggerServerEvent("wc_doublemake")

            end

            WarMenu.Display()
			
		elseif WarMenu.IsMenuOpened('hgmake2') then
		if WarMenu.Button('Make Melee') then
		TriggerEvent("wc_")
		
		elseif WarMenu.Button('Make') then
		TriggerEvent("wc_")
		
		elseif WarMenu.Button('Make') then 
		TriggerEvent("wc_")
		

	
       
            end

            WarMenu.Display()
			
			elseif WarMenu.IsMenuOpened('hgmake3') then
		if WarMenu.Button('Rifles') then
        TriggerEvent("wc_")
        
        elseif WarMenu.Button('Make') then
        TriggerEvent("wc_")

        elseif WarMenu.Button('Make') then
        TriggerEvent("wc_")

        elseif WarMenu.Button('Make') then
        TriggerEvent("wc_")

        elseif WarMenu.Button('Make') then
        TriggerEvent("wc_")


			end

            WarMenu.Display()

       -- elseif whenKeyJustPressed(keys["J"]) then 
         --   WarMenu.OpenMenu('menu')
        end
		
	
        Citizen.Wait(0)
    end
end)

--RegisterCommand("opentestmenu", function(source, args, rawCommand) -- slash COMMAND
AddEventHandler('weaponsmith:open', function()
    local _source = source
            if weapsmith ~= 0 then
                SetEntityAsMissionEntity(weapsmith)
                DeleteObject(weapsmith)
                weapsmith = 0
                end
                local playerPed = PlayerPedId()
                Citizen.Wait(0)
                ClearPedTasksImmediately(PlayerPedId())
                WarMenu.OpenMenu('menu')
                TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_HAMMER_TABLE'), -1, true, false, false, false)
           
                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
                --local prop = CreateObject(GetHashKey("p_cs_note01x"), x, y, z, true, false, true)
                SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
                PlaceObjectOnGroundProperly(prop)
                weapsmith = prop
    
    --end, false)
end)

Citizen.CreateThread(function()
    while true do
	local playerPed = PlayerPedId()
        Citizen.Wait(0)
		
        if whenKeyJustPressed(keys['BACKSPACE']) then
            if weapsmith ~= 0 then
            SetEntityAsMissionEntity(weapsmith)
            DeleteObject(weapsmith)
			ClearPedTasksImmediately(PlayerPedId())
            weapsmith = 0
            end
     end
	end
end)


--- Settings ProgressBars ---

--- Flesh --- 

RegisterNetEvent('progressbar:start')
AddEventHandler('progressbar:start', function()

    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 27000, true, false, false, false)
    exports['progressBars']:startUI(20000, "Crafting...")
    Citizen.Wait(20000)
    ClearPedTasksImmediately(PlayerPedId())

end)


function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

--[[RegisterNetEvent("crafting:time")
AddEventHandler("crafting:time", function()

    local playerPed = PlayerPedId()
    exports['progressBars']:startUI(27000, "Crafting...")


end)--]]

RegisterNetEvent("wc_craftitem:prompt")
AddEventHandler("wc_craftitem:prompt", function(msg)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
   SetTextScale(w, h)
   SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
   SetTextCentre(centre)
   if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
   Citizen.InvokeNative(0xADA9255D, 10);
   DisplayText(str, x, y)
end


