--[[
Planned Commands

/tp -> player and coords
/tpm -> marker
/back -> go to last position after /tp
/kill id
/kick id reason
/ban id yMdhm reason
/spawn vehicle
/giveitem id item amount
/givemoney id account amount
/setmoney id account amount
/removemoney id account amount


]]


---@type table<string, table>
local registeredCommands = {}

---@type table<string, string>
local allCommands = {}

do
    for _, command in ipairs(GetRegisteredCommands()) do
        allCommands[command.name] = command.resource
    end
end

---@param commandName string | string[]
---@param properties table | false
---@param cb function
---@param ... any
function Luxu.addCommand(commandName, properties, cb, ...)
    if not cb then return end

    local shouldSendCommands = type(properties) == "table"
    local restricted = properties and properties.restricted or false
    local params = properties and properties.params

    -- Handle group permissions
    if type(restricted) == "table" then
        for _, group in ipairs(restricted) do
            local ace = ("command.%s"):format(commandName)
            if not IsPrincipalAceAllowed(group, ace) then
                ExecuteCommand(("add_ace %s %s allow"):format(group, ace))
            end
        end
    else
        if not restricted then
            local ace = ("command.%s"):format(commandName)
            ExecuteCommand(("remove_ace builtin.everyone %s deny"):format(ace))
            ExecuteCommand(("add_ace builtin.everyone %s allow"):format(ace))
        end
    end

    -- Process parameter help text
    if params then
        for _, param in ipairs(params) do
            if param.type and param.help then
                param.help = ("%s (type: %s)"):format(param.help, param.type)
            elseif param.type then
                param.help = ("(type: %s)"):format(param.type)
            end
        end
    end

    local commands = type(commandName) == "table" and commandName or { commandName }
    local commandHandler = function(source, args, raw)
        local success, err = pcall(cb, source, args, raw)
        if not success then
            Citizen.Trace(("^1Command '%s' failed: %s^0"):format(raw:match("^(%S+)") or "unknown", err))
        end
    end

    for _, cmdName in ipairs(commands) do
        -- Check for command conflicts
        if allCommands[cmdName] and allCommands[cmdName] ~= GetCurrentResourceName() then
            --- Pre registered commands might be restricted with ace and this is incompatible with the admin menu
            Luxu.print.warning(("Command '%s' is already registered by resource '%s'"):format(cmdName,
                allCommands[cmdName]))
        end

        RegisterCommand(cmdName, commandHandler, restricted)

        if shouldSendCommands then
            local cmdProps = table.clone(properties)
            cmdProps.name = ("/%s"):format(cmdName)
            cmdProps.restricted = nil

            registeredCommands[cmdName] = cmdProps
            TriggerClientEvent('chat:addSuggestions', -1, cmdProps)
        end
    end
end

AddEventHandler("playerJoining", function()
    local player = source
    local suggestions = {}

    for _, cmdProps in pairs(registeredCommands) do
        suggestions[#suggestions + 1] = cmdProps
    end

    if #suggestions > 0 then
        TriggerClientEvent("chat:addSuggestions", player, suggestions)
    end
end)



local commands = Config.commands

local function setLastCoords(src, coords, bucket)
    exports[cache.resource]:setLastCoords(src, { x = coords.x, y = coords.y, z = coords.z })
    if bucket then
        Player(src).state:set("luxu_admin_last_bucket", bucket, true)
    end
end

---@param duration string Duration string (e.g., "1y2M3w4d5h6m" or "0"/"-1" for permanent)
---@return number|nil durationMs Duration in milliseconds, or nil if invalid
---@return table|nil result Parsed duration components {y, M, w, d, h, m}
local function parseDurationString(duration)
    if not duration then return nil, nil end

    local result = { y = 0, M = 0, w = 0, d = 0, h = 0, m = 0 }

    -- Check if duration is permanent
    if duration == "0" or duration == "-1" then
        result.y = 100 -- Permanent (100 years)
    else
        -- Pattern: (%d+) captures digits, (%a) captures the letter
        for amount, unit in duration:gmatch("(%d+)(%a)") do
            local n = tonumber(amount)

            if unit == "y" then
                result.y = n
            elseif unit == "M" then
                result.M = n
            elseif unit == "w" then
                result.w = n
            elseif unit == "d" then
                result.d = n
            elseif unit == "h" then
                result.h = n
            elseif unit == "m" then
                result.m = n
            end
        end

        -- Validate that at least one duration component is provided
        if result.y == 0 and result.M == 0 and result.w == 0 and result.d == 0 and result.h == 0 and result.m == 0 then
            return nil, nil
        end
    end

    -- Convert to milliseconds
    local durationMs = result.y * 31536000000 + result.M * 2629746000 + result.w * 604800000 + result.d * 86400000 +
        result.h * 3600000 + result.m * 60000

    return durationMs, result
end


if Config.commands.teleport_go_back.enabled then
    Luxu.addCommand(Config.commands.teleport_go_back.name, {
        help = Config.commands.teleport_go_back.description,
        restricted = false,
        params = Config.commands.teleport_go_back.params,
    }, function(src, args)
        if not HasPermission(src, "self.teleport", true, true) then return end

        local target = src
        if args[1] and GetPlayerName(args[1]) then
            target = args[1]
        end

        local lastCoords = exports[cache.resource]:getLastCoords(target)
        local lastBucket = Player(target).state.luxu_admin_last_bucket
        if not lastCoords then
            return
        end
        local currentBucket = GetPlayerRoutingBucket(tostring(target))
        if lastBucket then
            SetPlayerRoutingBucket(tostring(target), lastBucket)
        end
        local ped = GetPlayerPed(target)
        local currentCoords = GetEntityCoords(ped)
        RequestAnticheatBypass(target, 3)
        SetEntityCoords(ped, lastCoords.x, lastCoords.y, lastCoords.z, true, false, false, false)
        setLastCoords(target, currentCoords, currentBucket)
    end)
end

if Config.commands.teleport_player.enabled then
    Luxu.addCommand(Config.commands.teleport_player.name, {
        help = Config.commands.teleport_player.description,
        restricted = false,
    }, function(src, args)
        if not HasPermission(src, "self.teleport", true, true) then return end
        local ped = GetPlayerPed(src)

        local vehicle = GetVehiclePedIsIn(ped, false)
        local entity = vehicle
        if vehicle == 0 then
            entity = ped
        end

        local currentCoords = GetEntityCoords(ped)
        local currentBucket = GetPlayerRoutingBucket(tostring(src))



        RequestAnticheatBypass(src, 5)

        --- Check if first argument is a player
        local target = args[1]
        if GetPlayerName(target) and not args[2] then
            local targetPed = GetPlayerPed(target)
            local coords = GetEntityCoords(targetPed)
            local targetBucket = GetPlayerRoutingBucket(tostring(target))

            setLastCoords(src, currentCoords, targetBucket)
            SetPlayerRoutingBucket(tostring(src), targetBucket)
            SetEntityCoords(entity, coords.x, coords.y, coords.z, true, false, false, false)
            return
        end

        if args[2] and args[3] then
            local x = args[1]:gsub(",", "")
            local y = args[2]:gsub(",", "")
            local z = args[3]:gsub(",", "")

            local coords = {
                x = tonumber(x),
                y = tonumber(y),
                z = tonumber(z),
            }

            if not coords.x or not coords.y or not coords.z then
                return
            end
            setLastCoords(src, currentCoords)
            SetEntityCoords(entity, coords.x, coords.y, coords.z, true, false, false, false)
            return
        end

        local coords = ParseCoordsString(table.concat(args, " "))

        -- If we successfully extracted coordinates from either method
        if coords then
            setLastCoords(src, currentCoords)
            SetEntityCoords(entity, coords.x, coords.y, coords.z, true, false, false, false)
            if coords.w then
                SetEntityHeading(entity, coords.w)
            end
        else
            -- Handle error: Invalid coordinates format
            -- TODO: Send a notification to the player about the invalid format
            print(("Player %s provided invalid coordinates for tp: %s"):format(src, table.concat(args, " ")))
        end
    end)
end

if commands.spectate.enabled then
    Luxu.addCommand(commands.spectate.name, {
        help = commands.spectate.description,
        restricted = false,
    }, function(src, args)
        if not HasPermission(src, "player.spectate", true, true) then
            return
        end
        local target = args[1]

        if not target or target == "stop" then
            if Player(src).state["luxu_admin_is_spectating"] then
                SetPlayerRoutingBucket(src, 0);
                Luxu.triggerClientEvent("spectate:stop", src)
            end
            return
        end

        if tonumber(target) == 0 or not GetPlayerName(target) then
            Luxu.notifyPlayer(src, {
                description = Locales.player_not_found,
                type = "error",
                title = Locales.player_not_found,
                duration = 4000
            })
            return
        end

        if Player(target).state["luxu_admin_is_spectating"] then
            Luxu.notifyPlayer(src, {
                description = Locales.this_staff_member_is_currently_spectating_another_player,
                type = "error",
                title = Locales.spectating_unavailable,
                duration = 4000
            })
            return
        end
        local ped = target and GetPlayerPed(target)
        if not ped then
            return
        end
        local targetBucket = GetPlayerRoutingBucket(tostring(target))
        if GetPlayerRoutingBucket(tostring(src)) ~= targetBucket then
            SetPlayerRoutingBucket(tostring(src), targetBucket)
        end
        local coords = GetEntityCoords(ped)
        Luxu.triggerClientEvent("actions:spectate", src,
            { target = tonumber(target), coords = { x = coords.x, y = coords.y, z = coords.z } })
    end)
end

if commands.open_panel.enabled then
    Luxu.addCommand(commands.open_panel.name, {
        help = commands.open_panel.description,
        restricted = false,
    }, function(src, args)
        if not IsStaff(src) then return end
        Luxu.triggerClientEvent("commands:open_panel", src)
    end)
end

if commands.open_menu.enabled then
    Luxu.addCommand(commands.open_menu.name, {
        help = commands.open_menu.description,
        restricted = false,
    }, function(src, args)
        if not HasPermission(src, "self.quickmenu", true, true) then return end
        Luxu.triggerClientEvent("commands:open_menu", src)
    end)
end

if commands.teleport_marker.enabled then
    Luxu.addCommand(commands.teleport_marker.name, {
        help = commands.teleport_marker.description,
        restricted = false,
    }, function(src, args)
        if not HasPermission(src, "self.teleport", true, true) then return end
        local ped = GetPlayerPed(src)
        local currentCoords = GetEntityCoords(ped)
        setLastCoords(src, currentCoords)
        Luxu.triggerClientEvent("commands:tpm", src)
    end)
end

if Config.reports.enabled and commands.player_report.enabled then
    Luxu.addCommand(commands.player_report.name, {
        help = commands.player_report.description,
        restricted = false,
    }, function(src, args)
        Luxu.triggerClientEvent("commands:report", src)
    end)
end

if commands.noclip.enabled then
    Luxu.addCommand(commands.noclip.name, {
        help = commands.noclip.description,
        restricted = false,
    }, function(src, args)
        if not HasPermission(src, "self.noclip", true, true) then return end
        exports[GetCurrentResourceName()]:action("noclip", src, {
            target = src
        })
    end)
end

Luxu.addCommand("myidentifiers", {}, function(src)
    local identifiers = GetPlayerIdentifiers(src)
    for _, identifier in ipairs(identifiers) do
        if not identifier:find("ip:") then
            print(identifier)
        end
    end
end)

if commands.staff.enabled then
    Luxu.addCommand(commands.staff.name, {
        help = commands.staff.description,
        restricted = false,
    }, function(src)
        local staffOnline = exports.luxu_admin:getOnlineStaff(true)
        Luxu.triggerClientEvent("commands:staff", src, staffOnline)
    end)
end

if commands.teleport_bring_player.enabled then
    Luxu.addCommand(commands.teleport_bring_player.name, {
        help = commands.teleport_bring_player.description,
        restricted = false,
        params = commands.teleport_bring_player.params,
    }, function(src, args)
        if not HasPermission(src, "player.teleport", true, true) then return end

        local target = args[1]

        -- Validate target argument
        if not target then
            Luxu.notifyPlayer(src, {
                description = Locales.player_id,
                type = "error",
                title = "Invalid Arguments",
                duration = 4000
            })
            return
        end

        -- Check if target player exists
        if not GetPlayerName(target) then
            Luxu.notifyPlayer(src, {
                description = Locales.player_not_found,
                type = "error",
                title = Locales.player_not_found,
                duration = 4000
            })
            return
        end

        -- Call the teleport_bring_player action
        local success = exports[GetCurrentResourceName()]:action("teleport_bring_player", src, {
            target = target
        })

        if success then
            Luxu.notifyPlayer(src, {
                description = "Player brought successfully",
                type = "success",
                title = Locales.success,
                duration = 5000
            })
        else
            Luxu.notifyPlayer(src, {
                description = "Failed to bring player",
                type = "error",
                title = Locales.error,
                duration = 4000
            })
        end
    end)
end

if commands.ban.enabled then
    Luxu.addCommand(commands.ban.name, {
        help = commands.ban.description,
        restricted = false,
        params = commands.ban.params,
    }, function(src, args)
        if not HasPermission(src, "player.ban", true, true) then return end

        local playerId = args[1]
        local duration = args[2]
        local reason = table.concat(args, " ", 3)

        -- Validate required arguments
        if not playerId then
            Luxu.notifyPlayer(src, {
                description = Locales.player_id,
                type = "error",
                title = "Invalid Arguments",
                duration = 4000
            })
            return
        end

        if not reason or reason:len() < 3 then
            Luxu.notifyPlayer(src, {
                description = Locales.reason_must_be_at_least_3_characters,
                type = "error",
                title = "Invalid Reason",
                duration = 4000
            })
            return
        end

        if not duration then
            Luxu.notifyPlayer(src, {
                description = Locales.duration_format .. ": 1y2d3h4m",
                type = "error",
                title = "Invalid Duration",
                duration = 4000
            })
            return
        end

        local banDurationMs = parseDurationString(duration)
        if not banDurationMs then
            Luxu.notifyPlayer(src, {
                description = Locales.invalid_duration,
                type = "error",
                title = "Invalid Duration Format",
                duration = 4000
            })
            return
        end

        -- Check if player exists
        local targetPlayer = GetPlayerName(playerId)
        if not targetPlayer then
            Luxu.notifyPlayer(src, {
                description = Locales.player_not_found,
                type = "error",
                title = Locales.player_not_found,
                duration = 4000
            })
            return
        end

        -- Call the ban action
        local success = exports[GetCurrentResourceName()]:action("ban", src, {
            target = playerId,
            reason = reason,
            duration = banDurationMs
        })

        if success then
            Luxu.notifyPlayer(src, {
                description = Locales.player_banned_successfully,
                type = "success",
                title = Locales.success,
                duration = 5000
            })
        else
            Luxu.notifyPlayer(src, {
                description = Locales.failed_to_ban_player,
                type = "error",
                title = Locales.error,
                duration = 4000
            })
        end
    end)
end

local JAIL_ACTIVE_CONDITION =
    "((COALESCE(time_mode, 'date') = 'date' AND expires_at > UTC_TIMESTAMP()) OR (time_mode = 'playtime' AND remaining_ms > 0))"

if commands.sentence.enabled then
    Luxu.addCommand(commands.sentence.name, {
        help = commands.sentence.description,
        restricted = false,
    }, function(src)
        local target = src
        local targetName = GetPlayerName(target)

        -- Check if target is a valid player
        if not targetName then
            Luxu.notifyPlayer(src, {
                description = Locales.player_not_found,
                type = "error",
                title = Locales.player_not_found,
                duration = 4000
            })
            return
        end


        local playerObj = Luxu.player.getPlayerObject(target)
        if not playerObj then return end
        local charId = Luxu.player.getCharId(playerObj)

        -- Get jail information from database
        local jailInfo = MySQL.prepare.await(
            "SELECT *, TIMESTAMPDIFF(SECOND, '1970-01-01 00:00:00', expires_at) as expires_at, TIMESTAMPDIFF(SECOND, '1970-01-01 00:00:00', created_at) as created_at FROM luxu_admin_jail WHERE char_id = ? AND " ..
            JAIL_ACTIVE_CONDITION .. " ORDER BY id DESC LIMIT 1",
            { charId })


        if not jailInfo then
            Luxu.notifyPlayer(src, {
                description = Locales.you_are_not_currently_jailed,
                type = "error",
                title = Locales.error,
                duration = 4000
            })
            return
        end

        jailInfo.time_mode = jailInfo.time_mode == "playtime" and "playtime" or "date"
        jailInfo.expires_at = (tonumber(jailInfo.expires_at) or 0) * 1000
        jailInfo.created_at = (tonumber(jailInfo.created_at) or 0) * 1000
        jailInfo.duration_ms = tonumber(jailInfo.duration_ms) or math.max(0, jailInfo.expires_at - jailInfo.created_at)
        jailInfo.remaining_ms = math.max(0, tonumber(jailInfo.remaining_ms) or 0)

        -- Calculate remaining time
        local currentTime = os.time() * 1000 -- Convert to milliseconds
        local remainingMs = jailInfo.time_mode == "playtime" and jailInfo.remaining_ms or jailInfo.expires_at - currentTime
        local isExpired = remainingMs <= 0

        -- Send sentence information to client for display
        Luxu.triggerClientEvent("commands:showSentence", src, {
            target = target,
            targetName = targetName,
            jailInfo = jailInfo,
            remainingMs = remainingMs,
            isExpired = isExpired,
        })
    end)
end

if commands.jail and commands.jail.enabled then
    Luxu.addCommand(commands.jail.name, {
        help = commands.jail.description,
        restricted = false,
        params = commands.jail.params,
    }, function(src, args)
        if not HasPermission(src, "player.jail", true, true) then return end

        local playerId = args[1]
        local duration = args[2]
        local reason = table.concat(args, " ", 3)

        -- Validate required arguments
        if not playerId then
            Luxu.notifyPlayer(src, {
                description = Locales.player_id,
                type = "error",
                title = "Invalid Arguments",
                duration = 4000
            })
            return
        end

        if not duration then
            Luxu.notifyPlayer(src, {
                description = Locales.duration_format .. ": 1y2d3h4m",
                type = "error",
                title = "Invalid Duration",
                duration = 4000
            })
            return
        end

        if not reason or reason:len() < 3 then
            Luxu.notifyPlayer(src, {
                description = Locales.reason_must_be_at_least_3_characters,
                type = "error",
                title = "Invalid Reason",
                duration = 4000
            })
            return
        end

        local jailDurationMs = parseDurationString(duration)
        if not jailDurationMs then
            Luxu.notifyPlayer(src, {
                description = Locales.invalid_duration,
                type = "error",
                title = "Invalid Duration Format",
                duration = 4000
            })
            return
        end

        -- Check if player exists
        local targetPlayer = GetPlayerName(playerId)
        if not targetPlayer then
            Luxu.notifyPlayer(src, {
                description = Locales.player_not_found,
                type = "error",
                title = Locales.player_not_found,
                duration = 4000
            })
            return
        end

        -- Get the first jail cell from config
        local jailCell = Config.jail.jail_cells[1]
        if not jailCell then
            Luxu.notifyPlayer(src, {
                description = "No jail cells configured",
                type = "error",
                title = Locales.error,
                duration = 4000
            })
            return
        end

        -- Call the jail action
        local success = exports[GetCurrentResourceName()]:action("jail", src, {
            target = tonumber(playerId),
            reason = reason,
            duration = jailDurationMs,
            cell = jailCell.name
        })

        if success then
            Luxu.notifyPlayer(src, {
                description = Locales.player_jailed_successfully or "Player jailed successfully",
                type = "success",
                title = Locales.success,
                duration = 5000
            })
        else
            Luxu.notifyPlayer(src, {
                description = Locales.failed_to_jail_player or "Failed to jail player",
                type = "error",
                title = Locales.error,
                duration = 4000
            })
        end
    end)
end

if commands.admincar and commands.admincar.enabled then
    Luxu.addCommand(commands.admincar.name, {
        help = commands.jail.description,
        restricted = false,
    }, function(src)
        if not HasPermission(src, "self.give_vehicle") then return end

        local vehicle = GetVehiclePedIsIn(GetPlayerPed(src), false)
        if vehicle == 0 then return end

        local plate = GetVehicleNumberPlateText(vehicle)
        local response = lib.callback.await("luxu_admin:client:getVehicleMods", src, false)

        if not response then return end

        local playerObj = Luxu.player.getPlayerObject(src)
        local charId = playerObj and Luxu.player.getCharId(playerObj)
        if not charId then return end

        local result = false
        if Framework.name == "esx" then
            result = MySQL.insert.await("INSERT INTO owned_vehicles (owner,plate,vehicle) VALUES (?,?,?)",
                { charId, plate, json.encode(response.mods) })
        else
            local license = Framework.name == "qb" and GetPlayerIdentifierByType(src, "license") or
                GetPlayerIdentifierByType(src, "license2")
            result = MySQL.insert.await(
                "INSERT INTO player_vehicles (citizenid, license, plate, mods, vehicle, hash) VALUES (?,?,?,?,?,?)", {
                    charId, license, plate, json.encode(response.mods), response.model, response.hash
                })
        end

        if result then
            Luxu.notifyPlayer(src, {
                description = "Vehicle given successfully",
                type = "success",
                title = Locales.success,
                duration = 5000
            })
        else
            Luxu.notifyPlayer(src, {
                description = "Failed to give vehicle",
                type = "error",
                title = Locales.error,
                duration = 4000
            })
        end
    end)
end
