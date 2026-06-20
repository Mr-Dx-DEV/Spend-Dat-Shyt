Config                              = Config or {}

-- Base
Config.PickUpDistance               = 1.8                   -- Distance for the player to be able to pick up an object (The default value is 1.8)
Config.AutoDelete                   = 600                   -- Time in seconds before a dropped prop is automatically deleted (The default value is 600 aka 10 minutes)
Config.PreventIfAlreadyEquipped     = true                  -- Prevent players from picking up hats/glasses if they already have one on (The default value is true)
Config.PreventItemPickupByGender    = true                  -- Prevent players from picking up items if their character's gender does not match the item's designated gender (This is a short-term solution to avoid mismatch when picking up hats/glasses due to the game having different IDs per gender) (The default value is true)
Config.CompatibilityLayer           = false                 -- Enable this if you're having any issues regarding hat/glasses in your other scripts (The default value is false)
Config.CheckForDamageDuringPickup   = true                  -- Interrupt the pickup animation if the player takes damage during the process (The default value is true)

-- Checks
Config.DropAccessories             = {                      -- This table determines the condition that must be met for a player to drop their equipped accessories (You can't add new condition that the default ones, except for the 'Bones' of "BonesShot")
    ["Meleed"] = true,
    ["HitByCar"] = {
        Enabled = true,                                     -- Enable/Disable the check for hit by car
        Measurement = 'kmh',                                -- Possibilities: 'kmh', 'mph', 'native'
        Speed = 20,                                         -- The minimum speed threshold (Set to 0 to disable the speed check)
    },
    ["BonesShot"] = {
        Enabled = true,                                     -- Enable or disable bones checking
        Bones = {31086, 24818, 24817},                      -- Example: Head = 31086, Chest Up = 24818, Chest Mid = 24817 (https://wiki.rage.mp/index.php?title=Bones)
    }
}

-- Interaction
Config.InteractionType              = 'Default'             -- 'Default' for DrawText3D method, 'Target' for Target scripts or 'Custom' to use 'custom_export.lua'
---- Default
Config.NotificationMode             = 'continuous'          -- 'continuous' (called every frame) or 'toggle' (show/hide once, for systems like ox_lib)
Config.CommandTitle                 = 'Pick up prop'        -- Key title in GTA 5 control settings
Config.CommandInputMapper           = 'KEYBOARD'            -- Input Mapper (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/)
Config.CommandInputParameter        = 'E'                   -- Input Parameter (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/)
Config.InteractionDistance          = 1.8                   -- Maximum distance to show interaction text
Config.InteractionAngle             = 10.0                  -- Separation angle (in degrees) between props
Config.MaxInteractionAngle          = 15.0                  -- Maximum angle (in degrees) between camera direction and entity direction
---- Target
Config.TargetType                   = 'ox_target'           -- The type of the target script you're using. Work with ox_target/qb-target/qtarget, even tho ox_target is recommended
Config.TargetName                   = 'ox_target'           -- The name of the target script you're using. It should be the same as above if you haven't modified anything special about your target script
Config.TargetText                   = "Pick Up"             -- The text
Config.Icon                         = 'fa-solid fa-hand'    -- The target icon from font awesome (https://fontawesome.com/icons)

-- Misc
Config.Language						= 'en'		            -- Currently Available: fr, en
Config.Debug        				= false   	            -- If you think something is not working properly, you can set 'Config.Debug' to true. It will then print a lot of debug information in your console or above radar
Config.DebugDistance        		= 12.0   	            -- Maximum distance to show debug infos
Config.UpdateChecker                = false                 -- Set to false if you don't want to check for resource update on start (No need to change this if you're using fivem-checker)
Config.ChangeLog					= false		            -- Set to false if you don't want to display the changelog if new version is find (No need to change this if you're using fivem-checker)

------------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICATION FUNCTION
------------------------------------------------------------------------------------------------------------------------------------------
-- Notification function that supports both continuous and toggle modes
-- message: The notification text to display (or nil when hiding)
-- entity: The entity being looked at (used for position in continuous mode)
-- operation: 'show' or 'hide' (only used in toggle mode)
--
-- IMPORTANT DISCLAIMER: If you use a custom notification system (anything other than AdvancedDrawText3D),
-- you need to modify the locale file to properly format the "DefaultInteractionText" message.
-- The default locale uses GetInputInstructionalButtonString formatting (e.g., "~INPUT_PICKUP~")
-- which only works with AdvancedDrawText3D. For custom notifications, change it to plain text like "Press E to pick up"
-- in your locale files (en.lua, fr.lua, etc.)
function PickupNotification(message, entity, operation)
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
                icon = 'hand'
            }) ]]

            -- Example for custom notification:
            -- TriggerEvent('myNotification:show', message)
        end
    else
        -- Continuous mode (default): Called every frame while looking at entity
        -- The 'operation' parameter is not used in this mode
        if entity and message then
            local entityCoords = GetEntityCoords(entity)
            AdvancedDrawText3D(entityCoords, message)
        end
    end
end