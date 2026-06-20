Config = {}

-- ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
-- ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
-- █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
-- ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
-- ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
local frameworkAutoFind = function()
    if GetResourceState('es_extended') ~= 'missing' then
        return "ESX"
    elseif GetResourceState('qb-core') ~= 'missing' then
        return "QB-Core"
    end
end

Config.Core = frameworkAutoFind()
Config.CoreExport = function()
    if Config.Core == "ESX" then
        return exports['es_extended']:getSharedObject()
    elseif Config.Core == "QB-Core" then
        return exports['qb-core']:GetCoreObject()
    end
end

-- @PlayerLoaded:  ESX: "esx:playerLoaded" / QB-Core: "QBCore:Client:OnPlayerLoaded"
Config.PlayerLoaded = Config.Core == "ESX" and "esx:playerLoaded" or "QBCore:Client:OnPlayerLoaded"  

-- @PlayerLogoutServer: ESX: "esx:playerDropped" / QB-Core: "QBCore:Server:OnPlayerUnload"
Config.PlayerLogoutServer = Config.Core == "ESX" and "esx:playerDropped" or "QBCore:Server:OnPlayerUnload"

-- @PlayerSetJob:  ESX: "esx:setJob" / QB-Core: "QBCore:Client:OnJobUpdate"
Config.PlayerSetJob = Config.Core == "ESX" and "esx:setJob" or "QBCore:Client:OnJobUpdate"



-- ███╗   ███╗ █████╗ ██╗███╗   ██╗    ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
-- ████╗ ████║██╔══██╗██║████╗  ██║    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
-- ██╔████╔██║███████║██║██╔██╗ ██║    ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
-- ██║╚██╔╝██║██╔══██║██║██║╚██╗██║    ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
-- ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝    ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
---@field Debug boolean: 
Config.Debug = true

---@field DefaultRoutingBucket boolean: Routing bucket in which every player is, the default is 0
Config.DefaultRoutingBucket = 0

---@field UseProgressbar boolean: If you want to use a progress bar for part installation, you can do so below.
Config.UseProgressBar = true

---@field UseTarget boolean: Do you want to use target system
Config.UseTarget = false
Config.TargetResource = 'ox_target' -- 'ox_target' / 'qb-target'

---@field KeyToAccess number: 
Config.KeyToAccess = 38 -- E

Config.UseMarkers = true
Config.UseText3D = false
Config.UseHelpNotify = true

---@field DrawOutlineOnLoot boolean:
Config.DrawOutlineOnLoot = false
Config.DrawOutlineOptions = {
    color = {r = 240, g = 20, b = 30, a = 20},
    shader = 0,
}

Config.LaserDetectors = {
    color = {255, 20, 20, 90}, -- r g b a
    tolerance = 0.75,
}

Config.CameraDetectors = {
    color = {255, 20, 20, 90}, -- r g b a
}

Config.Animations = {
    ['lockpick'] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 51},
    ['turning_off_electricity'] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1},
}

---@field PoliceJobs string | table: you can provide jobs as string or as table for more jobs than one: {'police', 'sheriff'}
Config.PoliceJobs = 'police'

---@field BlacklistedJobsToStartRobbery table: Jobs that can't start a house robbery.
Config.BlacklistedJobsToStartRobbery = {'police', 'ambulance'}

---@field BuyInformationsMoneyType string: 
Config.BuyInformationsMoneyType = 'cash' -- 'cash' / 'bank' / 'black_money'

---@field SpawnLootProps boolean: 
Config.SpawnLootProps = true

---@class PoliceAlerts #  
Config.PoliceAlerts = {
    failedSaleAtPawnshop = true,
    failedLockpick = true,
    showingUpToTenant = true,
}

---@class RobberyBlip # Blip that will be for player starting the robbery
Config.RobberyBlip = {
    blipEnabled = true,
    sprite = 458,
    display = 4,
    scale = 1.25,
    color = 49,
    name = 'Robbery - %s'
}

Config.Markers = {
    ['enter'] = {
        id = 21,
        size = vec(0.3, 0.3, 0.3),
        rotation = {180.0, 0.0, 0.0},
        color = {r=240, g=60, b=100, a=80},
        bobUpAndDown = false,
        rotate = true,
        distanceToSee = 18.0,
        distanceToAccess = 1.0
    },
    ['exit'] = {
        id = 21,
        size = vec(0.3, 0.3, 0.3),
        rotation = {180.0, 0.0, 0.0},
        color = {r=240, g=60, b=100, a=80},
        bobUpAndDown = false,
        rotate = true,
        distanceToSee = 25.0,
        distanceToAccess = 1.0
    },
    ['electricity_box'] = {
        id = 20,
        size = vec(0.15, 0.15, 0.15),
        rotation = {180.0, 0.0, 0.0},
        color = {r=240, g=60, b=100, a=60},
        bobUpAndDown = false,
        rotate = true,
        distanceToSee = 5.0,
        distanceToAccess = 1.0
    },
    ['pawnshop'] = {
        id = 21,
        size = vec(0.4, 0.4, 0.4),
        rotation = {0.0, 0.0, 0.0},
        color = {r=87, g=60, b=250, a=120},
        bobUpAndDown = false,
        rotate = true,
        distanceToSee = 25.0,
        distanceToAccess = 1.5
    },
    ['fence'] = {
        id = 21,
        size = vec(0.4, 0.4, 0.4),
        rotation = {0.0, 0.0, 0.0},
        color = {r=87, g=60, b=250, a=120},
        bobUpAndDown = false,
        rotate = true,
        distanceToSee = 25.0,
        distanceToAccess = 1.5
    }
}

-- ███████╗████████╗ ██████╗ ██████╗     ██████╗  ██████╗ ██████╗ ██████╗ ███████╗██████╗ ██╗   ██╗
-- ██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗╚██╗ ██╔╝
-- ███████╗   ██║   ██║   ██║██████╔╝    ██████╔╝██║   ██║██████╔╝██████╔╝█████╗  ██████╔╝ ╚████╔╝ 
-- ╚════██║   ██║   ██║   ██║██╔═══╝     ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔══╝  ██╔══██╗  ╚██╔╝  
-- ███████║   ██║   ╚██████╔╝██║         ██║  ██║╚██████╔╝██████╔╝██████╔╝███████╗██║  ██║   ██║   
-- ╚══════╝   ╚═╝    ╚═════╝ ╚═╝         ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝   ╚═╝   
---@field StopRobbery boolean: 
Config.StopRobbery = {
    allow = true,

    isPaid = true, -- If you set it to true, the player will have to pay to cancel before the time is up
    moneyType = 'cash', -- 'cash' / 'bank' / 'black_money'
    usePricePerMinute = true, -- If you set true, then the price will depend on the missing time to completion
    
    price = 250, -- If you are using usePricePerMinute, then the price given is per minute, if you are not using usePricePerMinute, then it will be a static price that the player has to pay to finish 
}



-- ██████╗  ██████╗ ██████╗ ██████╗ ███████╗██████╗ ██╗   ██╗     ██████╗ ██████╗  ██████╗  █████╗ ███╗   ██╗██╗███████╗███████╗██████╗ 
-- ██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗╚██╗ ██╔╝    ██╔═══██╗██╔══██╗██╔════╝ ██╔══██╗████╗  ██║██║╚══███╔╝██╔════╝██╔══██╗
-- ██████╔╝██║   ██║██████╔╝██████╔╝█████╗  ██████╔╝ ╚████╔╝     ██║   ██║██████╔╝██║  ███╗███████║██╔██╗ ██║██║  ███╔╝ █████╗  ██████╔╝
-- ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔══╝  ██╔══██╗  ╚██╔╝      ██║   ██║██╔══██╗██║   ██║██╔══██║██║╚██╗██║██║ ███╔╝  ██╔══╝  ██╔══██╗
-- ██║  ██║╚██████╔╝██████╔╝██████╔╝███████╗██║  ██║   ██║       ╚██████╔╝██║  ██║╚██████╔╝██║  ██║██║ ╚████║██║███████╗███████╗██║  ██║
-- ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝   ╚═╝        ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝
---@class RobberyOrganizer # 
Config.RobberyOrganizer = {
    blip = {
        sprite = 480,
        display = 4,
        scale = 0.85,
        color = 15,
        name = 'Robbery Organizer'
    },
    localization = {
        blipEnabled = true,
        pedModel = 's_m_y_dealer_01',
        pedAnimation = {'amb@world_human_leaning@male@wall@back@foot_up@idle_a', 'idle_a'},
        coords = vector4(-1117.23, -503.08, 34.81, 296.67),
    },
}


-- ██████╗  █████╗ ██╗    ██╗███╗   ██╗███████╗██╗  ██╗ ██████╗ ██████╗ 
-- ██╔══██╗██╔══██╗██║    ██║████╗  ██║██╔════╝██║  ██║██╔═══██╗██╔══██╗
-- ██████╔╝███████║██║ █╗ ██║██╔██╗ ██║███████╗███████║██║   ██║██████╔╝
-- ██╔═══╝ ██╔══██║██║███╗██║██║╚██╗██║╚════██║██╔══██║██║   ██║██╔═══╝ 
-- ██║     ██║  ██║╚███╔███╔╝██║ ╚████║███████║██║  ██║╚██████╔╝██║     
-- ╚═╝     ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     
---@class Pawnshop # 
Config.Pawnshop = {
    receiveMoneyType = 'cash',
    chanceCallPolice = 25, -- 25% chance that an employee will realize the item is stolen and call the police.
    removeItemsOnCallPolice = true, -- Are the items to be removed, the ones he tried to sell in pawnshop when the employee was call the police?
    workingHours = nil, -- pawn shop is open 24/7
    blip = {
        sprite = 500,
        display = 4,
        scale = 0.85,
        color = 15,
        name = 'Pawn Shop'
    },
    localization = {
        blipEnabled = true,
        pedModel = 'a_m_m_polynesian_01',
        pedAnimation = {'amb@world_human_leaning@male@wall@back@foot_up@idle_a', 'idle_a'},
        coords = vector4(-1411.3, -385.72, 35.64, 276.37),
    }
}


-- ███████╗███████╗███╗   ██╗ ██████╗███████╗███████╗    ██████╗ ███████╗ █████╗ ██╗     ███████╗██████╗ 
-- ██╔════╝██╔════╝████╗  ██║██╔════╝██╔════╝██╔════╝    ██╔══██╗██╔════╝██╔══██╗██║     ██╔════╝██╔══██╗
-- █████╗  █████╗  ██╔██╗ ██║██║     █████╗  ███████╗    ██║  ██║█████╗  ███████║██║     █████╗  ██████╔╝
-- ██╔══╝  ██╔══╝  ██║╚██╗██║██║     ██╔══╝  ╚════██║    ██║  ██║██╔══╝  ██╔══██║██║     ██╔══╝  ██╔══██╗
-- ██║     ███████╗██║ ╚████║╚██████╗███████╗███████║    ██████╔╝███████╗██║  ██║███████╗███████╗██║  ██║
-- ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝╚══════╝╚══════╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝
---@class FencesDealer # 
Config.FencesDealer = {
    receiveMoneyType = 'black_money',
    blip = {
        sprite = 500,
        display = 4,
        scale = 0.85,
        color = 6,
        name = 'Fence'
    },
    localizations = {
        ['Monday'] = {
            blipEnabled = false,
            pedModel = 'g_m_y_mexgoon_02',
            pedAnimation = {'amb@world_human_leaning@male@wall@back@foot_up@idle_a', 'idle_a'},
            coords = vector4(-297.26, 6286.07, 30.49, 229.87),
        },
        ['Tuesday'] = {
            blipEnabled = false,
            pedModel = 'g_m_y_mexgoon_02',
            pedAnimation = {'anim@heists@heist_corona@team_idles@male_a', 'idle'},
            coords = vector4(1642.55, 4845.44, 44.48, 10.65),
        },
        ['Wednesday'] = {
            blipEnabled = false,
            pedModel = 'g_m_y_mexgoon_02',
            pedAnimation = {'amb@world_human_leaning@male@wall@back@foot_up@idle_a', 'idle_a'},
            coords = vector4(-2964.39, 29.2, 10.61, 244.33),
        },
        ['Thursday'] = {
            blipEnabled = true,
            pedModel = 'g_m_y_mexgoon_02',
            pedAnimation = {'amb@world_human_leaning@male@wall@back@foot_up@idle_a', 'idle_a'},
            workingHours = {
                [0] = true,
                [1] = true,
                [2] = true,
                [3] = true,
                [4] = true,
                [22] = true,
                [23] = true,
            }, -- TIME IN GAME: you will only be able to sell items at 0, 1, 2, 3, 4, 22, 23 o'clock
            coords = vector4(1134.71, -323.13, 66.15, 7.56),
        },
        ['Friday'] = {
            blipEnabled = false,
            pedModel = 'g_m_y_mexgoon_02',
            pedAnimation = {'timetable@ron@ig_5_p3', 'ig_5_p3_base'},
            coords = vector4(1097.42, -2229.05, 29.85, 177.39),
        },
        ['Saturday'] = {
            blipEnabled = true,
            pedModel = 'g_m_y_mexgoon_02',
            pedAnimation = {'timetable@ron@ig_3_couch', 'base'},
            workingHours = {
                [0] = true,
                [1] = true,
                [2] = true,
                [3] = true,
                [4] = true,
                [22] = true,
                [23] = true,
            }, -- TIME IN GAME: you will only be able to sell items at 0, 1, 2, 3, 4, 22, 23 o'clock
            coords = vector4(920.77, 3643.63, 31.95, 201.02),
        },
        ['Sunday'] = {
            blipEnabled = false,
            pedModel = 'g_m_y_mexgoon_02',
            pedAnimation = {'anim@mp_corona_idles@male_d@idle_a', 'idle_a'},
            coords = vector4(-1108.14, -1192.61, 5.68, 34.14),
        },
    },
}