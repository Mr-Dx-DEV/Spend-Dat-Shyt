SDC = {}

---------------------------------------------------------------------------------
-------------------------------Important Configs---------------------------------
---------------------------------------------------------------------------------
SDC.Target = "ox_target" --Can be one of these (If "none" is selected it will use TextUi): ["qb-target","ox_target","none"]

SDC.CCJob = "ccjob" --The Job name to be able to use the car crushing area
SDC.NeedJobForScript = false --If you want this activity to be job locked (If FALSE everyone will able to crush cars!)

SDC.JobCoords = vec3(2384.9761, 3096.0366, 48.1568) --General Coords For Site
SDC.MaxJobRange = 250 --How far you need to go before you get auto clocked out

SDC.EveryoneCanSeeCrushedCars = false --If this is true it will show the crushed vehicles for everyone (Can cause MS Spikes)
---------------------------------------------------------------------------------
-------------------------------Keybind Configs-----------------------------------
---------------------------------------------------------------------------------
SDC.VehicleKeys = { --Keybinds for the vehicle hud
    SelectVehicle = {Input = "INPUT_PICKUP", InputNum = 38}, --Keybind For Selecting A Vehicle
    Connect = {Input = "INPUT_PICKUP", InputNum = 38}, --Keybind For Connecting A Vehicle
    Disconnect = {Input = "INPUT_PICKUP", InputNum = 38}, --Keybind For Disconnect The Attached Vehicle
}

SDC.SearchKeybind = {Input = 47, Label = "G"} --Keybind for Searching 
SDC.DeleteKeybind = {Input = 47, Label = "G"} --Keybind for Deleting Personal Loader 
SDC.ManagerKeybind = {Input = 38, Label = "E"} --Keybind for Talking To Manager (Only If Not Using Target)
SDC.ScrapBuyerKeybind = {Input = 38, Label = "E"} --Keybind for Talking To Manager (Only If Not Using Target)
---------------------------------------------------------------------------------
-------------------------------Animation Configs---------------------------------
---------------------------------------------------------------------------------
SDC.AnimationTimes = { --All animation Times
    SearchingVehicle = 10 --Time it takes to search a vehicle
}

---------------------------------------------------------------------------------
-------------------------------Icon Configs--------------------------------------
---------------------------------------------------------------------------------
SDC.Icons = { --All icon configs (DistToDraw is how close you have to be for the icon to show)
    Manager = {Enabled = true, DistToDraw = 7},
    ScrapBuyer = {Enabled = true, DistToDraw = 7},
    MyVehicle = {Enabled = true, DistToDraw = 50},
    Crusher = {Enabled = true, DistToDraw = 100},
    CrushedCars = {Enabled = true, DistToDraw = 20},
    SearchCrushedCar = {Enabled = true, DistToDraw = 20},
    PickupCrushedCar = {Enabled = true, DistToDraw = 20},
    PickupCarFromCrusher = {Enabled = true, DistToDraw = 20},
    Dropoff = {Enabled = true, DistToDraw = 15},
    VehicleDelete = {Enabled = true, DistToDraw = 25},
}
---------------------------------------------------------------------------------
-------------------------------Vehicle Configs-----------------------------------
---------------------------------------------------------------------------------
SDC.VehicleName = "vstruck" --Name of the vehicle Model (MAKE SURE THE MODEL IS THE ONE FROM README.MD)
SDC.VehicleBlip = {Enabled = true, Sprite = 225, Color = 28, Size = 0.5} --Blip Configs for front loader
SDC.VehicleSpawnLocations = { --All spawn locations for the front loaders
    --EX: vec4(0.0, 0.0, 0.0, 0.0)

    vec4(2336.8225, 3085.6404, 48.1059, 359.2939),
    vec4(2341.6382, 3085.4290, 48.0994, 1.7472),
    vec4(2346.7947, 3085.4429, 48.0804, 8.2921),
    vec4(2351.9705, 3087.2417, 48.0439, 27.5796),
    vec4(2356.9509, 3089.0767, 48.0308, 17.7462),
    vec4(2361.5911, 3090.4954, 48.0308, 17.6869),
    vec4(2366.3977, 3093.0212, 48.0615, 40.3960),
    vec4(2369.8213, 3097.0151, 48.0629, 58.0268),
}

SDC.DeleteVehicle = vec3(2345.9456, 3104.2017, 48.1763) --Delete Vehicle coords
SDC.DeleteVehicleDist = 2.0 --How close you have to be for it to show Text UI
---------------------------------------------------------------------------------
-------------------------------Manager Configs-----------------------------------
---------------------------------------------------------------------------------
SDC.ManagerPed = "a_m_m_soucent_02" --Ped Model for Manager
SDC.ManagerSpawn = vec4(2342.2241, 3127.8494, 48.2087, 355.1588) --Spawn location for the Manager
SDC.SpawnManagerDist = 50 --How close/far you have to be for it to spawn/delete the manager ped
SDC.ManagerBlip = {Enabled = true, Sprite = 124, Color = 56, Size = 0.5} --Blip configs for the Manager

---------------------------------------------------------------------------------
-----------------------------Scrap Buyer Configs---------------------------------
---------------------------------------------------------------------------------
SDC.ScrapBuyer = { --Scrap Buyer Ped Configs
    Enabled = true, --If you want the scrap buyer to be enabled
    PedModel = "a_m_m_mexlabor_01", --Ped Model for the Scrap Buyer
    SpawnCoords = vec4(2346.1091, 3137.2439, 48.2087, 166.3705), --Spawn Coords for the Scrap Buyer
    SpawnDist = 50, --How close/far you have to be for it to spawn/delete the scrap buyer ped
    Blip = {Enabled = true, Sprite = 108, Color = 31, Size = 0.5} --Blip Configs for the Scrap Buyer
}
SDC.ScrapBuyerPurchases = { --All things the Scrap Buyer Purchases
    --EX: ["item_name"] = {Label = "Item_Label", PurchasePrice = 1},

    ["sdccj_carbattery"] = {Label = "Car Battery", PurchasePrice = 100},
    ["sdccj_sparechange"] = {Label = "Spare Change", PurchasePrice = 10},
    ["sdccj_trash"] = {Label = "Trash", PurchasePrice = 5},
    ["sdccj_wallet"] = {Label = "Random Wallet", PurchasePrice = 75},
    ["sdccj_pdocuments"] = {Label = "Personal Documents", PurchasePrice = 300},
    ["sdccj_watch"] = {Label = "Misplaced Watch", PurchasePrice = 150},
    ["sdccj_subwoofer"] = {Label = "Subwoofer", PurchasePrice = 175},
    ["sdccj_phone"] = {Label = "Dead Phone", PurchasePrice = 75},
    ["sdccj_laptop"] = {Label = "Laptop", PurchasePrice = 650},
    ["sdccj_keys"] = {Label = "Random Keys", PurchasePrice = 45},
}

---------------------------------------------------------------------------------
----------------------------Crushed Vehicle Configs------------------------------
---------------------------------------------------------------------------------
SDC.CrushSpawnDist = 100 --How close/far you need to be for it to spawn/delete the crushable cars
SDC.SearchCrushDist = 2.5 --How close you have to be to start searching the car
SDC.CrushCar_HighlightedColor = {r = 3, g = 165, b = 252, a = 155} --The color that highlights the crushable car for a search
SDC.CrushCar_HighlightedColor2 = {r = 50, g = 255, b = 50, a = 155} --The color that highlights the crushable car to connect
SDC.CrushVehicleSpawns = { --All the crushable car spawns
    --EX: vec4(0.0, 0.0, 0.0, 0.0)

    vec4(2400.4048, 3148.8052, 48.2799, 154.7694),
    vec4(2410.5647, 3157.3037, 48.3291, 268.5309),
    vec4(2421.8750, 3148.4255, 48.1641, 2.3261),
    vec4(2399.4299, 3089.8350, 48.1531, 89.0091),
    vec4(2390.0981, 3079.8340, 48.1529, 157.1398),
    vec4(2382.8325, 3035.4709, 48.1529, 111.0860),
    vec4(2351.2905, 3030.3547, 48.1523, 101.6542),
    vec4(2403.0981, 3138.1689, 48.1533, 65.5914),
    vec4(2408.8604, 3038.6326, 48.1526, 76.8289)
}
SDC.CrushedBlip = {Enabled = true, Sprite = 225, Color = 11, Size = 0.5} --All blip configs for crushed cars
SDC.CrushVehicleModels = { --All Crushable car models
    --EX: {Mode l= "vehicle_name", AttachOffsetFromTractor = {vec3(0.0, 0.0, 0.0)}, GrabPointOffset = {vec3(0.0, 0.0, 0.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 0.0, 0.0)}},

    {Model = "adder", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.3)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.3)}},
    {Model = "sultan", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.25)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.25)}},
    {Model = "sandking", AttachOffsetFromTractor = {vec3(0.0, 1.5, 0.35)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.5, 0.35)}},
    {Model = "club", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.2)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.2)}},
    {Model = "dilettante", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.25)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.25)}},
    {Model = "prairie", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.25)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.25)}},
    {Model = "felon", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.3)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.3)}},
    {Model = "windsor2", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.3)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.3)}},
    {Model = "sentinel", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.25)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.25)}},
    {Model = "clique", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.2)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.2)}},
    {Model = "dominator", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.2)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.2)}},
    {Model = "dukes", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.25)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.25)}},
    {Model = "impaler2", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.2)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.2)}},
    {Model = "slamvan", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.25)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.25)}},
    {Model = "emperor", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.25)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.25)}},
    {Model = "buffalo", AttachOffsetFromTractor = {vec3(0.0, 1.4, 0.3)}, GrabPointOffset = {vec3(0.0, 0.0, 1.0)}, GrabPointOffsetCrushed = {vec3(0.0, 0.0, 0.0)}, AttachOffsetFromTractorCrushed = {vec(0.0, 1.4, 0.3)}},
}

---------------------------------------------------------------------------------
----------------------------Search Vehicle Configs-------------------------------
---------------------------------------------------------------------------------
SDC.RandomItemsGiven = {Min = 0, Max = 4} --Random number configs for items given
SDC.SearchLoot = { --Loot pool for searching (Higher the entries the more likely you are to get it)
    --EX: {Label = "Item_Label", Name = "item_name", ChanceEntries = 1},

    {Label = "Car Battery", Name = "sdccj_carbattery", ChanceEntries = 10},
    {Label = "Spare Change", Name = "sdccj_sparechange", ChanceEntries = 30},
    {Label = "Trash", Name = "sdccj_trash", ChanceEntries = 30},
    {Label = "Random Wallet", Name = "sdccj_wallet", ChanceEntries = 15},
    {Label = "Personal Documents", Name = "sdccj_pdocuments", ChanceEntries = 5},
    {Label = "Misplaced Watch", Name = "sdccj_watch", ChanceEntries = 10},
    {Label = "Subwoofer", Name = "sdccj_subwoofer", ChanceEntries = 15},
    {Label = "Dead Phone", Name = "sdccj_phone", ChanceEntries = 20},
    {Label = "Laptop", Name = "sdccj_laptop", ChanceEntries = 3},
    {Label = "Random Keys", Name = "sdccj_keys", ChanceEntries = 15},
}
SDC.SecondRandomItemsGiven = {Min = 1, Max = 3} --Random number configs for items given for second searchs
SDC.SecondSearchLoot = { --Loot pool for searching (Higher the entries the more likely you are to get it)
    --EX: {Label = "Item_Label", Name = "item_name", ChanceEntries = 1},

    {Label = "Car Battery", Name = "sdccj_carbattery", ChanceEntries = 10},
    {Label = "Spare Change", Name = "sdccj_sparechange", ChanceEntries = 30},
    {Label = "Trash", Name = "sdccj_trash", ChanceEntries = 30},
    {Label = "Random Wallet", Name = "sdccj_wallet", ChanceEntries = 15},
    {Label = "Personal Documents", Name = "sdccj_pdocuments", ChanceEntries = 5},
    {Label = "Misplaced Watch", Name = "sdccj_watch", ChanceEntries = 10},
    {Label = "Subwoofer", Name = "sdccj_subwoofer", ChanceEntries = 15},
    {Label = "Dead Phone", Name = "sdccj_phone", ChanceEntries = 20},
    {Label = "Laptop", Name = "sdccj_laptop", ChanceEntries = 3},
    {Label = "Random Keys", Name = "sdccj_keys", ChanceEntries = 15},
}

---------------------------------------------------------------------------------
-------------------------------Crusher Configs-----------------------------------
---------------------------------------------------------------------------------
SDC.CrusherModels = { --Crusher Model Configs (Do Not Touch Unless You Know What Your Doing)
    Base = "prop_crusher_bottom",
    Top = "prop_crusher_top"
}
SDC.DefaultTopOffset = {vec3(0.0, 0.0, 0.0)} --Offset for Crusher models (Do Not Touch Unless You Know What Your Doing)

SDC.PlaceVehInCrusherDist = 1.5 --How close the crushable car has to be from the center of the crusher for it to allow to be placed
SDC.PlaceOffsetFromBase = {vec3(0.0, 5.5, 1.0)} --Vehicle placement in crusher offset (Do Not Touch Unless You Know What Your Doing)
SDC.GrabVehicleFromCrusherDist = 2.3 --How close you have to be to pickup the vehicle from the crusher

SDC.WarningLightModel = "prop_wall_light_10a" --Model for the warning light (Only spawns when crusher is active)
SDC.WaningLightOffset = {vec3(2.45, -3.0, 3.5)} --Offset for the light to be placed
SDC.WarningLightRotation = vec3(0.0, -90.0, 0.0) --Rotation of the warning light

SDC.CrusherSound = { --Sound Configs for crusher
    Enabled = true, --If you want the crushers to have sounds
    SoundFile = "car_crusher_sound.ogg", --Sound file
    MaxVolume = 1.0, --This Can be anywhere between (0.1-1.0) (DO NOT GO OUTSIDE OF PARAMETERS)
    MaxHearDistance = 30 --How close you have to be to hear the sound
}

SDC.CrusherBlip = {Enabled = true, Sprite = 380, Color = 57, Size = 0.5} --Blip configs for the crushers
SDC.SpawnCrusherDist = 125 --How close/far you have to be for it to spawn/delete the crushers
SDC.CrusherSpawns = { --All crusher spawn locations
    --EX: {BaseSpawn = vec4(0.0, 0.0, 0.0, 0.0)},

    {BaseSpawn = vec4(2331.86768, 3064.63257, 47.0863, 0.0)},
    {BaseSpawn = vec4(2368.902, 3051.9624, 47.08959, 0.0)},
    {BaseSpawn = vec4(2371.54517, 3088.04956, 47.0726852, 320.0)},
    {BaseSpawn = vec4(2420.42017, 3108.22119, 47.08461, 180.0)},
    {BaseSpawn = vec4(2432.25562, 3137.22656, 47.1573257, 180.0)}
}

---------------------------------------------------------------------------------
-------------------------------Dropoff Configs-----------------------------------
---------------------------------------------------------------------------------
SDC.RewardForDroppingOff = {Min = 500, Max = 1200} --Money reward for dropping off a vehicle
SDC.PlaceOnTrailerDist = 1.5 --How close the crushed vehicle has to be for you to drop it off
SDC.DropoffLocations = { --All Drop off locations
    --EX: vec4(0.0, 0.0, 0.0, 0.0)

    vec4(2387.9902, 3133.8667, 49.6905, 152.1670),
    vec4(2393.1016, 3146.3904, 49.2194, 158.2833),
    vec4(2374.8284, 3151.2520, 49.6905, 310.9290)
}
