print("Tu marche?")

local playerShooters = {}

AddEventHandler('gameEventTriggered', function(eventName, eventData)
    print("Test crampté 1")
    if eventName == 'CEventNetworkEntityDamage' then
        print("Test crampté 2")
        local shooterId = eventData[1]
        local weaponHash = eventData[3]

        if IsPedAPlayer(shooterId) then
            local playerId = NetworkGetPlayerIndexFromPed(shooterId)
            playerShooters[playerId] = true

            print("Le joueur avec l'ID " .. playerId .. " a tiré avec l'arme " .. weaponHash)

            Citizen.CreateThread(function()
                Citizen.Wait(120000)
                playerShooters[playerId] = nil
            end)
        end
    end
end)

function isPlayerShooter(playerId)
    return playerShooters[playerId] ~= nil
end