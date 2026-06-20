local RobberyIntelConfigFile = 'config/robbery-intel-npc.json'
local CachedRobberyIntelConfig = nil

local function trimString(value)
    return tostring(value or ''):gsub('^%s+', ''):gsub('%s+$', '')
end

local function normalizeRobberyIntelCoords(coords)
    if type(coords) ~= 'table' then
        return nil
    end

    local x = tonumber(coords.x or coords[1])
    local y = tonumber(coords.y or coords[2])
    local z = tonumber(coords.z or coords[3])
    if not x or not y or not z then
        return nil
    end

    return {
        x = x,
        y = y,
        z = z,
    }
end

local function normalizeRobberyIntelList(entries)
    local normalized = {}
    local seen = {}

    if type(entries) ~= 'table' then
        return normalized
    end

    for _, entry in ipairs(entries) do
        local robberyName = trimString(entry)
        local lookupKey = robberyName:lower()
        if robberyName ~= '' and not seen[lookupKey] then
            seen[lookupKey] = true
            normalized[#normalized + 1] = robberyName
        end
    end

    return normalized
end

function GetDefaultRobberyIntelConfig()
    return {
        enabled = false,
        pedModel = 'g_m_y_mexgoon_02',
        interactionLabel = 'Ask about robbery intel',
        coords = nil,
        heading = 0.0,
        visibleRobberies = {},
    }
end

function NormalizeRobberyIntelConfig(config)
    local defaults = GetDefaultRobberyIntelConfig()
    config = type(config) == 'table' and config or {}

    local pedModel = trimString(config.pedModel)
    if pedModel == '' then
        pedModel = defaults.pedModel
    end

    local interactionLabel = trimString(config.interactionLabel)
    if interactionLabel == '' then
        interactionLabel = defaults.interactionLabel
    end

    return {
        enabled = config.enabled == true,
        pedModel = pedModel,
        interactionLabel = interactionLabel,
        coords = normalizeRobberyIntelCoords(config.coords),
        heading = tonumber(config.heading) or defaults.heading,
        visibleRobberies = normalizeRobberyIntelList(config.visibleRobberies),
    }
end

function getRobberyIntelConfig()
    if CachedRobberyIntelConfig then
        return CachedRobberyIntelConfig
    end

    local raw = LoadResourceFile(GetCurrentResourceName(), RobberyIntelConfigFile)
    if raw and raw ~= '' then
        local ok, decoded = pcall(json.decode, raw)
        if ok and type(decoded) == 'table' then
            CachedRobberyIntelConfig = NormalizeRobberyIntelConfig(decoded)
            return CachedRobberyIntelConfig
        end
    end

    CachedRobberyIntelConfig = GetDefaultRobberyIntelConfig()
    return CachedRobberyIntelConfig
end

local function saveRobberyIntelConfig(config)
    local normalized = NormalizeRobberyIntelConfig(config)
    local encoded = json.encode(normalized)
    local didSave = SaveResourceFile(GetCurrentResourceName(), RobberyIntelConfigFile, encoded, -1)
    if not didSave then
        return false, nil
    end

    CachedRobberyIntelConfig = normalized
    return true, normalized
end

local function getRobberyCooldownStatus(robberyName)
    if type(AllRobberysCooldDownTable) ~= 'table' then
        return false, 0
    end

    local cooldownEndTime = AllRobberysCooldDownTable[robberyName]
    if not cooldownEndTime then
        return false, 0
    end

    local currentTime = os.time()
    if cooldownEndTime > currentTime then
        return true, cooldownEndTime - currentTime
    end

    AllRobberysCooldDownTable[robberyName] = nil
    return false, 0
end

local function buildRobberyIntelStatusEntries(config)
    local entries = {}
    local heistLookup = {}

    for _, heist in ipairs(getHeists() or {}) do
        local heistName = trimString(heist and heist.heist_name)
        if heistName ~= '' then
            heistLookup[heistName:lower()] = heistName
        end
    end

    for _, robberyName in ipairs(config.visibleRobberies or {}) do
        local resolvedName = heistLookup[trimString(robberyName):lower()]
        if resolvedName then
            local cooldownActive, remainingSeconds = getRobberyCooldownStatus(resolvedName)
            entries[#entries + 1] = {
                name = resolvedName,
                cooldownActive = cooldownActive,
                remainingSeconds = remainingSeconds,
            }
        end
    end

    return entries
end

Config.FrameworkFunctions.CreateCallback('Pug:server:GetRobberyIntelConfig', function(source, cb)
    cb(getRobberyIntelConfig())
end)

Config.FrameworkFunctions.CreateCallback('Pug:server:GetRobberyIntelStatus', function(source, cb)
    local config = getRobberyIntelConfig()
    cb({
        success = true,
        config = config,
        robberies = buildRobberyIntelStatusEntries(config),
    })
end)

RegisterNetEvent('Pug:server:SaveRobberyIntelConfig', function(config)
    local src = source
    local success, normalized = saveRobberyIntelConfig(config)

    if not success then
        TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.T("RobberyIntelSaveFailed"), 'error')
        return
    end

    TriggerClientEvent('Pug:client:UpdateRobberyIntelData', -1, normalized)
    TriggerClientEvent('Pug:client:ShowHeistNotify', src, Config.T("RobberyIntelSaved"), 'success')
end)
