
--db items and found/notfound

ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent('krp_pickweed:getItem')
AddEventHandler('krp_pickweed:getItem', function()

    local luck = math.random(1, 3)

    if luck == 1 then

        local items = { 
            'weed'
        }

        local xPlayer = ESX.GetPlayerFromId(source)
        local randomItems = items[math.random(#items)]
        local quantity = math.random(#items)
        local itemfound = ESX.GetItemLabel(randomItems)

        xPlayer.addInventoryItem(randomItems, quantity)
        TriggerClientEvent('esx:showNotification', source, 'You found ' .. quantity .. ' gram of ' .. itemfound)
    else
        TriggerClientEvent('esx:showNotification', source, 'Nothing found, maybe someone already harvested?')
    end
end)
