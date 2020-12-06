Citizen.CreateThread(function()
	while true do 
	Citizen.Wait(1)
		if IsControlJustReleased(0, 0xE30CD707) then
			TriggerEvent('cl_SendCoords')
		end            
	end
end)

RegisterNetEvent('cl_SendCoords')
AddEventHandler('cl_SendCoords', function()

	local ped = PlayerPedId()
	local Coords = GetEntityCoords(ped)
	local heading = GetEntityHeading(ped)
	TriggerServerEvent("SendCoords", Coords,heading)

end)
