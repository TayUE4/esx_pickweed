--inital setting of weed props for cache

ESX        = nil
cachedPlant = {}
closestPlant = {
    'Prop_weed_01',
    'bkr_prop_weed_lrg_01a',
    'bkr_prop_weed_lrg_01b',
    'bkr_prop_weed_med_01a',
    'bkr_prop_weed_med_01b',
    'bkr_prop_weed_01_small_01a',
    'bkr_prop_weed_01_small_01b',
    'bkr_prop_weed_01_small_01c'


}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        cachedPlant = {}
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

--user interaction and ShowNotification

Citizen.CreateThread(function()
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestPlant do
            local x = GetClosestObjectOfType(playerCoords, 2.0, GetHashKey(closestPlant[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                entity = x
                Plant    = GetEntityCoords(entity)
                sleep  = 5
                DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, 'Press [~g~E~s~] to harvest the ~b~weed~s~')  
                if IsControlJustReleased(0, 38) then
                    if not cachedPlant[entity] then
                        OpenPlant(entity)
                    else
                        ESX.ShowNotification('~r~This plant has already been harvested.~s~')
                    end
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)