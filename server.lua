print("Tu marche?")

ESX = exports['es_extended']:getSharedObject()

local playerShooters = {}

RegisterNetEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weaponHash)
    local playerId = source
    print("Crampté au nom de " .. tostring(playerId) .. " a tiré")

    playerShooters[playerId] = true

    Citizen.CreateThread(function()
        Citizen.Wait(3600000) -- 1 heure en millisecondes
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

    if xPlayer == nil then
        print("xPlayer est nil pour l'ID de joueur: " .. tostring(sourcePlayerId))
        return
    end

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

RegisterNetEvent('resetPlayerShotState')
AddEventHandler('resetPlayerShotState', function()
    local playerId = source
    print("Réinitialisation de l'état de tir pour le joueur avec l'ID " .. tostring(playerId))
    playerShooters[playerId] = nil
    print("État de tir réinitialisé pour le joueur avec l'ID " .. tostring(playerId))
end)

function isPlayerShooter(playerId)
    return playerShooters[playerId] ~= nil
end