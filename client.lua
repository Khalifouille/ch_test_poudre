--["douille"] = {
--    label = "Douille",
--    weight = 1,
--    stack = false,
--   close = true,
--    client = {
--        image = 'douille.png',
--    },
--},
--["test_de_poudre"] = {
--    label = "Test de poudre",
--    weight = 1,
--    stack = false,
--    close = true,
--    client = {
--        image = 'test_de_poudre.png',
--    },
--},

--["savon"] = {
--    label = "Savon",
--    weight = 1,
--   stack = false,
--   close = true,
--   client = {
--        image = 'savon.png',
--   },
--},

function IsPlayerNearWater()
    local playerPed = PlayerPedId()
    return IsEntityInWater(playerPed)
end

RegisterCommand('selaver', function()
    local playerPed = PlayerPedId()
    if IsPlayerNearWater() then
        TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', ' Lavage des mains en cours' } })
        TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
        Citizen.Wait(5000)
        ClearPedTasks(playerPed)
        TriggerServerEvent('resetPlayerShotState')
        TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', ' Lavage des mains fini !' } })
    else
        TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', ' Vous n\'êtes pas à proximité de l\'eau.' } })
    end
end, false)

RegisterCommand('poudretest', function(source, args)
    local targetPlayerId = tonumber(args[1])
    if targetPlayerId then
        TriggerServerEvent('checktir', targetPlayerId)
    else
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedShooting(PlayerPedId()) then
            local weaponHash = GetSelectedPedWeapon(PlayerPedId())
            TriggerServerEvent('playerShotWeapon', weaponHash)
        end
    end
end)