-- ============================================================
-- rtx_notify_bridge/client.lua
-- Hooks ox_lib notify + QBX notify events -> rtx_notify
-- ============================================================

-- Type mapping: ox_lib / qbx types -> rtx_notify types
local typeMap = {
    inform   = 'info',
    info     = 'info',
    success  = 'success',
    warning  = 'warning',
    warn     = 'warning',
    error    = 'error',
    critical = 'error',
    primary  = 'info',
    dark     = 'custom',
}

local function resolveType(t)
    if not t then return 'info' end
    return typeMap[tostring(t):lower()] or 'info'
end

-- ── ox_lib: lib.notify({ title, description, type, duration }) ──
-- ox_lib fires this event internally when lib.notify() is called
AddEventHandler('ox_lib:notify', function(data)
    if type(data) ~= 'table' then return end
    local title   = data.title       or data.header or ''
    local desc    = data.description or data.message or data.body or ''
    local ntype   = resolveType(data.type)
    local duration = data.duration   or data.length or 5000
    TriggerEvent('rtx_notify:Notify', title, desc, duration, ntype)
end)

-- ── QBX / QBCore legacy notify event ──
AddEventHandler('QBCore:Notify', function(msg, ntype, duration)
    TriggerEvent('rtx_notify:Notify', '', msg or '', duration or 5000, resolveType(ntype))
end)

-- ── QBX newer notify ──
AddEventHandler('qbx:notify', function(data)
    if type(data) ~= 'table' then return end
    local title   = data.title       or ''
    local desc    = data.description or data.message or ''
    local ntype   = resolveType(data.type)
    local duration = data.duration   or 5000
    TriggerEvent('rtx_notify:Notify', title, desc, duration, ntype)
end)

-- ── chat:addMessage used as notify fallback by some resources ──
-- Only intercept single-line non-chat messages (args[1] == 'System' or similar)
AddEventHandler('chat:addMessage', function(data)
    if type(data) ~= 'table' then return end
    local args = data.args
    if not args or #args < 2 then return end
    -- Only intercept if it looks like a notification (not a player chat line)
    local tag = tostring(args[1] or ''):lower()
    if tag == 'system' or tag == 'notify' or tag == 'info' or tag == 'warning' or tag == 'error' or tag == 'success' then
        TriggerEvent('rtx_notify:Notify', args[1], args[2], 5000, resolveType(tag))
    end
end)

-- ── Override exports.ox_lib:notify so direct export calls are caught too ──
-- ox_lib exposes this via its own export; we shadow it at the event level above.
-- For resources that call exports['ox_lib']:notify() directly, ox_lib will still
-- fire the 'ox_lib:notify' event internally, so the handler above catches those too.

print('^2[rtx_notify_bridge] ^7Notify bridge active — all ox_lib/QBX notifications routed to rtx_notify')
