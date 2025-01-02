ESX = exports['es_extended']:getSharedObject()

local playerShooters = {}

RegisterNetEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weaponHash)
    local playerId = source

    playerShooters[playerId] = true

    Citizen.CreateThread(function()
        Citizen.Wait(3600000)
        playerShooters[playerId] = nil
        print("Reset fait")
    end)
end)

RegisterNetEvent('checktir')
AddEventHandler('checktir', function(targetPlayerId)
    local sourcePlayerId = source
    local xPlayer = ESX.GetPlayerFromId(sourcePlayerId)

    if xPlayer.getInventoryItem('test_de_poudre').count > 0 then
        if playerShooters[targetPlayerId] then
            xPlayer.removeInventoryItem('test_de_poudre', 1)
            -- xPlayer.removeInventoryItem('savon', 1)
            TriggerClientEvent('chat:addMessage', sourcePlayerId, { args = { '^1SYSTEM', ' Le joueur a tiré récemment. Test de poudre utilisé.' } })
        else
            TriggerClientEvent('chat:addMessage', sourcePlayerId, { args = { '^1SYSTEM', ' Le joueur n\'a pas tiré récemment.' } })
            xPlayer.removeInventoryItem('test_de_poudre', 1)
            -- xPlayer.removeInventoryItem('savon', 1)
        end
    else
        TriggerClientEvent('chat:addMessage', sourcePlayerId, { args = { '^1SYSTEM', ' Vous avez besoin d\'un test de poudre.' } })
    end
end)

RegisterNetEvent('checksavon')
AddEventHandler('checksavon', function()
    local sourcePlayerId = source
    local xPlayer = ESX.GetPlayerFromId(sourcePlayerId)

    if xPlayer.getInventoryItem('savon').count > 0 then
        xPlayer.removeInventoryItem('savon', 1)
        TriggerClientEvent('startHandWashing', sourcePlayerId)
    else
        TriggerClientEvent('chat:addMessage', sourcePlayerId, { args = { '^1SYSTEM', ' Vous n\'avez pas de savon.' } })
    end
end)

RegisterNetEvent('resetPlayerShotState')
AddEventHandler('resetPlayerShotState', function()
    local playerId = source
    playerShooters[playerId] = nil
end)

function isPlayerShooter(playerId)
    return playerShooters[playerId] ~= nil
end