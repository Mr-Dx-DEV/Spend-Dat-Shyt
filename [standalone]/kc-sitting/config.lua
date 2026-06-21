Config                              = Config or {}

-- Detection
Config.DetectWorld                  = true  -- This value determines whether the system should detect seats in the world (The default value is true)
Config.DetectProps                  = true  -- This value determines whether the system should detect seats on props (The default value is true)
Config.DetectVehicles               = false -- This value determines whether the system should detect seats on vehicles (The default value is false)
-- I would advise to not change anything in this category, I've still left those options if anyone really need to modify such things. Be aware of DetectVehicles, it doesn't work for every vehicles, thats why it's false by default!

-- Sit Down Keybind Config
Config.SitUseKeybind                = true              -- Set to true to enable keybind for sitting
Config.SitKeybindTitle              = 'Sit Anywhere'    -- Key title in GTA 5 control settings
Config.SitKeybindMapper             = 'KEYBOARD'        -- Input Mapper (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/)
Config.SitKeybindParameter          = 'J'               -- Input Parameter (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/)
Config.SitCommandName               = 'sit'             -- Command name - If you use another sitting script, change this to avoid conflicts

-- Get Up Config
Config.GetUpMethod                  = 'action_control'  -- Choose how players get up: 'keybind', 'action_control', or 'move_keys'
                                                        -- 'keybind'        - Uses keybind system
                                                        -- 'action_control' - Uses action control/control ID
                                                        -- 'move_keys'      - Uses movement keys (W, A, S, D) to get up
-- Keybind Settings (only used when GetUpMethod is 'keybind')
Config.GetUpKeybindTitle            = 'Get Up'          -- Key title in GTA 5 control settings
Config.GetUpKeybindMapper           = 'KEYBOARD'        -- Input Mapper (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/)
Config.GetUpKeybindParameter        = 'X'               -- Input Parameter (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/) - Default: X
-- Action Control Settings (only used when GetUpMethod is 'action_control')
Config.GetUpActionControlKey        = 73                -- Control ID to get up from seat (Default: 73 - X) -- https://docs.fivem.net/docs/game-references/controls/
Config.GetUpActionControlKeyName    = 'INPUT_VEH_DUCK'  -- Control name for display purposes
Config.GetUpChecks                  = {                 -- This table determines the condition that must be met for a player to get up from a seat (You can't add new condition that the default ones)
    ["Health"] = true,
    ["Ragdoll"] = true
}

-- List
Config.EnabledList = { -- This list allow you to able/disable certain sit type.
    ['Stairs'] = true,
    ['Chair'] = true,
    ['Sit'] = true,
    ['Wall'] = true,
    ['Ledge'] = true,
    ['Ground'] = true,
    ['Seat'] = true,
    ['Seat (chair)'] = true
}

-- Misc
Config.Language						= 'en'		    -- Currently Available: fr, en
Config.Debug        				= false   	    -- If you think something is not working properly, you can set 'Config.Debug' to true. It will then print a lot of debug information in your console or above radar
Config.UpdateChecker                = false         -- Set to false if you don't want to check for resource update on start (No need to change this if you're using fivem-checker)
Config.ChangeLog					= false		    -- Set to false if you don't want to display the changelog if new version is find (No need to change this if you're using fivem-checker)
Config.NotificationMode             = 'continuous'  -- 'continuous' (default - called every frame) or 'toggle' (called once to show, once to hide)

-- Custom condition to sit
function CanSit(player)
    return true -- Example: " return GetSelectedPedWeapon(player) == GetHashKey('weapon_unarmed')"
end

-- This function allows to set a custom height adjustment value
-- It can be used to fix animation positioning issues caused by certain clothing or character models (For example, high heels)
-- Do note than in certain situations, for example, sitting on the ground, the position of the player will get lifted back up as the game thinks the player is inside the ground (Related to IK)
function HeightAdjustment(player)
    return 0.0 -- GetPedDrawableVariation(player, 6) == 7 and -0.08
    -- The commented code above checks if the player's shoe model (component 6) is 7 (high heels).
    -- If true, it returns -0.08, otherwise 0.0 (no adjustment).

    -- To use this logic, you could uncomment and modify it like this:
    -- return GetPedDrawableVariation(player, 6) == 7 and -0.08 or 0.0
end

-- Notification function that supports both continuous and toggle modes
-- message: The notification text to display (or nil when hiding)
-- type: 0 = info, 1 = success, 2 = error, 3 = in progress
-- operation: 'show' or 'hide' (only provided in toggle mode)
--
-- IMPORTANT DISCLAIMER: If you use a custom notification system (anything other than DrawText2D),
-- you need to modify the locale file to properly format the "GetUpFromKey" message.
-- The default locale uses GetInputInstructionalButtonString formatting (e.g., "~INPUT_VEH_DUCK~")
-- which only works with DrawText2D. For custom notifications, change it to plain text like "Press X to stand up"
-- in your locale files (en.lua, fr.lua, etc.)
function SittingNotification(message, type, operation)
    -- Check which notification mode is configured
    if Config.NotificationMode == 'toggle' then
        -- Toggle mode: Uses show/hide operations (for systems like ox_lib)
        -- The 'operation' parameter will be either 'show' or 'hide'
        if operation == 'hide' then
            -- Hide the notification
            -- Example for ox_lib:
            -- lib.hideTextUI()

            -- Example for custom notification:
            -- TriggerEvent('myNotification:hide')
        elseif operation == 'show' and message then
            -- Show the notification
            -- Example for ox_lib:
            --[[ lib.showTextUI(message, {
                position = 'left-center',
                icon = type == 1 and 'check' or type == 2 and 'xmark' or 'chair',
                iconAnimation = type == 3 and 'pulse' or nil
            }) ]]

            -- Example for custom notification:
            -- TriggerEvent('myNotification:show', message, type)
        end
    else
        -- Continuous mode (default): Called every frame while sitting
        -- The 'operation' parameter is not used in this mode
        local ShouldBeep = {
            [0] = false,
            [1] = true,
            [2] = true,
            [3] = false
        }

        DrawText2D(message, ShouldBeep[type])
    end
end