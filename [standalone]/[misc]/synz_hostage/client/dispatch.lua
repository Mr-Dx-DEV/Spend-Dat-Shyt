local function log(fmt, ...)
    if Config.Debug then
        print(("[synz_hostage][dispatch] " .. fmt):format(...))
    end
end

local function safeVec3(c)
    if type(c) == "vector3" then return c end
    if type(c) == "table" and c.x and c.y and c.z then
        return vector3(c.x + 0.0, c.y + 0.0, c.z + 0.0)
    end
    local p = GetEntityCoords(PlayerPedId())
    return vector3(p.x, p.y, p.z)
end

local function getStreetLabelAt(coords)
    local s1, s2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street1 = s1 and GetStreetNameFromHashKey(s1) or ""
    local street2 = s2 and GetStreetNameFromHashKey(s2) or ""
    if street1 == "" then return street2 end
    if street2 == "" then return street1 end
    return street1 .. " / " .. street2
end

local function cdInfo()
    local ok, data = pcall(function() return exports['cd_dispatch']:GetPlayerInfo() end)
    if ok and type(data) == "table" then return data end
    return { sex = "Person", unique_id = tostring(PlayerId()), street = getStreetLabelAt(GetEntityCoords(PlayerPedId())) }
end

-- Main dispatch function — sends alert ONLY to police dispatch systems
-- Does NOT trigger any client-side notifications
function ReB_PoliceAlert(coords, opts)
    if not Config or not Config.Dispatch or not Config.Dispatch.Enabled then return end

    local sys     = (Config.Dispatch.System or "default"):lower()
    local pos     = safeVec3(coords or GetEntityCoords(PlayerPedId()))
    local title   = (opts and opts.title) or Config.Dispatch.Title or "ASSAULT"
    local message = (opts and opts.message) or Config.Dispatch.Message or "Civilian Assault on-going"
    local jobs    = Config.Dispatch.Jobs or { 'police' }
    local street  = getStreetLabelAt(pos)
    local blip    = Config.Dispatch.Blip or {}

    log("Dispatch system: %s", sys)

    if sys == "none" then
        return

    elseif sys == "origen_police" then
        TriggerServerEvent("SendAlert:police", {
            coords  = pos,
            title   = title,
            type    = 'GENERAL',
            message = message,
            job     = 'police',
        })

    elseif sys == "cd_dispatch" then
        local data = cdInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = jobs,
            coords    = pos,
            title     = title,
            message   = message .. " - " .. (data.street or street),
            flash     = 0,
            unique_id = data.unique_id,
            sound     = 1,
            blip = {
                sprite  = blip.sprite or 431,
                scale   = blip.scale or 1.2,
                colour  = blip.colour or 3,
                flashes = blip.flashes or false,
                text    = blip.text or ('911 - ' .. title),
                time    = blip.time or 5,
                radius  = blip.radius or 0,
            }
        })

    elseif sys == "qs-dispatch" then
        pcall(function()
            exports['qs-dispatch']:CustomAlert({
                coords  = pos,
                message = title .. ' - ' .. message,
                job     = jobs,
                length  = (blip.time or 5) * 60 * 1000,
                blip = {
                    sprite  = blip.sprite or 431,
                    scale   = blip.scale or 1.2,
                    colour  = blip.colour or 3,
                    text    = blip.text or title,
                    time    = blip.time or 5,
                }
            })
        end)

    elseif sys == "ps-dispatch" then
        pcall(function()
            exports['ps-dispatch']:CustomAlert({
                coords  = pos,
                message = title .. ' - ' .. message,
                dispatchCode = '10-64',
                description  = message,
                radius  = blip.radius or 0,
                sprite  = blip.sprite or 431,
                color   = blip.colour or 3,
                scale   = blip.scale or 1.2,
                length  = blip.time or 5,
                jobs    = jobs,
            })
        end)

    elseif sys == "rcore_dispatch" then
        local rc = Config.Dispatch.RCore or {}
        TriggerServerEvent('rcore_dispatch:server:sendAlert', {
            code             = rc.code or '10-64',
            default_priority = rc.priority or 'high',
            coords           = pos,
            job              = jobs,
            text             = title,
            type             = rc.type or 'alerts',
            blip_time        = rc.blip_time or 5,
            blip = {
                sprite  = blip.sprite or 431,
                colour  = blip.colour or 3,
                scale   = blip.scale or 1.2,
                text    = blip.text or title,
                flashes = blip.flashes or false,
                radius  = blip.radius or 0,
            }
        })

    elseif sys == "sonoran_cad" then
        local postal = nil
        if Bridge.IsStarted('nearest-postal') then
            local ok2, res = pcall(function() return exports['nearest-postal']:getPostal() end)
            if ok2 then postal = res end
        end
        TriggerServerEvent('SonoranScripts::Call911', 'Bystander', street, title .. " - " .. message, postal, nil)

    elseif sys == "emergencydispatch" or sys == "emergency-dispatch" then
        pcall(function()
            TriggerServerEvent('dispatch:svNotify', {
                dispatchcodename = 'civilianassault',
                dispatchCode     = '10-64',
                firstStreet      = street,
                priority         = 2,
                origin           = { x = pos.x, y = pos.y, z = pos.z },
                dispatchMessage  = message,
                job              = jobs,
            })
        end)

    elseif sys == "default" then
        -- Server-side default: creates blip only for police players
        TriggerServerEvent('synz_hostage:server:dispatchCall', pos)

    elseif sys == "test" then
        log("TEST DISPATCH -> %s | %s @ (%.2f, %.2f, %.2f)", title, message, pos.x, pos.y, pos.z)

    else
        log("Unknown dispatch '%s', falling back to default", tostring(sys))
        TriggerServerEvent('synz_hostage:server:dispatchCall', pos)
    end
end

RegisterCommand('testdispatch', function()
    local p = GetEntityCoords(PlayerPedId())
    ReB_PoliceAlert(p, { title = Config.Dispatch.Title or "TEST", message = Config.Dispatch.Message or "Test" })
    Bridge.Client.Notify('Dispatch test sent', 'info')
end, false)

-- This event is received ONLY by police players (server filters it)
RegisterNetEvent('synz_hostage:client:policeAlert', function(coords, title, message)
    -- Create blip for the officer
    if coords then
        local blipCfg = Config.Dispatch.Blip or {}
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, blipCfg.sprite or 431)
        SetBlipScale(blip, blipCfg.scale or 1.2)
        SetBlipColour(blip, blipCfg.colour or 3)
        SetBlipAsShortRange(blip, false)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(blipCfg.text or ('911 - ' .. (title or 'ASSAULT')))
        EndTextCommandSetBlipName(blip)

        if blipCfg.flashes then SetBlipFlashes(blip, true) end

        -- Auto-remove blip
        SetTimeout((blipCfg.time or 5) * 60 * 1000, function()
            if DoesBlipExist(blip) then RemoveBlip(blip) end
        end)
    end

    Bridge.Client.Notify(message or 'Civilian Assault on-going', 'info')
end)
