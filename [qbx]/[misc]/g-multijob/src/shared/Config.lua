Config = {}

--- RECOMENDED TO LEAVE AS TRUE ---
Config.CheckForUpdates = true -- Check for updates on server start
Config.AutoImportSQL = true   -- Automatically import on server start


Config.SystemSettings = {
    Language = "en",
    Debug = false,
    theme = "shadcn_dark", --  shadcn_dark | gblue | theme3 | theme4 | theme5 | theme6
    -- You don't have to worry about this—if your OpenType is set to "command" or "keybind", you don't need to configure it.
    OpenMenuVia = "textui", -- target | textui
    Notify = "rtx_notify" -- okok | esx | qbcore | ox_lib | 17mov | g-notifications | rtx_notify | standalone
}

-- TextUI settings
Config.Key = 38 -- 38 = [E] https://docs.fivem.net/docs/game-references/controls/#controls
Config.KeyName = "[E] "
Config.TextUI = "ox_lib" -- supported Notifications TextUi's -  "ox_lib" | "okok" | "esx" | "qbcore"

Config.Icons = {
    multijobTargetIcon = "fas fa-briefcase"
}

Config.UnemployedLabel = "Unemployed"
Config.MultiJob = {
    --[[
      if open type is "custom" then you need to write a custom logic to open the menu in src/client/cl_edit.lua
    ]]
    OpenType = "keybind", -- command | keybind | location | custom

    Command = {
        name = "multijob", -- command name
        description = "Open the multi job menu",
        showInHelp = false -- if true, the command will be shown in slash command help
    },
    KeyBind = "F4", -- F4 - https://docs.fivem.net/docs/game-references/controls/
    Location = {
        coords = {vec4(-1103.4449, -809.6194, 17.9186, 77.5161)},
        ped = {
            enable = true, -- if you want to enable ped then set to true
            model = "a_m_m_business_01",
            scenario = "WORLD_HUMAN_CLIPBOARD"
        }
    },

    UnemployedJob = {
        name = "unemployed",
        grade = 0
    },

    -- These jobs can't be removed from the menu
    NonRemovableJobs = {
        "unemployed", -- do not remove this
        -- "police",
    },

    MaxJobs = 5 -- max jobs that can be added as secondary jobs

}
