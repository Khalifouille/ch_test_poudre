-- Created item "Test de poudre" on ox_inventory 
-- 	["test de poudre"] = {
--		label = "Test de poudre",
--		weight = 1,
--		stack = false,
--		close = true,
--	},

RegisterCommand('poudretest', function(source, args)
local targetPlayerId = tonumber(args[1])
if targetPlayerId then
    TriggerServerEvent('checktir', targetPlayerId)
else
    print("Utilisation: /poudretest [playerId]")
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