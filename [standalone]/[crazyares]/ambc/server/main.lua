local playerCooldowns = {}
local playerViolations = {}
local activeUnpacks = {}

local COOLDOWN_MS = 3000
local MAX_VIOLATIONS = 5

local function GetPlayerJob(src)
    local player = exports.qbx_core:GetPlayer(src)
    if player and player.PlayerData then
        return player.PlayerData.job and player.PlayerData.job.name or nil
    end
    return nil
end

local function SendDiscordAlert(title, message)
    local discord = Config.Security.discord
    if not discord.enabled or discord.webhookUrl == '' then return end

    PerformHttpRequest(discord.webhookUrl, function() end, 'POST', json.encode({
        username = discord.botName,
        avatar_url = discord.botAvatar,
        content = discord.mentionRole ~= '' and discord.mentionRole or nil,
        embeds = {{
            title = title,
            description = message,
            color = 16711680,
            footer = { text = os.date('%Y-%m-%d %H:%M:%S') }
        }}
    }), { ['Content-Type'] = 'application/json' })
end

local function AddViolation(src, reason)
    if not Config.Security.enabled then return end

    playerViolations[src] = (playerViolations[src] or 0) + 1
    local count = playerViolations[src]

    DebugLog(string.format(_L('debug_security_violation'), tostring(src), reason))
    DebugLog(string.format(_L('debug_violation_count'), tostring(src), count))

    if count >= MAX_VIOLATIONS then
        SendDiscordAlert('Player Kicked', string.format(_L('admin_player_kicked'), GetPlayerName(src) or src))
        DropPlayer(src, _L('security_blocked'))
    elseif count == MAX_VIOLATIONS - 1 then
        TriggerClientEvent('ox_lib:notify', src, {
            title = _L('security_title'),
            description = _L('security_final_warning'),
            type = 'error',
            position = Config.Notifications.position,
            duration = Config.Notifications.duration,
        })
    else
        TriggerClientEvent('ox_lib:notify', src, {
            title = _L('security_title'),
            description = string.format(_L('security_suspicious'), count, MAX_VIOLATIONS),
            type = 'warning',
            position = Config.Notifications.position,
            duration = Config.Notifications.duration,
        })
    end
end

local function ValidateBoxUse(src, boxName)
    local boxConfig = Config.AmmoBoxes[boxName]
    if not boxConfig then return false, 'error_no_box' end
    if not boxConfig.enabled then return false, 'error_disabled' end

    local now = GetGameTimer()
    if playerCooldowns[src] and (now - playerCooldowns[src]) < COOLDOWN_MS then
        return false, 'error_cooldown'
    end

    if boxConfig.requiredJob then
        local job = GetPlayerJob(src)
        if job ~= boxConfig.requiredJob then
            return false, 'error_wrong_job'
        end
    end

    if boxConfig.minLevel and boxConfig.minLevel > 0 then
        local player = exports.qbx_core:GetPlayer(src)
        local level = 0
        if player and player.PlayerData and player.PlayerData.metadata then
            level = player.PlayerData.metadata.level or 0
        end
        if level < boxConfig.minLevel then
            return false, 'error_low_level'
        end
    end

    local count = exports.ox_inventory:Search(src, 'count', boxName)
    if not count or count < 1 then
        return false, 'error_no_box'
    end

    return true
end

local function NotifyError(src, key)
    TriggerClientEvent('ox_lib:notify', src, {
        title = _L('error_title'),
        description = _L(key),
        type = 'error',
        position = Config.Notifications.position,
        duration = Config.Notifications.duration,
    })
end

for boxName, boxConfig in pairs(Config.AmmoBoxes) do
    if boxConfig.enabled then
        exports.qbx_core:CreateUseableItem(boxName, function(src, item)
            if activeUnpacks[src] then return end

            local valid, errorKey = ValidateBoxUse(src, boxName)
            if not valid then
                NotifyError(src, errorKey)
                return
            end

            activeUnpacks[src] = boxName
            playerCooldowns[src] = GetGameTimer()

            DebugLog(string.format(_L('debug_player_used'), tostring(src), boxName))

            TriggerClientEvent('donk-ammobox:client:useBox', src, boxName)
        end)
    end
end

RegisterNetEvent('donk-ammobox:server:finishUnpack', function(boxName, success)
    local src = source
    if not activeUnpacks[src] or activeUnpacks[src] ~= boxName then
        AddViolation(src, 'Unpack completion without active session')
        return
    end

    activeUnpacks[src] = nil
    if not success then return end

    local boxConfig = Config.AmmoBoxes[boxName]
    if not boxConfig then return end

    local count = exports.ox_inventory:Search(src, 'count', boxName)
    if not count or count < 1 then
        AddViolation(src, 'Item missing on completion')
        return
    end

    local removed = exports.ox_inventory:RemoveItem(src, boxName, 1)
    if not removed then return end

    local added = exports.ox_inventory:AddItem(src, boxConfig.ammoType, boxConfig.amount)
    if not added then
        exports.ox_inventory:AddItem(src, boxName, 1)
        NotifyError(src, 'error_no_box')
        return
    end

    TriggerClientEvent('ox_lib:notify', src, {
        title = _L('success_title'),
        description = _L('success_unpacked', tostring(boxConfig.amount)),
        type = 'success',
        position = Config.Notifications.position,
        duration = Config.Notifications.duration,
    })
end)

AddEventHandler('playerDropped', function()
    local src = source
    activeUnpacks[src] = nil
    playerCooldowns[src] = nil
    playerViolations[src] = nil
end)
