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

local function SendNotify(target, a, b, c, d)
    local src = tonumber(target)
    if not src or src <= 0 then return false end

    local title, message, duration, ntype = normalizeNotify(a, b, c, d)

    -- IMPORTANT: Do not trigger ox_lib:notify from the server.
    -- That event is not net-safe on newer ox_lib builds.
    TriggerClientEvent('rtx_notify_bridge:clientNotify', src, title, message, duration, ntype)
    return true
end

exports('Notify', SendNotify)
exports('SendNotify', SendNotify)
exports('Notification', SendNotify)
exports('Alert', SendNotify)
