local config = Modules.require('config')

if not config.logger or not config.logger.enabled or config.logger.type ~= 'discord' then return end

local logger = {}

function logger.init() end

local webhookUrls = {}

local colors = {
    death = 16711680,
    revive = 65280,
    respawn = 65280,
    treatment = 255,
    duty = 16776960,
    action = 8421504,
    default = 3447003,
}

local function getWebhookUrl(eventType)
    eventType = eventType or 'default'
    if webhookUrls[eventType] ~= nil then return webhookUrls[eventType] end

    local webhooks = config.logger.webhooks or config.logger.discordWebhooks or {}
    local url = webhooks[eventType] or webhooks.default or config.logger.discordWebhook

    if not url or url == '' then
        url = config.logger.discordWebhook
    end

    webhookUrls[eventType] = url or false
    return webhookUrls[eventType]
end

local function sendWebhook(eventType, title, description, color, fields, footer)
    if not config then return end

    local targetWebhook = getWebhookUrl(eventType or 'default')

    if not targetWebhook or targetWebhook == '' then
        lib.print.warn(('[Logger] Discord webhook URL is not configured for event type: %s'):format(tostring(eventType or 'default')))
        return
    end

    local embed = {
        title = title,
        description = description,
        color = color or colors.default,
        timestamp = os.date('!%Y-%m-%dT%H:%M:%SZ'),
        footer = footer and { text = footer } or { text = 'Wasabi Ambulance' },
    }

    if fields and #fields > 0 then
        embed.fields = fields
    end

    local payload = {
        username = 'Wasabi Ambulance',
        embeds = { embed }
    }

    PerformHttpRequest(targetWebhook, function(statusCode, response, headers)
        if statusCode ~= 200 and statusCode ~= 204 then
            lib.print.warn('[Logger] Discord webhook failed with status:', statusCode)
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

local function getPlayerIdentifier(source)
    if type(source) == 'number' and source > 0 then
        local name = GetPlayerName(source)
        local identifiers = {}
        for i = 0, GetNumPlayerIdentifiers(source) - 1 do
            local identifier = GetPlayerIdentifier(source, i)
            if identifier then
                if string.find(identifier, 'license:') then
                    identifiers.license = identifier
                elseif string.find(identifier, 'discord:') then
                    identifiers.discord = identifier
                elseif string.find(identifier, 'steam:') then
                    identifiers.steam = identifier
                end
            end
        end
        return string.format('%s (ID: %s)', name or 'Unknown', source)
    end
    return tostring(source)
end

function logger.log(source, event, message, ...)
    local playerInfo = getPlayerIdentifier(source)
    local title = '📋 ' .. event
    local description = message

    local fields = {
        { name = 'Player', value = playerInfo, inline = true },
    }

    sendWebhook('default', title, description, colors.default, fields)
end

function logger.logEvent(source, eventType, data)
    local playerInfo = getPlayerIdentifier(source)
    local title = '📋 ' .. string.upper(eventType)
    local description = 'Event triggered'
    local color = colors[eventType] or colors.default

    local fields = {
        { name = 'Player',     value = playerInfo, inline = true },
        { name = 'Event Type', value = eventType,  inline = true },
    }

    if data then
        for key, value in pairs(data) do
            if type(value) == 'table' then
                value = json.encode(value)
            else
                value = tostring(value)
            end
            table.insert(fields, { name = key, value = value, inline = true })
        end
    end

    sendWebhook(eventType or 'default', title, description, color, fields)
end

function logger.logDeath(source, deathData)
    local playerInfo = getPlayerIdentifier(source)
    local isDeath = deathData and deathData.state == 2
    local title = isDeath and '💀 Player Death' or '🚑 Player Last Stand'
    local description = isDeath and 'A player has died' or 'A player has gone into last stand'

    local fields = {
        { name = 'Player', value = playerInfo, inline = true },
    }

    if deathData then
        if deathData.cause then
            table.insert(fields, { name = 'Cause', value = tostring(deathData.cause), inline = true })
        end
        if deathData.killer then
            local killerInfo = getPlayerIdentifier(deathData.killer)
            table.insert(fields, { name = 'Killer', value = killerInfo, inline = true })
        end
        if deathData.coords then
            local coords = type(deathData.coords) == 'table' and deathData.coords or { x = deathData.coords.x, y = deathData.coords.y, z = deathData.coords.z }
            table.insert(fields, { name = 'Location', value = string.format('X: %.2f, Y: %.2f, Z: %.2f', coords.x or 0, coords.y or 0, coords.z or 0), inline = false })
        end
    end

    sendWebhook('death', title, description, colors.death, fields)
end

function logger.logRevive(source, reviveData)
    local playerInfo = getPlayerIdentifier(source)
    local title = '💉 Player Revive'
    local description = 'A player has been revived'

    local fields = {
        { name = 'Player', value = playerInfo, inline = true }
    }

    if reviveData then
        if reviveData.method then
            table.insert(fields, { name = 'Revive Method', value = tostring(reviveData.method), inline = true })
        end
        if reviveData.revivedBy then
            table.insert(fields, { name = 'Revived By', value = type(reviveData.revivedBy) == 'number' and getPlayerIdentifier(reviveData.revivedBy) or tostring(reviveData.revivedBy), inline = true })
        end
        if reviveData.isInBed ~= nil then
            table.insert(fields, { name = 'In Bed', value = reviveData.isInBed and 'Yes' or 'No', inline = true })
        end
        if reviveData.coords then
            local coords = reviveData.coords
            table.insert(fields, { name = 'Coordinates', value = string.format('X: %.2f, Y: %.2f, Z: %.2f', coords.x or 0, coords.y or 0, coords.z or 0), inline = false })
        end
    end

    sendWebhook('revive', title, description, colors.revive, fields)
end

function logger.logRespawn(source, respawnData)
    local playerInfo = getPlayerIdentifier(source)
    local title = '🔄 Player Respawn'
    local description = 'A player has respawned'

    local fields = {
        { name = 'Player', value = playerInfo, inline = true }
    }

    if respawnData then
        if respawnData.location then
            table.insert(fields, { name = 'Respawn Location', value = tostring(respawnData.location), inline = true })
        end
        if respawnData.method then
            table.insert(fields, { name = 'Respawn Method', value = tostring(respawnData.method), inline = true })
        end
        if respawnData.revivedBy then
            table.insert(fields, { name = 'Revived By', value = type(respawnData.revivedBy) == 'number' and getPlayerIdentifier(respawnData.revivedBy) or tostring(respawnData.revivedBy), inline = true })
        end
        if respawnData.itemsWiped ~= nil then
            table.insert(fields, { name = 'Items Wiped', value = respawnData.itemsWiped and 'Yes' or 'No', inline = true })
        end
        if respawnData.coords then
            local coords = respawnData.coords
            table.insert(fields, { name = 'Coordinates', value = string.format('X: %.2f, Y: %.2f, Z: %.2f', coords.x or 0, coords.y or 0, coords.z or 0), inline = false })
        end
    end

    sendWebhook('respawn', title, description, colors.respawn, fields)
end

function logger.logTreatment(source, targetSource, treatmentData)
    local medicInfo = getPlayerIdentifier(source)
    local patientInfo = getPlayerIdentifier(targetSource)
    local title = '🏥 Medical Treatment'
    local description = 'A player received medical treatment'

    local fields = {
        { name = 'Medic',   value = medicInfo,   inline = true },
        { name = 'Patient', value = patientInfo, inline = true },
    }

    if treatmentData then
        if treatmentData.type then
            table.insert(fields, { name = 'Treatment Type', value = tostring(treatmentData.type), inline = true })
        end
        if treatmentData.item then
            table.insert(fields, { name = 'Item Used', value = tostring(treatmentData.item), inline = true })
        end
        if treatmentData.healAmount then
            table.insert(fields, { name = 'Heal Amount', value = tostring(treatmentData.healAmount), inline = true })
        end
    end

    sendWebhook('treatment', title, description, colors.treatment, fields)
end

function logger.logDuty(source, onDuty)
    local playerInfo = getPlayerIdentifier(source)
    local title = onDuty and '🟢 On Duty' or '🔴 Off Duty'
    local description = 'Player duty status changed'

    local fields = {
        { name = 'Player', value = playerInfo,                         inline = true },
        { name = 'Status', value = onDuty and 'On Duty' or 'Off Duty', inline = true },
    }

    sendWebhook('duty', title, description, colors.duty, fields)
end

function logger.logAction(source, action, data)
    local playerInfo = getPlayerIdentifier(source)
    local title = '⚡ ' .. action
    local description = 'Player action logged'

    local fields = {
        { name = 'Player', value = playerInfo, inline = true },
        { name = 'Action', value = action,     inline = true },
    }

    if data then
        for key, value in pairs(data) do
            if type(value) == 'table' then
                value = json.encode(value)
            else
                value = tostring(value)
            end
            table.insert(fields, { name = key, value = value, inline = true })
        end
    end

    sendWebhook('action', title, description, colors.action, fields)
end

Modules.register('logger', logger, {
    dependencies = { 'config' }
})
