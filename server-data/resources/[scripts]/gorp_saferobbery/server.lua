VorpInv = exports.vorp_inventory:vorp_inventoryApi()
VorpCore = {}
data = {}

TriggerEvent("getCore", function(core) VorpCore = core end)

Citizen.CreateThread(function()
    Citizen.Wait(2000) 
    VorpInv.RegisterUsableItem("lockpick", function(data)
        TriggerClientEvent('gorp:saferobbery', data.source)
    end)
end)

local Items = {
	{item = "polvora", name = "Pólvora", amountToGive = math.random(1,2)},
    {item = "relogiovelho", name = "Relógio Velho", amountToGive = math.random(1,2)},
    {item = "chips2", name = "Fichas", amountToGive = math.random(1,2)},
    {item = "corda", name = "Corda", amountToGive = math.random(1,2)},
    {item = "moedaantiga", name = "Moeda Antiga", amountToGive = math.random(2,5)},
    {item = "coca", name = "Goma de Cocaina", amountToGive = math.random(2,4)}

function payLoot(source)
    local Loot = {}
    for k, v in pairs(items) do 
        table.insert(Loot,v.item)
    end
    if Loot[1] ~= nil then
        local value = math.random(1,#Loot)
        local picked = Loot[value]
        return picked
    end
end


RegisterServerEvent('gorp:robberycomplete')
AddEventHandler('gorp:robberycomplete', function()
	local FinalLoot = LootToGive(source)
    local User = VorpCore.getUser(source).getUsedCharacter
    local chance = math.random(1,100)
    if chance <= 50 then
        for k,v in pairs(Items) do
                if v.item == FinalLoot then
                    VorpInv.subItem(source, "lockpick", 1)
                    VorpInv.addItem(source, FinalLoot, v.amountToGive)
                    LootsToGive = {}
                    TriggerClientEvent("vorp:TipRight", source, ' '..v.amountToGive..' ' ..v.name, 3000)
                end
            end
        else
        TriggerClientEvent("vorp:TipRight", source, 'Partiu a chave', 3000)
        VorpInv.subItem(source, "lockpick", 1)
    end
end)

function LootToGive(source)
	local LootsToGive = {}
	for k,v in pairs(Items) do
		table.insert(LootsToGive,v.item)
	end

	if LootsToGive[1] ~= nil then
		local value = math.random(1,#LootsToGive)
		local picked = LootsToGive[value]
		return picked
	end
end