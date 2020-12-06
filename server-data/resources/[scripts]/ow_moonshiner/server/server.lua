Inventory = exports.vorp_inventory:vorp_inventoryApi()
VORP = exports.vorp_core:vorpAPI()
local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

--############################## Server Callbacks ##############################--
VORP.addNewCallBack("check_mashItems", function(source, cb, itemArray)
    local _source = source
    local hasAllItems = false
    for k,v in pairs(itemArray) do
        local count = Inventory.getItemCount(_source, k)
        if count >= v then
            hasAllItems = true
        else 
            hasAllItems = false
        end
    end
    if hasAllItems then
        for k,v in pairs(itemArray) do
            Inventory.subItem(_source, k, v)
        end
    end

    cb(hasAllItems)
end)

VORP.addNewCallBack("check_moonshineItems", function(source, cb, itemArray)
    local _source = source
    local hasAllItems = false
    for k,v in pairs(itemArray) do
        local count = Inventory.getItemCount(_source, k)
        if count >= v then
            hasAllItems = true
        else 
            hasAllItems = false
        end
    end
    if hasAllItems then
        for k,v in pairs(itemArray) do
            Inventory.subItem(_source, k, v)
        end
    end

    cb(hasAllItems)
end)
--############################## END Server Callbacks ##############################--

--############################## Usable Items ##############################--
Citizen.CreateThread(function()
	Citizen.Wait(2000)
	Inventory.RegisterUsableItem(Config.brewPop, function(data)
        TriggerClientEvent("moonshiner:placeProp", data.source, Config.brewPop)
        Inventory.subItem(data.source, Config.brewPop, 1)
    end)
    Inventory.RegisterUsableItem(Config.mashProp, function(data)
        TriggerClientEvent("moonshiner:placeProp", data.source, Config.mashProp)
        Inventory.subItem(data.source, Config.mashProp, 1)
    end)
end)
--############################## END Usable Items ##############################--

--############################## Item Management ##############################--
RegisterServerEvent('moonshiner:giveMoonshine')
AddEventHandler("moonshiner:giveMoonshine", function(moonshineName, minXP, maxXP)
    local _source = source
    local xp = math.random(minXP, maxXP)
    local Character = VorpCore.getUser(_source).getUsedCharacter

    Character.addXp(xp)
    Inventory.addItem(_source, moonshineName, 1)
end)

RegisterServerEvent('moonshiner:giveMash')
AddEventHandler("moonshiner:giveMash", function(mashName, minXP, maxXP)
    local _source = source
    local xp = math.random(minXP, maxXP)
    local Character = VorpCore.getUser(_source).getUsedCharacter

    Character.addXp(xp)
    Inventory.addItem(_source, mashName, 1)
end)

RegisterServerEvent('moonshiner:givePropBack')
AddEventHandler("moonshiner:givePropBack", function(propName)
    local _source = source

    Inventory.addItem(_source, propName, 1)
end)

RegisterServerEvent('moonshiner:giveHarvestItems')
AddEventHandler("moonshiner:giveHarvestItems", function(itemName, itemCount)
    local _source = source

    Inventory.addItem(_source, itemName, itemCount)
    TriggerClientEvent("vorp:TipBottom", _source, "Du hast "..itemCount.." "..itemName.." gesammelt", 4000)
end)
--############################## END Item Management ##############################--