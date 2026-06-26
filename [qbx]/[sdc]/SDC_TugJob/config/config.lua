SDC = {}

---------------------------------------------------------------------------------
-------------------------------Important Configs---------------------------------
---------------------------------------------------------------------------------
SDC.Target = "ox_target" --Can be one of these (If "none" is selected it will use TextUi): ["qb-target","ox_target","none"]

SDC.TugJob = "tugjob" --The Job name to be able to use the tug job
SDC.NeedJobForScript = true --If you want this activity to be job locked (If FALSE everyone will able to do the job!)
SDC.MaxDistFromJob = 1300 --How far you can go before it clocks you off (This is from manager spawn coords)

SDC.BetterBargePhysics = true -- If you want the barge to have better physics (IF TRUE IT USES HIGHER MS)

SDC.RequireBoatLicense = false -- Works for Base QB/ESX Scripts (You can change this in server_customize_me)

SDC.EnableBargesToBeSeenByEveryone = false --This will spawn barges for everyone regardless of their job (May Cause MS Jumps!)

---------------------------------------------------------------------------------
-------------------------------Keybind Configs-----------------------------------
---------------------------------------------------------------------------------
SDC.VehicleKeys = { --Keybinds for the vehicle hud
    Connect = {Input = "INPUT_PICKUP", InputNum = 38}, --Keybind For Connecting A Barge
    Disconnect = {Input = "INPUT_DETONATE", InputNum = 47}, --Keybind For Disconnect The Attached Barge
    Dropoff = {Input = "INPUT_PICKUP", InputNum = 38}, --Keybind For Dropping Off A Barge
}

SDC.HonkKeybind = {Input = 86, Label = "Honk"} --Keybind for honking (This is to lift the draw bridges)
SDC.ManagerKeybind = {Input = 38, Label = "E"} --Keybind for talking to Manager (Only Used For TextUI)

---------------------------------------------------------------------------------
-------------------------------Icon Configs--------------------------------------
---------------------------------------------------------------------------------
SDC.Icons = { --All Icon Configs 
    BridgeNone = {Draw = true}, --Distance is based on SDC.DistToStartLift
    BridgeRaising = {Draw = true}, --Distance is based on SDC.DistToStartLift
    BridgeLowering = {Draw = true}, --Distance is based on SDC.DistToStartLift
    Manager = {Draw = true, DistToDraw = 7}, --Icon For The Manager Ped
    Connect = {Draw = true, DistToDraw = 50}, --Icon For Connection Points On Barges
    Dropooff = {Draw = true, DistToDraw = 50}, --Icon For The Barge Dropoff
}

---------------------------------------------------------------------------------
-------------------------------Manager Configs-----------------------------------
---------------------------------------------------------------------------------
SDC.Manager = { --Manager Ped Configs
    PedModel = "a_m_y_busicas_01", --Ped Model Of Manager
    SpawnCoords = vec4(-316.6743, -2780.2742, 4.9953, 272.2263), --Spawn Coords For Manager
    Blip = {Enabled = true, Sprite = 404, Color = 32, Size = 0.5} --Blip Configs For Manager
}
SDC.ManagerSpawnDist = 50 --How close/far you have to be for it spawn/delete the manager ped
SDC.ManagerInteractDist = 1 --How close you have to be to interact with Manager(Only If SDC.Target Is "none")

---------------------------------------------------------------------------------
-------------------------------Tug Configs---------------------------------------
---------------------------------------------------------------------------------
SDC.TugModel = "tug2" --Model Of Tug Boat
SDC.TugBlip = {Enabled = true, Sprite = 404, Color = 32, Size = 0.5} --Tug Boat Blip Configs
SDC.TugFrontOffset = {vec3(0.0, 14.0, 1.2)} --The Front Offset Coords (DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
SDC.TugSpawns = { --All Spawn Loactions For Tug Boats
    --EX: vec4(0.0, 0.0, 0.0, 0.0)

    vec4(-297.5405, -2801.7715, 1.0125, 271.3649),
    vec4(-297.9819, -2819.9363, 1.0431, 274.2224),
    vec4(-334.1772, -2815.1777, 1.1987, 213.3054),
    vec4(-357.8107, -2849.9678, 0.5847, 319.1167)
}

SDC.SpeedReducedWithBarge = { --If you want the speed of the boat to change whether or not they have a barge
    Enabled = true, --If you want it enabled (Can Sometimes Cause Higher MS)
    Default = 30.0, --Max Speed Without Having A Barge Attached
    Slowed = 15.0 --Max Speed With Having A Barge Attached
}

---------------------------------------------------------------------------------
-------------------------------Barge Configs-------------------------------------
---------------------------------------------------------------------------------
SDC.BargeModel = "prop_barge" --Prop Model For The Barge
SDC.ConnectBargeDist = 3.5 --How close the connection point has to be from the front offset coords to connect the barge
SDC.BargeConnectionPoints = { --Connection Point Offsets From Barge (DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    Front = {vec3(0.0, -16.0, 1.0)}, --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    LSide = {vec3(-6.0, 0.0, 1.0)}, --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    RSide = {vec3(6.0, 0.0, 1.0)} --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
}
SDC.BargeTugOffset = { --The Offset of the Barge From The Tug (DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    Front = {vec3(0.0, 30.0, -0.7)}, --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    LSide = {vec3(0.0, 22.0, -0.7)}, --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    RSide = {vec3(0.0, 22.0, -0.7)} --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
}


SDC.DropoffBlip = {Sprite = 479, Color = 1, Size = 0.5} --Drop off Blip Configs
SDC.DropoffDist = 3.0 --How close the barge has to be from the exact Dropoff location to allow it
SDC.DropoffHeadingDist = 7 --The Maximum amount of heading difference the barge can have for it to be acceptable
SDC.DropoffReward = {Min = 500, Max = 1500} --Reward for dropping off a barge

SDC.BargeBlip = {Enabled = true, Sprite = 479, Color = 24, Size = 0.5} --Blip Configs For The Barge
SDC.BargeSpawnDist = 175 --How close/far you have to be for it spawn/delete the barges
SDC.BargeSpawns = { --All barge spawns (Note only half actually get used at a time)
    --EX: vec4(0.0, 0.0, 0.0, 0.0)

    vec4(-428.6446, -2420.5712, -1.0, 232.0),
    vec4(-461.3714, -2459.57373, -1.0, 49.5),
    vec4(-420.6806, -2493.71729, -1.0, 49.5),
    vec4(-376.531219, -2530.76318, -1.0, 230.0),
    vec4(-287.8029, -2520.8584, -1.0, 230.0),
    vec4(-298.480652, -2388.09937, -1.0, 140.0),
    vec4(-293.084778, -2251.015, -1.0, 55.0),
    vec4(-218.433151, -2269.10645, -1.0, 270.0),
    vec4(-148.8313, -2269.33154, -1.0, 90.0),
    vec4(-110.001755, -2269.33154, -1.0, 270.0),
    vec4(-66.58175, -2281.973, -1.0, 90.0),
    vec4(-47.903244, -2372.905, -1.0, 90.0),
    vec4(54.538662, -2432.38086, -1.0, 235.0),
    vec4(2.448986, -2395.98267, -1.0, 235.0),
    vec4(63.5194473, -2372.215, -1.0, 90.0),
    vec4(126.60965, -2372.215, -1.0, 90.0),
    vec4(112.860107, -2277.066, -1.0, 90.0),
    vec4(446.1279, -2232.184, -1.0, 335.0),
    vec4(484.622223, -2323.2417, -1.0, 63.0),
    vec4(395.617157, -2475.31885, -1.0, 180.0),
    vec4(432.4946, -2544.92065, -1.0, 180.0),
    vec4(394.220428, -2630.02124, -1.0, 180.0),
    vec4(394.220367, -2713.78418, -1.0, 180.0),
    vec4(610.844238, -2576.53247, -1.0, 220.0),
    vec4(525.523132, -2865.90674, -1.0, 250.0),
    vec4(322.283722, -3055.14136, -1.0, 180.0),
    vec4(322.2837, -3113.635, -1.0, 0.0),
    vec4(232.573364, -3352.23218, -1.0, 90.0),
    vec4(96.08072, -3325.30518, -1.0, 0.0),
    vec4(96.08072, -3260.48242, -1.0, 180.0),
    vec4(96.08072, -3205.419, -1.0, 0.0),
    vec4(96.96867, -2876.188, -1.0, 0.0),
    vec4(144.3477, -2684.5896, -1.0, 0.0),
    vec4(112.440933, -2736.44751, -1.0, 135.0),
    vec4(-145.1648, -2728.057, -1.0, 90.0),
    vec4(-209.121216, -2716.2915, -1.0, 0.0),
    vec4(-547.8371, -2779.726, -1.0, 315.0),
    vec4(-570.2984, -2845.82422, -1.0, 25.0),
}

SDC.BargeSetups = { --All barge Setups
    --[[EX:

    {
        ["prop_name"] = {Offset = {vec3(0.0, 0.0, 0.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
    },

    ]]

    {
        ["prop_pile_dirt_04"] = {Offset = {vec3(0.0, -5.0, 2.1)}, Rotation = vec3(0.0, 0.0, 0.0)},   
        ["prop_pile_dirt_04"] = {Offset = {vec3(0.0, 5.0, 2.1)}, Rotation = vec3(0.0, 0.0, 0.0)},   
    },
    {
        ["prop_pile_dirt_03"] = {Offset = {vec3(0.0, -5.0, 2.1)}, Rotation = vec3(0.0, 0.0, 0.0)},   
        ["prop_pile_dirt_03"] = {Offset = {vec3(0.0, 5.0, 2.1)}, Rotation = vec3(0.0, 0.0, 0.0)},   
    },
    {
        ["prop_pile_dirt_04"] = {Offset = {vec3(0.0, -6.0, 2.1)}, Rotation = vec3(0.0, 0.0, 0.0)},   
        ["prop_container_old1"] = {Offset = {vec3(4.0, 5.5, 3.4)}, Rotation = vec3(0.0, 0.0, 0.0)},   
        ["prop_contr_03b_ld"] = {Offset = {vec3(1.3, 5.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
        ["prop_pallet_pile_03"] = {Offset = {vec3(-2.0, 3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_pile_dirt_01"] = {Offset = {vec3(-3.5, 6.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},       
    },
    { 
        ["prop_container_old1"] = {Offset = {vec3(4.0, 5.5, 3.4)}, Rotation = vec3(0.0, 0.0, 0.0)},   
        ["prop_contr_03b_ld"] = {Offset = {vec3(1.3, 5.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
        ["prop_pipes_conc_02"] = {Offset = {vec3(-3.0, 5.0, 3.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_pile_dirt_03"] = {Offset = {vec3(0.0, -6.0, 2.1)}, Rotation = vec3(0.0, 0.0, 0.0)},      
    },
    { 
        ["prop_container_old1"] = {Offset = {vec3(4.0, 5.5, 3.4)}, Rotation = vec3(0.0, 0.0, 0.0)},   
        ["prop_contr_03b_ld"] = {Offset = {vec3(1.3, 5.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
        ["prop_container_01a"] = {Offset = {vec3(-3.0, -3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
    },
    { 
        ["prop_container_old1"] = {Offset = {vec3(4.0, 5.5, 3.4)}, Rotation = vec3(0.0, 0.0, 0.0)},   
        ["prop_contr_03b_ld"] = {Offset = {vec3(1.3, 5.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
        ["prop_container_01a"] = {Offset = {vec3(-3.0, -3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_pile_dirt_01"] = {Offset = {vec3(3.5, -4.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},    
    },
    { 
        ["prop_container_01a"] = {Offset = {vec3(-3.5, -3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01b"] = {Offset = {vec3(3.5, -3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
        ["prop_container_01c"] = {Offset = {vec3(0.0, -3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
    },
    { 
        ["prop_pipes_conc_02"] = {Offset = {vec3(2.0, 6.0, 3.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01d"] = {Offset = {vec3(-3.5, -4.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01e"] = {Offset = {vec3(3.5, -4.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
        ["prop_container_01c"] = {Offset = {vec3(0.0, -4.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
    },
    {
        ["prop_truktrailer_01a"] = {Offset = {vec3(3.0, 0.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
        ["prop_container_01d"] = {Offset = {vec3(-3.5, 0.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
    },
    {
        ["prop_container_01b"] = {Offset = {vec3(-3.5, -3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01f"] = {Offset = {vec3(3.5, -3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_cons_ply01"] = {Offset = {vec3(3.0, 7.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
        ["prop_pile_dirt_01"] = {Offset = {vec3(-3.5, 6.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
    },
    {
        ["prop_storagetank_02"] = {Offset = {vec3(0.0, -6.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01e"] = {Offset = {vec3(3.5, 3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
        ["prop_pipes_conc_02"] = {Offset = {vec3(-3.0, 5.0, 3.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
    },
        {
        ["prop_storagetank_02"] = {Offset = {vec3(0.0, -6.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01e"] = {Offset = {vec3(3.5, 3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
        ["prop_container_01a"] = {Offset = {vec3(-3.5, 3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
    },
    {
        ["prop_skip_08a"] = {Offset = {vec3(-3.0, -5.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01b"] = {Offset = {vec3(3.0, -4.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
    },
    {
        ["prop_skip_08a"] = {Offset = {vec3(-3.0, -5.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01c"] = {Offset = {vec3(3.0, -4.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},  
        ["prop_pipes_04a"] = {Offset = {vec3(-3.0, 5.5, 3.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
    },
    {
        ["prop_dock_crane_04"] = {Offset = {vec3(0.0, 5.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_storagetank_02"] = {Offset = {vec3(0.0, -6.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
    },
    {
        ["po1_03_sail01"] = {Offset = {vec3(0.0, 0.0, 5.5)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
    },
    {
        ["prop_portacabin01"] = {Offset = {vec3(0.0, -6.0, 1.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01b"] = {Offset = {vec3(-2.0, 3.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
        ["prop_container_01e"] = {Offset = {vec3(2.0, 3.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
    },
    {
        ["prop_pipes_01a"] = {Offset = {vec3(-3.0, -4.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01c"] = {Offset = {vec3(2.0, 3.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
        ["prop_skip_08a"] = {Offset = {vec3(-3.0, 5.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
    },
    {
        ["prop_rub_wreckage_4"] = {Offset = {vec3(-3.5, -4.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01g"] = {Offset = {vec3(4.5, 3.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
        ["prop_container_01b"] = {Offset = {vec3(1.5, 3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
        ["prop_skip_06a"] = {Offset = {vec3(-4.0, 5.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
    },
    {
        ["prop_tanktrailer_01a"] = {Offset = {vec3(-3.5, -4.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
        ["prop_container_01g"] = {Offset = {vec3(4.5, 3.0, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
        ["prop_container_01b"] = {Offset = {vec3(1.5, 3.5, 2.0)}, Rotation = vec3(0.0, 0.0, 0.0)},
        ["prop_pipes_04a"] = {Offset = {vec3(-3.5, 6.0, 3.0)}, Rotation = vec3(0.0, 0.0, 0.0)}, 
    },
}

---------------------------------------------------------------------------------
-------------------------------Bridge Configs------------------------------------
---------------------------------------------------------------------------------
SDC.SpawnBridgeDist = 400 --How close/far you have to be for it spawn/delete the draw bridges
SDC.DefaultBridgeSpawns = { --Default Spawn Location For The Draw Bridges (DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    Train = vec4(219.5085, -2319.432, 13.25203, 0.0), --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    Vehicle = vec4(353.3317, -2315.838, 13.72306, 0.0) --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
}
SDC.MaxBridgeHeight = { --Maximum Height That The Bridges Lift
    Train = 15.0, --Train Bridge
    Vehicle = 15.0 --Vehicle Bridge
}
SDC.BridgeModels = { --Draw Bridge Models
    Train = "prop_tbridge",--Train Bridge
    Vehicle = "prop_vbridge",--Vehicle Bridge
}
SDC.DistToStartLift = 65 --How close you have to be for it to accept your honks to lift the bridge

SDC.DeleteVehiclesApproachingBridgeWhileMoving = true --This only applys for the vehicle bridge but it will delete AI ONLY when near the bridge to prevent them from driving off into the water

SDC.BridgeBarriers = { --Barrier Configs 
    Model = "prop_railway_barrier_02", --Model Of Barrier
    SpawnDist = 100, --How close/far you have to be for it to spawn these when a bridge is moving
    TrainPlacements = { --Placement Coords For Barriers On Train Bridge --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
        {Coords = vec3(224.320557, -2294.141, 8.034011), Rotation = vec3(0.0, -90.0, 0.0)},--(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
        {Coords = vec3(224.839874, -2344.93066, 8.034011), Rotation = vec3(0.0, -90.0, 0.0)},--(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    },
    VehiclePlacements = { --Placement Coords For Barriers On Vehicle Bridge --(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
        {Coords = vec3(354.043365, -2348.49951, 9.7491894), Rotation = vec3(0.0, -90.0, 180.0)},--(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
        {Coords = vec3(352.719177, -2283.146, 9.7492018), Rotation = vec3(0.0, -90.0, 0.0)},--(DO NOT TOUCH UNLESS YOU KNOW WHAT YOURE DOING)
    },
}
