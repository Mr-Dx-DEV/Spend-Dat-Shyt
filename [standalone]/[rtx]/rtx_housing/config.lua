Config = {}

Config.Framework = "qbcore"  -- Supported frameworks: standalone, qbcore, esx

Config.InterfaceColor = "#b3afaf" -- UI theme color in HEX format (e.g. #ff66ff)

Config.Language = "English" -- UI language used by the script (English, German, Spanish, French) (located in language/main.lua)

Config.Target = false -- Enable target-based interaction (true/false)

Config.Targettype = "oxtarget" -- Target system type: qtarget, qbtarget, oxtarget

Config.TargetSystemsNames = {qtarget = "qtarget", qbtarget = "qb-target", oxtarget = "ox_target"}

Config.HousingInteractionSystem = 1 -- Interaction style: 1 = Custom interaction, 2 = 3D Text, 3 = GTA Online style

Config.HouseLocationInteractDistance = 2.5 -- Distance to interact with house interactions

Config.HouseLocationOpenKey = "e" -- Key used for interactions (if not using target)

Config.ActionCooldown = 1000 -- Global action cooldown (ms)

Config.SoundEffects = true  -- Enable sound effects for UI/actions

Config.SoundEffectsVolume = 0.1 -- Sound volume (0.0 - 1.0)

Config.WeatherSystem = "cd_easytime" -- Supported weather sync: cd_easytime, vSync, qb-weathersync, renewed, av_weather, cs_weather, dbn_weather, night_natural_disasters

Config.InventorySystem = "oxinventory" -- types (oxinventory, qbcoreinventory, codeminventory, coreinventory, psinventory, chezza, jaksam_inventory, tgiann-inventory) (you can add your own inventory system for storages in other.lua files in client and in server side)

Config.WardrobeSystem = "illeniumappearance" -- types (esx, qbcore, codem, fivemappearance, illeniumappearance, rcore) you can add your own wardrobe system for storages in other.lua files in client and in server side

Config.GarageSystem = "jg-advancedgarages" -- types (ZSX_Garages, jg-advancedgarages, qb-garages, okokGarage, cd_garage, codem-garage, RxGarages, vms_garagesv2, zerio-garage) (you can add your own garage system in other.lua files in client and in server side)

Config.AlertSystem = "default" -- types (default, cd_dispatch) Alert/dispatch system integration (extend in client/server other.lua)

Config.DisableLights = {shell = true, ipl = true}  -- Disable interior lights for shell/ipl types (useful for custom lighting setups)

Config.KnockDoorBellNotify = true -- Notify the owner when someone rings/knocks

Config.DoorInteractDistance = 2.5 -- Distance to interact with doors

Config.OrderKeyPrice = 3000 -- Price to order a new key

Config.ChangeLockPrice = 10000 -- Price to change locks (invalidate old keys)

Config.DeliveryTime = 1 -- Delivery time in minutes

Config.DancerDespawnTime = 5 -- Despawn time in minutes

Config.WebHooks = false -- Enable Discord webhooks for actions (set webhook URLs in server/other.lua)

Config.PropertyCreatorCommand = "housing" -- - Command to open the property creator (permissions are handled in server/other.lua)

Config.EnablePropertyOwnershipLimit = true -- Enable this option to limit how many properties a player can own

Config.PropertyOwnershipLimit = 3 -- Maximum number of properties a single player is allowed to own

Config.LastPropertyTeleport = true -- -- When enabled, teleports the player to the last property they were in before disconnecting

Config.PaymentMethod = "both" -- Choose payment method: "cash", "bank", or "both" (both = tries cash first, then bank if not enough)

Config.DeliveryBoxes = true -- Enable physical delivery boxes for furniture deliveries (you must configure a delivery box position in the property creator

Config.PropertyCreatorPermissions = {

	-- Controls access to the property creator (ACE, job or identifiers)
	-- actions = permissions for specific features (true = allowed, false = blocked)

	-- ACE permissions (server.cfg)
	acepermissionsforusecontrolmenu = {
		enable = false, -- enable/disable ACE permissions
		permission = "propertycreator.use", -- required ACE permission
		actions = {create = true, delete = true, removeownership = true, edit = true, tp = true} -- create = create properties, delete = delete properties, removeownership = remove ownership, edit = edit properties, tp = teleport to property
	},

	-- Job-based permissions
	jobpermissionsforusecontrolmenu = {
		enable = true, -- enable/disable job check
		jobname = "realestate", -- required job name
		actions = {create = true, delete = true, removeownership = true, edit = true, tp = true} -- same as above
	},

	-- Enable identifier-based permissions (license, steam, discord, etc.)
	identifierspermissionsforcontrolmenu = true,

	-- Specific allowed identifiers
	permissionsviaidentifiers = {
		{
			permissiontype = "license", -- identifier type (license, steam, discord)
			permisisondata = "license:59cda6cea2cba2d00a2866476b76a12cf58be27a", -- identifier value
			actions = {create = true, delete = true, removeownership = true, edit = true, tp = true} -- same as above
		},
	},
}

Config.FurnitureSystem = {
	furnitureshop = false, --- If true, furniture can only be purchased at the Krapea store (not directly from the furniture menu)
	furnituredelivery = true, -- If true, furniture is delivered after purchase (delayed delivery system)
	furnitureplaceafterpurchase = true, --  If true, you place furniture right after buying; otherwise it goes to inventory
	furniturelimit = 100000, -- Maximum number of placed furniture entities per property
	furnituredeliverytime = 8, -- Delivery time (minutes)
	furnituremaxcamdistance = 50.0, -- Max distance for freecam from the player while placing furniture
	furniturepreview = true, -- If true, the furniture will be previewed when the player hovers over it with the mouse in the furniture menu.
	krapea = {
		furniturepreview = true, -- Allow previewing furniture inside the Krapea showroom
		coords = vector3(62.97, -1759.4, 30.09),
		previewcoords = vector3(82.91427, -1760.61205, -60.41156),
		previewrotation = vector3(0.0, 0.0, 0.0),
		camerasettings = {angle = 90.0, pitch = -15.0, dist = 8.0},
		locations = {
			{coords = vector3(54.69, -1800.78, 28.61), locationtype = "bathroom"},
			{coords = vector3(64.76, -1800.46, 28.61), locationtype = "bedroom"},
			{coords = vector3(74.28, -1805.05, 28.61), locationtype = "livingroom"},
			{coords = vector3(82.12, -1814.28, 28.61), locationtype = "livingroom"},
			{coords = vector3(87.06, -1803.38, 28.61), locationtype = "office"},
			{coords = vector3(84.49, -1791.87, 28.61), locationtype = "kitchen"},
			{coords = vector3(101.28, -1789.7, 28.61), locationtype = "outdoors"},
			{coords = vector3(95.59, -1777.27, 28.61), locationtype = "all"},
			{coords = vector3(93.73, -1775.78, 28.61), locationtype = "all"},
			{coords = vector3(91.85, -1774.16, 28.61), locationtype = "all"},
			{coords = vector3(73.8, -1750.31, 28.61), locationtype = "cart"},
			{coords = vector3(72.16, -1752.29, 28.61), locationtype = "cart"},
			{coords = vector3(70.27, -1754.16, 28.61), locationtype = "cart"},
			{coords = vector3(68.44, -1756.11, 28.61), locationtype = "cart"},
			{coords = vector3(66.93, -1758.29, 28.61), locationtype = "cart"},
			{coords = vector3(65.01, -1760.14, 28.61), locationtype = "cart"},
		},
	},
	screenshot = false, -- DEV ONLY: allows generating furniture screenshots
	screenshotcommandall = "furnscreenall", -- DEV ONLY: generate images for all furniture in Config.FurnitureData
	screenshotsingle = "furnscreen", -- DEV ONLY: generate image for a single object (/furnscreen objectname)
}

Config.SellSettings = {
	selltoplayer = false,       -- Allow selling a property to another player
	selltobank = false,         -- Allow selling a property back to the bank/system
	selltobankpercentage = 75, -- Percentage of the original price returned when selling to the bank
	listrealestate = true,     -- Show/list properties in the Real Estate / Dynasty 8 UI
}

Config.SafeSettings = {
	pinlength = 4, -- Length of the safe PIN code
	slots = 40,    -- Number of storage slots in the safe
	weight = 400000,  -- Maximum storage weight (depends on your inventory system)
}

Config.DefaultStorageData = {
	slots = 40,    -- Number of storage slots in the storage
	weight = 100000,  -- Maximum storage weight (depends on your inventory system)
}

Config.StorageLimit = {
	enabled = true, -- Enable storage limits to prevent players from placing an excessive number of storage containers
	maxstorage = 5, -- Maximum number of storage stashes that can be placed inside one property
	maxsafe = 5, -- Maximum number of safes that can be placed inside one property
}

Config.ManagementSettings = {
	enablecommand = true, -- Enable this feature if you want the player to be able to open the management menu anywhere in the property.
	command = "management",
}

Config.PropertyPreviewSharedInstance = true -- If false, each player previews the property in a separate instance; if true, all players share the same preview instance and can see each other.

Config.StarterApartments = { -- Instructions for implementing starter apartments in your multicharacter system can be found in [Dev Tools - Docs]/STARTER APARTMENTS.txt
	complexid = "509507963", -- You must create an apartment complex and enter the complex ID (houseId) from the database here
	apartmenttype = "SHELL", -- Apartment type: SHELL or IPL
	apartmentid = "rtx_housing_shell_1", -- Index from Config.HouseShells or Config.HouseIpls
	apartmenttheme = "modern", -- Theme used for IPL apartments only
	furnitureinside = true, -- Enable if players are allowed to place furniture inside the apartment
	wardrobe = true, -- Enable if the apartment includes a wardrobe
	storage = true, -- Enable if the apartment includes storage
	storagedata = {
		slots = 40,       -- Number of storage slots
		weight = 100000, -- Maximum storage weight (depends on your inventory system)
	},	
	cantransfer = false, -- Enable if players are allowed to transfer the starter apartment
	cansell = false, -- Enable if players are allowed to sell the starter apartment
	sellprice = 0, -- Sell price (usually 0 for starter apartments)
	canlist = false, -- Enable if players are allowed to list the apartment on the market
}

Config.ServicesSettings = {
	["electricity"] = {
		ratedefault     = 5.0,  -- Default price per unit (kWh)
		debtforshutdown = 10.0,  -- If unpaid debt reaches this value, service can be shut down
		rate            = "per kWh", -- Label shown in UI
		unit            = "kWh",     -- Unit shown in UI
		passiveTickEnabled = true,   -- If true, consumption increases passively over time
		passiveUnitPerTick = 0.10,   -- Units consumed per passive tick
	},
	["water"] = {
		ratedefault     = 5.0,  -- Default price per unit (L)
		debtforshutdown = 10.0, -- If unpaid debt reaches this value, service can be shut down
		rate            = "per L", -- Label shown in UI
		unit            = "L", -- Unit shown in UI
		passiveTickEnabled = true, -- If true, consumption increases passively over time
		passiveUnitPerTick = 0.10, -- Units consumed per passive tick
	},
	["internet"] = {
		ratedefault     = 5.0,  -- Default price per unit (GB)
		debtforshutdown = 15.0,  -- If unpaid debt reaches this value, service can be shut down
		rate            = "per GB", -- Label shown in UI
		unit            = "GB", -- Unit shown in UI
		passiveTickEnabled = true, -- If true, consumption increases passively over time
		passiveUnitPerTick = 0.055, -- Units consumed per passive tick
	},

	rentcycle = "month",               -- Billing cycle label (used in UI / logic)
	passiveTickEveryMs = 60 * 60 * 1000 -- Passive consumption tick interval in ms (every 5 minutes)
}


Config.ServiceRateZones = {
	--[[
	ServiceRateZones:
	This config defines custom service pricing for different areas (zones) on the map.

	- Each zone can override default service rates (electricity, water, internet)
	- When a player/property is inside a zone, its service rates are used instead of defaults
	- If no zone is found near the given coordinates, values from Config.ServicesSettings are used
	]]
	["downtown"] = {
		label = "Downtown",
		coords = vector3(215.0, -810.0, 30.0),
		radius = 400.0,
		services = {
			electricity = 1.7,
			water = 1.3,
			internet = 1.8,
		}
	},

	["rockford_hills"] = {
		label = "Rockford Hills",
		coords = vector3(-820.0, 180.0, 70.0),
		radius = 350.0,
		services = {
			electricity = 2.2,
			water = 1.6,
			internet = 2.5,
		}
	},

	["vinewood_hills"] = {
		label = "Vinewood Hills",
		coords = vector3(-500.0, 600.0, 120.0),
		radius = 500.0,
		services = {
			electricity = 2.0,
			water = 1.5,
			internet = 2.2,
		}
	},

	["del_perro"] = {
		label = "Del Perro",
		coords = vector3(-1400.0, -600.0, 30.0),
		radius = 400.0,
		services = {
			electricity = 1.8,
			water = 1.4,
			internet = 2.0,
		}
	},

	["mirror_park"] = {
		label = "Mirror Park",
		coords = vector3(1100.0, -400.0, 60.0),
		radius = 350.0,
		services = {
			electricity = 1.4,
			water = 1.1,
			internet = 1.3,
		}
	},

	["vespucci"] = {
		label = "Vespucci",
		coords = vector3(-1200.0, -1200.0, 10.0),
		radius = 450.0,
		services = {
			electricity = 1.6,
			water = 1.2,
			internet = 1.7,
		}
	},

	["alta"] = {
		label = "Alta",
		coords = vector3(300.0, -200.0, 50.0),
		radius = 300.0,
		services = {
			electricity = 1.5,
			water = 1.2,
			internet = 1.6,
		}
	},

	["davis"] = {
		label = "Davis",
		coords = vector3(150.0, -1600.0, 30.0),
		radius = 400.0,
		services = {
			electricity = 1.1,
			water = 0.9,
			internet = 1.0,
		}
	},

	["sandy_shores"] = {
		label = "Sandy Shores",
		coords = vector3(1700.0, 3600.0, 35.0),
		radius = 700.0,
		services = {
			electricity = 0.9,
			water = 0.7,
			internet = 0.8,
		}
	},

	["paleto_bay"] = {
		label = "Paleto Bay",
		coords = vector3(-100.0, 6300.0, 35.0),
		radius = 600.0,
		services = {
			electricity = 1.0,
			water = 0.8,
			internet = 0.9,
		}
	}

}

Config.ActivitySettings = {
	AccessActivityCount = 5, -- Maximum number of activity log entries stored/displayed
	logtypes = {
		["enter"] = {
			enabled = true,
			text = "Someone entered the property",
		},
		["unlock"] = {
			enabled = true,
			text = "The door was unlocked.",
		},
		["lock"] = {
			enabled = true,
			text = "The door was locked.",
		},		
		["doorbell"] = {
			enabled = true,
			text = "Doorbell rung",
		},			
		["accessblocked"] = {
			enabled = true,
			text = "Access attempt blocked",
		},				
	},
}

Config.TenantPropertyPermissions = {
	-- Tenant permissions for specific property features.
	-- true  = tenants can use the feature
	-- false = tenants cannot use the feature (owner only)
	["furnitureMenu"] = true,
	["unlocking"]     = true,
	["wardrobe"]      = true,
	["storage"]       = true,
	["manageKeys"]    = false,
	["upgrades"]      = false,
	["payBills"]      = false,
	["garage"]        = false,
	["orderServices"] = true,
	["tenants"]       = false,
	["clean"]         = true,
	["doorbell"]      = true,
	["cameras"]       = true,		
	["services"]       = true,	
	["positions"]       = true,
}

Config.ReturnPlayerIfTooFar = true -- Teleport the player back to the exit location if they move too far away from the shell/IPL.

Config.MotionDetectorSettings = {
	detectoutsidemotion = true, -- Detect movement outside the property area
	motionblip = {enabled = true, lifetime = 30000},  -- Optional blip for detected motion (lifetime in ms)
	detectenterproperty = true, -- Detect when someone enters the property
	motionalertcooldown = 120000, -- Alert cooldown in ms (prevents spam)
}

Config.Upgrades = {
	-- Property upgrades purchasable by the owner.
	-- id          = internal identifier (used in code & DB)
	-- label       = name shown in UI
	-- price       = purchase price
	-- description = text shown in the upgrade menu

	["cameras"] = {
		id = "cameras", -- Enables property camera system
		label = "Cameras",
		price = 40000,
		description = "Provides access to interior and exterior property cameras. Lets you view live security feeds from the Housing menu."
	},

	["motion"] = {
		id = "motion", -- Enables motion detection around the property
		label = "Motion Sensors",
		price = 25000,
		description = "Installs motion sensors near doors and windows. Alerts you when unauthorized movement is detected around the property."
	},

	["alarm"] = {
		id = "alarm", -- Enables alarm system integration
		label = "Alarm",
		price = 40000,
		description = "Adds a security alarm system. Triggers audible alerts when tampering or forced entry is detected."
	},

	["doorbell"] = {
		id = "doorbell", -- Unlocks doorbell sounds & notifications
		label = "Doorbell",
		price = 35000,
		description = "Enables customizable doorbell sounds and notifications when someone rings your doorbell."
	},

	["smarthome"] = {
		id = "smarthome", -- Enables smart home features 
		label = "Smart Home",
		price = 250000,
		description = "Turns your property into a smart home with remote lighting, automation settings, and system integrations."
	},

	["robotvacuum"] = {
		id = "robotvacuum", -- Enables robotic vacuum cleaning
		label = "Robot Vacuum",
		price = 125000,
		description = "Allows using an automated floor-cleaning robot. Can be activated through the Housing clean menu."
	},
}

Config.Bills = {
	-- Bill types applied to properties.
	-- enabled = if false, the bill will not be charged or displayed

	["water"] = {
		id = "water", -- Water usage bill
		label = "Water",
		enabled = true,
	},

	["electricity"] = {
		id = "electricity", -- Electricity usage bill
		label = "Electricity",
		enabled = true,
	},

	["internet"] = {
		id = "internet", -- Internet service bill
		label = "Internet",
		enabled = true,
	},

	["rent"] = {
		id = "rent", -- Monthly rent (for rented properties)
		label = "Rent",
		enabled = true,
	},

	["tax"] = {
		id = "tax", -- Property tax charged periodically
		label = "Property Tax",
		enabled = true,
	},
}


Config.FinanceSettings = {
  tickEveryMs = 1000 * 60 * 1000, -- Interval in milliseconds for finance updates (10 minutes)

  rent = {
    enabled = true, -- Enable or disable rent billing
    removeownership = true, -- If enabled, ownership will be removed when rent bills are not paid
    addPercentPerTick = 0.25, -- Percentage of the monthly rent added on each tick
    evictAtPercent = 200.0, -- Evict the owner when unpaid rent reaches this percentage
    lastWarningAtPercent = 10.0, -- Percentage at which the last payment warning is sent
  },

  tax = {
    enabled = true, -- Enable or disable property tax billing
    removeownership = true, -- If enabled, ownership will be removed when taxes are not paid
    monthlyTaxAmount = 2000, -- Base monthly tax amount
    addPercentPerTick = 0.25, -- Percentage of the monthly tax added on each tick
    repossessAtPercent = 200.0, -- Repossess the property when unpaid tax reaches this percentage
    lastWarningAtPercent = 10.0, -- Percentage at which the last payment warning is sent
  },
}

Config.TenantsFinance = {
  tickEveryMs = 1000 * 60 * 1000, -- Interval in milliseconds for tenant billing updates (10 minutes)
  chargePercentPerTick = 5.0, -- Percentage of the tenant rent price charged per tick
  minimumCharge = 1, -- Minimum amount charged per tick
  chargeOnlyIfTenantOnline = true, -- Charge tenant rent only if the tenant is online
  payOwnerOnlyIfOnline = true, -- Pay the property owner only if they are online (otherwise payment can be skipped or stored as debt)
}

Config.DoorBells = {
	-- Available doorbell sounds selectable by the property owner.
	-- id    = internal identifier
	-- label = name shown in UI
	-- sound = relative path to sound file
	[1] = {
		id = 1,
		label = "Classic",
		sound = "sounds/doorbell1.mp3",
	},
	[2] = {
		id = 2,
		label = "Assumptions",
		sound = "sounds/doorbell2.mp3",
	},	
	[3] = {
		id = 3,
		label = "7 Weeks",
		sound = "sounds/doorbell3.mp3",
	},		
	[4] = {
		id = 4,
		label = "Lollipop",
		sound = "sounds/doorbell4.mp3",
	},			
	[5] = {
		id = 5,
		label = "Snowfall",
		sound = "sounds/doorbell5.mp3",
	},		
	[6] = {
		id = 6,
		label = "Solo",
		sound = "sounds/doorbell6.mp3",
	},	
	[7] = {
		id = 7,
		label = "Fluxx",
		sound = "sounds/doorbell7.mp3",
	},	
	[8] = {
		id = 8,
		label = "Timeless",
		sound = "sounds/doorbell8.mp3",
	},			
}

Config.Tips = {
	-- Random gameplay tips displayed in the Housing UI.
	"Change your doorbell tone to match your vibe.",
	"Grant unlocking only to trusted players.",
	"Disconnect internet when you’re away to save bills.",
	"Use the robot vacuum after parties to speed up cleaning."
}

Config.BlipSettings = {
	-- Map blip settings used for various property states/locations.
	-- blipiconid, blipdisplay, blipcolor are standard GTA blip settings.
	forsale = {
		enabled = true, -- enable this if you want display blip on map
		blipiconid = 350, -- icon type
		blipdisplay = 4, -- icon display
		blipcolor = 2, -- icon color
		blipshortrange = true, -- icon range
		blipscale = 1.0, -- icon scale
		bliptext = "For Sale", -- text of blip
	},	
	complex = {
		enabled = true, -- enable this if you want display blip on map
		blipiconid = 826, -- icon type
		blipdisplay = 4, -- icon display
		blipcolor = 2, -- icon color
		blipshortrange = true, -- icon range
		blipscale = 1.0, -- icon scale
		bliptext = "Apartment Complex", -- text of blip
	},		
	owned = {
		enabled = true, -- enable this if you want display blip on map
		blipiconid = 40, -- icon type
		blipdisplay = 4, -- icon display
		blipcolor = 3, -- icon color
		blipshortrange = true, -- icon range
		blipscale = 1.0, -- icon scale
		bliptext = "My House", -- text of blip
	},	
	furniturestore = {
		enabled = false, -- enable this if you want display blip on map
		blipiconid = 86, -- icon type
		blipdisplay = 4, -- icon display
		blipcolor = 2, -- icon color
		blipshortrange = true, -- icon range
		blipscale = 1.0, -- icon scale
		bliptext = "Furniture Store", -- text of blip
	},	
	motion = {
		enabled = true, -- enable this if you want display blip on map
		blipiconid = 161, -- icon type
		blipdisplay = 4, -- icon display
		blipcolor = 1, -- icon color
		blipshortrange = true, -- icon range
		blipscale = 1.0, -- icon scale
		bliptext = "Motion", -- text of blip
	},	
	alarm = {
		enabled = true, -- enable this if you want display blip on map
		blipiconid = 161, -- icon type
		blipdisplay = 4, -- icon display
		blipcolor = 1, -- icon color
		blipshortrange = true, -- icon range
		blipscale = 1.0, -- icon scale
		bliptext = "Alarm", -- text of blip
	},		
	realestate = {
		enabled = true, -- enable this if you want display blip on map
		blipiconid = 476, -- icon type
		blipdisplay = 4, -- icon display
		blipcolor = 2, -- icon color
		blipshortrange = true, -- icon range
		blipscale = 1.0, -- icon scale
		bliptext = "Real Estate", -- text of blip
	},		
}

Config.Keys = {
	-- Default interaction keys (used if you are NOT using a target system)
	propertymenu = "E",
	storagemenu = "E",
	wardrobemenu = "E",
	managmentmenu = "E",
	garagemenu = "E",
	kitchenmenu = "E",
	catalogmenu = "E",
	furnitureinteract = "E",
	pickdelivery = "E",
	-- Robbery controls
	robinteract = "E",
	robcancel = "F",
	-- Other interactions
	marketmenu = "E",
	cleaninteract = "E",
	cleancancel = "F",
	-- Door lock toggle
	doorlock = "G",
}

Config.BuildingTypes = {
	-- Available building shells/MLO objects for the property creator.
	-- key   = internal spawn/model name
	-- label = name shown in UI
	-- object= object/model that gets spawned
    ["lf_house_01_"] = {
        label = "House 1",
        object = "lf_house_01_",
    },
	["lf_house_04_"] = {
        label = "House 4",
        object = "lf_house_04_",
    },
	["lf_house_05_"] = {
        label = "House 5",
        object = "lf_house_05_",
    },
	["lf_house_07_"] = {
        label = "House 7",
        object = "lf_house_07_",
    },
	["lf_house_08_"] = {
        label = "House 8",
        object = "lf_house_08_",
    },
	["lf_house_09_"] = {
        label = "House 9",
        object = "lf_house_09_",
    },
	["lf_house_10_"] = {
        label = "House 10",
        object = "lf_house_10_",
    },
	["lf_house_11_"] = {
        label = "House 11",
        object = "lf_house_11_",
    },
	["lf_house_13_"] = {
        label = "House 13",
        object = "lf_house_13_",
    },
	["lf_house_14_"] = {
        label = "House 14",
        object = "lf_house_14_",
    },
	["lf_house_15_"] = {
        label = "House 15",
        object = "lf_house_15_",
    },
	["lf_house_16_"] = {
        label = "House 16",
        object = "lf_house_16_",
    },
	["lf_house_17_"] = {
        label = "House 17",
        object = "lf_house_17_",
    },
	["lf_house_18_"] = {
        label = "House 18",
        object = "lf_house_18_",
    },
	["lf_house_19_"] = {
        label = "House 19",
        object = "lf_house_19_",
    },
	["lf_house_20_"] = {
        label = "House 20",
        object = "lf_house_20_",
    },
	["db_apart_01_"] = {
        label = "Apartment 1",
        object = "db_apart_01_",
    },
	["db_apart_02_"] = {
        label = "Apartment 2",
        object = "db_apart_02_",
    },
	["db_apart_03_"] = {
        label = "Apartment 3",
        object = "db_apart_03_",
    },
	["db_apart_05_"] = {
        label = "Apartment 5",
        object = "db_apart_05_",
    },
	["db_apart_07_"] = {
        label = "Apartment 7",
        object = "db_apart_07_",
    },
	["db_apart_08_"] = {
        label = "Apartment 8",
        object = "db_apart_08_",
    },
	["db_apart_09_"] = {
        label = "Apartment 9",
        object = "db_apart_09_",
    },
	["db_apart_10_"] = {
        label = "Apartment 10",
        object = "db_apart_10_",
    },
}

Config.AssistantName = "felicia" -- name of the assistant (change if you want a different assistant name)

Config.Assistant = {

    enabled = true, -- set to true if you want to have the assistant on the server
	deepgramKey = "b026e14b00faddb0768b6f2918de14ae534cfa36", -- Deepgram API key used for speech recognition and voice replies (free key can be generated here: https://deepgram.com)
    sttModel = "nova-2", -- speech-to-text model
    language = "en-US", -- speech recognition language
    ttsVoiceModel = "aura-2-thalia-en", -- TTS voice model

    wakeWords = {"hi felicia", "hey felicia"}, -- phrases that wake the assistant

    phraseReady = "whats the word fam?", -- response when assistant wakes
    phraseUnknown = "i dont undertstand fam.", -- response when command not understood
    phraseOk = "Okay.", -- default confirmation phrase

    matchThreshold = 0.55, -- score needed to execute command directly
    confirmThreshold = 0.45, -- score where assistant asks confirmation

    autoExecuteOnConfirm = true, -- execute command automatically after confirm delay
    confirmDelayMs = 700, -- delay before auto executing confirmed command

    commandCooldownMs = 900, -- cooldown between commands to prevent spam

    orderTimeoutMs = 25000, -- time before order flow cancels

    storeMatchThreshold = 0.35, -- minimum score for matching store name
    itemMatchThreshold = 0.32, -- minimum score for matching item name

    speakkey = "Z", -- push-to-talk key label
    speakkeyid = 20, -- GTA control ID for PTT key

    openclosekey = "CAPITAL", -- key to toggle assistant
    openclosekeylabel = "CAPSLOCK", -- label shown in UI

    debugPrint = true, -- enable debug prints in console

    Fuzzy = {
        storeMinScore = 0.38, -- minimum fuzzy score for store detection
        itemMinScore = 0.32, -- minimum fuzzy score for item detection
        tokenPartialBonus = 0.14, -- bonus score for partial word matches
        tokenPartialCap = 0.42 -- maximum bonus score allowed
    },

    StoreAliases = { -- shortcuts so user can say simple store names
        ["pizza"] = "pizzathis", -- maps "pizza" to Pizza This
        ["pizzeria"] = "pizzathis",
        ["burger"] = "burgershot",
        ["burgers"] = "burgershot",
        ["cluckin"] = "cluckinbell",
        ["cluckin bell"] = "cluckinbell",
        ["chicken"] = "cluckinbell",
        ["grocery"] = "gloceriesstore",
        ["groceries"] = "gloceriesstore",
        ["supermarket"] = "gloceriesstore",
        ["liquor"] = "liqour",
        ["alcohol"] = "liqour",
        ["beer"] = "liqour",
        ["vodka"] = "liqour",
        ["whiskey"] = "liqour",
        ["wine"] = "liqour"
    },

    Commands = { -- voice commands the assistant can execute

		-- name = display name of the command (only used internally / for debugging, must be unique)
		-- keywords = important words used in command detection (higher weight in matching)
		-- examples = example phrases the player might say (used for fuzzy matching)
		-- tts = phrase the assistant will speak after the command triggers
		-- action = Lua function that runs when the command is executed
        {
            name = "Lights Off", -- command display name
            keywords = {"lights", "off"}, -- main words used for matching
            examples = { -- example phrases for fuzzy matching
                "turn lights off",
                "turn the lights off",
                "lights off",
                "switch lights off",
                "lights out",
                "kill the lights"
            },
            tts = "Okay. Turning the lights off.", -- voice reply
            action = function() -- function executed when command runs
                TriggerEvent("rtx_housing:Angel:LightsHandler", false)
            end
        },

        {
            name = "Lights On", -- command display name
            keywords = {"lights", "on"}, -- matching keywords
            examples = { -- example phrases for fuzzy matching
                "turn lights on",
                "turn the lights on",
                "lights on",
                "switch lights on",
                "enable lights",
                "lights up"
            },
            tts = "Okay. Turning the lights on.", -- voice reply
            action = function()
                TriggerEvent("rtx_housing:Angel:LightsHandler", true)
            end
        },

        {
            name = "Lock Door", -- lock property door
            keywords = {"lock", "door"}, -- matching keywords
            examples = {"lock door", "lock the door", "please lock door", "lock my door"}, -- example phrases for fuzzy matching
            tts = "Okay. Locking the door.", -- voice reply
            action = function()
                TriggerEvent("rtx_housing:Angel:LockHandler", true)
            end
        },

        {
            name = "Unlock Door", -- unlock property door
            keywords = {"unlock", "door"}, -- main words used for matching
            examples = {"unlock door", "unlock the door", "please unlock door", "open the door"}, -- example phrases for fuzzy matching
            tts = "Okay. Unlocking the door.", -- voice reply
            action = function()
                TriggerEvent("rtx_housing:Angel:LockHandler", false)
            end
        },

        {
            name = "Order Service", -- general delivery ordering
            keywords = {"order", "service"}, -- main words used for matching
            examples = {
                "order service",
                "order delivery",
                "order from a store",
                "i want to order something",
                "buy something",
                "get a delivery"
            },
            tts = "Sure. Let's place an order.", -- voice reply
            action = function()
                startOrder("any") -- start full order flow
            end
        },

        {
            name = "Order Food", -- food delivery ordering
            keywords = {"order", "food"}, -- main words used for matching
            examples = {"order food", "get food", "buy food", "i want food", "bring me food"}, -- example phrases for fuzzy matching
            tts = "Okay. Let's order food.", -- voice reply
            action = function()
                startOrder("food")
            end
        },

        {
            name = "Order Dancer", -- dancer ordering command
            keywords = {"order", "dancer", "lapdance"}, -- main words used for matching
            examples = {"order dancer", "get a dancer", "send a dancer", "call a dancer", "lapdance", "dancer"}, -- example phrases for fuzzy matching
            tts = "Alright. Let's order a dancer.", -- voice reply
            action = function()
                startDancerOrder() -- start dancer order flow
            end
        },

        {
            name = "Start Vacuum", -- start robotic vacuum
            keywords = {"start", "vacuum"}, -- main words used for matching
            examples = {"start vacuum", "turn on vacuum", "vacuum on", "start the vacuum cleaner"}, -- example phrases for fuzzy matching
            tts = "Okay. Starting the vacuum.", -- voice reply
            action = function()
                TriggerEvent("rtx_housing:Angel:VacuumHandler", true)
            end
        },

        {
            name = "Stop Vacuum", -- stop robotic vacuum
            keywords = {"stop", "vacuum"}, -- main words used for matching
            examples = {"stop vacuum", "turn off vacuum", "vacuum off", "stop the vacuum cleaner"}, -- example phrases for fuzzy matching
            tts = "Okay. Stopping the vacuum.", -- voice reply
            action = function()
                TriggerEvent("rtx_housing:Angel:VacuumHandler", false)
            end
        }
    },
    SmallTalk = {	-- casual conversations that do NOT trigger gameplay actions

		-- name = name of the small talk category (used for debugging)
		-- patterns = phrases that trigger this response (simple text match)
		-- replies = random responses the assistant can say
        {
            name = "Greeting",
            patterns = {"hello", "hi", "hey", "good morning", "good afternoon", "good evening"},
            replies = {
                "Hey! What can I do for you?",
                "Hello! I'm here.",
                "Hi there. I'm listening.",
                "Hey! Ready when you are."
            }
        },
        {
            name = "How are you",
            patterns = {"how are you", "how are you doing", "how you doing", "how's it going", "hows it going"},
            replies = {
                "I'm doing great, thanks for asking.",
                "I'm good! What do you need?",
                "All good here. How can I help?",
                "Feeling awesome. Give me a command."
            }
        },
        {
            name = "User is fine",
            patterns = {
                "i am fine",
                "im fine",
                "i'm fine",
                "i am good",
                "im good",
                "i'm good",
                "i am okay",
                "im okay",
                "i'm okay",
                "doing fine",
                "pretty good",
                "not bad"
            },
            replies = {
                "Aww, glad to hear that.",
                "That's cute. I'm happy you're doing well.",
                "Nice! Glad you're feeling good.",
                "Love that. What can I do for you next?"
            }
        },
        {
            name = "User is sad",
            patterns = {"i am sad", "im sad", "i'm sad", "not good", "bad day", "im tired", "i'm tired"},
            replies = {
                "Aw, I'm sorry. Want to tell me what's up?",
                "That sucks. I'm here with you. What can I do to help?",
                "Sending you good vibes. Want a small win—like lights on?"
            }
        },
        {
            name = "Compliment",
            patterns = {"you are cute", "you're cute", "i like you", "love you", "good job"},
            replies = {
                "Aww, thank you. You're pretty cool too.",
                "Stop, you're making me blush. What’s next?",
                "That made my day. Tell me what you need."
            }
        },
        {
            name = "Thanks",
            patterns = {"thanks", "thank you", "appreciate it", "ty"},
            replies = {
                "You're welcome!",
                "No problem.",
                "Anytime!",
                "Glad to help."
            }
        },
        {
            name = "Joke",
            patterns = {"tell me a joke", "say something funny", "make me laugh"},
            replies = {
                "I would tell you a joke about cars, but it might backfire.",
                "I tried to catch fog once. Mist.",
                "I’m on a seafood diet. I see food and I order it."
            }
        },
        {
            name = "Name",
            patterns = {"what is your name", "who are you"},
            replies = {
                "I'm " .. Config.AssistantName .. ".",
                "You can call me " .. Config.AssistantName .. "."
            }
        },
        {
            name = "Help",
            patterns = {"help", "what can you do", "what do you do", "commands"},
            replies = {
                "Try: lock door, unlock door, lights off, lights on, order food, order dancer, start vacuum, stop vacuum.",
                "Say things like: turn the lights off… or start vacuum."
            }
        },
        {
            name = "Knock Knock Joke",
            patterns = {
                "knock knock",
                "tell me a knock knock joke",
                "say knock knock"
            },
            replies = {
                "Knock knock. Who’s there? Lettuce. Lettuce who? Lettuce in, it’s cold out here!",
                "Knock knock. Who’s there? Boo. Boo who? Don’t cry, it’s just a joke!",
                "Knock knock. Who’s there? Cow says. Cow says who? No silly—cow says moo!"
            }
        },
        {
            name = "Knock Knock Joke",
            patterns = {
                "knock knock",
                "tell me a knock knock joke",
                "say knock knock"
            },
            replies = {
                "Knock knock. Who’s there? Lettuce. Lettuce who? Lettuce in, it’s cold out here!",
                "Knock knock. Who’s there? Boo. Boo who? Don’t cry, it’s just a joke!",
                "Knock knock. Who’s there? Cow says. Cow says who? No silly—cow says moo!"
            }
        }
    },
}


Config.IslandTypes = {
	-- Available island platforms (used for custom islands / water properties).
	-- offsets are used to align the building correctly on the island object.
	["rtx_djn_housing_island_small_1"] = {
		label = "Small Island 1",
		object = "rtx_djn_housing_island_small_1",
		offsets = vector3(-8.341553, -30.360596, 5.621299),
	},
	["rtx_djn_housing_island_small_2"] = {
		label = "Small Island 2",
		object = "rtx_djn_housing_island_small_2",
		offsets = vector3(-7.078369, -0.561523, 5.469539),
	},
	["rtx_djn_housing_island_small_3"] = {
		label = "Small Island 3",
		object = "rtx_djn_housing_island_small_3",
		offsets = vector3(-5.785645, 29.337402, 2.794368),
	},
	["rtx_djn_housing_island_small_4"] = {
		label = "Small Island 4",
		object = "rtx_djn_housing_island_small_4",
		offsets = vector3(0.291138, 0.592651, 3.515),
	},
	["rtx_djn_housing_island_medium_1"] = {
		label = "Medium Island",
		object = "rtx_djn_housing_island_medium_1",
		offsets = vector3(-19.415771, -45.505615, 9.0),
	},	
	["rtx_djn_housing_island_large_1"] = {
		label = "Large Island 1",
		object = "rtx_djn_housing_island_large_1",
		offsets = vector3(36.675537, 35.469971, 12.90),
	},	
	["rtx_djn_housing_island_large_2"] = {
		label = "Large Island 2",
		object = "rtx_djn_housing_island_large_2",
		offsets = vector3(6.064453, 91.383301, 6.0),
	},		
}

Config.SignRender = true -- If true, property signs are rendered (e.g. "For Sale" signage)
 
Config.ObjectsRenderDistance = {
	island = 500.0,    -- Render distance for island objects
	building = 500.0,  -- Render distance for buildings
	sign = 500.0,      -- Render distance for sign objects
	deliveryboxes = 500.0, -- Render distance for delivery boxes objects
	signrender = 25.0, -- Render distance for sign text/details
}

Config.LockpickDifficulty = {
	-- Lockpicking minigame presets.
	-- pins      = number of pins
	-- speed     = minigame speed multiplier
	-- sweetSize = size of the success window (smaller = harder)
	-- failLimit = allowed failed attempts
	-- timeLimit = time limit in seconds (0 = no limit)
	-- (your entries stay the same)
    ["easy"] = {
        pins      = 3,
        speed     = 0.9,
        sweetSize = 0.35,
        failLimit = 5,
        timeLimit = 0, 
    },
    ["normal"] = {
        pins      = 4,
        speed     = 1.1,
        sweetSize = 0.25,
        failLimit = 4,
        timeLimit = 0,
    },
    ["hard"] = {
        pins      = 5,
        speed     = 1.5,
        sweetSize = 0.18,
        failLimit = 3,
        timeLimit = 25,
    },
    ["nightmare"] = {
        pins      = 6,
        speed     = 1.9,
        sweetSize = 0.14,
        failLimit = 2,
        timeLimit = 18,
    }
}

Config.LockPickRaidSettings = {
	LockPick = {
		enabled = true, -- Enable property lockpickingEnable property lockpicking
		difficulty = "hard", -- Preset from Config.LockpickDifficulty
		itemrequired = true, -- Require an item to lockpick
		itemname = "lockpick", -- Item name
		itemcount = 1, -- Required amount
		removeafteruse = true, --  Remove item on use
		ownermustbeonline = false, -- If true, lockpicking only works when owner is online
		requiredpolice = true, -- If true, minimum police online is required
		policerequiredcount = 1, -- Minimum police count online
		jobs = {
			["police"] = true, 
		},
	},			
	Raid = {
		enabled = true, -- Enable property raid (usually police-only)
		difficulty = "easy", -- difficulty for raid - Preset from Config.LockpickDifficulty
		itemrequired = false, -- Require an item to raid
		itemname = "stormram", -- Item name
		itemcount = 1, -- Required amount
		removeafteruse = true, -- Remove raid item after use
		openstorage = true, -- if you want to allow police officers to open storage during a raid, enable this feature.
		jobs = {
			["police"] = true,
		},
	},	
}

Config.AlarmSettings = {
	Police = { -- alarm settings for police
		alert = true, -- enable this if you want alert police when alarm is triggered
		jobs = { -- jobs for alarm
			["police"] = true,
		},			
		Alerts = {
			lockpickstart = true, -- trigger alarm when player start lockpicking the property
			lockpickfail = true, -- trigger alarm when player fail lockpicking the property
			lockpicksuccess = true, -- trigger alarm when player success with lockpicking the property
		}
	},
	Owner = { -- alarm settings for property owner
		alert = true, -- enable this if you want alert owner when alarm is triggered		
		Alerts = {
			lockpickstart = true, -- trigger alarm when player start lockpicking the property
			lockpickfail = false, -- trigger alarm when player fail lockpicking the property
			lockpicksuccess = false, -- trigger alarm when player success with lockpicking the property
			raidstart = true, -- trigger alarm when police start raiding the property
			raidfail = true, -- trigger alarm when police failed raiding the property
			raidsuccess = true, -- trigger alarm when police success with raiding the property
		}
	},	
}

Config.RobberySettings = {
	enabled = true,               -- Enable property robbery feature
	ownermustbeonline = false,    -- If true, robbery/lockpick is only allowed when owner is online
	requiredpolice = false,       -- If true, requires police online
	policerequiredcount = 1,      -- Minimum police online

	jobs = { 
		["police"] = true 
	}, -- Police jobs used for checks/alerts

	alarmnrequiredforalerts = false, -- If true, alerts trigger only if the property has an alarm upgrade
	alertpolice = true,              -- Notify police on robbery start
	alertowner = true,               -- Notify owner on robbery start

	maxitems = 10,               -- Maximum number of items that can be stolen per reset window
	robberyreset = 10,           -- Reset window in minutes (restores the max stealable count)

	itemrequired = false,        -- Require an item to start robbery
	itemname = "backpack",       -- Required item name
	itemcount = 1,               -- Required amount
	removeafteruse = true,       -- Remove the item after starting robbery

	robberycommand = "robbery",  -- Command used to start robbery mode

	allowrobstorage = false,     -- If true, storage can also be robbed

	robberyitems = false,        -- If true, stolen furniture is converted to items (disables blackmarket selling flow)
	blackmarket = {
		enabled = true,           -- Enable selling stolen furniture at the blackmarket
		coords = vector3(726.58, -828.28, 23.8),
		heading = 86.0,
		pedmodel = "g_m_y_famfor_01",
	},

	furnitureoutline = true,                 -- Highlight furniture that can be stolen in robbery mode
	furnitureoutlinecolor = {r = 255, g = 102, b = 255}, -- Outline color
}

Config.RealEstateSettings = {
	enabled = true, -- Enable Dynasty 8 / Real Estate property browsing
	realestateagency = "Dynasty 8", -- Agency name shown in UI
	realestatecoords = vector3(-1082.23, -247.68, 36.76), -- NPC/marker location for the real estate menu
	realestatesellcut = true, 
	-- Enables commission for the real estate society when a house is sold.
	-- If enabled, the defined percentage below will be automatically calculated
	-- from the final sale price and added to the real estate society account.

	realestatepercentage = 10, 
	-- Commission percentage taken from the total selling price.
	-- Example: If a house is sold for $100,000 and percentage = 20,
	-- the real estate society will receive $20,000.

	-- IMPORTANT:
	-- If you are using a custom society / banking / management system
	-- (e.g. custom qb-banking, okokBanking, renewed-banking, custom ESX addonaccount, etc.),
	-- you MUST edit the AddRealEstatePercentage function
	-- located in: server/other.lua
	-- and adjust the society money handling to match your framework.

}

Config.CleanlinessSettings = {
    -- =========================
    -- Passive cleanlin accumulation
    -- =========================
    passiveTickEnabled   = true,           -- Enable passive cleanliness decay
    passiveTickEveryMs   = 60 * 60 * 1000,  -- How often cleanliness decays (ms)
    passiveDropPerTick   = 2.5,             -- How much cleanliness (%) drops per tick

    minClean             = 0.0,             -- Minimum cleanliness value
    maxClean             = 100.0,           -- Maximum cleanliness value
	addPercent = 15.0,        -- How much cleanliness (%) is added per action
	cleantime = 5, -- time cleaning

    -- =========================
    -- Robotic vacuum cleaner
    -- =========================
    vacuum = {
        enabled = true,                     -- Enable robotic vacuum system
        tickEveryMs = 30 * 1000,            -- How often vacuum cleans (ms)
        cleanPointsPerTick = 1,             -- How many cleanpoints are cleaned per tick
        requireElectricity = true,          -- Vacuum requires electricity to operate
		mloAddPerTick = 15.0,     -- MLO: cleanliness % added per tick (e.g. 15%)
    }
}

Config.GiveApartments = { -- GIVE APARTMENTS: These apartments can be manually assigned to players using GivePlayerApartment(playerSource, apartmentId) (example: GivePlayerApartment(1, "apartment1")); for full usage details and integration instructions, please refer to our online documentation.
	["apartment1"] = {
		complexid = "509507963", -- You must create an apartment complex and enter the complex ID (houseId) from the database here
		apartmenttype = "SHELL", -- Apartment type: SHELL or IPL
		apartmentid = "rtx_housing_shell_1", -- Index from Config.HouseShells or Config.HouseIpls
		apartmenttheme = "modern", -- Theme used for IPL apartments only
		furnitureinside = true, -- Enable if players are allowed to place furniture inside the apartment
		wardrobe = true, -- Enable if the apartment includes a wardrobe
		storage = true, -- Enable if the apartment includes storage
		storagedata = {
			slots = 40,       -- Number of storage slots
			weight = 100000, -- Maximum storage weight (depends on your inventory system)
		},	
		cantransfer = false, -- Enable if players are allowed to transfer the starter apartment
		cansell = false, -- Enable if players are allowed to sell the starter apartment
		sellprice = 0, -- Sell price (usually 0 for starter apartments)
		canlist = false, -- Enable if players are allowed to list the apartment on the market
	},
	["apartment2"] = {
		complexid = "509507963", -- You must create an apartment complex and enter the complex ID (houseId) from the database here
		apartmenttype = "SHELL", -- Apartment type: SHELL or IPL
		apartmentid = "rtx_housing_shell_2", -- Index from Config.HouseShells or Config.HouseIpls
		apartmenttheme = "modern", -- Theme used for IPL apartments only
		furnitureinside = true, -- Enable if players are allowed to place furniture inside the apartment
		wardrobe = true, -- Enable if the apartment includes a wardrobe
		storage = true, -- Enable if the apartment includes storage
		storagedata = {
			slots = 40,       -- Number of storage slots
			weight = 100000, -- Maximum storage weight (depends on your inventory system)
		},	
		cantransfer = false, -- Enable if players are allowed to transfer the starter apartment
		cansell = false, -- Enable if players are allowed to sell the starter apartment
		sellprice = 0, -- Sell price (usually 0 for starter apartments)
		canlist = false, -- Enable if players are allowed to list the apartment on the market
	},	
}

Config.ESXFramework = {
	newversion = true, -- Set to true if you're using the newer ESX versions (prevents old SharedObject errors)
	getsharedobject = "esx:getSharedObject", -- Event name used to fetch ESX shared object (old ESX compatibility)
	resourcename = "es_extended" -- Name of your ESX resource folder
}

Config.QBCoreFrameworkResourceName = "qb-core" -- QBCore resource name (change if your core resource has a different folder name)

Config.PlayerLoadedEvent = { -- load methods of housing
	esx = "esx:playerLoaded", 
	qbcore = "QBCore:Client:OnPlayerLoaded",
	standalone = "playerLoaded",
}

Config.SendHousesInBatches = true -- Enable this if you want to send housing data in batches instead of one large event

Config.LatentEventBps = 400000 -- Bandwidth per second (BPS) used for latent events (controls how fast data is sent)

Config.ZoneLabels = {
	-- ZoneLabels:
	-- Maps GTA zone codes to readable location names.
	-- Used for UI text, property info, logs, notifications, and zone display.
	-- Key   = zone code returned by GetNameOfZone()
	-- Value = human-readable zone name shown to players
    AIRP = "Los Santos International Airport",
    ALAMO = "Alamo Sea",
    ALTA = "Alta",
    ARMYB = "Fort Zancudo",
    BANHAMC = "Banham Canyon",
    BANNING = "Banning",
    BEACH = "Vespucci Beach",
    BHAMCA = "Banham Canyon",
    BRADP = "Braddock Pass",
    BRADT = "Braddock Tunnel",
    BURTON = "Burton",
    CALAFB = "Calafia Bridge",
    CANNY = "Raton Canyon",
    CCREAK = "Cassidy Creek",
    CHAMH = "Chamberlain Hills",
    CHIL = "Vinewood Hills",
    CHU = "Chumash",
    CMSW = "Chiliad Mountain State Wilderness",
    CYPRE = "Cypress Flats",
    DAVIS = "Davis",
    DELBE = "Del Perro Beach",
    DELPE = "Del Perro",
    DELSOL = "Puerto Del Sol",
    DESRT = "Grand Senora Desert",
    DOWNT = "Downtown",
    DTVINE = "Downtown Vinewood",
    EAST_V = "East Vinewood",
    EBURO = "El Burro Heights",
    ELYSIAN = "Elysian Island",
    GALFISH = "Galilee",
    GOLF = "Richman Golf Course",
    GRAPES = "Grapeseed",
    GREATC = "Great Chaparral",
    HARMO = "Harmony",
    HAWICK = "Hawick",
    HORS = "Vinewood Racetrack",
    HUMLAB = "Humane Labs",
    JAIL = "Bolingbroke Penitentiary",
    KOREAT = "Little Seoul",
    LACT = "Land Act Reservoir",
    LAGO = "Lago Zancudo",
    LDAM = "Land Act Dam",
    LEGSQU = "Legion Square",
    LMESA = "La Mesa",
    LOSPUER = "La Puerta",
    MIRR = "Mirror Park",
    MORN = "Morningwood",
    MOVIE = "Richards Majestic",
    MTCHIL = "Mount Chiliad",
    MTGORDO = "Mount Gordo",
    MTJOSE = "Mount Josiah",
    MURRI = "Murrieta Heights",
    NCHU = "North Chumash",
    NOOSE = "N.O.O.S.E Headquarters",
    OCEANA = "Pacific Ocean",
    PALCOV = "Paleto Cove",
    PALETO = "Paleto Bay",
    PALFOR = "Palomino Highlands",
    PALHIGH = "Palomino Avenue",
    PALMPOW = "Palmer-Taylor Power Station",
    PBLUFF = "Pacific Bluffs",
    PBOX = "Pillbox Hill",
    PROCOP = "Procopio Beach",
    PROL = "Prologue Mountain",
    RANCHO = "Rancho",
    RGLEN = "Richman Glen",
    RICHM = "Richman",
    ROCKF = "Rockford Hills",
    RTRAK = "Roger's Scrapyard",
    SANAND = "San Andreas",
    SANCHIA = "San Chianski Mountain Range",
    SANDY = "Sandy Shores",
    SKID = "Mission Row (Skid Row)",
    SLAB = "Stab City",
    STAD = "Maze Bank Arena",
    STRAW = "Strawberry",
    TATAMO = "Tataviam Mountains",
    TERMINA = "Terminal",
    TEXTI = "Textile City",
    TONGVAH = "Tongva Hills",
    TONGVAV = "Tongva Valley",
    VCANA = "Vespucci Canals",
    VESP = "Vespucci",
    VINE = "Vinewood",
    WVINE = "West Vinewood",
    ZANCUDO = "Zancudo River",
    ZP_ORT = "Port of South Los Santos",
    ZQ_UAR = "Davis Quartz Quarry"
}

Config.TargetIcons = {
	managmenticon   = "fa-solid fa-gear",          -- Property management / settings
	entericon       = "fa-solid fa-door-open",     -- Enter property
	targeticon      = "fa-solid fa-bullseye",      -- Interaction target
	exiticon        = "fa-solid fa-door-closed",   -- Exit property
	complexicon     = "fa-solid fa-building",      -- Apartment / building complex
	realestateicon  = "fa-solid fa-house",         -- Real estate / property listing
	blackmarketicon = "fa-solid fa-mask",          -- Black market
	catalogicon     = "fa-solid fa-book-open",     -- Furniture / shop catalog
	carticon        = "fa-solid fa-cart-shopping", -- Shopping cart
	wardrobeicon    = "fa-solid fa-shirt",         -- Wardrobe / clothes
	storageicon     = "fa-solid fa-box-archive",   -- Storage / stash
	safeicon        = "fa-solid fa-vault",          -- Safe / valuables
	bathicon        = "fa-solid fa-bath",           -- Bath
	showericon      = "fa-solid fa-shower",         -- Shower
	sinkicon        = "fa-solid fa-faucet",         -- Sink / water
	kitchenicon     = "fa-solid fa-kitchen-set",    -- Kitchen / cooking
	dooricon        = "fa-solid fa-door-closed",   -- Door
}

Config.PlayerRespawnEvent = { -- respawn methods of housing (ambulance job respawn event in hospital)
	esx = "esx_ambulancejob:playerSpawned", 
	qbcore = "hospital:client:RespawnPlayer",
	standalone = "playerRespawn",
}

Config.ShowPropertyZoneWhenPlayerIsInside = false -- enable this if you want to see the property zone when you are inside the property zone

Config.DebugMode = false -- Enable this only if you are experiencing issues; it will print additional debug information to the server console

Config.DoorCreator = {
    command         = "doorcreator",    -- /doorcreator
    keyToggleMode   = 137,              -- CAPSLOCK: toggle single/double-door mode
    keySelectDoor   = 24,               -- LMB: select door
    keyDeleteDoor   = 25,               -- RMB: delete selected door
    keyFinish       = 191,              -- ENTER: finish and save
    keyCancelDouble = 202,              -- BACKSPACE: cancel double-door selection

    -- Bounding box colors (default matches your pink theme)
    boxColor     = { r = 255, g = 102, b = 255, a = 255 },
    boxFillColor = { r = 255, g = 102, b = 255, a = 60 },

    -- Colors for the "pending" first door in double-door mode
    pendingBoxColor     = { r = 0,   g = 255, b = 150, a = 255 },
    pendingBoxFillColor = { r = 0,   g = 255, b = 150, a = 60 },

    -- Maximum model thickness to still be considered a door
    doorThicknessMax = 1.0,

    debugPrint = true -- Print debug info to console
}


Config.PolyCreatorConfig = {
    -- fixed wall height (meters), not changed in-game
    wallHeight = 40.0,

    -- base Z adjustment step (how much up/down per key press)
    baseStep = 0.5,

    -- keys for base Z adjustment (control group 0)
    keyBaseUp   = 181, -- RIGHT ARROW = base Z up
    keyBaseDown = 180, -- LEFT ARROW  = base Z down

    -- colors: {r, g, b, a}
    colorFloorLine   = {255, 102, 255, 200}, -- bottom polygon outline
    colorTopLine     = {255, 102, 255, 220}, -- top polygon outline
    colorWall        = {255, 102, 255, 50},  -- vertical walls (DrawPoly)
    colorPillar      = {255, 255, 255, 200}, -- vertical edge lines
    colorPointSphere = {255, 102, 255, 220}, -- sphere marker on top of each vertex
    colorPreview     = {0, 180, 255, 220},   -- preview ray / preview point
    colorHelpText    = {255, 255, 255, 200}
}

Config.BuildingIslandCreator = {
    keyPrev      = 180,                -- Left arrow: previous option
    keyNext      = 181,                -- Right arrow: next option
    keyConfirm   = 191,                -- ENTER: confirm selection
    debugPrint   = true,

    moveStep          = 0.1,   -- Base movement step (recommended 0.05–0.2)
    fastMoveMultiplier = 5.0,  -- Multiplier while holding SHIFT

    keyMoveForward = 32,  -- W
    keyMoveBack    = 33,  -- S
    keyMoveLeft    = 34,  -- A
    keyMoveRight   = 35,  -- D
    keyMoveUp      = 10,  -- PAGE UP
    keyMoveDown    = 11,  -- PAGE DOWN
}


Config.FurnitureSettings = {
	furnitureviacommand = true, -- Allow opening furniture menu via command
	furniturecommand = "furnituremenu", -- Command name to open the furniture menu

	moveStep           = 0.05, -- Base movement step for furniture
	fastMoveMultiplier = 5.0,  -- Movement multiplier while holding SHIFT
	rotateStep         = 2.5,  -- Rotation step in degrees

	outline = true, -- Enable outline on selected furniture
	outlinecolor = {r = 255, g = 102, b = 255}, -- Outline color (RGB)

	keyToggleFreecam = { control = 23,  ui = "F" },        -- Toggle free camera mode
	keyToggleMode    = { control = 47,  ui = "G" },        -- Toggle move / rotate mode
	keyToggleGizmo   = { control = 38,  ui = "E" },        -- Toggle transform gizmo
	keySnapToGround  = { control = 44,  ui = "Q" },        -- Snap furniture to ground
	keyGizmoSpace    = { control = 74,  ui = "H" },        -- Toggle gizmo space (world / local)

	keyMoveForward   = { control = 172, ui = "↑" },        -- Move furniture forward
	keyMoveBack      = { control = 173, ui = "↓" },        -- Move furniture backward
	keyMoveLeft      = { control = 174, ui = "←" },        -- Move furniture left
	keyMoveRight     = { control = 175, ui = "→" },        -- Move furniture right
	keyShift         = { control = 21,  ui = "Shift" },    -- Enable fast movement

	keyMoveUp        = { control = 10,  ui = "PgUp" },     -- Move furniture up
	keyMoveDown      = { control = 11,  ui = "PgDown" },   -- Move furniture down

	keyConfirm       = { control = 191, ui = "ENTER" },    -- Confirm furniture placement
	keyCancel        = { control = 194, ui = "BACKSPACE" } -- Cancel placement and revert
}


Config.OffsetCreator = false -- Enable prop offset creator for the robbery system (DEV ONLY). Example: /offsetcreator prop_speaker_03

function Notify(text, title, notifytype)
	exports["rtx_notify"]:Notify(title, text, 5000, notifytype)
end