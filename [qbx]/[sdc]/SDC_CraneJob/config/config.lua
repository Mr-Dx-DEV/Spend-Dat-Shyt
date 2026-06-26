SDC = {}

---------------------------------------------------------------------------------
-------------------------------Important Configs---------------------------------
---------------------------------------------------------------------------------
SDC.Target = "ox_target" --Can be one of these (If "none" is selected it will use TextUi): ["qb-target","ox_target","none"]

SDC.MutePlayersInCrane = true --If you want to mute all players inside a crane so they won't hear others also in crane (Only works for mumble based scripts)

SDC.CompleteMaterialMoveReward = 250 --How much money you earn for completing one material moved
SDC.CompleteTruckLoadReward = 1000 --How much money you earn for completing a whole truck load
---------------------------------------------------------------------------------
-------------------------------Job Configs---------------------------------------
---------------------------------------------------------------------------------
SDC.JobName = "cranejob" --Job Name of the crane job
SDC.NeedJobForResource = false --If you need the job to work a crane

SDC.SiteManager = { --Site Manger Configs
    Ped = "a_m_m_eastsa_02", --Ped model of the site manager
    Coords = vec4(721.8976, -909.4210, 25.4327, 93.5018), --Coords for the site manager
    Blip = {Enabled = true, Sprite = 440, Color = 17, Size = 0.5}, --Blip for site manager, if you don't want one then set "Enabled" to false
    SpawnPedDist = 75 --How close/far you have to be for it spawn/despawn the site manager ped
}
SDC.CraneBlip = {Enabled = true, Sprite = 527, Color = 47, Size = 0.5} --Blip for Assigned Crane, if you don't want one then set "Enabled" to false
SDC.CraneWaypoint = {Enabled = true} --If you want it to set their waypoint to the assigned crane site, if you don't want this then set "Enabled" to false
SDC.CloseJobDistance = 100 --How far you have to get from the crane site for it to cancel your assigned crane

SDC.CraneCabinHud = true --If you want it to draw the 3d texts that show you info on your crane

---------------------------------------------------------------------------------
-------------------------------Keybind Configs-----------------------------------
---------------------------------------------------------------------------------

SDC.CraneKeys = { --Keybinds for the stations in the truck
    Exit = {Input = "INPUT_DETONATE", InputNum = 47}, --Keybind For Exiting
    TurnLeft = {Input = "INPUT_CELLPHONE_LEFT", InputNum = 174},--Keybind For Turning The Crane Left
    TurnRight = {Input = "INPUT_CELLPHONE_RIGHT", InputNum = 175},--Keybind For Turning The Crane Right
    TrolleyFwd = {Input = "INPUT_CELLPHONE_UP", InputNum = 172},--Keybind For Moving The Trolley Forward
    TrolleyBck = {Input = "INPUT_CELLPHONE_DOWN", InputNum = 173},--Keybind For Moving The Trolley Backward
    HookUp = {Input = "INPUT_MOVE_UP_ONLY", InputNum = 32},--Keybind For Moving The Hook Up
    HookDown = {Input = "INPUT_MOVE_DOWN_ONLY", InputNum = 33},--Keybind For Moving The Hook Down
    ChangeCamera = {Input = "INPUT_NEXT_CAMERA", InputNum = 0},--Keybind For Changing Camera Angles
    HookObject = {Input = "INPUT_PICKUP", InputNum = 38}, --Keybind For Hooking A Material to the hook
}

---------------------------------------------------------------------------------
-------------------------------Icon Configs--------------------------------------
---------------------------------------------------------------------------------
SDC.Icons = {
    Elevator = {Draw = true},
    EnterCrane = {Draw = true},
    Hook = {Draw = true},
    Materials = {Draw = true},
}

---------------------------------------------------------------------------------
-------------------------------Crane Spawn Configs-------------------------------
---------------------------------------------------------------------------------
SDC.AddingNewCraneCircle = false --If you want it to draw a circle around the crane with the radius so you can get coords for placements and the truck
SDC.ShowCraneSprite = 10 --How close you have to be for it to show the crane sprites
SDC.CranePlacement = { --All crane site placements
--[[
    Crane Site Fromat:

    ["unique_site_name"] = { --Put A Unique Name For The Site
        SiteLabel = "label_for_site", --Put A Label For The Site
        BaseCoords = vec3(0.0, 0.0, 0.0), --The Coords Of The Actual Crane Base
        Rotation =  0.0, --MUST ALWAYS BE POSITIVE (Rotation Of The Crane)
        Parts = {"base"}, --MUST ALWAYS HAVE "base" FIRST, All Crane Parts Are Put Here, Example Crane Parts: ["standard" or "breakaway"]
        TruckSpawn = vec4(0.0, 0.0, 0.0, 0.0), -- Coords For The Truck And Trailer To Spawn, Make Sure To Give Enough Room For Trailer To Spawn
        TrailerLoadoutsAllowed = {}, --This is the list of trailer loadouts this site supports, put the number of the loadout (SDC.TrailerLoadouts)
        SitePlacements = { --All placements coords (coords for placement on site)
            Large = { --All large material placement coords
                --Must be a vec4(), Example: vec4(0.0, 0.0, 0.0, 0.0)
            },
            Small = {
                --Must be a vec4(), Example: vec4(0.0, 0.0, 0.0, 0.0)
            }
        }
    }

]]
    ["alta1"] = {
        SiteLabel = "Alta Construction Site",
        BaseCoords = vec3(128.019, -347.9146, 41.52882),
        Rotation =  280.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "standard", "standard"},
        TruckSpawn = vec4(137.4180, -364.9102, 43.2571, 152.8203),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(83.2174, -350.7605, 67.1967, 66.8398),
                vec4(95.4390, -369.9855, 67.3122, 251.6928),
                vec4(112.6281, -363.1479, 67.3122, 251.5741),
                vec4(102.0213, -350.5951, 55.4968, 249.9014),
                vec4(107.0716, -341.7488, 55.4969, 70.6888)
            },
            Small = {
                vec4(97.1816, -356.7155, 67.3125, 166.7549),
                vec4(106.2127, -371.7819, 67.3120, 249.0492),
                vec4(105.8732, -364.7231, 67.3122, 168.9645),
                vec4(123.5833, -362.8441, 67.1677, 255.2825),
                vec4(122.3313, -356.5076, 67.1677, 344.9220),
                vec4(110.8947, -351.0150, 55.4969, 333.9287),
                vec4(114.5580, -356.8669, 55.4969, 253.7490)
            }
        }
    },
    ["alta2"] = {
        SiteLabel = "Alta Construction Site",
        BaseCoords = vec3(47.225, -460.4344, 38.798),
        Rotation =  180.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "standard", "standard"},
        TruckSpawn = vec4(57.4597, -415.3724, 39.9211, 343.6987),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(29.1871, -447.3225, 73.9001, 340.5809),
                vec4(13.4451, -443.9174, 55.2848, 247.6949),
                vec4(17.6506, -432.2749, 55.2271, 336.5884),
                vec4(20.3774, -422.0404, 55.2848, 254.8176),
                vec4(45.8822, -414.1926, 45.5592, 159.6786)
            },
            Small = {
                vec4(45.9312, -413.9478, 73.9401, 248.9814),
                vec4(40.1970, -412.0164, 73.9401, 340.6016),
                vec4(45.7041, -408.5338, 73.9401, 346.7142),
                vec4(11.3263, -436.0518, 55.2848, 342.5241),
                vec4(39.0088, -408.5056, 45.5592, 71.3022),
                vec4(35.7745, -416.1413, 45.5592, 163.2328),
                vec4(28.7664, -412.7655, 45.5592, 69.3845),
                vec4(31.1502, -428.3152, 65.0297, 67.7213)
            }
        }
    },
    ["littleseoul1"] = {
        SiteLabel = "Little Seoul Construction Site",
        BaseCoords = vec3(-461.5735, -975.9592, 22.409),
        Rotation =  180.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "standard", "standard"},
        TruckSpawn = vec4(-494.3338, -940.7418, 23.9640, 2.0442),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(-447.5600, -972.1317, 25.8981, 356.6635),
                vec4(-437.6793, -1009.0403, 25.8998, 182.0494),
                vec4(-464.8103, -954.0938, 47.9796, 271.0459),
                vec4(-456.7884, -942.1564, 47.9839, 1.0107),
                vec4(-456.4793, -924.3743, 47.9797, 90.3217)
            },
            Small = {
                vec4(-444.5028, -956.4307, 47.9796, 267.7137),
                vec4(-450.8821, -953.3314, 47.9796, 182.1605),
                vec4(-466.5400, -934.0603, 47.9797, 3.4463),
                vec4(-460.8038, -934.0249, 47.9797, 0.2806),
                vec4(-444.2689, -938.6127, 47.9797, 183.2213),
                vec4(-451.7054, -938.7702, 47.9839, 90.3727),
                vec4(-452.4129, -931.4124, 47.9797, 0.3868)
            }
        }
    },
    ["littleseoul2"] = {
        SiteLabel = "Little Seoul Construction Site",
        BaseCoords = vec3(-450.0215, -1079.558, 22.3202),
        Rotation =  210.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "standard", "standard"},
        TruckSpawn = vec4(-498.5770, -1056.3655, 23.5505, 59.0117),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(-437.8332, -1030.2026, 25.8981, 1.4995),
                vec4(-473.0344, -1042.5953, 52.4766, 146.4582),
                vec4(-478.9427, -1053.3380, 52.4766, 55.7122),
                vec4(-461.8641, -1051.7347, 52.4762, 235.3931)
            },
            Small = {
                vec4(-444.8139, -1057.4348, 29.1373, 142.2484),
                vec4(-488.3128, -1047.9326, 52.4762, 51.8864),
                vec4(-491.6164, -1043.0696, 52.4762, 323.2816),
                vec4(-481.4115, -1035.8988, 52.4762, 241.1875),
                vec4(-471.3974, -1057.0725, 52.4762, 143.6324),
                vec4(-467.8240, -1059.4868, 52.4762, 148.2323),
                vec4(-463.0239, -1060.7719, 52.4762, 239.3028)
            }
        }
    },
    ["pillbox1"] = {
        SiteLabel = "Pillbox Hill Construction Site",
        BaseCoords = vec3(-204.4852, -1115.432, 21.776),
        Rotation =  130.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "standard", "standard"},
        TruckSpawn = vec4(-203.1075, -1084.9597, 21.6824, 341.7407),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(-175.7286, -1100.5015, 42.1392, 252.0124),
                vec4(-163.6119, -1108.4846, 42.1393, 275.7116),
                vec4(-165.1144, -1082.5540, 42.1393, 69.3897),
                vec4(-182.8544, -1079.5919, 42.1393, 250.9016),
                vec4(-182.5138, -1071.0946, 42.1393, 333.4825)
            },
            Small = {
                vec4(-189.9465, -1109.0060, 42.1393, 191.7862),
                vec4(-187.9759, -1102.7883, 42.1392, 337.6371),
                vec4(-186.1448, -1096.3087, 42.1392, 249.3616),
                vec4(-179.5825, -1106.9940, 42.1392, 148.8597),
                vec4(-164.3425, -1099.8983, 42.1393, 344.4927),
                vec4(-161.7716, -1092.4680, 42.1393, 341.0243)
            }
        }
    },
    ["pillbox2"] = {
        SiteLabel = "Pillbox Hill Construction Site",
        BaseCoords = vec3(-98.8041, -1050.6714, 26.3015),
        Rotation =  270.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "standard", "standard"},
        TruckSpawn = vec4(-133.6590, -1049.2506, 27.2736, 78.6094),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(-145.7225, -1069.1432, 42.1392, 71.1691),
                vec4(-137.0006, -1084.0936, 42.1393, 166.4898),
                vec4(-137.7249, -1023.6151, 54.2594, 341.5916),
                vec4(-129.4105, -1010.0430, 54.2626, 345.9080),
                vec4(-117.8377, -1002.8812, 54.2590, 292.5460)
            },
            Small = {
                vec4(-124.9470, -1098.6871, 36.1393, 157.0144),
                vec4(-130.6046, -1094.1594, 36.1393, 70.9102),
                vec4(-154.1432, -1054.4626, 42.1392, 343.6724),
                vec4(-146.4556, -1030.7892, 54.5179, 65.6628),
                vec4(-138.1729, -1034.5833, 54.5216, 249.1575),
                vec4(-131.0659, -1026.1613, 54.2594, 251.3369),
                vec4(-118.2296, -1018.6146, 54.2583, 252.5612)
            }
        }
    },
    ["westvinewood1"] = {
        SiteLabel = "West Vinewood Construction Site",
        BaseCoords = vec3(-664.313, 229.924, 80.944),
        Rotation =  0.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "breakaway", "standard", "breakaway"},
        TruckSpawn = vec4(-690.1633, 229.4531, 80.8683, 294.3074),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(-672.2807, 223.2340, 137.5182, 23.4345),
                vec4(-682.4860, 222.5676, 137.5250, 108.7726),
                vec4(-678.9097, 215.5984, 137.5250, 204.5740),
                vec4(-699.1332, 201.8821, 140.7539, 109.1823)
            },
            Small = {
                vec4(-662.7191, 215.9057, 81.9551, 206.0485),
                vec4(-666.0704, 205.1523, 81.9551, 115.3333),
                vec4(-668.2885, 215.5619, 137.5182, 30.8101),
                vec4(-682.9680, 212.0872, 137.5250, 116.1888),
                vec4(-688.6378, 209.2343, 137.5250, 116.4032),
                vec4(-691.5137, 214.8138, 137.5250, 25.0352)
            }
        }
    },
    ["redwood1"] = {
        SiteLabel = "Redwood Construction Site",
        BaseCoords = vec3(1131.583, 2172.449, 47.9799),
        Rotation =  180.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "standard"},
        TruckSpawn = vec4(1145.4034, 2158.8193, 53.3102, 269.2010),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(1144.7418, 2140.5488, 55.0167, 269.3416),
                vec4(1153.1471, 2129.0613, 55.3393, 179.4931),
                vec4(1113.1713, 2220.5820, 50.0670, 110.3451),
                vec4(1122.4873, 2194.2092, 46.8571, 314.7804)
            },
            Small = {
                vec4(1170.6713, 2140.0261, 54.6541, 121.3027),
                vec4(1172.3774, 2147.2747, 54.1982, 354.5206),
                vec4(1147.4625, 2184.4053, 45.5231, 91.3680),
                vec4(1149.1078, 2202.1709, 49.6053, 268.2981),
                vec4(1108.1223, 2208.0125, 48.7742, 178.6054),
                vec4(1101.4496, 2203.5891, 48.0600, 179.0611),
                vec4(1112.6423, 2198.7927, 48.9883, 280.9442)
            }
        }
    },
    ["redwood2"] = {
        SiteLabel = "Redwood Construction Site",
        BaseCoords = vec3(1051.097, 2280.449, 48.3208),
        Rotation =  270.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "standard"},
        TruckSpawn = vec4(1098.9849, 2280.4812, 49.6441, 269.6127),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(1064.0178, 2299.9939, 45.5078, 7.5211),
                vec4(1082.8031, 2296.4673, 45.5088, 267.1500),
                vec4(1088.5935, 2313.0422, 45.5132, 55.6427),
                vec4(1066.4502, 2319.0930, 45.5080, 88.8187)
            },
            Small = {
                vec4(1056.2075, 2295.9563, 45.5070, 2.0149),
                vec4(1059.0209, 2303.9192, 45.5076, 4.9441),
                vec4(1074.6395, 2302.3813, 45.5085, 359.5094),
                vec4(1081.6257, 2303.3970, 45.5088, 267.8955),
                vec4(1096.9143, 2308.8035, 45.5126, 280.5451),
                vec4(1077.5059, 2314.3364, 45.5085, 102.5729),
                vec4(1057.2572, 2322.5891, 45.5075, 87.3583)
            }
        }
    },
    ["redwood3"] = {
        SiteLabel = "Redwood Construction Site",
        BaseCoords = vec3(948.7873, 2409.49, 50.069),
        Rotation =  0.0, --MUST ALWAYS BE POSITIVE
        Parts = {"base", "standard", "standard"},
        TruckSpawn = vec4(996.0516, 2414.9607, 51.4632, 194.3407),
        TrailerLoadoutsAllowed = {1, 2, 3, 4},
        SitePlacements = {
            Large = {
                vec4(969.5503, 2405.1404, 51.8855, 115.3756),
                vec4(987.6194, 2378.4131, 51.8365, 274.1985),
                vec4(992.2880, 2386.5557, 51.5327, 270.3370),
                vec4(963.9359, 2446.8799, 51.5035, 36.1611),
                vec4(911.1525, 2400.9114, 50.5666, 183.4140)
            },
            Small = {
                vec4(992.4539, 2394.6094, 52.0966, 351.8125),
                vec4(999.2424, 2394.8196, 51.6763, 268.4568),
                vec4(956.9593, 2434.4163, 51.3869, 143.9112),
                vec4(965.0952, 2427.4944, 51.5425, 201.0940),
                vec4(964.2873, 2419.0906, 51.5404, 193.4579),
                vec4(928.5069, 2413.8579, 51.4663, 88.9314),
                vec4(918.1470, 2417.5300, 51.4359, 56.8085)
            }
        }
    }
}
SDC.CraneTPOffset = { --Offset For The Crane Elevator (Dont Touch Unless You Know What You're Doing)
    Base = {vec3(0.0, 0.25, 4.0)},
    Crane = {vec3(0.7, 0.0, 1.5)}
}
SDC.CraneDoorOffset = {vec3(-2.3, -0.8, 1.5), vec3(-2.3, 1.2, 1.5)} --Offset for the door sprite to enter crane (Dont Touch Unless You Know What You're Doing)


---------------------------------------------------------------------------------
-------------------------------Craneable Object Configs--------------------------
---------------------------------------------------------------------------------
SDC.CraneableObjects = { --All Craneable Materials
    Large = { --All Large Craneable Materials
        --Example: {Prop = "model_name" --Model Name, ZTrailerOffset = 0.0 --Height Offset From Trailer, HookOffset = 0.0 --Height Offset From Hook},
        {Prop = "prop_woodpile_04a", ZTrailerOffset = -1.2, HookOffset = -2.0},
        {Prop = "prop_container_03b", ZTrailerOffset = -1.15, HookOffset = -3.0},
        {Prop = "prop_woodpile_03a", ZTrailerOffset = -1.15, HookOffset = -3.0},
        {Prop = "prop_tunnel_liner03", ZTrailerOffset = -1.15, HookOffset = -5.0},
        {Prop = "prop_pipes_01b", ZTrailerOffset = -1.15, HookOffset = -2.0},
        {Prop = "prop_pipes_01a", ZTrailerOffset = -1.15, HookOffset = -2.0},
        {Prop = "prop_elecbox_10", ZTrailerOffset = -1.15, HookOffset = -3.0},
        {Prop = "prop_sub_trans_04a", ZTrailerOffset = -1.15, HookOffset = -2.5},
        {Prop = "prop_plywoodpile_01b", ZTrailerOffset = -1.15, HookOffset = -3.0},
        {Prop = "prop_pipes_04a", ZTrailerOffset = -0.2, HookOffset = -2.0},
        {Prop = "prop_cons_ply02", ZTrailerOffset = -1.2, HookOffset = -3.0},
        {Prop = "prop_metal_plates02", ZTrailerOffset = -1.15, HookOffset = -0.3},
        {Prop = "prop_generator_04", ZTrailerOffset = -1.15, HookOffset = -3.0},
        {Prop = "prop_drywallpile_02", ZTrailerOffset = -1.15, HookOffset = -3.0},
        {Prop = "prop_cablespool_01b", ZTrailerOffset = 0.4, HookOffset = -2.5},
    },
    Small = { --All Small Craneable Materials
        --Example: {Prop = "model_name" --Model Name, ZTrailerOffset = 0.0 --Height Offset From Trailer, HookOffset = 0.0 --Height Offset From Hook},
        {Prop = "prop_cons_cements01", ZTrailerOffset = -1.1, HookOffset = -2.0},
        {Prop = "prop_cablespool_02", ZTrailerOffset = -0.25, HookOffset = -2.0},
        {Prop = "prop_conc_blocks01a", ZTrailerOffset = -1.15, HookOffset = -2.5},
        {Prop = "prop_pipes_conc_01", ZTrailerOffset = -0.6, HookOffset = -2.0},
        {Prop = "prop_pallet_pile_02", ZTrailerOffset = -1.1, HookOffset = -3.0},
        {Prop = "prop_boxpile_06b", ZTrailerOffset = -1.3, HookOffset = -2.0},
        {Prop = "prop_partsbox_01", ZTrailerOffset = -1.15, HookOffset = -1.5},
        {Prop = "prop_cs_dumpster_01a", ZTrailerOffset = -0.8, HookOffset = -1.5},
    }
}

---------------------------------------------------------------------------------
-------------------------------Truck Configs-------------------------------------
---------------------------------------------------------------------------------
SDC.TruckModel = "hauler" --Truck Model for Site
SDC.TrailerModel = "freighttrailer" --Trailer Model for Site
SDC.TrailerOffset = {vec3(0.0, -10.0, 0.0)} --Offset of trailer from truck (Dont Touch Unless You Know What You're Doing)

SDC.WaitForAnotherTruckTime = 10 --How long you wait for the next truck to pull in (in seconds)

SDC.TrailerLoadouts = { --All Trailer Loadouts
--[[
    Example:

    [NUMBER] = { --Number of loudout, must go in order: 1,2,3,4,etc
        --Example: {Size = ""--Can be ["Small" or "Large"], Offset = {x = 0.0, y = 0.0} --Offset from trailer},
    },
]]
    [1] = {
        {Size = "Large", Offset = {x = 0.0, y = 4.5}},
        {Size = "Small", Offset = {x = 0.0, y = -2.0}},
        {Size = "Small", Offset = {x = 0.0, y = -5.0}},
        {Size = "Small", Offset = {x = 0.0, y = -8.0}}
    },
    [2] = {
        {Size = "Large", Offset = {x = 0.0, y = 4.5}},
        {Size = "Large", Offset = {x = 0.0, y = -4.0}},
    },
    [3] = {
        {Size = "Small", Offset = {x = 0.0, y = 7.0}},
        {Size = "Small", Offset = {x = 0.0, y = 4.0}},
        {Size = "Small", Offset = {x = 0.0, y = 1.0}},
        {Size = "Small", Offset = {x = 0.0, y = -2.0}},
        {Size = "Small", Offset = {x = 0.0, y = -5.0}},
        {Size = "Small", Offset = {x = 0.0, y = -8.0}}
    },
    [4] = {
        {Size = "Large", Offset = {x = 0.0, y = -4.5}},
        {Size = "Small", Offset = {x = 0.0, y = 2.0}},
        {Size = "Small", Offset = {x = 0.0, y = 5.0}},
        {Size = "Small", Offset = {x = 0.0, y = 8.0}}
    },
}
