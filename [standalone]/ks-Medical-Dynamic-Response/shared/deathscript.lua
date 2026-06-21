local DeathScriptResourceCandidates = {
    'DeathScript',
    'deathscript'
}

local function GetConfiguredDeathScriptResourceCandidates()
    if type(Config) ~= 'table' then
        return DeathScriptResourceCandidates
    end

    local configured = Config.DeathScriptResourceNames or Config.DeathScriptResourceName or Config.DeathScriptResource
    if type(configured) == 'string' and configured ~= '' then
        return { configured }
    end

    if type(configured) == 'table' and #configured > 0 then
        return configured
    end

    return DeathScriptResourceCandidates
end

function GetDeathScriptResourceName()
    for _, resourceName in ipairs(GetConfiguredDeathScriptResourceCandidates()) do
        if type(resourceName) == 'string' and resourceName ~= '' and GetResourceState(resourceName) == 'started' then
            return resourceName
        end
    end

    return nil
end

function IsDeathScriptLoaded()
    return GetDeathScriptResourceName() ~= nil
end

local function IsTruthyDeathState(value)
    if value == true then
        return true
    end

    local valueType = type(value)
    if valueType == 'number' then
        return value ~= 0
    end

    if valueType == 'string' then
        local lowered = string.lower(value)
        return lowered == 'dead'
            or lowered == 'death'
            or lowered == 'dying'
            or lowered == 'laststand'
            or lowered == 'unconscious'
            or lowered == 'incapacitated'
            or lowered == 'downed'
            or lowered == '1'
            or lowered == 'true'
    end

    if valueType == 'table' then
        local candidateKeys = {
            'dead',
            'isDead',
            'isdead',
            'is_dead',
            'death',
            'playerDead',
            'isPlayerDead',
            'inLaststand',
            'isInLaststand',
            'laststand',
            'isLaststand',
            'unconscious',
            'incapacitated',
            'downed',
            'deathScriptDead',
            'deathscriptDead',
            'deathScriptState',
            'deathstate',
            'state',
            'status'
        }

        for _, key in ipairs(candidateKeys) do
            if IsTruthyDeathState(value[key]) then
                return true
            end
        end
    end

    return false
end

local function ReadDeathScriptStateBag(serverId)
    if IsDuplicityVersion() then
        if not serverId then
            return nil
        end

        local player = Player(serverId)
        if not player or not player.state then
            return nil
        end

        local state = player.state
        local keys = {
            'dead',
            'isDead',
            'isdead',
            'is_dead',
            'death',
            'playerDead',
            'isPlayerDead',
            'inLaststand',
            'isInLaststand',
            'laststand',
            'isLaststand',
            'unconscious',
            'incapacitated',
            'downed',
            'deathScriptDead',
            'deathscriptDead',
            'deathScriptState'
        }

        for _, key in ipairs(keys) do
            if state[key] ~= nil then
                return IsTruthyDeathState(state[key])
            end
        end

        return nil
    end

    local localState = LocalPlayer and LocalPlayer.state or nil
    if not localState then
        return nil
    end

    local keys = {
        'dead',
        'isDead',
        'isdead',
        'is_dead',
        'death',
        'playerDead',
        'isPlayerDead',
        'inLaststand',
        'isInLaststand',
        'laststand',
        'isLaststand',
        'unconscious',
        'incapacitated',
        'downed',
        'deathScriptDead',
        'deathscriptDead',
        'deathScriptState'
    }

    for _, key in ipairs(keys) do
        if localState[key] ~= nil then
            return IsTruthyDeathState(localState[key])
        end
    end

    return nil
end

function IsDeathScriptPlayerDead(source)
    local resourceName = GetDeathScriptResourceName()
    if not resourceName then
        return nil
    end

    local serverId = source
    if serverId == nil and not IsDuplicityVersion() then
        serverId = GetPlayerServerId(PlayerId())
    end

    local exportHandle = exports[resourceName]
    if exportHandle then
        local exportCalls = {
            function()
                return exportHandle:isPlayerDead(serverId)
            end,
            function()
                return exportHandle:isPlayerDead()
            end,
            function()
                return exportHandle:isDead(serverId)
            end,
            function()
                return exportHandle:isDead()
            end,
            function()
                return exportHandle:IsPlayerDead(serverId)
            end,
            function()
                return exportHandle:GetDeathState(serverId)
            end
        }

        for _, callFn in ipairs(exportCalls) do
            local ok, result = pcall(callFn)
            if ok and result ~= nil then
                return IsTruthyDeathState(result)
            end
        end
    end

    local stateBagResult = ReadDeathScriptStateBag(serverId)
    if stateBagResult ~= nil then
        return stateBagResult
    end

    return nil
end

function TriggerDeathScriptRevive(targetSource)
    local resourceName = GetDeathScriptResourceName()
    if not resourceName then
        return false
    end

    local exportHandle = exports[resourceName]
    if exportHandle then
        local exportCalls = {
            function()
                if IsDuplicityVersion() then
                    return exportHandle:Revive(targetSource)
                end

                return exportHandle:Revive()
            end,
            function()
                if IsDuplicityVersion() then
                    return exportHandle:revive(targetSource)
                end

                return exportHandle:revive()
            end
        }

        for _, callFn in ipairs(exportCalls) do
            local ok = pcall(callFn)
            if ok then
                return true
            end
        end
    end

    if IsDuplicityVersion() then
        if targetSource and tonumber(targetSource) and tonumber(targetSource) > 0 then
            TriggerClientEvent('DeathScript:Admin:Revive', targetSource, 0, false)
            return true
        end

        return false
    end

    TriggerEvent('DeathScript:Admin:Revive', 0, false)
    return true
end
