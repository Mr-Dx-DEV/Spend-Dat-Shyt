ConvoyConfig = {}

ConvoyConfig.isEnabled = false                       -- Toggle This To False If You Do Not Want To Use The Convoy System At All (Will Skip Convoy Creation and Send to Prison)
ConvoyConfig.isAIConvoyEnabled = false               -- [HEAVILY EXPERIMENTAL] Toggle This To False If You Do Not Want To Use The AI Convoy System (Players Will Have To Drive Prisoners To The Prison)
ConvoyConfig.isConvoySkippableOptionEnabled = false -- Toggle This To False If You Do Not Want The Convoy To Be Skippable in Options (Can only be turned on if isAIConvoyEnabled is false)
ConvoyConfig.IllegalCallChance = 100                -- The Chance Of The Police Calling The Convoy (1-100)
ConvoyConfig.FreezePlayer = false -- If true, the script will handle stopping the player from leaving the convoy, if false you will have to handle it yourself in editablefunctions_cl.lua however this could allow you to let prisoners escape the convoy
ConvoyConfig.ConvoySpawnTimer = 2000 -- This should only be modified if your convoy is not spawning.
ConvoyConfig.UseLightsandSirens = true -- If true, the lights and sirens will be used

ConvoyConfig.ConvoySetupSettings = {
    pedsEnabled = true, -- If Ped is Disabled use the export in the documentation to open the convoy menu
    convoyLeaderSpeed = 20.0,
    convoySpeed = 100.0,
    convoyTrafficFlags = 524348, -- change this here https://forge.plebmasters.de/vehicleflags?category=DrivingStyleFlags&value=787004
    peds = {
        [1] = {
            model = "s_m_y_cop_01",
            coords = vector4(462.16, -1009.74, 24.56, 268.54)
        },
        -- Prompt Sheriff Station
        [2] = {
            model = "s_m_y_cop_01",
            coords = vector4(1831.57, 3668.6, 29.69, 119.12)
        },
        -- Prompt Rockford PD
        [3] = {
            model = "s_m_y_cop_01",
            coords = vector4(-556.54, -98.7, 32.68, 14.81)
        },
    }
}

--Boat is Only Used If MLOSelection is set to molo-alcatraz
ConvoyConfig.BoatSettings = {
    boatModel = "dinghy",
    boatCoords = vector4(2840.97, -675.01, 0.12, 291.97),
    destinationCoords = vector4(3837.06, -47.69, 0.97, 277.44),
    atPrisonOffBoatCoords = vector4(3836.16, -44.8, 2.28, 266.22)
}

if Config.MLOSelection == 'prompt-prison' then
    ConvoyConfig.Coordinates = {
        policeStations = {
            { coords = vector4(496.05, -1034.96, 28.43, 1.9), name = "MRPD", compatibleRouteIDs = {1},
                vehicles = {
                    { model = "policet", position = "ahead",   leader = true, xoffset = 0, yoffset = 20 },
                    { model = "pbus",    position = "default", xoffset = 0, yoffset = 10 },
                    { model = "police",  position = "behind", xoffset = 0,  yoffset = 0 },
                    { model = "riot",    position = "behind", xoffset = 0,  yoffset = -7 },
                }
            },
            { coords = vector4(-533.78, -111.52, 39.07, 211.49), name = "Rockford PD", compatibleRouteIDs = {1},
                vehicles = {
                    { model = "policet", position = "ahead",   leader = true, xoffset = 0, yoffset = 20 },
                    { model = "pbus",    position = "default", xoffset = 0, yoffset = 10 },
                    { model = "police",  position = "behind", xoffset = 0,  yoffset = 0 },
                    { model = "riot",    position = "behind", xoffset = 0,  yoffset = -7 },
                }
            },
            { coords = vector4(1814.03, 3697.87, 34.02, 121.05), name = "Sandy Sherriff", compatibleRouteIDs = {2},
                vehicles = {
                    { model = "policet", position = "ahead",   leader = true, xoffset = -10, yoffset = 0 },
                    { model = "pbus",    position = "default", xoffset = 0, yoffset = 10 },
                    { model = "police",  position = "behind",  xoffset = 5, yoffset = 10 },
                    { model = "riot",    position = "behind",  xoffset = 10, yoffset = 10 },
                }
            },
        }
    }

    ConvoyConfig.Routes = {
        {
            routeID = 1,
            name = "City PD's To Prison",
            coords = {
                [1] = {
                    coords = vector4(2817.05, 4400.04, 48.76, 15.97),
                    finalCoord = false,
                    waitTime = 0
                },
                [2] = {
                    coords = vector4(1855.81, 2607.91, 45.69, 93.13),
                    finalCoord = false,
                    unlockDoor = "FrontGate1",
                    waitTime = 1000
                },
                [3] = {
                    coords = vector4(1827.39, 2607.95, 45.61, 90.23),
                    finalCoord = false,
                    unlockDoor = "FrontGate2",
                    waitTime = 1000
                },
                [4] = {
                    coords = vector4(1673.45, 2602.86, 45.17, 90.3),
                    finalCoord = true,
                    waitTime = 0
                }
            }
        },
        {
            routeID = 2,
            name = "Sandy Sherriff to Prison",
            coords = {
                [1] = {
                    coords = vector4(1855.81, 2607.91, 45.69, 93.13),
                    finalCoord = false,
                    unlockDoor = "FrontGate1",
                    waitTime = 1000
                },
                [2] = {
                    coords = vector4(1827.39, 2607.95, 45.61, 90.23),
                    finalCoord = false,
                    unlockDoor = "FrontGate2",
                    waitTime = 1000
                },
                [3] = {
                    coords = vector4(1673.45, 2602.86, 45.17, 90.3),
                    finalCoord = true,
                    waitTime = 0
                }
            }
        }

    }
elseif Config.MLOSelection == 'molo-alcatraz' then
    ConvoyConfig.Coordinates = {
        policeStations = {
            { coords = vector4(495.96, -1034.44, 28.15, 178.49), name = "MRPD", compatibleRouteIDs = {1},
                vehicles = {
                    { model = "policet", position = "ahead",   leader = true, xoffset = 0, yoffset = -7 },
                    { model = "pbus",    position = "default", xoffset = 0, yoffset = 0 },
                    { model = "police",  position = "behind",  xoffset = 0, yoffset = 10 },
                    { model = "riot",    position = "behind",  xoffset = 0, yoffset = 20 },
                }
            },
            { coords = vector4(-533.78, -111.52, 39.07, 211.49), name = "Rockford PD", compatibleRouteIDs = {1},
                vehicles = {
                    { model = "policet", position = "ahead",   leader = true, xoffset = 0, yoffset = -7 },
                    { model = "pbus",    position = "default", xoffset = 0, yoffset = 0 },
                    { model = "police",  position = "behind",  xoffset = 0, yoffset = 10 },
                    { model = "riot",    position = "behind",  xoffset = 0, yoffset = 20 },
                }
            },
        }
    }

    ConvoyConfig.Routes = {
        {
            routeID = 1,
            name = "Route #1",
            coords = {
                [1] = {
                    coords = vector4(2382.91, -688.44, 63.32, 272.91),
                    finalCoord = false,
                    waitTime = 0
                },
                [2] = {
                    coords = vector4(2727.05, -773.48, 23.52, 12.02),
                    finalCoord = false,
                    waitTime = 2000
                },
                [3] = {
                    coords = vector4(2722.05, -704.33, 13.56, 302.11),
                    finalCoord = false,
                    waitTime = 2000
                },
                [4] = {
                    coords = vector4(2770.05, -713.84, 7.31, 273.22),
                    finalCoord = true,
                    waitTime = 2000
                },
            }
        }

    }

elseif Config.MLOSelection == 'gabz-prison' then
    ConvoyConfig.Coordinates = {
        policeStations = {
            { coords = vector4(496.05, -1034.96, 28.43, 1.9), name = "MRPD", compatibleRouteIDs = {1},
                vehicles = {
                    { model = "policet", position = "ahead",   leader = true, xoffset = 0, yoffset = 20 },
                    { model = "pbus",    position = "default", xoffset = 0, yoffset = 10 },
                    { model = "police",  position = "behind",  xoffset = 0, yoffset = 0 },
                    { model = "riot",    position = "behind",  xoffset = 0, yoffset = -7 },
                }
            },
            { coords = vector4(-533.78, -111.52, 39.07, 211.49), name = "Rockford PD", compatibleRouteIDs = {1},
                vehicles = {
                    { model = "policet", position = "ahead",   leader = true, xoffset = 0, yoffset = 20 },
                    { model = "pbus",    position = "default", xoffset = 0, yoffset = 10 },
                    { model = "police",  position = "behind",  xoffset = 0, yoffset = 0 },
                    { model = "riot",    position = "behind",  xoffset = 0, yoffset = -7 },
                }
            },
            { coords = vector4(1814.03, 3697.87, 34.02, 121.05), name = "Sandy Sherriff", compatibleRouteIDs = {2},
                vehicles = {
                    { model = "policet", position = "ahead",   leader = true, xoffset = -10, yoffset = 0 },
                    { model = "pbus",    position = "default", xoffset = 0, yoffset = 10 },
                    { model = "police",  position = "behind",  xoffset = 7, yoffset = 12 },
                    { model = "riot",    position = "behind",  xoffset = 15, yoffset = 10 },
                }
            },
        }
    }

    ConvoyConfig.Routes = {
        {
            routeID = 1,
            name = "City PD's To Prison",
            coords = {
                [1] = {
                    coords = vector4(2817.05, 4400.04, 48.76, 15.97),
                    finalCoord = false,
                    waitTime = 0
                },
                [2] = {
                    coords = vector4(1855.81, 2607.91, 45.69, 93.13),
                    finalCoord = false,
                    unlockDoor = "FrontGate1",
                    waitTime = 1000
                },
                [3] = {
                    coords = vector4(1827.39, 2607.95, 45.61, 90.23),
                    finalCoord = false,
                    unlockDoor = "FrontGate2",
                    waitTime = 1000
                },
                [4] = {
                    coords = vector4(1763.54, 2606.64, 44.98, 87.95),
                    finalCoord = true,
                    waitTime = 0
                }
            }
        },
        {
            routeID = 2,
            name = "Sandy Sherriff to Prison",
            coords = {
                [1] = {
                    coords = vector4(1855.81, 2607.91, 45.69, 93.13),
                    finalCoord = false,
                    unlockDoor = "FrontGate1",
                    waitTime = 1000
                },
                [2] = {
                    coords = vector4(1827.39, 2607.95, 45.61, 90.23),
                    finalCoord = false,
                    unlockDoor = "FrontGate2",
                    waitTime = 1000
                },
                [3] = {
                    coords = vector4(1763.54, 2606.64, 44.98, 87.95),
                    finalCoord = true,
                    waitTime = 0
                }
            }
        }

    }
elseif Config.MLOSelection == 'custom' then
    -- Open a Ticket So I can help you with your custom prison
end
