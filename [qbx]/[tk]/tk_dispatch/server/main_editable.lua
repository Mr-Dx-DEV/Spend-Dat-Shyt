function Notify(src, text, notifyType)
    if Config.NotificationType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = notifyType, text = text})
    else
        ShowNotification(src, text, notifyType)
    end
end

function Webhook(message)
    if not ConfigSV.WebhookLink or ConfigSV.WebhookLink == '' then return end

    local msg = {{["color"] = Config.WebhookColor, ["title"] = "**".. _U('webhook_title') .."**", ["description"] = message, ["footer"] = { ["text"] = os.date("%d.%m.%y Time: %X")}}}
    PerformHttpRequest(ConfigSV.WebhookLink, function(err, text, headers) end, 'POST', json.encode({embeds = msg}), { ['Content-Type'] = 'application/json' })
end

---Called when a player responds to an active call
---@param playerId number id of the player that responded to the call
---@param callData table data of the call, same as the addCall export data
function PlayerRespondedToCall(playerId, callData)

end

function GetCallsign(identifier)
    if Config.DebugMode then print('GetCallsign', identifier, GetResourceKvpString(('callsign_%s'):format(identifier))) end
    return GetResourceKvpString(('callsign_%s'):format(identifier))
end

function GetPhoneNumber(identifier)
    if Config.Phone == 'lb' then
        local phoneNumber = MySQL.Sync.fetchScalar([[
            SELECT
                phone_number
            FROM
                phone_phones
            WHERE
                id = ?
        ]], {identifier})

        return phoneNumber or _U('unknown')
    end

    if Config.Phone == 'qs' then
        local xPlayer = GetPlayerFromIdentifier(identifier)
        if not xPlayer then return _U('unknown') end

        local playerId = GetSource(xPlayer)
        return exports['qs-base']:GetPlayerPhone(playerId)
    end

    if Config.Phone == 'qs-pro' then
        return exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier, true)
    end

    if Config.Phone == 'gks' then
        local phoneNumber = MySQL.Sync.fetchScalar([[
            SELECT
                phone_number
            FROM
                gksphone_settings
            WHERE
                identifier = ?
        ]], {identifier})

        return phoneNumber
    end

    if Config.Framework == 'qb' then
        local phoneNumber = MySQL.Sync.fetchScalar([[
            SELECT
                JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.phone')) AS phone_number
            FROM
                players
            WHERE
                citizenid = ?
        ]], {identifier})

        return phoneNumber or _U('unknown')
    end

    if Config.Framework == 'esx' then
        local phoneNumber = MySQL.Sync.fetchScalar([[
            SELECT
                phone_number
            FROM
                users
            WHERE
                identifier = ?
        ]], {identifier})

        return phoneNumber or _U('unknown')
    end
end

RegisterServerEvent('cd_dispatch:AddNotification', function(data)
    exports.tk_dispatch:addCall({
        jobs = data.job_table,
        coords = data.coords,
        title = data.title,
        message = data.message,
        flash = data.flash,
        blip = data.blip,
        playSound = data.blip.sound
    })
end)

RegisterServerEvent('qs-dispatch:server:CreateDispatchCall', function(data)
    exports.tk_dispatch:addCall({
        jobs = data.job,
        coords = data.callLocation,
        code = data.callCode?.code,
        title = data.blip.text,
        message = data.message,
        flash = data.flash,
        image = data.image,
        blip = data.blip,
    })
end)

RegisterServerEvent('ps-dispatch:server:notify', function(data)
    exports.tk_dispatch:addCall({
        title = data.message,
        code = data.code,
        priority = data.priority,
        coords = data.coords,
        location = data.street,
        gender = data.gender,
        weapon = data.weapon,
        direction = data.heading,
        vehicle = data.vehicle and {plate = data.plate, color = data.color, name = data.vehicle},
        jobs = data.jobs
    })
end)

RegisterCallback('tk_dispatch:getPhoneNumber', function(src, cb)
	cb(GetPhoneNumber(GetIdentifier(GetPlayerFromId(src))))
end)

local function ItemSwapped(playerId, item, amount)
    local xPlayer = GetPlayerFromId(playerId)
    local jobIndex = GetJobIndex(xPlayer)
    if not jobIndex then return end

    local neededItem = Config.Dispatch[jobIndex].neededItem
    if not neededItem then return end

    if item ~= neededItem then return end

    if amount > 0 then
        AddJobPlayer(playerId)
    else
        RemoveJobPlayer(playerId)
    end
end

AddEventHandler('esx:onRemoveInventoryItem', ItemSwapped)
AddEventHandler('esx:onAddInventoryItem', ItemSwapped)

if Config.Inventory == 'ox' then
    local itemFilter = {}

    for k,v in pairs(Config.Dispatch) do
        if v.neededItem then
            itemFilter[v.neededItem] = true
        end
    end

    CreateThread(function()
        exports.ox_inventory:registerHook('swapItems', function(payload)
            SetTimeout(1000, function()
                local xPlayer = GetPlayerFromId(payload.source)
                local jobIndex = GetJobIndex(xPlayer)
                if not jobIndex then return end

                local neededItem = Config.Dispatch[jobIndex].neededItem
                if not neededItem then return end

                local amount = GetItemAmount(xPlayer, neededItem)
                ItemSwapped(payload.source, neededItem, amount)
            end)
        end, {
            itemFilter = itemFilter
        })
    end)
end