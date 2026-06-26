Config = {}


-- USE COMMAND /mail_debug_boxes to see where boxes are & COMMAND /mail_debug_clearbox to remove cooldown
Config.Debug = false  -- set to true while developing mailbox locations


-- 'ESX' or 'QBCore'
Config.Framework = 'QBCore'      -- change to 'QBCore' if needed
Config.PoliceJob = 'police'

--========================================================
--  DISPATCH / POLICE ALERT CONFIG
--========================================================
-- Types:
--  "standard"     - built-in blip + notify to police job
--  "ps-dispatch"  - uses exports from ps-dispatch
--  "cd_dispatch"  - uses cd_dispatch:AddNotification
--  "qs-dispatch"  - uses exports['qs-dispatch']
--  "core-dispatch"- uses exports['core-dispatch']
--  "custom"       - fires your own event (see CustomEvent)
Config.Dispatch = {
    Type = 'standard',  -- change to one of the options above

    -- resource names, just incase you've changed anything
    Resources = {
        ps   = 'ps-dispatch',
        cd   = 'cd_dispatch',
        qs   = 'qs-dispatch',
        core = 'core-dispatch'
    },

    -- default data used by external dispatches
    Code        = '10-66',
    Title       = 'Mail Cheque Robbery',
    Radius      = 50.0,
    Priority    = 2,

    -- Custom dispatch event when Type = "custom"
    -- args: (coords, message)
    CustomEvent = 'my_dispatch'
}

---- ### NEW - CHEAT DETECTION ENABLE SOFT IF YOU HAVE A LOT OF FALSE POSITIVES, DISABLE IF YOU DON'T NEED IT ### ----

Config.CheatDetect = 'soft' -- 'off' | 'soft' | 'on'

-- Soft-mode tuning
Config.CheatSoft = {
  StrikeWindowSeconds = 300,   -- strikes expire after 5 min
  StrikesToKick       = 4,     -- kick after 4 detections within window
  NotifyStaff         = true,  -- send message to admins/mods (chat) on detections
  PrintToConsole      = true,
}


-- Discord link why? If the script detects someone exploiting/cheating it will kick them and give them the discord link as a message
Config.DiscordLink = 'https://discord.gg/yourdiscordhere'

-- Time it takes to search a mailbox (in ms)
Config.MailboxSearchTime = 5000 -- 5 seconds

-- Default weapon if not specified per house
Config.OwnerDefaultWeapon = 'WEAPON_BAT'

-- How close you must be to interact
Config.MailboxDistance = 1.5
Config.CashInDistance  = 2.0

-- Cooldown per mailbox (seconds)
Config.MailboxCooldown = 300 -- 5 minutes

-- DEFAULT chances that cops get alerted on steal (Default holder, they're are fallbacks each mailbox now uses it's own chance)
Config.StealPoliceChance   = 0.35

-- Also default, but police multiplyer on sales can be adjusted at the bottom of the config, based on how you're selling.
Config.CashInPoliceChance  = 0.25

-- Interaction text (shown in ox_lib text UI)
Config.TextMailbox       = '[E] Steal mail cheque'
Config.TextContractBox   = '[E] Hit contract address'
Config.TextCashIn        = '[E] Cash cheques'
Config.TextLaunder       = '[E] Launder cheques'

-- Limits for anti-abuse (server side)
Config.MaxChequesPerCash = 50       -- max cheques processed per cash-in call
Config.MaxPayoutPerCash  = 200000   -- max total payout per cash-in call

-- CHEQUE TYPES (YOU CAN ADD AS MANY CHEQUES AS YOU WANT, THIS TABLE IS FOR SELLING, SO BE SURE TO INCLUDE THEM HERE FIRST)
Config.Cheques = {
    ['cheque_common'] = {
        label        = 'Fleeca Bank Low Value Cheque',
        minAmount    = 200,
        maxAmount    = 500,
        rejectChance = 0.40
    },
    ['cheque_rare'] = {
        label        = 'Union Bank Cheque',
        minAmount    = 800,
        maxAmount    = 1600,
        rejectChance = 0.35
    },
    ['cheque_blaine'] = {
        label        = 'Blaine County Cheque',
        minAmount    = 2500,
        maxAmount    = 4000,
        rejectChance = 0.15
    },
    ['cheque_ultra_rare'] = {
        label        = 'Maze Bank Cheque',
        minAmount    = 4500,
        maxAmount    = 7500,
        rejectChance = 0.15
    }
}

-- PERSONAL THEFT LIMITS
-- Example: can steal 5 mailboxes in 10 minutes; on 6th attempt they get a personal cooldown.
Config.HowManyTheftsBeforeCooldown = 5            -- how many completed mailbox steals allowed
Config.PersonalCooldownWindow      = 600          -- This is set to 10 minutes, this will stop players from looting as many mail boxes they want.
Config.PersonalCooldownTime        = 600          -- personal cooldown length in seconds


-- =========================================================
--  NORMAL WORLD MAILBOXES
-- =========================================================

-- These are the “free roam” mailboxes players can hit anytime.
-- chance values are 0.0–1.0 per mailbox.
Config.Mailboxes = {
    {
        id     = 1,
        coords = vector3(1192.3546, -602.5032, 63.9439),

        items  = {
            { item = 'cheque_common',    chance = 0.40 },
            { item = 'cheque_rare',      chance = 0.20 },
        },

        policeChance = 0.20,

        owner = {
            enabled = true,
            chance  = 0.20,
            model   = 'a_m_m_hillbilly_01',
            weapon  = 'WEAPON_BAT',
            spawn   = vector4(1203.9001, -600.1861, 68.0610, 49.8339),
        }
    },

    {
        id     = 2,
        coords = vector3(1197.8713, -629.6023, 62.8766),

        items  = {
            { item = 'cheque_common',    chance = 0.50 },
            { item = 'cheque_rare',      chance = 0.25 },
            { item = 'cheque_ultra_rare', chance = 0.05 },
        },

        policeChance = 0.35,

        owner = {
            enabled = true,
            chance  = 0.30,
            model   = 'a_m_y_business_01',
            weapon  = 'WEAPON_GOLFCLUB',
            spawn   = vector4(1206.6648, -621.0184, 66.4370, 28.1870),
        }
    },

    {
        id     = 3,
        coords = vector3(1207.8303, -681.0158, 60.8047),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(1219.9327, -669.4033, 63.0821, 72.2381),
        }
    },

        {
        id     = 4,
        coords = vector3(1211.4771, -698.1779, 60.1265),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(1222.9890, -696.8851, 60.8038, 75.4321),
        }
    },

        {
        id     = 5,
        coords = vector3(1216.0463, -740.7849, 58.4956),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(1229.4113, -725.6699, 60.8882, 40.3459),
        }
    },

        {
        id     = 6,
        coords = vector3(1188.9926, -560.0996, 64.4854),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(1203.9888, -558.0493, 69.4007, 203.3735),
        }
    },

        {
        id     = 7,
        coords = vector3(1261.8219, -614.6063, 68.90352),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(1251.3645, -621.5818, 69.4131, 144.0005),
        }
    },

        {
        id     = 8,
        coords = vector3(1009.2400, -733.5275, 57.7194),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(997.2404, -729.6840, 57.8157, 0.4705),
        }
    },

        {
        id     = 9,
        coords = vector3(985.9583, -711.5015, 58.0188),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(978.8920, -715.8887, 58.2206, 62.5966),
        }
    },

        {
        id     = 10,
        coords = vector3(973.8575, -681.1406, 57.4117),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(970.8279, -701.3708, 58.4819, 314.5411),
        }
    },

        {
        id     = 11,
        coords = vector3(961.7432, -657.3690, 57.4448),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(960.0688, -669.9741, 58.4497, 21.6363),
        }
    },

        {
        id     = 12,
        coords = vector3(957.6321, -651.9505, 57.4503),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(943.5224, -653.2483, 58.4293, 3.4329),
        }
    },

        {
        id     = 13,
        coords = vector3(971.3987, -631.8173, 57.4672),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(980.3248, -627.5748, 59.2358, 141.7870),
        }
    },

        {
        id     = 14,
        coords = vector3(934.2829, -624.9318, 57.4599),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(928.9445, -639.6954, 58.2425, 241.2160),
        }
    },


        {
        id     = 15,
        coords = vector3(919.5288, -614.2782, 57.5353),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(903.3043, -615.4002, 58.4534, 249.8044),
        }
    },

        {
        id     = 16,
        coords = vector3(894.6475, -595.8179, 57.3660),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(886.9557, -608.3317, 58.4437, 44.8273),
        }
    },

        {
        id     = 17,
        coords = vector3(868.6906, -577.3442, 57.3481),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(861.9568, -583.5502, 58.1565, 355.0422),
        }
    },

        {
        id     = 18,
        coords = vector3(859.4607, -561.2838, 57.3338),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(844.1200, -563.2087, 57.8339, 233.2514),
        }
    },

        {
        id     = 19,
        coords = vector3(859.6240, -532.1024, 57.3353),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(850.2631, -532.8565, 57.9255, 206.7637),
        }
    },

        {
        id     = 20,
        coords = vector3(867.6277, -518.3376, 57.330),

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_rare',      chance = 0.30 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(861.5582, -508.9820, 57.7222, 280.7989),
        }
    },
}

-- =========================================================
--  CONTRACT-ONLY MAILBOXES
-- =========================================================

-- These *do not* show up as normal mailboxes.
-- Only used when a contract references them.
Config.ContractMailboxes = {
    {
        id     = 101, -- must be unique
        coords = vector3(1359.8099, -1546.8047, 54.8866), -- example contract address 1

        items  = {
            { item = 'cheque_common',    chance = 0.50 },
            { item = 'cheque_blaine',      chance = 0.35 },
            { item = 'cheque_ultra_rare', chance = 0.10 },
        },

        policeChance = 0.45,

        owner = {
            enabled = true,
            chance  = 0.40,
            model   = 'a_m_m_business_01',
            weapon  = 'WEAPON_BAT',
            spawn   = vector4(1360.4836, -1555.8956, 56.3415, 13.6415),
        }
    },
    {
        id     = 102,
        coords = vector3(803.3394, -169.7286, 72.8811), -- example contract address 2

        items  = {
            { item = 'cheque_common',    chance = 0.40 },
            { item = 'cheque_blaine',      chance = 0.40 },
            { item = 'cheque_ultra_rare', chance = 0.15 },
        },

        policeChance = 0.50,

        owner = {
            enabled = true,
            chance  = 0.45,
            model   = 'a_m_m_eastsa_01',
            weapon  = 'WEAPON_CROWBAR',
            spawn   = vector4(808.7288, -163.5874, 75.8798, 148.4763),
        }
    },
    {
        id     = 103,
        coords = vector3(1068.0012, -384.9289, 67.1503), -- example contract address 3

        items  = {
            { item = 'cheque_common',    chance = 0.30 },
            { item = 'cheque_blaine',      chance = 0.40 },
            { item = 'cheque_ultra_rare', chance = 0.20 },
        },

        policeChance = 0.55,

        owner = {
            enabled = true,
            chance  = 0.50,
            model   = 'a_m_m_genfat_02',
            weapon  = 'WEAPON_BAT',
            spawn   = vector4(1060.4116, -378.3178, 68.2312, 227.5850),
        }
    },
}

-- =========================================================
--  CASH-IN LOCATIONS (bank + launderer with NPC)
-- =========================================================

Config.CashInLocations = {
    {
        id         = 1,
        coords     = vector3(147.3239, -1039.8588, 29.3777),
        label      = 'Legion Square Bank',
        type       = 'bank',
        isShady    = false,
        payoutCut  = 1.0,
        policeMult = 1.0,
        rejectMult = 1.0,
    },
    {
        id         = 2,
        coords     = vector3(304.0738, -1236.3647, 29.6241),
        label      = 'Back Alley Launderer',
        type       = 'launder',
        isShady    = true,
        payoutCut  = 0.8,
        policeMult = 0.4,
        rejectMult = 0.5,

        npc = {
            model        = 's_m_y_dealer_01',
            spawn        = vector4(304.0738, -1236.3647, 29.6241, 359.9175),
            idleScenario = 'WORLD_HUMAN_DRUG_DEALER'
        }
    }
}

-- =========================================================
--  MAIL HEIST CONTRACTS
-- =========================================================

Config.ContractMaxActivePerPlayer = 1

-- timeLimit in seconds, cooldown in seconds, bonusCashMin/Max in $
-- mailboxIds reference IDs in Config.ContractMailboxes
Config.Contracts = {
    {
        id            = 1,
        label         = 'Courier’s Nightmare',
        description   = 'Hit all three marked addresses before the courier arrives.',
        mailboxIds    = { 101, 102, 103 },   -- CONTRACT mailboxes, not normal ones
        timeLimit     = 600,                 -- 10 minutes
        cooldown      = 1800,                -- 30 minutes server-wide
    },
    -- you can add more contracts referring to other contract mailbox IDs |  BESURE TO ADD MORE CONTRACT LOCATIONS
}

-- Time police blip stays on map (seconds)
Config.PoliceBlipTime = 60

-- Blip settings for cops
Config.PoliceBlipSprite = 161
Config.PoliceBlipScale  = 1.2
Config.PoliceBlipText   = 'Suspicious Mail Activity'
