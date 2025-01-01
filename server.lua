print("Tu marche?")

local playerShooters = {}

RegisterNetEvent('playerShotWeapon')
AddEventHandler('playerShotWeapon', function(weaponHash)
    -- print("Test crampté 1")
    local playerId = source
    print("Crampté au nom de " .. tostring(playerId) .. " a tiré")

    playerShooters[playerId] = true

    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        playerShooters[playerId] = nil
        print("Reset fait")
    end)
end)
