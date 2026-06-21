-- ─── Target system bridge (ox_target / qb-target) ───────────────────────────
-- Auto-detects which targeting resource is running, same pattern as the
-- inventory detection in bridge/qb/server.lua.

local targetSystem = nil

if GetResourceState('ox_target') == 'started' then
    targetSystem = 'ox'
elseif GetResourceState('qb-target') == 'started' then
    targetSystem = 'qb'
end

if Config.Debug then
    print('^3[fsg_cooking]^7 Detected target system: ' .. (targetSystem or 'NONE'))
end

--- Add interaction options to a local entity.
--- Takes ox_target-style options and translates for qb-target when needed.
--- @param entity number
--- @param options table[] ox_target format: { {name, icon, label, distance, canInteract, onSelect}, ... }
function AddTargetEntity(entity, options)
    if targetSystem == 'ox' then
        exports.ox_target:addLocalEntity(entity, options)
    elseif targetSystem == 'qb' then
        local qbOptions = {}
        local maxDistance = 2.5
        for _, opt in ipairs(options) do
            if opt.distance and opt.distance > maxDistance then
                maxDistance = opt.distance
            end
            qbOptions[#qbOptions + 1] = {
                num = #qbOptions + 1,
                icon = opt.icon,
                label = opt.label,
                canInteract = opt.canInteract,
                action = opt.onSelect,
            }
        end
        exports['qb-target']:AddTargetEntity(entity, {
            options = qbOptions,
            distance = maxDistance,
        })
    end
end

--- Remove interaction options from a local entity.
--- @param entity number
--- @param optionNames? string[] specific option names to remove (ox_target only, qb-target always removes all)
function RemoveTargetEntity(entity, optionNames)
    if targetSystem == 'ox' then
        if optionNames then
            exports.ox_target:removeLocalEntity(entity, optionNames)
        else
            exports.ox_target:removeLocalEntity(entity)
        end
    elseif targetSystem == 'qb' then
        exports['qb-target']:RemoveTargetEntity(entity)
    end
end
