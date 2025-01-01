-- Created item "Test de poudre" on ox_inventory 
-- 	["test de poudre"] = {
--		label = "Test de poudre",
--		weight = 1,
--		stack = false,
--		close = true,
--	},

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPedShooting(PlayerPedId()) then
            local weaponHash = GetSelectedPedWeapon(PlayerPedId())
            TriggerServerEvent('playerShotWeapon', weaponHash)
        end
    end
end)