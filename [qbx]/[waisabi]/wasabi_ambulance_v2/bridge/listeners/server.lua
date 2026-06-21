local noop = function() end

local listeners = {}

-- Return noop for any listener that isn't defined to prevent errors when calling
setmetatable(listeners, {
    __index = function()
        return noop
    end
})

--! DO NOT EDIT ABOVE THIS LINE
--! DO NOT USE BLOCKING CALLS IN THESE LISTENERS - THEY ARE CALLED DURING DEATH LOOPS AND CAN CAUSE ISSUES IF THEY HANG

---Called when a player enters last stand (downed but not fully dead)
---@param source number Server ID of the player
---@param deathData { cause: number?, killer: number? }? Death data with cause hash and killer server ID
function listeners.onLastStand(source, deathData)
    -- Example: Start a bleedout timer
    -- exports.your_resource:startBleedout(source)
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnLastStand', source, deathData)
end

---Called when a player enters the fully dead state
---@param source number Server ID of the player
---@param deathData { cause: number?, killer: number? }? Death data with cause hash and killer server ID
function listeners.onDeath(source, deathData)
    -- Example: Log death to external system
    -- exports.your_logging:logDeath(source, deathData.cause)

    -- Example: Notify admins
    -- lib.triggerClientEvent('admin:notify', GetPlayers(), { message = 'Player died' })
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnDeath', source, deathData)
end

---Called when a player is revived by any method
---@param source number Server ID of the player being revived
---@param reviver number? Server ID of the player who revived them (nil if self/hospital)
---@param method 'player'|'hospital'|'item'|'admin'|'command' How the player was revived
function listeners.onRevive(source, reviver, method)
    -- Example: Log revival
    -- print(('[Revive] Player %d revived via %s'):format(source, method))

    -- Example: Give reviver a reward
    -- if reviver and method == 'player' then
    --     exports.qbx_core:AddMoney(reviver, 'cash', 100, 'revive-reward')
    -- end
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnRevive', source, reviver, method)
end

---Called when a player respawns at a hospital (gave up or forced respawn)
---@param source number Server ID of the player
---@param facilityId number? The facility ID where the player respawned
---@param coords vector3 The respawn coordinates
function listeners.onRespawn(source, facilityId, coords)
    -- Example: Apply death penalty
    -- exports.your_economy:applyDeathPenalty(source)

    -- Example: Clear wanted level
    -- exports.your_police:clearWanted(source)
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnRespawn', source, facilityId, coords)
end

---Called before resolving a hospital respawn to optionally route jailed players to a standalone facility.
---Return true to use the nearest standalone facility, a facility id, or a facility name.
---@param source number Server ID of the player
---@return boolean|number|string standaloneFacility true/id/name to use standalone respawn, false/nil for normal respawn
function listeners.getStandaloneRespawnFacility(source)
    -- Example: injail state bag from wasabi_police's jail function
    if Player(source).state.injail then
        return 'Prison Clinic' -- or return true for nearest standalone facility
    end
    return false
end

---Called when a player completes facility treatment (healed at hospital bed)
---@param source number Server ID of the player
---@param facilityId number The facility ID
---@param facilityName string The facility name
---@param cost number The amount charged (0 if free)
function listeners.onFacilityHeal(source, facilityId, facilityName, cost)
    -- Example: Create a medical record
    -- exports.your_records:createMedicalRecord(source, facilityName, cost)
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnFacilityHeal', source, facilityId, facilityName, cost)
end

---Called when a player is placed on a stretcher
---@param source number Server ID of the player on the stretcher
---@param stretcherId number The stretcher ID
---@param placedBy number Server ID of the player who placed them
function listeners.onStretcherEnter(source, stretcherId, placedBy)
    -- Example: Log stretcher usage
    -- print(('[Stretcher] Player %d placed on stretcher by %d'):format(source, placedBy))
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnStretcherEnter', source, stretcherId, placedBy)
end

---Called when a player is removed from a stretcher
---@param source number Server ID of the player removed from stretcher
---@param stretcherId number The stretcher ID
---@param removedBy number Server ID of the player who removed them
function listeners.onStretcherExit(source, stretcherId, removedBy)
    -- Example: Log stretcher removal
    -- print(('[Stretcher] Player %d removed from stretcher by %d'):format(source, removedBy))
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnStretcherExit', source, stretcherId, removedBy)
end

---Called when a healing item is used on a player
---@param source number Server ID of the player being healed
---@param itemName string The item name
---@param healAmount number The amount healed
---@param healerId number? The server ID of the healer (nil if self)
function listeners.onHealingItemUsed(source, itemName, healAmount, healerId)
    -- Example: Track healing statistics
    -- exports.your_stats:trackHealing(healerId or source, itemName, healAmount)
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnHealingItemUsed', source, itemName, healAmount, healerId)
end

---Called when a player's injury state changes
---@param source number Server ID of the player
---@param limbs table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData> Current limb injury data
---@param previousLimbs table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData> Previous limb injury data
function listeners.onInjuryUpdate(source, limbs, previousLimbs)
    -- Example: Sync injuries to external system
    -- exports.your_medical:syncInjuries(source, limbs)
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnInjuryUpdate', source, limbs, previousLimbs)
end

---Called when duty status changes for EMS
---@param source number Server ID of the player
---@param onDuty boolean Whether the player is now on duty
---@param job string Job name
function listeners.onDutyChange(source, onDuty, job)
    -- Example: Log duty changes
    -- print(('[Duty] Player %d is now %s for %s'):format(source, onDuty and 'on duty' or 'off duty', job))
    TriggerEvent('wasabi_ambulance:Server:Listeners:OnDutyChange', source, onDuty, job)
end

---Called when a admin check is needed, add your own checks and return true if the player is an admin
---This is useful for custom admin checks that are not covered by the default admin group checks via bridge.hasGroup or IsPlayerAceAllowed
---@param source number Server ID of the player
---@return boolean isAdmin True if the player is an admin
function listeners.onAdminCheck(source)
    -- Add your own  check for admin permissions here and return true if the player is an admin
    -- Example:
    -- if exports.adminTracker:isAdmin(source) then
    --     return true
    -- end
    return false -- Leave this fallback return false so you don't accidentally allow non-admins to access admin features
end

Modules.register('listeners', listeners)
