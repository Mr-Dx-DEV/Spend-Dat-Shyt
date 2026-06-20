--[[
    INVENTORY / WEAPON RESTRICTIONS
    Customize how weapons are disabled and re-enabled inside community service zones.

    CustomDisableWeapons(ped) is called every frame while the player is inside any zone.
    CustomEnableWeapons() is called once when the player leaves the zone.

    Default: ox_inventory state bag + force unarmed + disable fire controls
    You can replace this with whatever inventory system your server uses.

    Examples:
        -- ox_inventory (default)
        LocalPlayer.state:set('canUseWeapons', false, true)

        -- qb-inventory
        TriggerEvent('inventory:client:SetWeaponDisabled', true)

        -- qs-inventory
        exports['qs-inventory']:SetWeaponDisabled(true)

        -- codem-inventory
        exports['codem-inventory']:disableWeapons(true)

        -- No inventory integration (just force unarmed via GTA natives)
        -- Remove the ox_inventory lines and keep only the native controls below
]]

function CustomDisableWeapons(ped)
    -- Inventory integration: tell your inventory to block weapons
    if GetResourceState('ox_inventory') == 'started' then
        LocalPlayer.state:set('canUseWeapons', false, true)
    end

    -- Force player unarmed
    local currentWeapon = GetSelectedPedWeapon(ped)
    if currentWeapon ~= `WEAPON_UNARMED` then
        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    end

    -- Disable fire/aim controls
    DisablePlayerFiring(ped, true)
    DisableControlAction(0, 24, true)  -- Attack
    DisableControlAction(0, 25, true)  -- Aim
    DisableControlAction(0, 37, true)  -- Select Weapon
end

function CustomEnableWeapons()
    -- Re-enable weapons when leaving the zone
    if GetResourceState('ox_inventory') == 'started' then
        LocalPlayer.state:set('canUseWeapons', true, true)
    end
end
