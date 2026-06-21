SDC = {}

---------------------------------------------------------------------------------
-------------------------------Important Configs---------------------------------
---------------------------------------------------------------------------------
SDC.Target = "qb-target" --Can be one of these (If "none" is selected it will use TextUi): ["qb-target","ox-target","none"]
SDC.MenuPosition = "top-right" --Where you want the main food truck menu to show up: ['top-left', 'top-right', 'bottom-left', 'bottom-right']

SDC.ShowDebugVehiclesLoadingOnClientF8 = false --This is if you want it to show all the vehicles loading on clients f8

SDC.MaxAmountOfProjectCarsAllowed = 10 --The Max Amount Of Project Cars Allowed Per Charater At A Time

SDC.VehicleOffsetDebug = { --Debug Settings (Used To Test Vehicle Offsets For SDC.ProjectCars)
    Enabled = true, --If you want this enabled
    Command = "cbdebugvehicle" --Command to use debug feature
}

SDC.PickAndBuildCarRegenerationTime = 300 --How long it takes for a Pick and Build Car to regenerate after one is purchased (IN SECONDS)

SDC.RequiresWhitelistedJob = {--If you want it so you have to have a job to do things relating to car building!
    PickAndBuildCarInfo = false, --If you want to require a whitelisted job to see pick and build car's info
    PickAndBuildSalesmen = false, --If you want to require a whitelisted job to interact with the pick and build salesman
    TransportSpecialist = false, --If you want to require a whitelisted job to interact with the transport specialist
    ProjectCar = false, --If you want to require a whitelisted job to interact with a project car
    Stores = false --If you want to require a whitelisted job to interact with stores
} 
SDC.WhitelistedJobs = { --Whitelisted Jobs
    --EX: ["job_name"] = "job_label"

}

SDC.WebhooksEnabled = { --All Webhook Settings
    WebhookColor = 0, --Color of the webhook embed
    Purchase = true, --If you want there to be a webhook sent for purchasing a vehicle
    ProjectCarFinished = true, --If you want there to be a wehbook sent for Project Cars being finished
    ProjectCarTransfered = true, -- If you want there to be a wehhook sent for Project Cars Transfered
    ProjectCarDeleted = true -- If you want there to be a wehhook sent for Project Cars Deleted
}

SDC.ProjectCarsDecay = { --Project Car Decay Options
    CanDecayOverTime = true, --If you want it so a vehicle can be deleted due to inactivity with interaction
    AmountOfTimeBeforeDeletion = 96, --The Amount Of Time It Takes For A Vehicle To Be Deleted If Not Interacted With By Anyone (Time In Hours)
    CheckInterval = 15 --How often the script should check for decayed vehicles (Time In Minutes)
}

SDC.JobsAllowedToRemoveProjectCars = { --These are the specific jobs you would like the ability to remove any project car.
    --EX: ["job_name"] = "job_label"
    
}

SDC.DisableTransferOwnership = false --Set this to true if you would like the "Transfer Ownership" to be disabled
---------------------------------------------------------------------------------
-------------------------------Keybind Configs-----------------------------------
---------------------------------------------------------------------------------

SDC.TransportKeys = { --Keybinds for transporting project cars
    CancelTransport = {Input = "INPUT_DETONATE", InputNum = 47}, --Keybind For Cancelling Transport
    PlaceVehicle = {Input = "INPUT_PICKUP", InputNum = 38}, --Keybind For Placing The Vehicle
}

SDC.RepairKeys = { --Keybinds for repairing part on project car
    Cancel = {Input = "INPUT_DETONATE", InputNum = 47}, --Keybind For Cancelling Repair
    Repair = {Input = "INPUT_PICKUP", InputNum = 38}, --Keybind For Installing The Part
}

SDC.SwapPartKeys = { --Keybinds for swapping part on project car
    Cancel = {Input = "INPUT_DETONATE", InputNum = 47}, --Keybind For Cancelling The Part Swap
    SwapPart = {Input = "INPUT_PICKUP", InputNum = 38}, --Keybind For Swapping The Part
}

SDC.DebugKeys = { --Keybinds for offset debug 
    Cancel = {Input = "INPUT_DETONATE", InputNum = 47}, --Keybind For Cancelling Debug
}

SDC.CBCarInteractKeybind = {Input = 38, Label = "E"} --Keybind for interacting with Car Builder Car 
SDC.PJCarInteractKeybind = {Input = 38, Label = "E"} --Keybind for interacting with Project Car 

SDC.PBPedKeybind = {Input = 38, Label = "E"} --Keybind for interacting with Pick & Build Salesmen (TEXT UI ONLY)
SDC.TSPedKeybind = {Input = 38, Label = "E"} --Keybind for interacting with Transport Specialist (TEXT UI ONLY)
SDC.StorePedKeybind = {Input = 38, Label = "E"} --Keybind for interacting with Store Ped (TEXT UI ONLY)

---------------------------------------------------------------------------------
-------------------------------Icon Configs--------------------------------------
---------------------------------------------------------------------------------
SDC.Icons = { --All Icon Settings 
    PickNBuildPed = {Enabled = true, DistToDraw = 7}, --Icon For Pick & Build Ped
    TransportPed = {Enabled = true, DistToDraw = 7}, --Icon For Transport Ped
    PickNBuildVehicle = {Enabled = true, DistToDraw = 7}, --Icon For Vehicles At Pick & Build
    ProjectCar = {Enabled = true, DistToDraw = 10}, --Icon For Nearby Project Car
    RepairLocation = {Enabled = true, DistToDraw = 15}, --Icon For Repair/Part Swap Location On Vehicle
    Shop = {Enabled = true, DistToDraw = 7}, --Icon For Store Ped
}

---------------------------------------------------------------------------------
-------------------------------Pick & Build Configs------------------------------
---------------------------------------------------------------------------------
SDC.PBCoords = vec3(1019.5541, -2273.0901, 30.5022) --Pick & Build General Coords
SDC.PBBlip = {Enabled = true, Sprite = 402, Color = 0, Size = 1.0} --Pick & Build Blip Settings
SDC.PBPed = { --Pick & Build Ped Settings
    Model = "a_m_m_bevhills_02", --Ped Model
    SpawnCoords = vec4(1017.1036, -2261.4211, 30.5058, 209.0843), --Spawncoords For Ped
    SpawnDist = 50, --How close/far you have to be for it to spawn/delete the ped
    InteractDist = 2.5, --How close you have to be to interact with ped (TEXT UI ONLY)
    Blip = {Enabled = true, Sprite = 389, Color = 17, Size = 0.7} --Blip Settings
}
SDC.TSPed = { --Transport Specialist Ped Settings
    Model = "s_m_m_autoshop_02", --Ped Model
    SpawnCoords = vec4(1001.5427, -2263.3420, 30.5248, 90.5294), --Spawncoords For Ped
    SpawnDist = 50, --How close/far you have to be for it to spawn/delete the ped
    InteractDist = 1.5, --How close you have to be to interact with ped (TEXT UI ONLY)
    Blip = {Enabled = true, Sprite = 388, Color = 29, Size = 0.7} --Blip Settings
}
SDC.TransportVehicle = { --Transport Vehicle Settings
    Model = "flatbed", --Transport Truck Model
    SpawnPoints = { --Spawnpoints for transport truck at Pick & Build
        --EX: vec4(0.0, 0.0, 0.0, 0.0),

        vec4(989.5641, -2266.2756, 30.5974, 175.7793),
        vec4(997.3009, -2281.1855, 30.5973, 174.2980),
        vec4(996.8357, -2295.6665, 30.5971, 177.8666),
        vec4(989.6057, -2309.1233, 30.5976, 173.8363),
        vec4(988.1592, -2322.9070, 30.5973, 173.9482),
        vec4(986.7578, -2340.0747, 30.5972, 174.3611),
        vec4(986.7927, -2336.7551, 30.5974, 172.1965),
        vec4(985.4680, -2351.1885, 30.5974, 173.8489)
    }
}

SDC.SpawnCarDistance = 100 --How close/far you have to be for it to spawn/delete the cars at Pick & Build
SDC.ShowInteractTextDist = 2.8 --How close you have to be to interact with Pick & Build Cars
SDC.PBSpawns = { --All car spawns for Pick & Build
    --EX: vec4(0.0, 0.0, 0.0, 0.0),

    vec4(1030.1660, -2295.0571, 30.5266, 85.2722),
    vec4(1030.0314, -2299.1604, 30.5264, 264.4156),
    vec4(1029.4987, -2303.2224, 30.5264, 264.5252),
    vec4(1016.8806, -2304.9119, 30.5265, 85.7147),
    vec4(1016.6550, -2308.7197, 30.5265, 84.9312),
    vec4(1016.5237, -2312.5325, 30.5266, 265.4673),
    vec4(1015.9586, -2316.9436, 30.5239, 84.2033),
    vec4(1015.7926, -2320.7986, 30.5277, 265.1814),
    vec4(1030.6456, -2310.3933, 30.5246, 175.2165),
    vec4(1029.8009, -2319.9336, 30.5267, 354.0803),
    vec4(1028.8198, -2329.0449, 30.5236, 174.8030),
    vec4(1013.8545, -2337.0300, 30.5266, 85.1325),
    vec4(1027.3960, -2344.2048, 30.5239, 354.7895),
    vec4(1026.5261, -2352.5381, 30.5234, 175.1534),
    vec4(1015.7552, -2369.0032, 30.5335, 174.7626),
    vec4(1011.6710, -2368.8179, 30.5335, 176.6032),
    vec4(1007.8870, -2368.3120, 30.5335, 355.9106),
    vec4(1004.1725, -2368.1956, 30.5482, 355.9487),
    vec4(1000.5140, -2367.9307, 30.5898, 174.0332),
    vec4(1011.9710, -2356.3022, 30.5241, 84.0343),
    vec4(1012.8669, -2352.1738, 30.5263, 262.7948),
    vec4(1012.6066, -2348.0898, 30.5242, 85.0078),
    vec4(1013.0776, -2344.3159, 30.5243, 83.2391),
    vec4(1013.9993, -2340.7957, 30.5246, 265.0396),
    vec4(997.2529, -2356.3916, 30.5344, 354.7400),
    vec4(998.0942, -2347.3391, 30.5237, 354.8136),
    vec4(999.0818, -2338.4438, 30.5236, 175.5895),
    vec4(1001.9441, -2323.9717, 30.5239, 265.8389),
    vec4(1002.1506, -2319.9104, 30.5266, 85.3550),
    vec4(1002.7993, -2315.7803, 30.5237, 265.5849),
    vec4(1003.1623, -2311.7515, 30.5236, 264.3625),
    vec4(1003.1778, -2307.7844, 30.5266, 85.0699),
    vec4(1008.5828, -2292.4846, 30.5239, 174.4671),
    vec4(1004.0835, -2291.8230, 30.6255, 354.6663)
}

---------------------------------------------------------------------------------
-------------------------------Project Car Configs-------------------------------
---------------------------------------------------------------------------------
SDC.ShowProjectCarDist = 75 --How close/far you have to be for it to spawn/delete nearby project cars
SDC.PJInteractDist = 2.5 --How close you have to be to interact with a nearby project car

SDC.PJCarBlip = {Enabled = true, Sprite = 326, Color = 47, Size = 0.7} --Blip Settings For Owned Project Cars

SDC.PJInteractDists = { --All Repair/Part Swap Distances For Every Area
    Wheels = 1.0,
    Suspension = 1.0,
    Doors = 1.3,
    Engine = 2.0,
    Transmission = 2.0,
    Extras = 2.0
}

SDC.AxelJacks = { --All Axel Jacks Settings
    Enabled = true, --If you want it to spawn axel jacks for missing wheels
    Model = {
        Vehicle = "imp_prop_axel_stand_01a", --Axel Jack Model
        Motorcycle = "ng_proc_brick_01a" --Brick Model
    },
    OffsetFromWheel = {
        Vehicle = {vec3(0.0, 0.0, 0.3), vec3(0.0, 0.0, -0.3)}, --Offset from wheels (left is passenger side, right is driver side)
        Motorcycle = {vec3(0.0, 0.0, 0.2), vec3(0.0, 0.0, -0.2)} --Offset from wheels (left is 3 wheeled bikes, right is for 2 wheeled bikes)
    },
    Rotation = {
        Vehicle = {vec3(0.0, 180.0, 0.0), vec3(0.0, 0.0, 0.0)}, --Rotation For Axel Jack (left is passenger side, right is driver side)
        Motorcycle = {vec3(0.0, 0.0, 0.0), vec3(0.0, 0.0, 0.0)} --Rotation For Axel Jack (left is 3 wheeled bikes, right is for 2 wheeled bikes)
    }
}
SDC.CustomEngineOffsets = { --If you have a custom engine offset for vehicle that dont work with default
    --EX: ["model_name"] = {vec3(0.0, 0.0, 0.0)}
}
SDC.RarityChances = {
    --EX ["rarity_name"] = 1 --The number is how many chances get entered for its spawn. For example if my Common rarity is set to 100 and my legendary is set to 1 it gives the legendary a 0.009% chance of spawning.

    ["common"] = 50,
    ["uncommon"] = 30,
    ["rare"] = 15,
    ["epic"] = 5,
    ["legendary"] = 1,
}
SDC.ProjectCars = { --All Project Car Settings
    --[[
        Example:

        NOTE: DOES NOT SUPPORT MOTORCYCLES WITH **2** WHEELS IN FRONT

        ["model_name"] = {
            Name = "vehicle_label", --Label Of Vehicle
            Brand = "brand_label", --Brand Of Vehicle
            Year = "0000", --Make Year Of Vehicle
            Rarity = "common", --Must match one of the rarities in SDC.RarityChances
            DealershipPrice = 1, --Default Price Without Reductions Due to Damages
            VehSettings = {RearMountedEngine = false, Wheels = 4, DoorsWithSeats = 4, IsMotorcycle = true, HasTrunk = true, HasHood = true, StockTurbos = false, MissingEngineBone = false, OpenHoodWhenWorkingOnEngine = true}, --All Specific vehicle settings
            TruckOffset = {vec3(0.0, -2.2, 1.0), vec3(0.0, -10.0, -0.5), vec3(0.0, 10.0, 0.0)}, --All Truck offsets (left is for vehicle on back of transport, middle is for vehicle behind transport, do not touch right)
        }
    ]]

    ["daemon"] = {
        Name = "Daemon",
        Brand = "Western Motorcycle",
        Year = "2003",
        Rarity = "common",
        DealershipPrice = 4000,
        VehSettings = {RearMountedEngine = true, Wheels = 2, DoorsWithSeats = 0, IsMotorcycle = true, HasTrunk = false, HasHood = false, StockTurbos = false, MissingEngineBone = false, OpenHoodWhenWorkingOnEngine = false},
        TruckOffset = {vec3(0.0, -2.2, 1.0), vec3(0.0, -10.0, -0.5), vec3(0.0, 10.0, 0.0)},
    },
    ["adder"] = {
        Name = "Adder",
        Brand = "Truffade",
        Year = "2010",
        Rarity = "epic",
        DealershipPrice = 8000,
        VehSettings = {RearMountedEngine = true, Wheels = 4, DoorsWithSeats = 2, IsMotorcycle = false, HasTrunk = false, HasHood = true, StockTurbos = false, MissingEngineBone = false, OpenHoodWhenWorkingOnEngine = false},
        TruckOffset = {vec3(0.0, -2.2, 1.0), vec3(0.0, -10.0, -0.5), vec3(0.0, 10.0, 0.0)},
    },
    ["stafford"] = {
        Name = "Stafford",
        Brand = "Enus",
        Year = "1970",
        Rarity = "uncommon",
        DealershipPrice = 60000,
        VehSettings = {RearMountedEngine = false, Wheels = 4, DoorsWithSeats = 4, IsMotorcycle = false, HasTrunk = true, HasHood = true, StockTurbos = false, MissingEngineBone = false, OpenHoodWhenWorkingOnEngine = true},
        TruckOffset = {vec3(0.0, -2.2, 1.0), vec3(0.0, -10.0, -0.5), vec3(0.0, 10.0, 0.0)},
    },
    ["warrener2"] = {
        Name = "Warrener",
        Brand = "Vulcar",
        Year = "2002",
        Rarity = "common",
        DealershipPrice = 20000,
        VehSettings = {RearMountedEngine = false, Wheels = 4, DoorsWithSeats = 2, IsMotorcycle = false, HasTrunk = true, HasHood = true, StockTurbos = false, MissingEngineBone = false, OpenHoodWhenWorkingOnEngine = true},
        TruckOffset = {vec3(0.0, -2.2, 0.7), vec3(0.0, -10.0, -0.8), vec3(0.0, 10.0, 0.0)},
    },
    ["contender"] = {
        Name = "Contender",
        Brand = "Vapid",
        Year = "2012",
        Rarity = "rare",
        DealershipPrice = 45000,
        VehSettings = {RearMountedEngine = false, Wheels = 4, DoorsWithSeats = 2, IsMotorcycle = false, HasTrunk = true, HasHood = true, StockTurbos = false, MissingEngineBone = false, OpenHoodWhenWorkingOnEngine = true},
        TruckOffset = {vec3(0.0, -2.2, 1.9), vec3(0.0, -10.0, 0.5), vec3(0.0, 10.0, 0.0)},
    },
    ["buccaneer"] = {
        Name = "Cuccaneer",
        Brand = "Albany",
        Year = "1963",
        Rarity = "uncommon",
        DealershipPrice = 10000,
        VehSettings = {RearMountedEngine = false, Wheels = 4, DoorsWithSeats = 2, IsMotorcycle = false, HasTrunk = true, HasHood = true, StockTurbos = false, MissingEngineBone = false, OpenHoodWhenWorkingOnEngine = true},
        TruckOffset = {vec3(0.0, -2.2, 0.8), vec3(0.0, -10.0, -0.7), vec3(0.0, 10.0, 0.0)},
    },
}


---------------------------------------------------------------------------------
-------------------------------Car Part Configs----------------------------------
---------------------------------------------------------------------------------
SDC.CarPartSettings = { --All Car Part Configs
    Wheels = { --Wheel Configs
        TireBurst = { --Tire Configs
            Enabled = true, --If you want this to be a possible issue
            ChanceOfBeingBurst = 50, --Change for this to be an issue (0-100)
            TimeToChangePart = 5, --How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_tire", Label = "Tire", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        RimMissing = { --Wheel/Rim Configs
            Enabled = true, --If you want this to be a possible issu
            ChanceOfRimMissing = 30, --Change for this to be an issue (0-100)
            TimeToChangePart = 10, --How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_wheel", Label = "Wheel", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
    },
    Suspension = { --Suspension Configs
        BrakePad = { --Brake Pad Configs
            Enabled = true, --If you want this to be a possible issue
            ChanceOfNeedingReplaced = 40,--Change for this to be an issue (0-100)
            TimeToChangePart = 7, --How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_brakepad", Label = "Brake Pad", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_brakepad2", Label = "Race Brake Pad", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        BrakeRotor = { --Brake Rotor Configs
            Enabled = true, --If you want this to be a possible issue
            ChanceOfNeedingReplaced = 30,--Change for this to be an issue (0-100)
            TimeToChangePart = 10, --How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_brakerotor", Label = "Brake Rotor", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_brakerotor2", Label = "Race Brake Rotor", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Spring = { --Spring Configs
            Enabled = true, --If you want this to be a possible issue
            ChanceOfNeedingReplaced = 15,--Change for this to be an issue (0-100)
            TimeToChangePart = 15,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_spring", Label = "Spring", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_spring2", Label = "Race Spring", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Shock = { --Shock Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 15,--Change for this to be an issue (0-100)
            TimeToChangePart = 15,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_shock", Label = "Shock", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_shock2", Label = "Race Shock", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
    },
    Doors = { --All Door Configs
        DoorMissing = { --Door Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfDoorMissing = 20,--Change for this to be an issue (0-100)
            TimeToChangePart = 15,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_door", Label = "Door", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        DoorDamaged = { --Damaged Door Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfBeingDamaged = 40,--Change for this to be an issue (0-100)
            TimeToChangePart = 10,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_doorrepairkit", Label = "Door Repair Kit", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        }, 
        WindowBroken = { --Window Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfBeingBroken = 50,--Change for this to be an issue (0-100)
            TimeToChangePart = 7,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_window", Label = "Window", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
    },
    Engine = { --All Engine Configs
        Intake = { --Intake Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 35,--Change for this to be an issue (0-100)
            TimeToChangePart = 7,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_intake", Label = "Intake", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_intake2", Label = "Race Intake", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}}, --Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Headers = { --Header Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 15,--Change for this to be an issue (0-100)
            TimeToChangePart = 20,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_header", Label = "Header", AmtNeeded = {Vehicle = 2, Motorcycle = 2}}, Race = {Item = "sdcb_header2", Label = "Race Header", AmtNeeded = {Vehicle = 2, Motorcycle = 2}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Radiator = { --Radiator Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 10,--Change for this to be an issue (0-100)
            TimeToChangePart = 20,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_radiator", Label = "Radiator", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_radiator2", Label = "Race Radiator", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Turbo = { --Turbo Configs (ONLY FOR VEHICLE WITH STOCK TURBO ON MODEL)
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 10,--Change for this to be an issue (0-100)
            TimeToChangePart = 15,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_turbo", Label = "Turbo", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Camshaft = { --Camshaft Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 10,--Change for this to be an issue (0-100)
            TimeToChangePart = 25,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_camshaft", Label = "Camshaft", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_camshaft2", Label = "Race Camshaft", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Pistons = { --Piston Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 15,--Change for this to be an issue (0-100)
            TimeToChangePart = 25,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_piston", Label = "Piston", AmtNeeded = {Vehicle = 6, Motorcycle = 2}}, Race = {Item = "sdcb_piston2", Label = "Race Piston", AmtNeeded = {Vehicle = 6, Motorcycle = 2}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        SparkPlugs = { --Spark Plug Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 40,--Change for this to be an issue (0-100)
            TimeToChangePart = 7,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_sparkplug", Label = "Spark Plug", AmtNeeded = {Vehicle = 6, Motorcycle = 2}}, Race = {Item = "sdcb_sparkplug2", Label = "Race Spark Plug", AmtNeeded = {Vehicle = 6, Motorcycle = 2}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Oil = { --Oil Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 80,--Change for this to be an issue (0-100)
            TimeToChangePart = 7,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_oil", Label = "Oil", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_oil2", Label = "Race Oil", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Rods = { --Engine Rod Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 13,--Change for this to be an issue (0-100)
            TimeToChangePart = 20,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_rod", Label = "Engine Rod", AmtNeeded = {Vehicle = 6, Motorcycle = 2}}, Race = {Item = "sdcb_rod2", Label = "Race Engine Rod", AmtNeeded = {Vehicle = 6, Motorcycle = 2}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Rockers = { --Rocker Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 10,--Change for this to be an issue (0-100)
            TimeToChangePart = 15,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_rocker", Label = "Rocker", AmtNeeded = {Vehicle = 6, Motorcycle = 2}}, Race = {Item = "sdcb_rocker2", Label = "Race Rocker", AmtNeeded = {Vehicle = 6, Motorcycle = 2}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        CylinderHeads = { --Cylinder Head Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 10,  --Change for this to be an issue (0-100)
            TimeToChangePart = 15,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_cylinderhead", Label = "Cylinder Head", AmtNeeded = {Vehicle = 2, Motorcycle = 2}}, Race = {Item = "sdcb_cylinderhead2", Label = "Race Cylinder Head", AmtNeeded = {Vehicle = 2, Motorcycle = 2}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Alternator = { --Alternator Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 30,--Change for this to be an issue (0-100)
            TimeToChangePart = 10, --How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_alternator", Label = "Alternator", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        Starter = { --Starter Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 20,  --Change for this to be an issue (0-100)
            TimeToChangePart = 10,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_starter", Label = "Starter", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
    },
    Transmission = { --Transmission Configs
        Clutch = { --Clutch Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 15, --Change for this to be an issue (0-100)
            TimeToChangePart = 20, --How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_clutch", Label = "Clutch", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_clutch2", Label = "Race Clutch", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        TorqueConverter = { --Torque Converter Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 10,  --Change for this to be an issue (0-100)
            TimeToChangePart = 15,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_torqueconverter", Label = "Torque Converter", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_torqueconverter2", Label = "Race Torque Converter", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        GearSet = { --Gear Set Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 5, --Change for this to be an issue (0-100)
            TimeToChangePart = 25,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_gearset", Label = "Gear Set", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_gearset2", Label = "Race Gear Set", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
    }, 
    Extras = { --All Extras Configs
        Exhaust = { --Exhuast Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 5, --Change for this to be an issue (0-100)
            TimeToChangePart = 15,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_exhaust", Label = "Exhaust", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = {Item = "sdcb_exhaust2", Label = "Race Exhaust", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        FrontAxel = { --Fron Axel Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 5, --Change for this to be an issue (0-100)
            TimeToChangePart = 20,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_axel", Label = "Axel", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
        RearAxel = { --Rear Axel Configs
            Enabled = true,--If you want this to be a possible issue
            ChanceOfNeedingReplaced = 5, --Change for this to be an issue (0-100)
            TimeToChangePart = 20,--How long it takes to change/repair part
            PartItems = {Stock = {Item = "sdcb_axel", Label = "Axel", AmtNeeded = {Vehicle = 1, Motorcycle = 1}}, Race = nil},--Part Item Section ("Item" = item name, "Label" = label of item, "AmtNeeded" = amount needed for change/repair)
        },
    }
}

---------------------------------------------------------------------------------
-------------------------------Race Part Configs---------------------------------
---------------------------------------------------------------------------------
SDC.RacePartSettings = { --All Race Part Point Configs (All these points added up to total which is divided by the total mods on the vehicle to get a mod level based on race parts installed)
    Brakes = { --All Brake Race Points
        Enabled = true, --If you want this Mod Level Enabled
        PartPoints = { --All part points for this mod
            BrakePad = 5,
            BrakeRotor = 10,
        }
    },
    Suspension = { --All Suspension Race Points
        Enabled = true,--If you want this Mod Level Enabled
        PartPoints = {--All part points for this mod
            Spring = 5,
            Shock = 5,
        }
    },
    Engine = { --All Engine Race Points
        Enabled = true,--If you want this Mod Level Enabled
        PartPoints = {--All part points for this mod
            Intake = 10,
            Headers = 15,
            Radiator = 10,
            Camshaft = 15,
            Pistons = 10,
            SparkPlugs = 5,
            Oil = 5,
            Rods = 15,
            Rockers = 10,
            CylinderHeads = 10,
            Exhaust = 10,
        }
    },
    Transmission = { --All Transmission Race Points
        Enabled = true,--If you want this Mod Level Enabled
        PartPoints = {--All part points for this mod
            Clutch = 15,
            TorqueConverter = 10,
            GearSet = 10,
        }
    }
}

---------------------------------------------------------------------------------
---------------------------Items With Props Configs------------------------------
---------------------------------------------------------------------------------
SDC.ItemsWithProps = { --All items with props
    ["sdcb_tire"] = {Model = "prop_rub_tyre_01", Offset = {vec3(0.0, 0.4, 0.35)}, Rotation = vec3(0.0, 0.0, 0.0)},
    ["sdcb_wheel"] = {Model = "prop_wheel_01", Offset = {vec3(0.0, 0.4, 0.3)}, Rotation = vec3(0.0, 0.0, 0.0)},
    ["sdcb_exhaust"] = {Model = "imp_prop_impexp_exhaust_04", Offset = {vec3(-0.1, 0.4, 0.05)}, Rotation = vec3(0.0, 0.0, 90.0)},
    ["sdcb_exhaust2"] = {Model = "imp_prop_impexp_exhaust_01", Offset = {vec3(0.1, 0.4, 0.05)}, Rotation = vec3(0.0, 0.0, 90.0)},
    ["sdcb_header"] = {Model = "imp_prop_impexp_exhaust_03", Offset = {vec3(0.0, 0.4, 0.05)}, Rotation = vec3(0.0, 0.0, 0.0)},
    ["sdcb_header2"] = {Model = "imp_prop_impexp_exhaust_02", Offset = {vec3(0.0, 0.5, -0.1)}, Rotation = vec3(0.0, 0.0, 0.0)},
    ["sdcb_door"] = {Model = "prop_car_door_01", Offset = {vec3(0.0, 0.4, 0.05)}, Rotation = vec3(0.0, 0.0, 0.0)},
    
    ["sdcb_oil"] = {Model = "prop_oiltub_03", Offset = {vec3(0.1, 0.38, 0.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
    ["sdcb_oil2"] = {Model = "prop_oiltub_04", Offset = {vec3(0.1, 0.38, 0.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
    ["sdcb_radiator"] = {Model = "imp_prop_impexp_radiator_04", Offset = {vec3(0.0, 0.38, 0.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
    ["sdcb_radiator2"] = {Model = "imp_prop_impexp_radiator_01", Offset = {vec3(0.0, 0.2, 0.05)}, Rotation = vec3(0.0, 0.0, 0.0)},
    ["sdcb_axel"] = {Model = "imp_prop_impexp_diff_01", Offset = {vec3(0.0, 0.45, 0.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
    ["sdcb_brakepad"] = {Model = "imp_prop_impexp_brake_caliper_01a", Offset = {vec3(0.1, 0.4, 0.05)}, Rotation = vec3(0.0, 90.0, 0.0)},
 
    --------------------------------------------------------- Dont REMOVE BELOW
    ["door_hood"] = {Model = "imp_prop_impexp_bonnet_01a", Offset = {vec3(0.0, 0.38, -0.15)}, Rotation = vec3(90.0, 0.0, 0.0)}, --DONT REMOVE
    ["box"] = {Model = "prop_cs_cardbox_01", Offset = {vec3(-0.05, 0.38, 0.2)}, Rotation = vec3(0.0, 0.0, 0.0)}, --DONT REMOVE
}


---------------------------------------------------------------------------------
--------------------------------Store Configs------------------------------------
---------------------------------------------------------------------------------
SDC.StoreInteractDist = 1.5 --How close you have to be to interact with store ped (TEXT UI ONLY)
SDC.Stores = { --All Store Configs
    Enabled = true, --If you want stores enabled
    Stores = { --All Stores
        --[[
            Example:

            {
                Label = "store_label", --Label Of Store
                Ped = {Model = "ped_model", SpawnCoords = vec4(0.0, 0.0, 0.0, 0.0), SpawnDist = 50}, --Ped Configs For Store
                Blip = {Enabled = true, Sprite = 1, Color = 1, Size = 0.7}, --Blip Settings
                Products = { --All Products In Store
                    --EX: {Item = "item_name", Label = "item_label", Price = 1},

                    {Item = "item_name", Label = "item_label", Price = 1},
                }
            } 
        
        ]]

        {
            Label = "Car Parts Store",
            Ped = {Model = "a_f_y_eastsa_02", SpawnCoords = vec4(765.2484, -1225.6588, 25.2063, 358.7312), SpawnDist = 50},
            Blip = {Enabled = true, Sprite = 59, Color = 14, Size = 0.7},
            Products = {
                {Item = "sdcb_tire", Label = "Tire", Price = 50},
                {Item = "sdcb_wheel", Label = "Wheel", Price = 100},

                {Item = "sdcb_brakepad", Label = "Brake Pad", Price = 15},
                {Item = "sdcb_brakerotor", Label = "Brake Rotor", Price = 50},
                {Item = "sdcb_spring", Label = "Spring", Price = 75},
                {Item = "sdcb_shock", Label = "Shock", Price = 75},

                {Item = "sdcb_door", Label = "Door", Price = 150},
                {Item = "sdcb_doorrepairkit", Label = "Door Repair Kit", Price = 30},
                {Item = "sdcb_window", Label = "Window", Price = 60},

                {Item = "sdcb_intake", Label = "Intake", Price = 45},
                {Item = "sdcb_header", Label = "Header", Price = 200},
                {Item = "sdcb_radiator", Label = "Radiator", Price = 150},
                {Item = "sdcb_turbo", Label = "Turbo", Price = 700},
                {Item = "sdcb_camshaft", Label = "Camshaft", Price = 300},
                {Item = "sdcb_piston", Label = "Piston", Price = 40},
                {Item = "sdcb_sparkplug", Label = "Spark Plug", Price = 15},
                {Item = "sdcb_oil", Label = "Oil", Price = 60},
                {Item = "sdcb_rod", Label = "Engine Rod", Price = 30},
                {Item = "sdcb_rocker", Label = "Rocker", Price = 45},
                {Item = "sdcb_cylinderhead", Label = "Cylinder Head", Price = 100},
                {Item = "sdcb_alternator", Label = "Alternator", Price = 400},
                {Item = "sdcb_starter", Label = "Starter", Price = 400},

                {Item = "sdcb_clutch", Label = "Clutch", Price = 500},
                {Item = "sdcb_torqueconverter", Label = "Torque Converter", Price = 250},
                {Item = "sdcb_gearset", Label = "Gear Set", Price = 150},

                {Item = "sdcb_exhaust", Label = "Exhaust", Price = 400},
                {Item = "sdcb_axel", Label = "Axel", Price = 500},
            }
        },
        {
            Label = "Race Parts Store",
            Ped = {Model = "a_f_y_eastsa_02", SpawnCoords = vec4(-1375.5327, -336.3630, 38.8908, 30.0053), SpawnDist = 50},
            Blip = {Enabled = true, Sprite = 59, Color = 15, Size = 0.7},
            Products = {
                {Item = "sdcb_brakepad2", Label = "Race Brake Pad", Price = 30},
                {Item = "sdcb_brakerotor2", Label = "Race Brake Rotor", Price = 100},
                {Item = "sdcb_spring2", Label = "Race Spring", Price = 150},
                {Item = "sdcb_shock2", Label = "Race Shock", Price = 150},

                {Item = "sdcb_intake2", Label = "Race Intake", Price = 90},
                {Item = "sdcb_header2", Label = "Race Header", Price = 400},
                {Item = "sdcb_radiator2", Label = "Race Radiator", Price = 300},
                {Item = "sdcb_camshaft2", Label = "Race Camshaft", Price = 600},
                {Item = "sdcb_piston2", Label = "Race Piston", Price = 80},
                {Item = "sdcb_sparkplug2", Label = "Race Spark Plug", Price = 30},
                {Item = "sdcb_oil2", Label = "Race Oil", Price = 120},
                {Item = "sdcb_rod2", Label = "Race Engine Rod", Price = 60},
                {Item = "sdcb_rocker2", Label = "Race Rocker", Price = 90},
                {Item = "sdcb_cylinderhead2", Label = "Race Cylinder Head", Price = 200},

                {Item = "sdcb_clutch2", Label = "Race Clutch", Price = 1000},
                {Item = "sdcb_torqueconverter2", Label = "Race Torque Converter", Price = 500},
                {Item = "sdcb_gearset2", Label = "Race Gear Set", Price = 300},

                {Item = "sdcb_exhaust2", Label = "Race Exhaust", Price = 800},
            }
        }
    }
}