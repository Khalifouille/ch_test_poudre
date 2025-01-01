print("Tu marche?")

ESX = exports['es_extended']:getSharedObject()

local playerShooters = {}

RegisterNetEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weaponHash)
    local playerId = source
    print("Crampté au nom de " .. tostring(playerId) .. " a tiré")

    playerShooters[playerId] = true

    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        playerShooters[playerId] = nil
        print("Reset fait")
    end)
end)

RegisterNetEvent('checktir')
AddEventHandler('checktir', function(targetPlayerId)
    local sourcePlayerId = source

    if ESX == nil then
        print("ESX n'est pas initialisé")
        return
    end

    local xPlayer = ESX.GetPlayerFromId(sourcePlayerId)
    
    if xPlayer.getInventoryItem('test_de_poudre').count > 0 then
        if playerShooters[targetPlayerId] then
            TriggerClientEvent('chat:addMessage', sourcePlayerId, { args = { '^1SYSTEM', 'Le joueur a tiré récemment.' } })
        else
            TriggerClientEvent('chat:addMessage', sourcePlayerId, { args = { '^1SYSTEM', 'Le joueur n\'a pas tiré récemment.' } })
        end
    else
        TriggerClientEvent('chat:addMessage', sourcePlayerId, { args = { '^1SYSTEM', 'Vous avez besoin d\'un test de poudre.' } })
    end
end)

function isPlayerShooter(playerId)
    return playerShooters[playerId] ~= nil
end