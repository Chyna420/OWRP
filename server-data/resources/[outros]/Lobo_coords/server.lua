RegisterNetEvent("SendCoords")
AddEventHandler("SendCoords", function(coords,heading)
	print("^3[#] Coords: ^1" ..coords.. " ^3[#] Heading = ^1" ..heading)
end)
