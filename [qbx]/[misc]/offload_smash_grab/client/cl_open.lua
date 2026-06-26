local Config = require 'config.client'
local Bridge = exports['community_bridge']:Bridge()

Interaction = {}

---Adds interaction to the vehicle
---@param netId number
---@param veh number
function Interaction.Add(netId, veh)
    local smashName = ('os_smash_grab_smash_%s'):format(netId)
    local lootName = ('os_smash_grab_loot_%s'):format(netId)

    Bridge.Target.AddLocalEntity(veh, {
        {
            name = smashName,
            label = Config.SmashLabel,
            distance = Config.TargetDistance,
            bones = { Config.AttachBone },
            items = Config.RequiredItem or false,
            canInteract = function(entity)
                if pendingLoot[netId] then return false end
                if not spawned[netId] or spawned[netId].looted then return false end
                
                if Config.RequiredItem and Config.RequiredHoldOnHands then
                    local currentWeapon, Weapon = GetCurrentPedWeapon(PlayerPedId(), true)
                    if not currentWeapon or Weapon ~= joaat(Config.RequiredItem) then
                        return false
                    end
                end
                
                return IsVehicleWindowIntact(entity, Config.WindowIndex)
            end,
            onSelect = function(_data)
                Interaction.OnSmash(netId, veh)
            end,
        },
        {
            name = lootName,
            label = Config.LootLabel,
            distance = Config.TargetDistance,
            bones = { Config.AttachBone },
            canInteract = function(entity)
                if pendingLoot[netId] then return false end
                if not spawned[netId] or spawned[netId].looted then return false end
                if not DoesEntityExist(entity) or not DoesEntityExist(spawned[netId].prop) then return false end
                
                if IsVehicleWindowIntact(entity, Config.WindowIndex) and not smashed[netId] then
                    return false
                end
                return true
            end,
            onSelect = function(_data)
                Interaction.OnLoot(netId, veh)
            end,
        },
    })
end

---Removes interaction from the vehicle
---@param netId number
---@param veh number
function Interaction.Remove(netId, veh)
    Bridge.Target.RemoveLocalEntity(veh, {
        ('os_smash_grab_smash_%s'):format(netId),
        ('os_smash_grab_loot_%s'):format(netId),
    })
end

---Logic for smashing the window
---@param netId number
---@param veh number
function Interaction.OnSmash(netId, veh)
    if pendingLoot[netId] then return end
    -- Dispatch
    if Config.Dispatch and math.random() <= Config.DispatchChance then
        Bridge.Dispatch.SendAlert({
            message = Config.DispatchTitle,
            code = Config.DispatchCode,
            coords = GetEntityCoords(veh) or GetEntityCoords(PlayerPedId()),
            jobs = {"police", "sheriff"},
            blipData = {
                sprite = 225,
                color = 1,
                scale = 0.5
            },
            time = 60000, -- 1 minutes
            icon = "fas fa-car"
        })
    end
    -- YOU CAN ADD MINIGAME HERE IF YOU WANT!!!

    local success = Bridge.ProgressBar.Open({
        duration = Config.SmashDurationMs,
        label = Config.SmashProgressLabel or Config.SmashLabel,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true
        },
        anim = Config.SmashAnim
    })

    if not success then return end  

    if DoesEntityExist(veh) then
        SmashVehicleWindow(veh, Config.WindowIndex)
        smashed[netId] = true
    end

    TriggerServerEvent('os_smash_grab:server:smashVehicle', netId)
end

---Logic for looting the vehicle
---@param netId number
---@param veh number
function Interaction.OnLoot(netId, veh)
    if pendingLoot[netId] then return end -- DONT TOUCH THIS

    pendingLoot[netId] = true
    local success = Bridge.ProgressBar.Open({
        duration = Config.LootDurationMs,
        label = Config.LootProgressLabel or Config.LootLabel,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true
        },
        anim = Config.LootAnim
    })

    if not success then
        pendingLoot[netId] = nil
        return
    end

    -- DONT TOUCH THIS
    TriggerServerEvent('os_smash_grab:server:lootVehicle', netId)

    SetTimeout(5000, function()
        pendingLoot[netId] = nil
    end)
end
