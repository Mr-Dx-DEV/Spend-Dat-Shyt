Config = {}

-- ============================================
-- BASIC SETTINGS
-- ============================================

-- Language for localization (cs, en)
Config.Locale = 'en'

-- Debug mode (shows detailed information in console)
Config.Debug = false

-- ============================================
-- SECURITY SETTINGS
-- ============================================

Config.Security = {
    -- 🛡️ MAIN SECURITY SYSTEM (Anti-cheat protection)
    -- true = Detects cheaters and kicks them after warnings
    -- false = No protection, allows everything (use only if buggy)
    enabled = true,
    
    -- 📢 DISCORD NOTIFICATIONS (Optional, requires webhookUrl)
    -- Works only if main security is enabled
    discord = {
        -- Enable Discord alerts when cheaters are detected
        enabled = false,
        
        -- Your Discord webhook URL (get from Discord server settings)
        webhookUrl = '', -- Example: 'https://discord.com/api/webhooks/1234567890/abcdef...'
        
        -- Role to mention (@everyone, @here, or <@&ROLE_ID>)
        mentionRole = '', -- Example: '<@&1234567890123456789>' or '@everyone'
        
        -- Custom bot appearance
        botName = 'MOON Security',
        botAvatar = 'https://cdn.discordapp.com/attachments/1415964371791646761/1423046462606020801/logo_moon.png',
    }
}

-- ============================================
-- ANIMATION AND EFFECTS
-- ============================================

Config.Animation = {
    -- Unpacking duration in ms
    duration = 2000,
    
    -- Can cancel unpacking
    canCancel = true,
    
    -- Disable use in car
    disableInCar = true,
    
    -- Character animation
    dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
    clip = 'machinic_loop_mechandplayer',
    flag = 3,
    
    -- Prop (object in hand)
    prop = {
        model = 'prop_box_ammo07b',
        pos = {x = 0.0, y = 0.7, z = -0.40},
        rot = {x = 0.00, y = 0.00, z = 90.00},
        bone = 56604
    }
}

-- ============================================
-- NOTIFICATIONS
-- ============================================

Config.Notifications = {
    -- Notification position (top-right, top-left, bottom-right, bottom-left, center)
    position = 'top-right',
    
    -- Display duration in ms
    duration = 5000,
}

-- ============================================
-- AMMO BOXES AND THEIR SETTINGS
-- ============================================

Config.AmmoBoxes = {
    ['ammo-9-box'] = {
        -- Box name in inventory
        name = 'ammo-9-box',
        
        -- Ammo type to receive
        ammoType = 'ammo-9',
        
        -- Amount of ammo
        amount = 50,
        
        -- Is box active
        enabled = true,
        
        -- Minimum player level for use (0 = no limit)
        minLevel = 0,
        
        -- Required job for use (nil = no limit)
        requiredJob = nil, -- e.g. 'police', 'mechanic'
    },
    
    ['ammo-rifle-box'] = {
        name = 'ammo-rifle-box',
        ammoType = 'ammo-rifle',
        amount = 30,
        enabled = true,
        minLevel = 0,
        requiredJob = nil,
    },
    
    ['ammo-rifle2-box'] = {
        name = 'ammo-rifle2-box',
        ammoType = 'ammo-rifle2',
        amount = 20,
        enabled = true,
        minLevel = 0,
        requiredJob = nil,
    },

    ['ammo-40-box'] = {
        name = 'ammo-40-box',
        ammoType = 'ammo-40',
        amount = 20,
        enabled = true,
        minLevel = 0,
        requiredJob = nil,
    },

    ['ammo-45-box'] = {
        name = 'ammo-45-box',
        ammoType = 'ammo-45',
        amount = 20,
        enabled = true,
        minLevel = 0,
        requiredJob = nil,
    },

    ['ammo-10-box'] = {
        name = 'ammo-10-box',
        ammoType = 'ammo-10',
        amount = 20,
        enabled = true,
        minLevel = 0,
        requiredJob = nil,
    },
    
    ['ammo-shotgun-box'] = {
        name = 'ammo-shotgun-box',
        ammoType = 'ammo-shotgun',
        amount = 10,
        enabled = true,
        minLevel = 0,
        requiredJob = nil,
    }
}

-- ============================================
-- LOCALIZATION
-- ============================================

Locales = {en}

-- ============================================
-- HELPER FUNCTIONS
-- ============================================

-- Get translation
function _L(key, ...)
    local locale = Locales[Config.Locale] or Locales['en']
    local text = locale and locale[key] or key
    
    if ... then
        return string.format(text, ...)
    end
    
    return text
end

-- Debug log
function DebugLog(message)
    if Config.Debug then
        print('[MOON-AmmoFromBoxes] ' .. message)
    end
end


