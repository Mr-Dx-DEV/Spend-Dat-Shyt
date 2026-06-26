local slots = Config.MDT.EvidenceStash.Slots or 60
local weight = Config.MDT.EvidenceStash.Weight or 50000

local registeredStashes = {}

---@param mdtName string
---@param stashId string
---@param label string
local function RegisterStash(mdtName, stashId, label)
    if registeredStashes[stashId] then
        return
    end

    local mdt = MDTs[mdtName]

    if not mdt then
        return
    end

    local stashGroups = {}

    for job, permissions in pairs(mdt.defaultPermissions) do
        stashGroups[job] = permissions.stash
    end

    if GetResourceState("ox_inventory") == "started" then
        exports.ox_inventory:RegisterStash(stashId, label, slots, weight, nil, stashGroups)
    end

    debugprint("Registered stash:", stashId)

    registeredStashes[stashId] = true
end

---@param mdtName string
---@param source number
---@param stashId string
---@param label string
function OpenStash(mdtName, source, stashId, label)
    RegisterStash(mdtName, stashId, label)

    if GetResourceState("qb-inventory") == "started" then
        exports["qb-inventory"]:OpenInventory(source, stashId, {
            maxweight = weight,
            slots = slots,
            label = label
        })
    elseif GetResourceState("ps-inventory") == "started" then
        exports["ps-inventory"]:OpenInventory(source, stashId, {
            maxweight = weight,
            slots = slots,
            label = label
        })
    end

    debugprint(source .. " opened stash: " .. stashId)

    TriggerClientEvent("tablet:police:openStash", source, stashId)
end
