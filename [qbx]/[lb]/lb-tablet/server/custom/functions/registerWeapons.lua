if not Config.MDT.AutoRegisterWeapons?.Enabled then
    return
end

local ignoreList = Config.MDT.AutoRegisterWeapons.IgnoreList or {}

Wait(1000)

---@class OxPayload
---@field inventoryId? number | string
---@field metadata table<string, any>
---@field item table<string, any>
---@field count number

---@param payload OxPayload
local function OxInventoryHook(payload)
    local item = payload.item
    local metadata = payload.metadata

    if not item.weapon or not metadata.serial then
        return
    end

    local owner

    if metadata.registered then
        local inventoryId = payload.inventoryId

        if type(inventoryId) == "number" then
            owner = GetIdentifier(inventoryId)
        end
    end

    if not owner and not Config.MDT.AutoRegisterWeapons.AddUnregistered then
        return
    end

    if contains(ignoreList, item.name) then
        debugprint("Ignoring weapon:", item.name)
        return
    end

    for mdt, _ in pairs(MDTs) do
        if GetMDTTab(mdt, "weapons") then
            RegisterWeapon(mdt, metadata.serial, {
                owner = owner,
                weaponName = item.name,
            })
        end
    end
end

if GetResourceState("ox_inventory") == "started" then
    exports.ox_inventory:registerHook("createItem", OxInventoryHook, {})
end
