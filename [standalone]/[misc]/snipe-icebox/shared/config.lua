-----------------For support, scripts, and more----------------
--------------- https://discord.gg/VGYkkAYVv2  -------------
---------------------------------------------------------------

-- if you have renamed your qb-core, es_extended, event names, make sure to change them. Based on this information your framework will be detected.
Config.FrameworkTriggers = {
    ["qb"] = {
        ResourceName = "qb-core",
        PlayerLoaded = "QBCore:Client:OnPlayerLoaded",
        PlayerUnload = "QBCore:Client:OnPlayerUnload",
        OnJobUpdate = "QBCore:Client:OnJobUpdate",
    },
    ["esx"] = {
        ResourceName = "es_extended",
        PlayerLoaded = "esx:playerLoaded",
        PlayerUnload = "esx:playerDropped",
        OnJobUpdate = "esx:setJob",
    }
}

Config.Inventory = "ox" -- ox || qb || qsv2

Config.UseLibTextUI = true -- if you are unable to see the lib text ui, set this to false. A lot of other scripts run a thread which constantly hides the ui which makes the ui in the icebox to not show up. 
-- In that case just the ui available inside my script if you dont know which script is doing it.

Config.Notification = "ox" -- ox || qb || esx

Config.Progress = "ox" -- qb | ox

Config.DefaultPrice = 1000 -- default price for the chain/watch if you dont set itemPrice for the item in the chains.lua or watches.lua

Config.ProgressTime = {
    ["craft"] = 5000,
    ["infuse"] = 5000,
    ["repair"] = 1000,
    ["addbuff"] = 5000,
}

Config.Anims = {
    ["craft"] = {
        ["dict"] = "amb@prop_human_bum_bin@idle_a", -- dictionaory or scenario
        ["anim"] = "idle_a",
    },
    ["infuse"] = {
        ["dict"] = "amb@prop_human_bum_bin@idle_a", -- dictionaory or scenario
        ["anim"] = "idle_a",
    },
    ["repair"] = {
        ["dict"] = "amb@prop_human_bum_bin@idle_a", -- dictionaory or scenario
        ["anim"] = "idle_a",
    },
    ["addbuff"] = {
        ["dict"] = "amb@prop_human_bum_bin@idle_a", -- dictionaory or scenario
        ["anim"] = "idle_a",
    }
}

Config.AllowItemToInspectPlayerChain = {
    enabled = true,
    realItem = "real_chain_tester",
    fakeItem = "fake_chain_tester"
}

Config.AllowRepair = false -- if true, it will allow repair (if false, there wont be repair functionality. No need to repair chains if set to false)
Config.TimeToRepair = 5 -- in days (people will have to repair their chain every 5 days)
Config.RemoveAllInfusedItemsOnRepair = true -- if true, it will remove all infused items on repair (people will have reinfuse them again)

Config.ChainRepairCost = {
    [1] = {
        ["item"] = "diamond",
        ["label"] = "Diamond",
        ["amount"] = 5,
    },
    [2] = {
        ["item"] = "ruby",
        ["label"] = "Ruby",
        ["amount"] = 1,
    }
}

-- emote for wearing and taking off chain
Config.Emotes = {
    ["wearing"] = {
        dict = "clothingtie",
        anim = "try_tie_positive_a",
    },
    ["takeoff"] = {
        dict = "clothingtie",
        anim = "try_tie_positive_a",
    },
    ["wearingwatch"] = {
        dict = "missmic4",
        anim = "michael_tux_fidget",
    },
    ["takeoffwatch"] = {
        dict = "missmic4",
        anim = "michael_tux_fidget",
    }
}

Config.InfuseItems = {
    ["diamond"] = { -- item that can be infused
        increasePerAmount = 0.001, -- kept it low because the particle effect increases a lot and make its look bad!
        label = "Icey",
        particleDict = "cut_amb_tv",
        particleName = "cs_amb_tv_sauna_steam",
        min = 0.001, -- minimum value if diamond is 1
        threadtime =  4 * 60 * 1000, -- time in ms to run the thread for the effect (4 minutes)

    },
    ["ruby"] = {
        increasePerAmount = 0.01,
        label = "Firey",
        particleDict = "scr_agencyheist",
        particleName = "sp_fire_trail",
        min = 0.05, -- minimum value if ruby is 1
        threadtime = 5 * 60 * 1000, -- time in ms to run the thread (5 minutes)
    },
}

Config.AllowBuffs = false -- if true, it will allow buffs
Config.AllowToStackBuffEffects = false -- if true, it will allow to stack buff effects (if you have buff in watch as well as chain, it will stack the 2 effects)
Config.PSBuff = false -- if true, it will use ps-buffs to add buffs on the hud (!!REQUIRES ps-hud and ps-buffs!!)

Config.BuffItems = {
    ["buff_diamond"] = {
        label = "Diamond (Health Buff)",
        buff = "health", -- check cl_buffeffects.lua
        threadTime = 20 * 1000, -- time in ms to run the thread (20 seconds)
        maxAllowed = 5, -- max number of buff diamonds that can be added (keep this value low because the metadata on the item will be too long and probably cause issues)
        defaultIncrease = 1, -- (if you have 1 gem, every 20 seconds, it will increase the health by 1)
        increasePerAmount = 1, -- (if you have 2 gems, every 20 seconds, it will increase the health by 2)
        duration = 0.5 -- in days (how long 1 buff_diamond will last in the chain/watch)
    },
    ["buff_ruby"] = {
        label = "Ruby (Armor Buff)",
        buff = "armor", -- check cl_buffeffects.lua
        threadTime = 20 * 1000, -- time in ms to run the thread (20 seconds)
        maxAllowed = 5, -- max number of buff ruby that can be added  (keep this value low because the metadata on the item will be too long and probably cause issues)
        defaultIncrease = 1, -- (if you have 1 gem, every 20 seconds, it will increase the health by 1)
        increasePerAmount = 1, -- (if you have 2 gems, every 20 seconds, it will increase the health by 2)
        duration = 0.5 -- in days (how long 1 buff_ruby will last in the chain/watch)
    },
    -- if you want to add more buffs, you will have to add it yourself in cl_buffeffects.lua and modify the code. I will be sending all the required information.
}

Config.Blips = {
    ["icebox"] = {
        enabled = false,
        label = "Icebox",
        sprite = 514,
        color = 0,
        scale = 0.8,
        display = 4,
        coords = vector3(-1238.14, -801.68, 18.0),
        shortRange = true,
    },
    ["jewellery"] = {
        enabled = true,
        label = "Jewellery",
        sprite = 617,
        color = 0,
        scale = 0.8,
        display = 4,
        coords = vector3(-630.0, -236.0, 38.0),
        shortRange = true,
    }
}

-- DO NOT TOUCH THIS!!!!

for k, v in pairs(Config.FrameworkTriggers) do
    if GetResourceState(v.ResourceName) == "started" then
        Config.Framework = k
        break
    end
end
