local noop = function() end
local antiCheatStateCount = 0

local listeners = {}

-- Return noop for any listener that isn't defined to prevent errors when calling
setmetatable(listeners, {
    __index = function()
        return noop
    end
})

--! DO NOT EDIT ABOVE THIS LINE
--! DO NOT USE BLOCKING CALLS IN THESE LISTENERS - THEY ARE CALLED DURING DEATH LOOPS AND CAN CAUSE ISSUES IF THEY HANG

---Checked during death/last stand loops to determine if death animation should play
---Return false to skip animation persistence (e.g. when being carried by another script)
---@return boolean shouldPlay Whether the death animation should play
function listeners.shouldPlayDeathAnim()
    -- Example: Disable death anim when being carried
    -- if exports.mustard_carry:IsPlayerBeingCarried() then return false end

    local animationOverrides = {
        { dict = 'anim@arena@celeb@flat@paired@no_props@', clip = 'piggyback_c_player_b', flag = 33 }, -- If being piggy backed
        { dict = 'nm',                                     clip = 'firemans_carry',       flag = 33 }, -- If being carried over shoulder
        -- Add more animations here
    }

    for i = 1, #animationOverrides do
        if IsEntityPlayingAnim(cache.ped, animationOverrides[i].dict, animationOverrides[i].clip, animationOverrides[i].flag) then
            return false
        end
    end

    return true
end

function listeners.shouldProcessDeath()
    -- Prevent death from being processed upon player death.
    -- Good for paintball scripts and other TDM scripts.
    if GetResourceState('nass_paintball') == 'started' then -- Nass Paintball: https://store.nass.dev/package/6149385
        if exports.nass_paintball:inGame() then
            return false
        end
    end

    return true -- If this function returns false during death, the death will be ignored by this script.
end

function listeners.shouldProcessInjuries()
    -- Prevent injury and limp processing without tying it to deathscreen/death state behavior.
    -- Good for paintball scripts and other TDM scripts.
    if GetResourceState('nass_paintball') == 'started' then -- Nass Paintball: https://store.nass.dev/package/6149385
        if exports.nass_paintball:inGame() then
            return false
        end
    end

    return true -- If this function returns false, injuries and limp effects will be ignored by this script.
end


function listeners.shouldBlockRespawn()
    -- Prevent respawn from nui
    -- In example, if player is being carried or piggy backed, they should not be able to respawn


    if not listeners.shouldPlayDeathAnim() and IsEntityAttachedToAnyPed(cache.ped) then -- checks if player is being carried or piggy backed
        return true -- blocks respawn
    end

    return false -- allows respawn
end

---Called before requesting a hospital respawn to optionally route jailed players to a standalone facility.
---Use this for jail/prison resources that only expose client-side checks.
---Return true to use the nearest standalone facility, a facility id, or a facility name.
---@return boolean|number|string|nil standaloneFacility true/id/name to request standalone respawn, false/nil for normal respawn
function listeners.getStandaloneRespawnFacility()
    -- Example: injail state bag from wasabi_police's jail function
    if LocalPlayer.state.injail then 
        return 'Prison Clinic' -- or return true for nearest standalone facility
    end
    return false
end

---Called when the player is put inside a body bag, then again when the body bag is fully cleared.
---Example: hide custom HUD while bagged, show it again after revive or after respawning on a hospital bed.
---@param enabled boolean True = in a body bag, false = no longer in a body bag
function listeners.onBodyBagState(enabled)
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnBodyBagState', enabled)
end

---Called once after the player is placed in a body bag and the screen fades out.
---Example: send a chat message, dispatch alert, MDT call, or death announcement.
function listeners.onBodyBagAnnouncement()
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnBodyBagAnnouncement')
end

---Called before/after ambulance performs anti-cheat sensitive local player actions.
---Use this to temporarily whitelist/disable anti-cheat checks while this resource teleports,
---resurrects, freezes, hides, or makes the local player invincible.
---@param enabled boolean True while protected actions are active, false when finished
function listeners.AntiCheatState(enabled)
    if enabled then
        antiCheatStateCount += 1
        if antiCheatStateCount ~= 1 then return end
    else
        if antiCheatStateCount <= 0 then return end
        antiCheatStateCount -= 1
        if antiCheatStateCount ~= 0 then return end
    end

    TriggerEvent('wasabi_ambulance:Client:Listeners:AntiCheatState', enabled)
end

---Called when the player enters the "last stand" (downed) state
---@param deathData { cause: number?, killer: number? }? Death data with cause hash and killer server ID
function listeners.onLastStand(deathData)
    -- Add custom logic here
    -- Example: Send distress signal, update UI, etc.
    TriggerEvent('wasabi_ambulance:Client:OnLastStand', deathData)
end

---Called when the player enters the fully dead state (after last stand or instant death)
---@param deathData { cause: number?, killer: number? }? Death data with cause hash and killer server ID
function listeners.onDeath(deathData)
    -- Add custom logic here
    -- Example: Play a sound, trigger external logging, etc.
    TriggerEvent('wasabi_ambulance:Client:OnDeath', deathData)
end

---Called when the player is revived
function listeners.onRevive()
    -- Add custom logic here
    -- Example: Play animation, clear effects, etc.
    TriggerEvent('wasabi_ambulance:Client:OnRevive')
end

---Called when the player respawns at a hospital (gave up or forced respawn)
---@param facilityId number? The facility ID where the player respawned
---@param coords vector3 The respawn coordinates
function listeners.onRespawn(facilityId, coords)
    -- Add custom logic here
    -- Example: Apply respawn penalties, reset certain states, etc.
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnRespawn', facilityId, coords)
end

---Called when facility treatment is completed (healed at hospital bed)
---@param facilityId number The facility ID
---@param facilityName string The facility name
function listeners.onFacilityHeal(facilityId, facilityName)
    -- Add custom logic here
    -- Example: Log hospital visit, apply effects, etc.
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnFacilityHeal', facilityId, facilityName)
end

---Called when the player is placed on a stretcher
---@param stretcherId number The stretcher ID
---@param stretcherEntity number The stretcher entity handle
function listeners.onStretcherEnter(stretcherId, stretcherEntity)
    -- Add custom logic here
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnStretcherEnter', stretcherId, stretcherEntity)
end

---Called when the player is removed from a stretcher
---@param stretcherId number The stretcher ID
---@param stretcherEntity number The stretcher entity handle
function listeners.onStretcherExit(stretcherId, stretcherEntity)
    -- Add custom logic here
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnStretcherExit', stretcherId, stretcherEntity)
end

---Called when the injury inspection UI opens
---@param targetServerId number The server ID of the inspected player
---@param targetPed number The inspected player's ped entity handle
---@param viewOnly boolean Whether the inspection UI is read-only
function listeners.onInspectionOpen(targetServerId, targetPed, viewOnly)
    -- Add custom logic here
    -- Example: Hide custom HUD, open external medical UI, etc.
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnInspectionOpen', targetServerId, targetPed, viewOnly)
end

---Called when the injury inspection UI closes
---@param targetServerId number? The server ID of the inspected player
function listeners.onInspectionClose(targetServerId)
    -- Add custom logic here
    -- Example: Restore custom HUD, close external medical UI, etc.
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnInspectionClose', targetServerId)
end

---Called when a healing item is used on the player
---@param itemName string The item name
---@param healAmount number The amount healed
---@param healerId number? The server ID of the healer (if healed by another player)
function listeners.onHealingItemUsed(itemName, healAmount, healerId)
    -- Add custom logic here
    -- Example: Play effects, update health UI, etc.
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnHealingItemUsed', itemName, healAmount, healerId)
end

---Called when the player's injury state changes
---@param limbs table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData> Current limb injury data
function listeners.onInjuryUpdate(limbs)
    -- Add custom logic here
    -- Example: Update custom injury UI, apply movement penalties, etc.
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnInjuryUpdate', limbs)
end

---Called when a status effect changes (bleed, stun, etc.)
---@param statusType WasabiAmbulanceStatusType The status type that changed
---@param amount number The new amount (0 if removed)
---@param previousAmount number The previous amount
function listeners.onStatusChange(statusType, amount, previousAmount)
    -- Add custom logic here
    -- Example: Update bleed UI, apply screen effects, etc.
    TriggerEvent('wasabi_ambulance:Client:Listeners:OnStatusChange', statusType, amount, previousAmount)
end

Modules.register('listeners', listeners)
