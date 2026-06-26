Config = {}
Config.Debug = false -- Set to true to enable debug mode

Config.DatabaseChecker = {}
Config.DatabaseChecker.Enabled = true -- if true, the tablet will check the database for any issues and fix them if possible
Config.DatabaseChecker.AutoFix = true -- if true, the tablet will automatically fix any issues & add new tables if needed

Config.LBPhone = "auto" -- Set to false if you don't want to link lb-phone to lb-tablet

Config.OpenCommand = "tablet" -- the command to open the tablet. can be set to false to disable

Config.Logs = {}
Config.Logs.Enabled = false
Config.Logs.Service = "discord" -- fivemanage, discord or ox_lib. if discord, set your webhook in server/apiKeys.lua
Config.Logs.Avatar = false -- attempt to get the player's avatar for discord logging?
Config.Logs.Dataset = "default" -- fivemanage dataset
Config.Logs.Actions = {
    TakePhoto = true,
    Police = true,
    Ambulance = true,
    Dispatch = true
}

-- [[ FRAMEWORK/SCRIPT OPTIONS ]] --
Config.Framework = "auto"
--[[
    Supported frameworks:
        * esx: es_extended, https://github.com/esx-framework/esx-legacy
        * qb: qb-core, https://github.com/qbcore-framework/qb-core
        * qbox: qbox, https://github.com/Qbox-project/qbx_core
        * standalone: no framework, standalone framework using the registration database by default
]]

Config.BillingScript = "auto" --[[
    Supported options:
        * auto
        * framework
        * vivum
]]

Config.RegistrationApp = "auto" -- add an app that lets players create their own characters, vehicles etc? useful for standalone servers

Config.Item = {}
Config.Item.Require = true -- require a tablet item to use the tablet
Config.Item.Name = "tablet" -- name of the tablet item
Config.Item.Inventory = "auto"
Config.HousingScript = "auto"
Config.JailScript = "auto"
--[[
    Supported jail scripts:
        * auto: automatically detect the jail script (recommended)
        * qalle: esx-qalle-jail https://github.com/qalle-git/esx-qalle-jail
        * esx: esx_jail https://github.com/esx-community/esx_jail
        * pickle: pickle_prisons https://github.com/PickleModifications/pickle_prisons
        * qb: qb-prison https://github.com/qbcore-framework/qb-prison
        * xt: xt-prison
        * qbox: qbx_prison
        * rcore: rcore_prison
]]

Config.Genders = "auto"
-- Config.Genders = {
--     {
--         label = "Male",
--         value = "m"
--     },
--     {
--         label = "Female",
--         value = "f"
--     }
-- }

Config.DobFormat = "auto" -- default for qb-core

-- [[ LANGUAGE OPTIONS ]] --
Config.DefaultLocale = "en"
Config.DateLocale = "en-US" -- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat/DateTimeFormat
Config.DateFormat = "auto" -- auto: use the date format from the locale, or set a custom format (e.g. "DDDD, MMMM DD")
Config.CurrencyFormat = "$%s"

Config.Locales = { -- If your desired language isn't here, you may contribute at https://github.com/lbphone/lb-tablet-locales
    {
        locale = "en",
        name = "English"
    },
    {
        locale = 'fr',
        name = 'Français'
    },
    {
        locale = 'sv',
        name = 'Svenska'
    },
    {
        locale = "de",
        name = "Deutsch"
    },
    {
        locale = "es",
        name = "Español"
    },
    {
        locale = "pt-br",
        name = "Português (Brasil)"
    },
    {
        locale = "ba",
        name = "Bosanski"
    },
    {
        locale = "nl",
        name = "Nederlands"
    },
    {
        locale = "ar",
        name = "العربية"
    },
    {
        locale = "cs",
        name = "Čeština"
    },
    {
        locale = "tr",
        name = "Türkçe"
    },
    {
        locale = "ro",
        name = "Romana"
    },
    {
        locale = "ua",
        name = "Українська"
    },
    {
        locale = "cn",
        name = "简体中文"
    },
    {
        locale = "no",
        name = "Norsk",
    },
    {
        locale = "da",
        name = "Dansk",
    }
}

-- [[ VOICE OPTIONS ]] --
Config.Voice = {}
Config.Voice.RecordNearby = true -- Should video & audio recording include nearby players?

-- [[ ENTITY OPTIONS ]] --
Config.TabletModel = `lb_tablet_prop` -- the prop of the tablet, if you want to use a custom tablet model, you can change this here
Config.TabletRotation = vector3(0.0, 180.0, 0.0) -- the rotation of the tablet when attached to a player
Config.TabletOffset = vector3(0.05, -0.005, -0.04) -- the offset of the tablet when attached to a player
Config.ServerSideSpawn = false -- should entities be spawned on the server?
Config.PropSpawn = "state" --[[
    - client: networked, spawned on the client
    - server: networked, spawned on the server
    - state: spawned on each client, not networked
]]

-- [[ MISC OPTIONS ]] --
Config.KeepInput = true -- keep input when nui is focused (meaning you can walk around etc)
Config.DisableFocusTalking = true -- disable the focus key (default ALT) when talking in-game? Potentially fixes issues with PTT getting stuck (open mic)
Config.SyncFlashlight = true -- should flashlight be synced between players?
Config.AutoDeleteNotifications = true -- true = delete 1 week old notifications, false = keep all notifications. you can also set to a number (in hours) to delete after that time
Config.FadeOutsideTablet = true -- should the tablet fade when the cursor is outside of the tablet?
Config.DutyBlipInterval = 5000 -- how often should duty blips update? in milliseconds

Config.AutoCreateEmail = true
Config.EmailDomain = "SpendDatShyt.com"

Config.RealTime = true -- if true, the time will use real life time depending on where the user lives, if false, the time will be the ingame time.
Config.CustomTime = false -- NOTE: set Config.RealTime to false if using this. you can set this to a function that returns custom time, as a table: { hour = 0-23, minute = 0-59 }

Config.FrameColor = "#39334d" -- This is the color of the tablet frame. Default (#39334d) is purple.
Config.AllowFrameColorChange = true -- Allow players to change the color of their tablet frame?

Config.WhitelistApps = {
    -- ["Calculator"] = { "police", "ambulance" }
}

Config.BlacklistApps = {
    -- ["Maps"] = { "police" }
}

Config.Sound = {}
Config.Sound.System = "native" -- native: use native GTA audio, nui: play audio via nui NOTE: syncing only works when using native GTA audio
Config.Sound.Sync = true -- syncing audio only works when using native audio
Config.Sound.Volume = {} -- the volume options only applies to native audio
Config.Sound.Volume.Multiplier = 1.0
Config.Sound.Volume.Static = false -- here you can set a static volume for native sounds, instead of allowing users to change volume themselves
Config.Sound.Volume.Min = 0.0
Config.Sound.Volume.Max = 1.0
Config.Sound.MaxDistance = 30.0 -- the maximum distance a sound can be heard from (only applies to native audio)

Config.Sound.Notifications = {
    ["default"] = {
        name = "1",
        soundSet = "notification"
    },
    ["notification 1"] = {
        name = "2",
        soundSet = "notification"
    },
    ["notification 2"] = {
        name = "3",
        soundSet = "notification"
    },
    ["notification 3"] = {
        name = "4",
        soundSet = "notification"
    },
    ["notification 4"] = {
        name = "5",
        soundSet = "notification"
    },
    ["notification 5"] = {
        name = "6",
        soundSet = "notification"
    },
    ["notification 6"] = {
        name = "7",
        soundSet = "notification"
    },
    ["notification 7"] = {
        name = "8",
        soundSet = "notification"
    },
}

Config.Sound.AppNotifications = {
    -- ["Messages"] = "default"
}

-- Config.CustomMaps = {
--     {
--         label = "Los Santos",
--         url = "https://s.rsg.sc/sc/images/games/GTAV/map/{layer}/{z}/{x}/{y}.jpg",
--         center = { 1650, 450 },
--         topLeft = { -4140, 8400 },
--         bottomRight = { 4860, -5100 },
--         resolution = { 16384, 24576 },
--         zoom = {
--             default = 3,
--             max = 7,
--             min = 2
--         },
--         styles = {
--             {
--                 name = "game",
--                 background = "#384950",
--                 preview = "./assets/img/maps/placeholder_santos_game.webp"
--             },
--             {
--                 name = "render",
--                 background = "#0d2b4f",
--                 preview = "./assets/img/maps/placeholder_santos_render.webp"
--             },
--             {
--                 name = "print",
--                 background = "#4eb1d0",
--                 preview = "./assets/img/maps/placeholder_santos_print.webp"
--             },
--         },
--     },
--     {
--         label = "Cayo Perico",
--         url = "https://s.rsg.sc/sc/images/games/GTAV/map/{layer}_island_heist/{z}/{x}/{y}.jpg",
--         center = { -5150, 4700 },
--         topLeft = { 3700, -4150 },
--         bottomRight = { 5700, -6150 },
--         resolution = { 10000, 10000 },
--         zoom = {
--             default = 2,
--             max = 6,
--             min = 2
--         },
--         styles = {
--             {
--                 name = "game",
--                 background = "#384950",
--                 preview = "./assets/img/maps/placeholder_cayo_game.webp"
--             },
--             {
--                 name = "render",
--                 background = "#0d2b4f",
--                 preview = "./assets/img/maps/placeholder_cayo_render.webp"
--             },
--             {
--                 name = "print",
--                 background = "#4eb1d0",
--                 preview = "./assets/img/maps/placeholder_cayo_print.webp"
--             },
--         },
--     },
--     {
--         label = "North Yankton",
--         url = "https://s.rsg.sc/sc/images/games/GTAV/map/{layer}_alt/{z}/{x}/{y}.jpg",
--         center = { 4500, -3700 },
--         topLeft = { 1900, -3700 },
--         bottomRight = { 7020, -5748 },
--         resolution = { 20316, 8192 },
--         zoom = {
--             default = 3,
--             max = 7,
--             min = 3
--         },
--         styles = {
--             {
--                 name = "game",
--                 background = "#1e1e1e",
--                 preview = "https://s.rsg.sc/sc/images/games/GTAV/map/game_alt/2/0/0.jpg"
--             },
--             {
--                 name = "render",
--                 background = "#e1e6ea",
--                 preview = "https://s.rsg.sc/sc/images/games/GTAV/map/render_alt/2/0/0.jpg"
--             },
--             {
--                 name = "print",
--                 background = "#cad2d2",
--                 preview = "https://s.rsg.sc/sc/images/games/GTAV/map/print_alt/2/0/0.jpg"
--             },
--         }
--     },
-- }

Config.ShowLocationsInDispatch = true -- show locations in the police & ambulance dispatches?
Config.Locations = { -- Locations that'll appear in the maps app
    {
        position = vector2(428.9, -984.5),
        name = "LSPD",
        description = "Los Santos Police Department",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
    },
    {
        position = vector2(304.2, -587.0),
        name = "Pillbox",
        description = "Pillbox Medical Hospital",
        icon = "https://cdn-icons-png.flaticon.com/128/1032/1032989.png",
    },
}

-- See https://docs.lbscripts.com/tablet/script-integration/custom-apps/
-- Required fields:
--  identifier: The identifier of the app (string)
--  name: The name of the app (string)
-- Optional fields:
--  description: The description of the app (string)
--  icon: The icon of the app (string)
--  price: The price of the app (number)
--  images: An array of images for the app (string[])
--  developer: The developer of the app (string)
--  size: The size of the app, in kB (number)
--  ui: The URL of the app (string)
--  defaultApp: Whether the app is a default app (boolean)
-- Actions:
--  onInstall: A function that is called when the app is installed
--  onOpen: A function that is called when the app is opened
--  onClose: A function that is called when the app is closed
--  onUninstall: A function that is called when the app is uninstalled
Config.CustomApps = {}

-- [[ DISPATCH OPTIONS ]]--
Config.RequireDutyDispatch = true -- require being on duty to see dispatch notifications?

Config.DispatchEnabled = false -- enable dispatch?
Config.DispatchVisible = true -- should the dispatch be visible? If false, you will only see dispatch in the MDT apps
Config.DispatchPosition = "top-right" -- position of the dispatch notifications (top/middle/bottom-left/middle/right, e.g., "top-left", "middle-right", "bottom-middle", or legacy: "left"/"right")
Config.DispatchLatestFirst = false -- show latest dispatches first?
Config.DispatchCompatibility = true -- add dispatch exports & events from other dispatch/mdt scripts? (note: this may not work with all scripts, we strongly recommend using the lb-tablet exports directly)
Config.AllowClientDispatch = true -- add client-sided exports for dispatch? (note: this allows modders to trigger dispatches, but may be needed for some scripts)
Config.ShowDispatchWithoutItem = true -- show dispatch even if the player doesn't have a tablet item?
Config.DispatchUpdateZIndex = true -- set the z-index to 99 when a dispatch comes in? this makes the dispatch appear over other UIs.
Config.HideDispatchWhenDead = true
Config.DispatchBlip = {
    Enabled = true, -- allow creating blips for dispatches
    Default = {
        Enabled = true, -- automatically create a blip for dispatches if one has not been provided?
        Type = "default", -- default / radius
        Radius = 50.0,
        Sprite = 161, -- https://docs.fivem.net/docs/game-references/blips/#blips
        Color = 1, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        Size = 1.5,
        ShortRange = false, -- show blip only when close to it?
        Label = "{dispatch_title}", -- Available placeholders: {dispatch_title}, {id}, {priority}
    }
}

Config.BaseDispatch = {}
Config.BaseDispatch.Enabled = true -- enable the base dispatch system? calls for e.g. hijacking, shooting, etc
Config.BaseDispatch.Debug = false -- draw a line to the witness?
Config.BaseDispatch.RequireWitness = true -- require a witness (NPC) to trigger dispatch?
Config.BaseDispatch.RequireLos = true -- require line of sight from the witness to the player to trigger dispatch?
Config.BaseDispatch.MaxDistance = 100 -- maximum distance from the player to the witness to trigger dispatch
Config.BaseDispatch.CallPolice = true -- should a nearby NPC call the police when a dispatch is triggered?
Config.BaseDispatch.Chance = 100 -- chance of a dispatch being triggered (0-100)
Config.BaseDispatch.IgnoredVehicles = { -- vehicles that will not generate CarJacking or VehicleTheft dispatches
    -- `t20`,
}
Config.BaseDispatch.IgnoredWeapons = { -- weapons that will not generate Gunshot or Armed dispatches
    -- `WEAPON_STUNGUN`,
}
Config.BaseDispatch.Actions = {
    --[[
        To disable an action, set it to false.
        Options:
            - mdts: string[] -- which MDTs to send the dispatch to (e.g. { "Police", "Ambulance" })
            - ignoreEmployees: boolean -- should employees of the MDT job be ignored for this dispatch? (e.g. police officers for gunshots)
            - chance: number -- chance of the action being triggered (0-100)
            - cooldown: number -- how often this action can be triggered by each player
            - serverCooldown: number -- how often this action can be triggered (server-wide cooldown)
            - dispatch
                - priority: "low" | "medium" | "high"
                - time: number -- how long the dispatch should be visible (in seconds)
                - sound: string
                - any other options, see https://docs.lbscripts.com/tablet/script-integration/server-exports/#adddispatch
    ]]
    CarJacking = {
        mdts = { "Police" },
        ignoreEmployees = false,
        cooldown = 0,
        serverCooldown = 0,
        dispatch = {
            priority = "medium",
            time = 120,
        },
    },
    VehicleTheft = {
        mdts = { "Police" },
        ignoreEmployees = false,
        cooldown = 0,
        serverCooldown = 0,
        dispatch = {
            priority = "medium",
            time = 120,
        },
    },
    Explosion = {
        mdts = { "Police", "Ambulance" },
        ignoreEmployees = false,
        serverCooldown = 10,
        ignoredExplosions = { -- https://docs.fivem.net/natives/?_0xE3AD2BDBAEE269AC
            11, 12, 13, 14, 18, 19, 20, 21, 22, 23, 24, 25, 38, 39, 77,
        },
        dispatch = {
            priority = "medium",
            time = 180,
        },
    },
    Gunshot = {
        mdts = { "Police", "Ambulance" },
        ignoreEmployees = true,
        cooldown = 60,
        serverCooldown = 0,
        ignoredWeaponGroups = { -- https://docs.fivem.net/natives/?_0xC3287EE3050FB74C
            "DIGISCANNER",
            "FIREEXTINGUISHER",
            "HACKINGDEVICE",
            "METALDETECTOR",
            "NIGHTVISION",
            "PARACHUTE",
            "PETROLCAN",
            "STUNGUN",
            "TRANQILIZER",
            "UNARMED",
            "UNKNOWN"
        },
        dispatch = {
            priority = "high",
            time = 300,
        },
    },
    Armed = {
        mdts = { "Police" },
        ignoreEmployees = true,
        cooldown = 120,
        serverCooldown = 0,
        ignoredWeaponGroups = { -- https://docs.fivem.net/natives/?_0xC3287EE3050FB74C
            "DIGISCANNER",
            "FIREEXTINGUISHER",
            "HACKINGDEVICE",
            "METALDETECTOR",
            "NIGHTVISION",
            "PARACHUTE",
            "PETROLCAN",
            "STUNGUN",
            "TRANQILIZER",
            "UNARMED",
            "UNKNOWN"
        },
        dispatch = {
            priority = "medium",
            time = 120,
        },
    },
}

-- [[ SERVICES APP OPTIONS ]] --
Config.Services = {}
Config.Services.MessageOffline = true -- if true, players can message companies even if no one in the company is online
Config.Services.SeeEmployees = "everyone" -- who should be able to see employees? they will see name, online status & phone number. options are: "everyone", "employees" or "none"
Config.Services.DeleteConversations = true -- allow employees to delete conversations?

Config.Services.Management = {
    Enabled = true, -- if true, employees & the boss can manage the companyW
    Duty = true, -- if true, employees can go on/off duty

    -- Boss actions
    Deposit = true, -- if true, the boss can deposit money into the company
    Withdraw = true, -- if true, the boss can withdraw money from the company
    Hire = true, -- if true, the boss can hire employees
    Fire = true, -- if true, the boss can fire employees
    Promote = true, -- if true, the boss can promote employees
}

Config.Services.Companies = { -- the companies that are shown in the app
    {
        job = "police",
        name = "Police",
        icon = "https://cdn-icons-png.flaticon.com/512/7211/7211100.png",
        canMessage = true, -- if true, players can message the company
        location = {
            name = "Mission Row",
            coords = {
                x = 428.9,
                y = -984.5,
            }
        }
    },
    {
        job = "ambulance",
        name = "Ambulance",
        icon = "https://cdn-icons-png.flaticon.com/128/1032/1032989.png",
        canMessage = true,
        location = {
            name = "Pillbox",
            coords = {
                x = 304.2,
                y = -587.0
            }
        }
    },
    {
        job = "mechanic",
        name = "Mechanic",
        icon = "https://cdn-icons-png.flaticon.com/128/10281/10281554.png",
        location = {
            name = "LS Customs",
            coords = {
                x = -336.6,
                y = -134.3
            }
        }
    },
    {
        job = "taxi",
        name = "Taxi",
        icon = "https://cdn-icons-png.flaticon.com/128/433/433449.png",
        canMessage = true,
        location = {
            name = "Taxi",
            coords = {
                x = 984.2,
                y = -219.0
            }
        }
    },
}

-- [[ MDT OPTIONS ]]
Config.MDT = {}

Config.MDT.RequireDuty = false -- require being on duty to be able to see & use MDT apps?
Config.MDT.CreateDispatch = true -- allow creating dispatches from the MDT?

Config.MDT.ExportReports = {}
Config.MDT.ExportReports.Enabled = "auto" -- allow exporting reports? auto: enabled if using a supported inventory
Config.MDT.ExportReports.Item = "document"

Config.MDT.TagColors = {
    ["Grey"] = "#8e8e93",
    ["Blue"] = "#0a84ff",
    ["Green"] = "#32d74b",
    ["Red"] = "#ff3b30",
    ["Orange"]  = "#ff9d0a",
    ["Yellow"] = "#cca250",
    ["Pink"] = "#FFC0CB",
    ["Purple"] = "#af52de",
    ["Brown"] = "#916e41",
    ["Navy"] = "#000080",
    ["Cyan"] = "#5ac8fa",
}

Config.MDT.EvidenceStash = {}
Config.MDT.EvidenceStash.Enabled = true -- allow employees to store evidence for cases in the tablet?
Config.MDT.EvidenceStash.Slots = 60
Config.MDT.EvidenceStash.Weight = 50000

Config.MDT.Jail = {}
Config.MDT.Jail.Refresh = true -- should jail_time be updated by the tablet script? Set to false if you've fully configured your jail script to work with lb-tablet
Config.MDT.Jail.Interval = 60 -- how often (in seconds) to update the jail time
Config.MDT.Jail.CanUnjail = "auto" -- auto: true if supported jail script, otherwise false
Config.MDT.Jail.AllowJailJailed = true -- allow jailing players that are already jailed? (meaning they exist in lbtablet_mdt_jail)

Config.MDT.Wiretapping = {}
Config.MDT.Wiretapping.Enabled = true
Config.MDT.Wiretapping.MinimumCallDuration = 0 -- how many seconds the call must be active before it can be listened to?

Config.MDT.AutoRegisterWeapons = {}
Config.MDT.AutoRegisterWeapons.Enabled = true -- automatically register weapons? this required a supported inventory (ox_inventory). Can be modified in server/custom/functions/registerWeapon.lua
Config.MDT.AutoRegisterWeapons.AddUnregistered = true -- add unregistered weapons (no owner) to the database?
Config.MDT.AutoRegisterWeapons.IgnoreList = {
    "WEAPON_PETROLCAN"
}

Config.MDT.Notifications = {
    NewBulletin = true,
    NewWeapon = false,
    NewReport = true,

    NewCatalogCategory = true,
    NewCatalogItem = true,

    NewChat = true,
    ChatMessage = true,
    ChatReaction = true, -- when someone reacts to your message
}

-- Here you can set the max points a licene has, or false to disable points for that license
Config.MDT.MaxLicensePoints = {
    drive = 12,
    driver = 12,
    weapon = false,
}

Config.MDT.DefaultMaxLicensePoints = 4 -- the default max points for licenses that aren't specified in Config.MDT.MaxLicensePoints. Set to false to disable points for unspecified licenses.

Config.LiveEdit = {}
Config.LiveEdit.Enabled = true
Config.LiveEdit.UpdateInterval = 250 -- how often (in ms) to update the live edit state?

Config.Triangulation = {}
Config.Triangulation.RequireCall = false -- require the phone number being triangulated to be in a call?
Config.Triangulation.CellTowerTime = 500 -- how many milliseconds between each cell tower when searching?
Config.Triangulation.SuccessRate = 50 -- how many % that the phone number will be found
Config.Triangulation.RangeMultiplier = 1.0 -- how much to multiply the cell tower range by when searching?

Config.DutyBlips = {}
Config.DutyBlips.RequireItem = true -- require a tablet item to be shown on & see duty blips?
Config.DutyBlips.Options = {
    Show = true, -- show blips for players on duty on the in-game map?
    Category = 7,
    Sprite = 1,
    Color = 0,
    FriendIndicator = true,
    Outline = false,
    OutlineColour = { 93, 182, 229 },
    Scale = 0.9,
    ShortRange = true,
    ShowHeading = true,
    Name = "{name} - {callsign}",
    VehicleTypes = {
        car = 56,
        bike = 226,
        heli = 64,
        boat = 455,
        plane = 423,
    }
}

-- [[ Browser App Options ]] --
Config.Browser = {}

Config.Browser.CX = "32dca7fc9f06341d2" -- The CX id used to search with Google. You can get your own id from https://cse.google.com/cse/all

Config.Browser.DefaultBookmarks = {
    -- {
    --     title = "LB",
    --     url = "https://lbscripts.com/",
    --     icon = "https://lbscripts.com/assets/favicon.ico"
    -- }
}

Config.Browser.WhitelistedDomains = {
    -- "lbscripts.com",
}

Config.Browser.BlacklistedDomains = {
    -- "example.com",
}

-- [[ KEY BINDINGS ]] --
Config.KeyBinds = {  -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
    Open = {
        bind = "F5",
        description = "Open your tablet"
    },
    Focus = {
        bind = "LMENU", -- ALT
        description = "Toggle cursor on your tablet"
    },
    Opacity = {
        bind = "LMENU",
        description = "Toggle tablet transparency"
    },

    -- Dispatch
    NotificationUp = {
        bind = "UP",
        description = "Go up in the dispatch list"
    },
    NotificationDown = {
        bind = "DOWN",
        description = "Go down in the dispatch list"
    },
    NotificationDismiss = {
        bind = "O",
        description = "Dismiss the current dispatch"
    },
    NotificationView = {
        bind = "G",
        description = "View the current dispatch"
    },
    NotificationRespond = {
        bind = "Z",
        description = "Respond to the current dispatch"
    },
    NotificationExpand = {
        bind = "J",
        description = "Expand to the current dispatch"
    },

    -- Camera
    FlipCamera = {
        bind = "UP",
        description = "Flip camera"
    },
    TakePhoto = {
        bind = "RETURN",
        description = "Take a photo/video"
    },
    ToggleFlash = {
        bind = "E",
        description = "Toggle flash"
    },
    LeftMode = {
        bind = "LEFT",
        description = "Change mode"
    },
    RightMode = {
        bind = "RIGHT",
        description = "Change mode"
    },
    RollLeft = {
        bind = "Z",
        description = "Roll camera to the left"
    },
    RollRight = {
        bind = "C",
        description = "Roll camera to the right"
    },
    FreezeCamera = {
        bind = "X",
        description = "Freeze camera"
    },
    ToggleCameraTip = {
        bind = "H",
        description = "Toggle camera tip"
    },
    UnlockTablet = {
        bind = "SPACE",
        description = "Unlock your tablet",
    },
}

-- [[ UPLOAD OPTIONS ]] --
Config.AllowExternal = { -- allow people to upload external images? (note: this means they can upload nsfw/gore etc)
    Police = true,
    Ambulance = true,
    Registration = true,
    Gallery = true,
    Mail = false,
    Other = false,
}

-- Blocked hostnames for external images. You will not be able to upload from these hostnames.
Config.ExternalBlacklistedHostnames = {}

-- Blacklisted domains for external images (blocks all subdomains too)
Config.ExternalBlacklistedDomains = {
    "imgur.com",
    "discord.com",
    "discordapp.com",
}

-- Whitelisted hostnames for external images
Config.ExternalWhitelistedHostnames = {
    -- "*.fivemanage.com",
    -- "*.fmfile.com",
    "r2.qbox.re",
}

-- Whitelisted domains for external images (allows all subdomains too)
Config.ExternalWhitelistedDomains = {
    "fivemanage.com"
}

-- Hostnames that are allowed to upload images to the tablet (prevent using devtools to upload images)
-- You can use "*" as a wildcard at the start of the hostname to allow all subdomains (e.g. "*.example.com" will allow uploads from "r2.example.com", "s3.example.com" etc)
Config.UploadWhitelistedHostnames = {
    -- "*.fivemanage.com",
    -- "*.fmfile.com",
    "*.users.cfx.re", -- lb-upload
    "r2.qbox.re", -- https://docs.qbox.re/dashboard/cdn
}

Config.UploadWhitelistedDomains = {
    "fivemanage.com",
    "fmfile.com",
    "amazonaws.com", -- lb-presigned (S3)
}

-- Set your api keys in lb-tablet/server/apiKeys.lua
Config.UploadMethod = {}
-- You can edit the upload methods in lb-tablet/config/upload.lua
-- The default and recommended upload method is Fivemanage
-- Use code "LBPHONE25" for 25% off - forever
-- You can get your API keys from https://refer.fivemanage.com/lb
-- Affiliate link - purchases made through this link will give us a commission at no extra cost to you
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
-- If you want to use S3/R2, you can use "LBPresigned": https://github.com/lbphone/lb-presigned
-- If you want to host uploads yourself, you can use "LBUpload": https://github.com/lbphone/lb-upload
Config.UploadMethod.Video = "Fivemanage"
Config.UploadMethod.Image = "Fivemanage"
Config.UploadMethod.Audio = "Fivemanage"

-- You can customize the function in lb-phone/server/custom/functions/webrtc.lua
-- You can set your api key in lb-phone/server/apiKeys.lua
Config.DynamicWebRTC = {}
Config.DynamicWebRTC.Enabled = false -- enable dynamic WebRTC? (this will allow you to generate new WebRTC credentials for each user)
Config.DynamicWebRTC.Service = "cloudflare" -- supported by default: cloudflare
Config.DynamicWebRTC.RemoveStun = false -- remove the stun servers?

-- ICE Servers for WebRTC (ig live, live video). If you don't know what you're doing, leave this as it is.
-- see https://developer.mozilla.org/en-US/docs/Web/API/RTCPeerConnection/RTCPeerConnection
-- Config.RTCConfig = {
--     iceServers = {
--         { urls = "stun:stun.l.google.com:19302" },
--     }
-- }

-- [[ PHOTO / VIDEO OPTIONS ]] --
Config.Camera = {}
Config.Camera.ShowTip = true -- show a tip in the top-left of key binds for the camera?
Config.Camera.Roll = true -- allow rolling the camera to the left & right?
Config.Camera.AllowRunning = true
Config.Camera.MaxFOV = 60.0 -- higher = zoomed out (ultrawide)
Config.Camera.MinFOV = 10.0 -- lower = zoomed in (telephoto)
Config.Camera.MaxLookUp = 80.0
Config.Camera.MaxLookDown = -80.0

Config.Camera.Vehicle = {}
Config.Camera.Vehicle.Zoom = true -- allow zooming in vehicles?
Config.Camera.Vehicle.MaxFOV = 80.0
Config.Camera.Vehicle.MinFOV = 10.0
Config.Camera.Vehicle.MaxLookUp = 50.0
Config.Camera.Vehicle.MaxLookDown = -30.0
Config.Camera.Vehicle.MaxLeftRight = 120.0
Config.Camera.Vehicle.MinLeftRight = -120.0

Config.Camera.Selfie = {}
Config.Camera.Selfie.Offset = vector3(0.04, 0.48, 0.42)
Config.Camera.Selfie.Rotation = vector3(40.0, 0.0, -180.0)
Config.Camera.Selfie.MaxFov = 90.0
Config.Camera.Selfie.MinFov = 50.0

Config.Camera.Freeze = {}
Config.Camera.Freeze.Enabled = true -- allow players to freeze the camera when taking photos? (this will make it so they can take photos in 3rd person)
Config.Camera.Freeze.MaxDistance = 10.0 -- max distance the camera can be from the player when frozen
Config.Camera.Freeze.MaxTime = 60 -- max time the camera can be frozen for (in seconds)

Config.Video = {}
Config.Video.Bitrate = 400 -- video bitrate (kbps), increase to improve quality, at the cost of file size
Config.Video.FrameRate = 24 -- video framerate (fps), 24 fps is a good mix between quality and file size used in most movies
Config.Video.MaxSize = 30 -- max video size (MB)
Config.Video.MaxDuration = 60 -- max video duration (seconds)
Config.Video.AudioBitrate = 128 -- audio bitrate (kbps) for video recordings
Config.Video.VariableBitrate = true -- allow variable video bitrate when recording

Config.Image = {}
Config.Image.Mime = "image/webp"
Config.Image.Quality = 0.95
