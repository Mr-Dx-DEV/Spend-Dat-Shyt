--[[ Main Panel ]]

--[[ DISCLAIMER

You are responsible for the SECURITY of the functions you created.
Remember that anybody can trigger these functions with a simple hack or exploit.
Important operations should ALWAYS be validated on the server side.s

You can make a simple protection by checking if the player is on duty.
You can also use the optional `permission` parameter in RegisterAddonButton, RegisterQuickAction, RegisterQuickToggle, and RegisterAddons.

e.g. `if not IsOnDuty() then return end`
]]


RegisterAddons({
    -- Button: appears in the main panel (same as RegisterAddonButton but in bulk)
    {
        type = "button",
        name = "example_addon_button",
        label = "Warn Player",
        icon = "mdi:alert",
        color = "#f59e0b",
        -- permission = "some.permission", -- optional
        handler = function(target, callServer)
            -- target: server id of the selected player
            -- callServer: calls the server callback registered with RegisterAddonCallback (see server.lua)
            print("Warn result:", "result")
        end,
    },

    -- Offline Button: appears in the offline player management dialog
    {
        type = "offline_button",
        name = "example_offline_button",
        label = "Wipe Inventory",
        icon = "mdi:bag-personal-off",
        color = "#ef4444",
        -- permission = "some.permission", -- optional
        ---@param target OfflineAddonTarget table { charId, uniqueId, name, identifiers }
        ---@param callServer fun(...): any calls RegisterOfflineAddonCallback in server.lua
        handler = function(target, callServer)
            local result = callServer()
            print("Offline action result for", target.name, "->", result)
        end,
    },

    -- Quick Action: appears in Quick Menu > Main tab, supports options
    {
        type = "quick_action",
        name = "example_quick_action",
        label = "Heal",
        icon = "mdi:heart-pulse",
        color = "#22c55e",
        options = { "self", "player", "everyone" }, -- "player" opens a player selector dialog
        handler = function(target, option)
            -- target: server id
            -- option: the selected option string ("self", "player", or "everyone")
            print("Heal action - target:", target, "option:", option)
        end,
    },

    -- Quick Toggle: appears in Quick Menu > Toggles tab, supports options
    {
        type = "quick_toggle",
        name = "example_quick_toggle",
        label = "Speed Boost",
        icon = "mdi:speedometer",
        color = "#8b5cf6",
        options = { "1.5x", "2x", "3x" }, -- cycle with arrow keys or mouse wheel
        handler = function(option)
            -- option: the selected option string ("1.5x", "2x", "3x") or nil if no options defined
            -- Must return a boolean (the toggle state)
            print("Speed boost toggled, level:", option)
            return true
        end,
    },
})

--- Statistics

RegisterAddonStatisticBlocks({
    "test_block_1",
    "test_block_2",
    "test_block_3",
})


--- Zone Handler

--- Register a zone handler
--- The zone name must be unique and is not related to the actual zone created, this is just the handler name, it can be used by multiple zones
RegisterZoneHandler("zone_handler_unique_name", function()
    ---@param zone Zone
    local function onEnter(zone)
        print("You entered a custom zone", zone.name)
    end

    ---@param zone Zone
    local function onExit(zone)
        print("You exited a custom zone", zone.name)
    end

    ---@param zone Zone
    local function inside(zone)
        print("You are inside a custom zone", zone.name)
    end

    return {
        onEnter = onEnter,
        onExit = onExit,
        inside = inside,
    } --[[ @as ZoneHandlerReturn ]]

    --[[

    -- More info about the zone object:
    -- If you don't use some of the callbacks, you can return nil for them (recommended)

    return {
        onEnter = onEnter,
        onExit = nil,
        inside = nil,
    }

    ]]
end)




exports("isStaff", function()
    return Luxu.callbackSync("staff:isStaff")
end)
