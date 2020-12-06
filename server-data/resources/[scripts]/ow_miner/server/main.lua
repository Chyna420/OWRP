local Loot = {
    {item = "coal", amountToGive = math.random(2,5)},
    {item = "flint", amountToGive = math.random(1,3)},
    {item = "rock", amountToGive = math.random(1,2)},
    {item = "copperore", amountToGive = math.random(2,4)},
    {item = "ironore", amountToGive = math.random(1,3)},
}

local LootRare = {
    {item = "goldore", amountToGive = math.random(1,1)},
    {item = "bauxita", amountToGive = math.random(1,2)},
    {item = "stone", amountToGive = math.random(1,3)},
    {item = "chumbo", amountToGive = math.random(1,3)},
    {item = "prata", amountToGive = math.random(1,2)},
}

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterServerEvent('VORP_MinerJob:loot')
AddEventHandler('VORP_MinerJob:loot', function(HR)
    local _source = source
    local FinalLoot = LootToGive(_source,HR)
        if HR then 
            for k,v in pairs(LootRare) do 
                if v.item == FinalLoot then
                    VorpInv.addItem(_source, FinalLoot,v.amountToGive)
                    LootsToGiveR = {}
                    break
                end
            end
            TriggerClientEvent("vorp:Tip", _source, "You got "..FinalLoot, 4)
        else
            for k,v in pairs(Loot) do 
                if v.item == FinalLoot then
                    VorpInv.addItem(_source, FinalLoot,v.amountToGive)
                    LootsToGive = {}
                    break
                end
            end
            TriggerClientEvent("vorp:Tip", _source, "You got "..FinalLoot, 4)
        end
end)

function LootToGive(source,HasRares) -- kek
    local LootsToGive = {}
    local LootsToGiveR = {}
    if HasRares then
        for k,v in pairs(LootRare) do
            table.insert(LootsToGiveR,v.item)
        end
    else
        for k,v in pairs(Loot) do
            table.insert(LootsToGive,v.item)
        end
    end

    if LootsToGive[1] ~= nil then
        local value = math.random(1,#LootsToGive)
        local picked = LootsToGive[value]
        return picked
    elseif LootsToGiveR[1] ~= nil then
        local value = math.random(1,#LootsToGiveR)
        local picked = LootsToGiveR[value]
        return picked
    end
end