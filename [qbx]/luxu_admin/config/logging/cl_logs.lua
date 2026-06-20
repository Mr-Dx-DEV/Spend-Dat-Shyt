-- Weapon constant names (as shown on FiveM docs)
WEAPON_HASHES = {
    [`WEAPON_SNOWLAUNCHER`]          = "WEAPON_SNOWLAUNCHER",
    [`WEAPON_COMPACTLAUNCHER`]       = "WEAPON_COMPACTLAUNCHER",
    [`WEAPON_MINIGUN`]               = "WEAPON_MINIGUN",
    [`WEAPON_GRENADELAUNCHER_SMOKE`] = "WEAPON_GRENADELAUNCHER_SMOKE",
    [`WEAPON_HOMINGLAUNCHER`]        = "WEAPON_HOMINGLAUNCHER",
    [`WEAPON_RAILGUN`]               = "WEAPON_RAILGUN",
    [`WEAPON_FIREWORK`]              = "WEAPON_FIREWORK",
    [`WEAPON_GRENADELAUNCHER`]       = "WEAPON_GRENADELAUNCHER",
    [`WEAPON_RPG`]                   = "WEAPON_RPG",
    [`WEAPON_RAYMINIGUN`]            = "WEAPON_RAYMINIGUN",
    [`WEAPON_EMPLAUNCHER`]           = "WEAPON_EMPLAUNCHER",
    [`WEAPON_RAILGUNXM3`]            = "WEAPON_RAILGUNXM3",

    -- explosives / throwable
    [`WEAPON_GRENADE`]               = "WEAPON_GRENADE",
    [`WEAPON_BZGAS`]                 = "WEAPON_BZGAS",
    [`WEAPON_PROXMINE`]              = "WEAPON_PROXMINE",
    [`WEAPON_PIPEBOMB`]              = "WEAPON_PIPEBOMB",
    [`WEAPON_ACIDPACKAGE`]           = "WEAPON_ACIDPACKAGE",
    [`WEAPON_SMOKEGRENADE`]          = "WEAPON_SMOKEGRENADE",

    -- pistols (examples from page)
    [`WEAPON_VINTAGEPISTOL`]         = "WEAPON_VINTAGEPISTOL",
    [`WEAPON_PISTOL`]                = "WEAPON_PISTOL",
    [`WEAPON_PISTOLXM3`]             = "WEAPON_PISTOLXM3",

    -- shotguns (examples)
    [`WEAPON_COMBATSHOTGUN`]         = "WEAPON_COMBATSHOTGUN",
    [`WEAPON_AUTOSHOTGUN`]           = "WEAPON_AUTOSHOTGUN",

    -- melee / blunt
    [`WEAPON_STONE_HATCHET`]         = "WEAPON_STONE_HATCHET",
    [`WEAPON_GOLFCLUB`]              = "WEAPON_GOLFCLUB",
    [`WEAPON_HAMMER`]                = "WEAPON_HAMMER",
    [`WEAPON_CANDYCANE`]             = "WEAPON_CANDYCANE",
    [`WEAPON_NIGHTSTICK`]            = "WEAPON_NIGHTSTICK",
    [`WEAPON_CROWBAR`]               = "WEAPON_CROWBAR",
    [`WEAPON_FLASHLIGHT`]            = "WEAPON_FLASHLIGHT",
    [`WEAPON_DAGGER`]                = "WEAPON_DAGGER",
    [`WEAPON_POOLCUE`]               = "WEAPON_POOLCUE",
    [`WEAPON_BAT`]                   = "WEAPON_BAT",
    [`WEAPON_BATTLEAXE`]             = "WEAPON_BATTLEAXE",
    [`WEAPON_STUNROD`]               = "WEAPON_STUNROD",
    [`WEAPON_MACHETE`]               = "WEAPON_MACHETE",
    [`WEAPON_SWITCHBLADE`]           = "WEAPON_SWITCHBLADE",
    [`WEAPON_HATCHET`]               = "WEAPON_HATCHET",
    [`WEAPON_BOTTLE`]                = "WEAPON_BOTTLE",

    -- other devices
    [`WEAPON_HACKINGDEVICE`]         = "WEAPON_HACKINGDEVICE",
    [`WEAPON_STUNGUN`]               = "WEAPON_STUNGUN",
    [`WEAPON_STUNGUN_MP`]            = "WEAPON_STUNGUN_MP",
}

--- Add missing weapon hashes from ox_inventory
if GetResourceState('ox_inventory') == 'started' then
    local list = require "@ox_inventory.data.weapons"

    for k in pairs(list.Weapons) do
        WEAPON_HASHES[joaat(k)] = k
    end
end

-- headshot ratio
local totalKills = 0
local totalKillsByHeadshot = 0

--- Batch the logs to send them in a single request and prevent spam
---@class BatchLogs
---@field deaths string[]
---@field actions string[]
local batchLogs = {
    deaths = {},
    actions = {},
}

---TODO: Check other causes of death, like vehicle collisions, falls, etc.
AddEventHandler('gameEventTriggered', function(event, args)
    if event == "CEventNetworkEntityDamage" then
        local playerPed = PlayerPedId()
        local attacker = args[2]
        -- Check if the attacker is the client
        local isAttacker = attacker ~= playerPed
        local victim = args[1]
        local wasFatal = args[6] == 1
        local isMelee = args[12] == 1
        local _found, bone = GetPedLastDamageBone(victim)


        local hasWeapon, clientWeaponHash = GetCurrentPedWeapon(playerPed, true)
        local clientWeaponModel = hasWeapon and (WEAPON_HASHES[clientWeaponHash] or clientWeaponHash) or "unarmed"

        if isAttacker and wasFatal and not isMelee then
            totalKills = totalKills + 1
            if bone == 31086 then
                totalKillsByHeadshot = totalKillsByHeadshot + 1
            end
            Luxu.triggerServerEvent("hs:update", totalKillsByHeadshot / totalKills)
        end
        --- If the victim is the client, log the death
        if victim == playerPed then
            local isAttackerAPlayer = NetworkGetPlayerIndexFromPed(attacker)


            local selfHarm = attacker == -1 -- Fell or Drowning

            --- Check if the player died from falling or drowning
            if selfHarm and wasFatal then
                local playerName = GetPlayerName(Luxu.cache.playerId)
                local logMessage = ("%s died from falling or drowning"):format(playerName)
                batchLogs.deaths[#batchLogs.deaths + 1] = logMessage
                return
            end

            --- Killed by another player
            if wasFatal and isAttackerAPlayer ~= -1 then
                local attackerServerId = GetPlayerServerId(isAttackerAPlayer)
                local attackerName = GetPlayerName(isAttackerAPlayer)
                local attackerHasWeapon, attackerWeaponHash = GetCurrentPedWeapon(attacker, true)
                local attackerWeaponModel = attackerHasWeapon and GetWeapontypeModel(attackerWeaponHash) or "unarmed"
                local victimName = GetPlayerName(Luxu.cache.playerId)
                local logMessage = ("%s was killed by [%d]%s | Weapon %s:%s"):format(
                    victimName,
                    attackerServerId,
                    attackerName,
                    attackerWeaponModel,
                    attackerWeaponHash)
                batchLogs.deaths[#batchLogs.deaths + 1] = logMessage
            end
        end


        --- Check if any action was done by this client as the attacker
        if attacker ~= PlayerPedId() then return end

        local victimEntityType = IsEntityAPed(victim) and "ped" or IsEntityAVehicle(victim) and "vehicle" or
            IsEntityAnObject(victim) and "object" or "unknown"

        --- Log vehicle destruction
        if victimEntityType == "vehicle" and wasFatal then
            local playerName = GetPlayerName(Luxu.cache.playerId)
            local plate = GetVehicleNumberPlateText(victim)
            local logMessage = ("%s destroyed a vehicle with plate: [%s] using %s:%s"):format(playerName, plate,
                clientWeaponModel, clientWeaponHash)
            batchLogs.actions[#batchLogs.actions + 1] = logMessage
            return
        end
    end
end)

-- Periodically send batched logs to the server using a latent trigger
Citizen.CreateThread(function()
    while true do
        if #batchLogs.deaths > 0 then
            Luxu.triggerServerEventLatent("log:playerDeathBatch", 10000, batchLogs.deaths)
            batchLogs.deaths = {} -- Clear the batch after sending
        end
        Citizen.Wait(10e3)        -- Wait for 10 seconds before checking again
    end
end)
