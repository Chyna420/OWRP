local safe = {   
"p_sidetable03x",
"p_sidetable02x", 
"p_bag01x", 
"p_baggage01x",
"p_veh_baggage01x_mud_low",
"p_baggage01x_amb01x",
"p_veh_baggage01x_tre_low",  
}
RegisterNetEvent('gorp:saferobbery')
AddEventHandler('gorp:saferobbery', function()
	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
	for key, value in pairs(safe) do
		local safe = DoesObjectOfTypeExistAtCoords(x, y, z, 1.0, GetHashKey(value), true)
		if safe then
			TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
            exports['progressBars']:startUI(15000, "Vaculhar...")
			Wait(15000)
			ClearPedTasks(GetPlayerPed())
			TriggerServerEvent("gorp:robberycomplete")
		end
	end
end)
