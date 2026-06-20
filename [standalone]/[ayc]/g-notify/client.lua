local function normalizeNotify(a, b, c, d)
    local title = 'Notification'
    local message = ''
    local duration = 5000
    local ntype = 'info'

    if type(a) == 'table' then
        title = tostring(a.title or 'Notification')
        message = tostring(a.description or a.message or a.text or a.msg or title)
        duration = tonumber(a.duration or a.time or a.length) or 5000
        ntype = tostring(a.type or a.status or 'info')
    elseif b ~= nil then
        title = tostring(a or 'Notification')
        message = tostring(b or '')
        duration = tonumber(c) or 5000
        ntype = tostring(d or 'info')
    else
        message = tostring(a or '')
    end

    return title, message, duration, ntype
end

local function SendNotify(a, b, c, d)
    local title, message, duration, ntype = normalizeNotify(a, b, c, d)

    if GetResourceState('rtx_notify') == 'started' then
        local ok = pcall(function()
            exports['rtx_notify']:Notify(title, message, duration, ntype)
        end)
        if ok then return true end

        ok = pcall(function()
            exports['rtx_notify']:sendNotification({
                title = title,
                description = message,
                message = message,
                type = ntype,
                duration = duration
            })
        end)
        if ok then return true end
    end

    -- Safe local ox_lib fallback only. Never TriggerEvent/TriggerClientEvent ox_lib:notify.
    if lib and lib.notify then
        lib.notify({ title = title, description = message, type = ntype, duration = duration })
        return true
    end

    TriggerEvent('chat:addMessage', { args = { title, message } })
    return true
end

exports('Notify', SendNotify)
exports('SendNotify', SendNotify)
exports('Notification', SendNotify)
exports('Alert', SendNotify)

RegisterNetEvent('rtx_notify_bridge:clientNotify', SendNotify)
RegisterNetEvent('g-notify:Notify', SendNotify)
RegisterNetEvent('g-notify:SendNotify', SendNotify)
