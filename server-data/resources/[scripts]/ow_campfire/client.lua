-- Made by Blue & Dungeon for Syn County RP
-- credits to malik & the creator of kcrp_boats_vorp
local iscrafting = false
local crafting = {

    --Food
	[1] = {
		['Text'] = "Ensopado de carne  (1 Meat, 3 Oregano)", -- name of item to craft on list
		['SubText'] = "",
		['Desc'] = "1 Meat, 3 Oregano",
		['Param'] = {
            ['Item'] = "meat", -- this always needs to be filled. crafting will always look for the first item.
            ['Item2'] = "consumable_herb_oregano", -- this can be left empty if you do not want to use a 2nd item
            ['Item3'] = "", -- this can be left empty if you do not want to use a 3nd item
            ['Count'] = 1, -- this needs to always be more than 1. it will determine how much to check for to allow crafting and how much of item 1 to remove
            ['Count2'] = 3, -- this has to be set to 0 if you do not want to use an item 2
            ['Count3'] = 0, -- this has to be set to 0 if you do not want to use an item 3
            ['Reward'] = "consumable_meat_greavy", -- result item 
            ['RewardCount'] = 1, -- how much of the result item do you want
		}
    }
    --Items


    --Weapons
}
keys = {
    -- Letter E
    ["G"] = 0x760A9C6F,
}

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

local keyopen = false

Citizen.CreateThread(function()
    WarMenu.CreateMenu('Craft', "Craft")
    WarMenu.SetSubTitle('Craft', 'Time to craft' )

    local _source = source
    while true do

        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('Craft') then
            if WarMenu.MenuButton('lets craft', "Craft") then
                OpenCraftMenu()
			end
            WarMenu.Display()
        end
        Citizen.Wait(0)
    end
end)

function OpenCraftMenu()
	WarMenu.OpenMenu('craftmenu')
end

Citizen.CreateThread( function()
	WarMenu.CreateMenu('craftmenu', 'craft menu')
	repeat
		if WarMenu.IsMenuOpened('craftmenu') then
			for i = 1, #crafting do
				if WarMenu.Button(crafting[i]['Text'], crafting[i]['SubText'], crafting[i]['Desc']) then
					TriggerServerEvent('syn:craftingalg', crafting[i]['Param'])
					WarMenu.CloseMenu()
				end
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	until false
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextFontForCurrentCommand(15) 
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local player = PlayerPedId()
        local Coords = GetEntityCoords(player)
        local campfire = DoesObjectOfTypeExistAtCoords(Coords.x, Coords.y, Coords.z, 1.5, GetHashKey("p_campfire02x"), 0) -- prop required to interact
        if campfire ~= false and iscrafting == false then 
            DrawTxt("[~e~G~q~] Para cozinhar", 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)

            if whenKeyJustPressed(keys["G"]) then
                if keyopen == false then
                WarMenu.OpenMenu('Craft')
                else end
            end
        end
    end
end)


RegisterNetEvent("syn:crafting")
AddEventHandler("syn:crafting", function()
    local playerPed = PlayerPedId()
        iscrafting = true
        TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 15000, true, false, false, false)
        exports['progressBars']:startUI(15000, "You're crafting...")
        Citizen.Wait(15000)

        keyopen = false
        iscrafting = false
end)

RegisterNetEvent('syn:campfire')
AddEventHandler('syn:campfire', function()

    if campfire ~= 0 then
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "You're placing a campfire...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_campfire02x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    campfire = prop

end)
