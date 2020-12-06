local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }
local still = 0
local actualBrewingTime = 0
local timeToBrew = 0
local actualBrewingMoonshine = ""
local getMoonshineMenu = false
local isBrewing = false
local isHarvesting = false
local isProcessingMash = false
local placedStill = false
local placedStillProp
local placedBarrel = false
local placedBarrelProp
local BuildPrompt
local DelPrompt
local prompt, prompt2 = false, false

--############################## Interaction Menu ##############################--
-- interact with object
Citizen.CreateThread(function()
    SetupBuildPrompt()
    SetupDelPrompt()
	while true do
		Citizen.Wait(1)
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        local isNearStill = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, GetHashKey(Config.brewPop), true)
        local isNearBarrel = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, GetHashKey(Config.mashProp), true)
		
		if placedStill and isNearStill then 
			TriggerEvent('vorp:Tip', "[G] Destilador de bubidas", 100)
			if IsControlJustReleased(0, 0x760A9C6F) then -- g
                WarMenu.OpenMenu('still')
			end
        end
        
        if placedBarrel and isNearBarrel and isProcessingMash == false then 
			TriggerEvent('vorp:Tip', "[G] Misturiador", 100)
			if IsControlJustReleased(0, 0x760A9C6F) then -- g
                WarMenu.OpenMenu('barrel')
			end
        end
	end
end)

-- search for items
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
        
        for prop,item in pairs(Config.collectables) do
            local isNearStill = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, GetHashKey(tostring(prop)), true)
            
            if isNearStill and not isHarvesting then 
                TriggerEvent('vorp:Tip', "[X] Apanhar "..item.Label, 100)
                if IsControlJustReleased(0, 0x8CC9CD42) then -- x
                    isHarvesting = true
                    TriggerEvent("moonshiner:harvest", item)
                end
            end
		end
	end
end)
--############################## END Interaction Menu ##############################--

--############################## Menu Creation ##############################--
--Moonshine Menu
Citizen.CreateThread(function()
    WarMenu.CreateMenu('still', "destilador")
    WarMenu.SetSubTitle('still', 'Produzir')
    WarMenu.CreateSubMenu('destille', 'still', 'Bubidas')
  
    while true do
        if WarMenu.IsMenuOpened('still') then
            if WarMenu.MenuButton('Produzir Bebidas', 'destille') then
            end
            if WarMenu.Button('Desmontar destilador') then
                TriggerEvent('moonshiner:deleteProp', Config.brewPop)
                WarMenu.CloseMenu()
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('destille') then
            for moonshine,item in pairs(Config.moonshine) do
                if WarMenu.MenuButton(item.Label, moonshine) then
                end
            end
            WarMenu.Display()
        end
        Citizen.Wait(0)
    end
end)

--Mash Menu
Citizen.CreateThread(function()
    WarMenu.CreateMenu('barrel', "Barril Mistura")
    WarMenu.SetSubTitle('barrel', 'Produzir')
  
    while true do
        if WarMenu.IsMenuOpened('barrel') then
            for mash,item in pairs(Config.mashes) do
                if WarMenu.MenuButton(item.Label, mash) then
                end
            end
            if WarMenu.Button('Desmantelar') then
                TriggerEvent('moonshiner:deleteProp', Config.mashProp)
                WarMenu.CloseMenu()
            end
            WarMenu.Display()
        end
        Citizen.Wait(0)
    end
end)

--flexible Mash menu
Citizen.CreateThread( function()
    Citizen.Wait(100)
    for mash, value in pairs(Config.mashes) do
		WarMenu.CreateSubMenu(mash, 'barrel', value.Label)
	end

	repeat
		Citizen.Wait(0)
		for mash, value in pairs(Config.mashes) do
			if WarMenu.IsMenuOpened(mash) then
                if WarMenu.Button('Preparar') then
                    TriggerEvent("moonshiner:startMash", mash, value.items, value.mashTime, value.minXP, value.maxXP, value.errorMSG)
					WarMenu.CloseMenu()
				end
				WarMenu.Display()
			end
		end
	until false
end)

--flexible Moonshine menu
Citizen.CreateThread( function()
    Citizen.Wait(100)
    for moonshine, value in pairs(Config.moonshine) do
		WarMenu.CreateSubMenu(moonshine, 'destille', value.Label)
	end

	repeat
		Citizen.Wait(0)
        for moonshine, value in pairs(Config.moonshine) do
            if WarMenu.IsMenuOpened(moonshine) then
                if isBrewing then
                    if moonshine == actualBrewingMoonshine then
                        local time = round(((actualBrewingTime - timeToBrew) / 60), 2) 
                        if WarMenu.Button('Preparar '..time..'min') then
                            WarMenu.CloseMenu()
                        end
                    end
                elseif getMoonshineMenu then
                    if moonshine == actualBrewingMoonshine then
                        if WarMenu.Button(value.Label..' zapfen') then
                            TriggerServerEvent("moonshiner:giveMoonshine", moonshine, value.minXP, value.maxXP)
                            TriggerEvent("vorp:TipBottom", "Recebes-te", 3000)
                            actualBrewingMoonshine = ""
                            timeToBrew = 0
                            actualBrewingTime = 0
                            getMoonshineMenu = false
                            WarMenu.CloseMenu()
                        end
                    end
                else
                    if WarMenu.Button(value.Label..' ') then
                        TriggerEvent("moonshiner:startBrewing", moonshine, value.items, value.brewTime)
                        WarMenu.CloseMenu()
                    end
                end
                WarMenu.Display()
            end
		end
	until false
end)
--############################## END Menu Creation ##############################--

--############################## Events ##############################--
RegisterNetEvent('moonshiner:placeProp')
AddEventHandler('moonshiner:placeProp', function(propName)
    local myPed = PlayerPedId()
    local pHead = GetEntityHeading(myPed)
    local pos = GetEntityCoords(PlayerPedId(), true)
    local object = GetHashKey(propName)

    if not HasModelLoaded(object) then
        RequestModel(object)
    end

    while not HasModelLoaded(object) do
        Citizen.Wait(1)
    end

    local placing = true
    local tempObj = CreateObject(object, pos.x, pos.y, pos.z, true, true, false)
    SetEntityHeading(tempObj, pHead)
    SetEntityAlpha(tempObj, 51)
    AttachEntityToEntity(tempObj, myPed, 0, 0.0, 1.0, -0.7, 0.0, 0.0, 0.0, true, false, false, false, false)
    while placing do
        Wait(10)
        SetEntityHeading(tempObj, GetEntityHeading(PlayerPedId()))
        if prompt == false then
            PromptSetEnabled(BuildPrompt, true)
            PromptSetVisible(BuildPrompt, true)
            prompt = true
        end
        if PromptHasHoldModeCompleted(BuildPrompt) then
            PromptSetEnabled(BuildPrompt, false)
            PromptSetVisible(BuildPrompt, false)
            PromptSetEnabled(DelPrompt, false)
            PromptSetVisible(DelPrompt, false)
            prompt = false
            prompt2 = false
            local pPos = GetEntityCoords(tempObj, true)
            DeleteObject(tempObj)
            
            TaskStartScenarioInPlace(myPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
            exports['progressBars']:startUI(6000, "Montar...")
            Citizen.Wait(6000)
            ClearPedTasksImmediately(myPed)

            if propName == Config.brewPop then
                placedStillProp = CreateObject(object, pPos.x, pPos.y, pPos.z, true, true, false)
                PlaceObjectOnGroundProperly(placedStillProp)
                placedStill = true
            else
                placedBarrelProp = CreateObject(object, pPos.x, pPos.y, pPos.z, true, true, false)
                PlaceObjectOnGroundProperly(placedBarrelProp)
                placedBarrel = true
            end

            break
        end
        if prompt2 == false then
            PromptSetEnabled(DelPrompt, true)
            PromptSetVisible(DelPrompt, true)
            prompt2 = true
        end
        if PromptHasHoldModeCompleted(DelPrompt) then
            PromptSetEnabled(BuildPrompt, false)
            PromptSetVisible(BuildPrompt, false)
            PromptSetEnabled(DelPrompt, false)
            PromptSetVisible(DelPrompt, false)
            prompt = false
            prompt2 = false
            DeleteObject(tempObj)
            TriggerServerEvent('moonshiner:givePropBack', propName)
            break
        end
	end


end)

RegisterNetEvent('moonshiner:deleteProp')
AddEventHandler('moonshiner:deleteProp', function(propName)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    local playerPed = PlayerPedId()
    local isNearStill = DoesObjectOfTypeExistAtCoords(x, y, z, 1.5, GetHashKey(propName), true)

    if isNearStill then
        TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
        exports['progressBars']:startUI(5000, "Desmontar...")
        Citizen.Wait(5000)
        ClearPedTasksImmediately(playerPed)

        if propName == Config.brewPop then
            SetEntityAsMissionEntity(placedStillProp)
            DeleteObject(placedStillProp)
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent('moonshiner:givePropBack', propName)
            placedStillProp = 0
            placedStill = false
        else
            SetEntityAsMissionEntity(placedBarrelProp)
            DeleteObject(placedBarrelProp)
            ClearPedTasksImmediately(PlayerPedId())
            TriggerServerEvent('moonshiner:givePropBack', propName)
            placedBarrelProp = 0
            placedBarrel = false
        end
    end
end)

RegisterNetEvent('moonshiner:harvest')
AddEventHandler('moonshiner:harvest', function(values)
    local playerPed = PlayerPedId()
    local itemArrayLength = GetArrayLength(values.items)    
    local randomItem = math.random(1, itemArrayLength)
    local arrayCount = 1
    local itemCount = 0
    local item

    for k,v in pairs(values.items) do
        if arrayCount == randomItem then
            itemCount = math.random(1, v)
            item = k
        end
        arrayCount = arrayCount + 1
    end

    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
    exports['progressBars']:startUI(15000, "Produzir...")
    Citizen.Wait(15000)
    ClearPedTasksImmediately(playerPed)
    
    isHarvesting = false
    TriggerServerEvent("moonshiner:giveHarvestItems", item, itemCount)
end)

RegisterNetEvent('moonshiner:startMash')
AddEventHandler('moonshiner:startMash', function(mash, itemArray, time, minXP, maxXP, message)
    isProcessingMash = true
    local playerPed = PlayerPedId()
    local canMash = false
    local mashTime = time * 60 * 1000
    TriggerEvent("vorp:ExecuteServerCallBack", "check_mashItems", function(canMash)
        if canMash then
            --start scenario to produce mash
            TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
            exports['progressBars']:startUI(mashTime, "Produzir Mistura...")
            Citizen.Wait(mashTime)
            ClearPedTasksImmediately(playerPed)

            TriggerServerEvent("moonshiner:giveMash", mash, minXP, maxXP)
            TriggerEvent("vorp:TipBottom", ""..mash.." a produzir", 4000)
            isProcessingMash = false
        else
            TriggerEvent("vorp:TipBottom", message, 4000)
            isProcessingMash = false
        end
    end, itemArray)
end)

RegisterNetEvent('moonshiner:startBrewing')
AddEventHandler('moonshiner:startBrewing', function(moonshine, itemArray, moonshineTime)
    local playerPed = PlayerPedId()
    local canBrew = false

    TriggerEvent("vorp:ExecuteServerCallBack", "check_moonshineItems", function(canBrew)
        if canBrew then

            RequestAnimDict( "script_re@moonshine_camp@player_put_in_herbs" )
            while ( not HasAnimDictLoaded( "script_re@moonshine_camp@player_put_in_herbs" ) ) do 
                Citizen.Wait( 100 )
            end
            TaskPlayAnim(playerPed, "script_re@moonshine_camp@player_put_in_herbs", "put_in_still", 8.0, -8.0, 120000, 31, 0, true, 0, false, 0, false)
            Citizen.Wait(4000)
            ClearPedSecondaryTask(playerPed)

            if isBrewing == false then
                actualBrewingTime = moonshineTime * 60
                actualBrewingMoonshine = moonshine
                isBrewing = true
                startTimer()
                TriggerEvent("vorp:TipBottom", " "..round(((actualBrewingTime - timeToBrew) / 60), 2).."Para a bubida ficar pronta.", 3500)
            else
                TriggerEvent("vorp:TipBottom", "Já estás a produzir, aguarda um pouco", 3000)
            end
        else
            TriggerEvent("vorp:TipBottom", "Não tens os ingredientes necessarios", 3000)
        end
    end, itemArray)
end)
--############################## END Events ##############################--

--############################## Functions ##############################--
function GetArrayLength(array)
    local arrayLength = 0
    for k,v in pairs(array) do
        arrayLength = arrayLength + 1
    end
    return arrayLength
end

function startTimer()
    timeToBrew = 0
    Citizen.CreateThread(function()      
        while timeToBrew <= actualBrewingTime do
            Citizen.Wait(1000)
            timeToBrew = timeToBrew +1
            print("Já falta pouco: "..timeToBrew)
        end
        isBrewing = false
        getMoonshineMenu = true
        TriggerEvent("vorp:TipBottom", "A bubida está pronta", 4000)
    end)
end

function round(num, idp)
    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult
end

function SetupBuildPrompt()
    Citizen.CreateThread(function()
        local str = 'Colocar'
        BuildPrompt = PromptRegisterBegin()
        PromptSetControlAction(BuildPrompt, 0x07CE1E61)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(BuildPrompt, str)
        PromptSetEnabled(BuildPrompt, false)
        PromptSetVisible(BuildPrompt, false)
        PromptSetHoldMode(BuildPrompt, true)
        PromptRegisterEnd(BuildPrompt)
    end)
end

function SetupDelPrompt()
    Citizen.CreateThread(function()
        local str = 'Guardar'
        DelPrompt = PromptRegisterBegin()
        PromptSetControlAction(DelPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(DelPrompt, str)
        PromptSetEnabled(DelPrompt, false)
        PromptSetVisible(DelPrompt, false)
        PromptSetHoldMode(DelPrompt, true)
        PromptRegisterEnd(DelPrompt)
    end)
end
--############################## END Functions ##############################--