Config = {}

-- ███████╗██████╗  █████╗ ███╗   ███╗███████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗
-- ██╔════╝██╔══██╗██╔══██╗████╗ ████║██╔════╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝
-- █████╗  ██████╔╝███████║██╔████╔██║█████╗  ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ 
-- ██╔══╝  ██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║   ██║██╔══██╗██╔═██╗ 
-- ██║     ██║  ██║██║  ██║██║ ╚═╝ ██║███████╗╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗
-- ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
local frameworkAutoFind = function()
    if GetResourceState('es_extended') == 'started' then
        return "ESX"
    elseif GetResourceState('qb-core') == 'started' then
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

---@field PlayerLoaded string: ESX: "esx:playerLoaded" / QB-Core: "QBCore:Client:OnPlayerLoaded"
Config.PlayerLoaded = Config.Core == "ESX" and "esx:playerLoaded" or "QBCore:Client:OnPlayerLoaded"  

---@field PlayerSetJob string: ESX: "esx:setJob" / QB-Core: "QBCore:Client:OnJobUpdate"
Config.PlayerSetJob = Config.Core == "ESX" and "esx:setJob" or "QBCore:Client:OnJobUpdate"

---@field PlayerSetGang string: ESX: "esx:setJob2" / QB-Core: "QBCore:Client:OnGangUpdate"
Config.PlayerSetGang = Config.Core == "ESX" and "esx:setJob2" or "QBCore:Client:OnGangUpdate"



-- ███╗   ███╗ █████╗ ██╗███╗   ██╗    ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
-- ████╗ ████║██╔══██╗██║████╗  ██║    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
-- ██╔████╔██║███████║██║██╔██╗ ██║    ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
-- ██║╚██╔╝██║██╔══██║██║██║╚██╗██║    ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
-- ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
-- ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝    ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
---@field AutoExecuteQuery boolean: Automatic creation of tables required for vms_cityhall
Config.AutoExecuteQuery = true

---@field Debug boolean: By running debugging, you will receive prints at various activities, in case of any problems, this will be able to help you find the cause of the misconfiguration.
Config.Debug = true

---@field ActionTimeout number: Time to block execution of actions - this blocks spamming with buttons such as withdraw etc.
Config.ActionTimeout = 3000

Config.UseMarkers = true -- Using a marker to display points
Config.UseText3D = false -- Using a 3D Text to display points
Config.UseHelpNotify = true -- Using a ESX.ShowHelpNotification (only for esx)

---@field TransactionCacheLimit number:
-- Maximum number of transactions loaded per company when the resource starts.
-- Older transactions will not be loaded into the server cache.
Config.TransactionCacheLimit = 1000

---@field UseTarget boolean: Do you want to use target system
Config.UseTarget = false
Config.TargetResource = 'ox_target' -- 'ox_target' / 'qb-target'

---@field UseOffDutyJobName boolean: Are you using a duty system that involves changing the name of the job from 'police' to 'offpolice' for example, if so, set true to display them in the employee list
Config.UseOffDutyJobName = true
Config.OffDutyJobNamePrefix = 'off' -- 'off' means that for 'police' job, it will check 'police' and 'offpolice'

---@field ClotheMerge boolean: Do you want players to be able to combine clothes in the Dressing Menu?
Config.ClotheMerge = true

---@class Marker Below you can configure the markers for each point
Config.Marker = {
    ['bossmenu'] = {
        type = 29,
        color = {0, 255, 128, 105},
        rotation = vec(0.0, 0.0, 0.0),
        scale = vec(0.33, 0.33, 0.33),
        bobUpAndDown = true,
        rotate = true,
        textureDict = nil,
        textureName = nil,
        drawOnEnts = false,
    },
    ['dressingroom'] = {
        type = 2,
        color = {0, 255, 188, 105},
        rotation = vec(0.0, 0.0, 0.0),
        scale = vec(0.12, 0.12, 0.12),
        bobUpAndDown = true,
        rotate = true,
        textureDict = nil,
        textureName = nil,
        drawOnEnts = false,
    },
}

---@class DressingAnimation
Config.DressingAnimation = {
    time = 3500,

    useScenario = false,
    scenario = 'WORLD_HUMAN_COP_IDLES',
    
    useAnimation = true,
    animation = {'clothingtie', 'try_tie_negative_a', 1},
}


------ ▄▀▀ ▄▀▄ █▄ █ █▀ █ ▄▀  █ █ █▀▄ ▄▀▄ ▀█▀ █ ▄▀▄ █▄ █
------ ▀▄▄ ▀▄▀ █ ▀█ █▀ █ ▀▄█ ▀▄█ █▀▄ █▀█  █  █ ▀▄▀ █ ▀█
---@field UseGangs boolean: Will you use the Gang Menu at all?
Config.UseGangs = true

---@field MaxLengthGradeLabel number: Maximum length of grade label that the boss can set
Config.MaxLengthGradeLabel = 50

---@field MinGradeSalary number: The minimum salary the boss must set for a grade
Config.MinGradeSalary = 20

---@field MaxGradeSalary number: The maximum salary the boss can set for a grade
Config.MaxGradeSalary = 600

Config.MenuOptions = {
    ['job'] = {
        SafeMoney = 'bank',
        SafeMoneyOnWithdrawAndDeposit = 'cash',

        AllowManageGradeLabel = true, -- ONLY FOR ESX
        AllowManageGradeSalary = true, -- ONLY FOR ESX

        AllowAnyTransfers = true,
        ShowAnnouncements = true,
    },
    ['gang'] = {
        SafeMoney = 'cash',
        SafeMoneyOnWithdrawAndDeposit = 'cash',

        AllowManageGradeLabel = false, -- ONLY FOR ESX
        AllowManageGradeSalary = false, -- ONLY FOR ESX

        AllowAnyTransfers = false,
        ShowAnnouncements = true,
    }
}

---@class BossMenus 
Config.BossMenus = {
    {
        markerData = Config.Marker['bossmenu'],
        distanceSee = 10.0,
        distanceAccess = 1.8,
        
        job = "police",
        requireOnDuty = true,

        menuCoords = vector3(448.11, -973.39, 30.69),
        targetCoords = vector4(447.17, -974.43, 30.47, 179.1), 
        targetSize = vec3(2.92, 1.6, 1.8),
    },
    {
        markerData = Config.Marker['bossmenu'],
        distanceSee = 10.0,
        distanceAccess = 1.8,
        
        job = "ambulance",
        requireOnDuty = true,

        menuCoords = vector3(311.8, -1424.58, 28.85),
        targetCoords = vector4(311.8, -1424.58, 28.85, 12.0), 
        targetSize = vec3(1.8, 1.8, 2.0),
    },
    {
        markerData = Config.Marker['bossmenu'],
        distanceSee = 10.0,
        distanceAccess = 1.8,
        
        job = "dynasty8",
        requireOnDuty = false,

        menuCoords = vector3(-719.14, -382.75, 340.64),
        targetCoords = vector4(-719.14, -382.75, 340.64, 341.45), 
        targetSize = vec3(1.8, 1.8, 2.0),
    },
    {
        markerData = Config.Marker['bossmenu'],
        distanceSee = 10.0,
        distanceAccess = 1.8,

        gang = "ballas",
        requireOnDuty = false,

        menuCoords = vector3(85.92, -1956.83, 20.75),
        targetCoords = vector4(85.75, -1957.12, 20.75, 144.71), 
        targetSize = vec3(1.8, 1.8, 2.0),
    },
}

---@class JobDressingRoom
Config.JobDressingRoom = {
    {
        markerData = Config.Marker['dressingroom'],
        distanceSee = 10.0,
        distanceAccess = 1.8,
        
        type = "job",
        job = "police",
        requireOnDuty = true,

        menuCoords = vector3(452.03, -988.04, 26.67),
        targetCoords = vector4(452.09, -988.98, 26.64, -178.12), 
        targetSize = vec3(1.8, 1.8, 2.5),
    }
}

---@class JobMenusSettings 
Config.JobMenusSettings = {
    ['police'] = {
        type = 'job',

        accountName = 'LSPD', -- if you are using another Config.Banking, adjust to your bank system
        maxEmployees = 30,
        maxPermissionsGrades = {
            ['4'] = true, -- This grade will have access to every menu option and will be the only one able to configure permissions
        },
        useBadgesSystem = true,

        allowStash = true,
        stashSettings = {
            id = 'police-bossmenu-1',
            label = 'Police Stash',
            slots = 40,
            weight = 20000,
        },

        customCSS = {
            -- ['--main-color'] = "",
            -- ['--main-color-hover'] = "",
            -- ['--main-color-active'] = "",
            -- ['--scrollbar-color'] = "",
            -- ['--scrollbar-color-hover'] = "",
            -- ['--scrollbar-background'] = "",
            -- ['--menu-shadow-before-color'] = "",
            -- ['--menu-shadow-after-color'] = "",
            -- ['--menu-background'] = "",
            -- ['--submenu-background'] = "",
            -- ['--submenu-background-selected'] = "",
        },

        useIndividualWebhooks = false,
        individualWebhooks = {
            -- ['EMPLOYEE_BONUS'] = true,
            -- ['EMPLOYEE_CHANGE_GRADE'] = true,
            -- ['EMPLOYEE_FIRE'] = true,
            -- ['EMPLOYEE_HIRE'] = true,
            -- ['UPDATE_GRADE_LABEL'] = false,
            -- ['UPDATE_GRADE_SALARY'] = false,
            -- ['UPDATE_GRADE_PERMISSIONS'] = true,
            -- ['WITHDRAW'] = true,
            -- ['DEPOSIT'] = true,
            -- ['TRANSFER'] = true,
            -- ['ANNOUNCEMENT'] = true,
            -- ['CREATED_CLOTHING'] = true,
            -- ['MODIFIED_CLOTHING'] = true,
            -- ['DELETED_CLOTHING'] = true,
        },
    },
    ['ambulance'] = {
        type = 'job',

        accountName = 'EMS', -- if you are using another Config.Banking, adjust to your bank system
        maxEmployees = 30,
        maxPermissionsGrades = {
            ['3'] = true, -- This grade will have access to every menu option and will be the only one able to configure permissions
        },
        useBadgesSystem = true,

        allowStash = true,
        stashSettings = {
            id = 'ambulance-bossmenu-1',
            label = 'Ambulance Stash',
            slots = 40,
            weight = 20000,
        },

        customCSS = {
            ['--main-color'] = "#fa3c8e",
            ['--main-color-hover'] = "#c72e75",
            ['--main-color-active'] = "#9c1556",
            ['--scrollbar-color'] = "#fa3c8e",
            ['--scrollbar-color-hover'] = "#c72e75",
            ['--scrollbar-background'] = "#0c0709fa",
            ['--menu-shadow-before-color'] = "#fa3c8ea6",
            ['--menu-shadow-after-color'] = "#c72e75b3",
            ['--menu-background'] = "#0c0709fa",
            ['--submenu-background'] = "#854d640f",
            ['--submenu-background-selected'] = "#2a24265e",
        },

        useIndividualWebhooks = false,
        individualWebhooks = {
            -- ['EMPLOYEE_BONUS'] = true,
            -- ['EMPLOYEE_CHANGE_GRADE'] = true,
            -- ['EMPLOYEE_FIRE'] = true,
            -- ['EMPLOYEE_HIRE'] = true,
            -- ['UPDATE_GRADE_LABEL'] = false,
            -- ['UPDATE_GRADE_SALARY'] = false,
            -- ['UPDATE_GRADE_PERMISSIONS'] = true,
            -- ['WITHDRAW'] = true,
            -- ['DEPOSIT'] = true,
            -- ['TRANSFER'] = true,
            -- ['ANNOUNCEMENT'] = true,
            -- ['CREATED_CLOTHING'] = true,
            -- ['MODIFIED_CLOTHING'] = true,
            -- ['DELETED_CLOTHING'] = true,
        },
    },
    ['dynasty8'] = {
        type = 'job',

        accountName = 'Dynasty 8', -- if you are using another Config.Banking, adjust to your bank system
        maxEmployees = 30,
        maxPermissionsGrades = {
            ['2'] = true, -- This grade will have access to every menu option and will be the only one able to configure permissions
        },
        useBadgesSystem = false,

        allowStash = false,

        customCSS = {},

        useIndividualWebhooks = false,
        individualWebhooks = {},
    },
    ['ballas'] = {
        type = 'gang',

        accountName = 'Ballas', -- if you are using another Config.Banking, adjust to your bank system
        maxEmployees = 50,
        maxPermissionsGrades = {
            ['1'] = true, -- This grade will have access to every menu option and will be the only one able to configure permissions
        },
        useBadgesSystem = false,

        allowStash = false,
        stashSettings = {
            id = 'ballas-bossmenu-1',
            label = 'Ballas Stash',
            slots = 30,
            weight = 25000,
        },

        customCSS = {
            ['--main-color'] = "#fa3c3c",
            ['--main-color-hover'] = "#c72e2e",
            ['--main-color-active'] = "#9c1515",
            ['--scrollbar-color'] = "#fa3c3c",
            ['--scrollbar-color-hover'] = "#c72e2e",
            ['--scrollbar-background'] = "#0c0707fa",
            ['--menu-shadow-before-color'] = "#fa3c3ca6",
            ['--menu-shadow-after-color'] = "#c72e2eb3",
            ['--menu-background'] = "#0c0707fa",
            ['--submenu-background'] = "#854d4d0f",
            ['--submenu-background-selected'] = "#2a24245e",
        },

        useIndividualWebhooks = false,
        individualWebhooks = {
            -- ['EMPLOYEE_BONUS'] = true,
            -- ['EMPLOYEE_CHANGE_GRADE'] = true,
            -- ['EMPLOYEE_FIRE'] = true,
            -- ['EMPLOYEE_HIRE'] = true,
            -- ['UPDATE_GRADE_LABEL'] = false,
            -- ['UPDATE_GRADE_SALARY'] = false,
            -- ['UPDATE_GRADE_PERMISSIONS'] = true,
            -- ['WITHDRAW'] = true,
            -- ['DEPOSIT'] = true,
            -- ['TRANSFER'] = true,
            -- ['ANNOUNCEMENT'] = true,
            -- ['CREATED_CLOTHING'] = true,
            -- ['MODIFIED_CLOTHING'] = true,
            -- ['DELETED_CLOTHING'] = true,
        },
    },
}



-- ██████╗  █████╗ ██████╗  ██████╗ ███████╗███████╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██╔════╝██╔════╝
-- ██████╔╝███████║██║  ██║██║  ███╗█████╗  ███████╗
-- ██╔══██╗██╔══██║██║  ██║██║   ██║██╔══╝  ╚════██║
-- ██████╔╝██║  ██║██████╔╝╚██████╔╝███████╗███████║
-- ╚═════╝ ╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚══════╝╚══════╝
---@param UseBadgesSystem boolean: Do you want to use the badge numbers built into vms_bossmenu?
Config.UseBadgesSystem = true

---@param BadgeOnlyNumbers number: Is the badge to consist only of numbers
Config.BadgeOnlyNumbers = true

---@param MinLengthBadge number: Minimum length of badge number
Config.MinLengthBadge = 0 -- Recommended 0 to be able to remove the badge leaving the field blank

---@param MaxLengthBadge number: Maximum length of badge number
Config.MaxLengthBadge = 3




-- ███████╗██╗  ██╗██╗███╗   ██╗███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗ 
-- ██╔════╝██║ ██╔╝██║████╗  ██║████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗
-- ███████╗█████╔╝ ██║██╔██╗ ██║██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝
-- ╚════██║██╔═██╗ ██║██║╚██╗██║██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗
-- ███████║██║  ██╗██║██║ ╚████║██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║
-- ╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝
local skinmanagerAutoFind = function()
    local skinmanagersList = {
        'rcore_clothing',
        'esx_skin',
        'fivem-appearance',
        'illenium-appearance',
        'qb-clothing',
        -- 'add_your_custom',
    }
    
    for _, skinmanagerName in ipairs(skinmanagersList) do
        if GetResourceState(skinmanagerName) == 'started' then
            return skinmanagerName
        end
    end

    return nil
end

---@field SkinManager string:
--[[
    - esx_skin
    - qb-clothing
    - fivem-appearance
    - illenium-appearance
    - rcore_clothing

    * If your skinmanger is not in the above list, it can be customized in ./client/bridge/skinmangers/ and ./server/bridge/skinmangers/
]]
Config.SkinManager = skinmanagerAutoFind()



-- ██████╗  █████╗ ██╗      █████╗ ███╗   ██╗ ██████╗███████╗
-- ██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║██╔════╝██╔════╝
-- ██████╔╝███████║██║     ███████║██╔██╗ ██║██║     █████╗  
-- ██╔══██╗██╔══██║██║     ██╔══██║██║╚██╗██║██║     ██╔══╝  
-- ██████╔╝██║  ██║███████╗██║  ██║██║ ╚████║╚██████╗███████╗
-- ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝╚══════╝
---@field Banking string: Using an external money storage system will disable the use of the entire Safe section, this means that you will not be able to make deposits, withdrawals, transfers and there will be no insight into the balance of the company
--[[
    - none: Using the built-in system for storing money, withdrawals/deposits, transfers

    - qb-banking
    - okokBanking
    - Renewed-Banking
    - tgg-banking

    * If there is no bank system listed above, you can customize it in config.server.lua (SV.getSocietyMoney, SV.addSocietyMoney, SV.removeSocietyMoney)
]]
Config.Banking = 'none'



-- ███████╗████████╗ █████╗ ███████╗██╗  ██╗
-- ██╔════╝╚══██╔══╝██╔══██╗██╔════╝██║  ██║
-- ███████╗   ██║   ███████║███████╗███████║
-- ╚════██║   ██║   ██╔══██║╚════██║██╔══██║
-- ███████║   ██║   ██║  ██║███████║██║  ██║
-- ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
local inventoryAutoFind = function()
    local inventoriesList = {
        'ox_inventory',
        'qb-inventory',
        'origen_inventory',
        'tgiann-inventory',
        -- 'add_your_custom',
    }
    
    for _, inventoryName in ipairs(inventoriesList) do
        if GetResourceState(inventoryName) == 'started' then
            return inventoryName
        end
    end

    return 'none'
end

---@field Inventory string: 
--[[
    - none: No stash at all

    - ox_inventory
    - qb-inventory
    - origen_inventory
    - tgiann-inventory

    * If there is no inventory system listed above, you can customize it in config.server.lua (CL.OpenStash, SV.registerAllStashes, SV.openStash)
]]
Config.Inventory = inventoryAutoFind()



-- ███████╗███╗   ███╗██████╗ ██╗      ██████╗ ██╗   ██╗███████╗███████╗███████╗
-- ██╔════╝████╗ ████║██╔══██╗██║     ██╔═══██╗╚██╗ ██╔╝██╔════╝██╔════╝██╔════╝
-- █████╗  ██╔████╔██║██████╔╝██║     ██║   ██║ ╚████╔╝ █████╗  █████╗  ███████╗
-- ██╔══╝  ██║╚██╔╝██║██╔═══╝ ██║     ██║   ██║  ╚██╔╝  ██╔══╝  ██╔══╝  ╚════██║
-- ███████╗██║ ╚═╝ ██║██║     ███████╗╚██████╔╝   ██║   ███████╗███████╗███████║
-- ╚══════╝╚═╝     ╚═╝╚═╝     ╚══════╝ ╚═════╝    ╚═╝   ╚══════╝╚══════╝╚══════╝
Config.RequiredJobToBeHired = 'unemployed' -- This does not apply to gangs



--- ██╗   ██╗███╗   ███╗███████╗     ██████╗██╗████████╗██╗   ██╗██╗  ██╗ █████╗ ██╗     ██╗     
--- ██║   ██║████╗ ████║██╔════╝    ██╔════╝██║╚══██╔══╝╚██╗ ██╔╝██║  ██║██╔══██╗██║     ██║     
--- ██║   ██║██╔████╔██║███████╗    ██║     ██║   ██║    ╚████╔╝ ███████║███████║██║     ██║     
--- ╚██╗ ██╔╝██║╚██╔╝██║╚════██║    ██║     ██║   ██║     ╚██╔╝  ██╔══██║██╔══██║██║     ██║     
---  ╚████╔╝ ██║ ╚═╝ ██║███████║    ╚██████╗██║   ██║      ██║   ██║  ██║██║  ██║███████╗███████╗
---   ╚═══╝  ╚═╝     ╚═╝╚══════╝     ╚═════╝╚═╝   ╚═╝      ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝
Config.VMSCityHallResource = 'vms_cityhall'
Config.UseVMSCityHall = GetResourceState(Config.VMSCityHallResource) == 'started'

---@field UseCityHallResumes boolean: If you are using vms_cityhall and using the job center section and want players to send resumes to companies, set true
Config.UseCityHallResumes = true

---@field UseCityHallTaxes boolean: If you are using vms_cityhall and you use the tax option and want companies to have to pay tax on the money they earn, set true
Config.UseCityHallTaxes = true