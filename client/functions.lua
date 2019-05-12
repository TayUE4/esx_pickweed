--draw 3d text to screen

DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
  
	local scale = 0.45
   
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
	end
end


--itemize cache 

OpenPlant = function(entity)
    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    Citizen.Wait(10000)
    cachedPlant[entity] = true
    TriggerServerEvent('krp_pickweed:getItem')
    ClearPedTasksImmediately(PlayerPedId())
end