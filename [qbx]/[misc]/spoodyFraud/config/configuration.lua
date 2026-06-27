QBCore = exports['qb-core']:GetCoreObject()

Configuration = {
    Settings = {
        ---@type "target" | "textui" # Target will use ox_target, textui will use Ox Lib Text UI
        OxType = "target",
        InteractionType = 'button', ---@type "button" | "target" # NEW: Use buttons to interact with fraud objects, or 3rd eye?
        Security = true, --- Security is a new system that prevents exploits and cheaters from exploiting scammer job
        NetworkedObjects = true, --- Placed objects are seen by other players?

        --- Wallpaper that is displayed in the UI, Want to make your own? -> height: 972 px width: 1536 px
        Wallpaper = "https://r2.fivemanage.com/CWDuI3yLS4av0OWnTLNNl/wallpaper_two.png",

        Sales = {
            Alert = true, -- Enable police alerts?
            Chances = 0.50, -- 50% chance police get alerted
        },

        NUI = {
            CloningTime = 5000, --- How long (in ms) will it takes to clone a card?
            PrintingTime = 6500, --- How long (in ms) will it takes to print a check?
            SimCloning = 7500, --- How long (in ms) will it takes to clone the new SIM?
            DataTransferTime = 4600, --- How long (in ms) it takes to transfer data to USB?

            --- NEW: Randomized rewards system, you can now give players multiple amounts of rewards after interacting.
            Rewards = {
                Clones = { min = 1, max = 5 }, --- Randomize 1-5 cards to be given after swiping?
                Checks = { min = 1, max = 3 }, --- Randomize 1-3 checks to be given after printing?
                Sim = { min = 1, max = 2 }, --- Randomize 1-2 SIM cards to be given after calling?
            },

            DataDownloadBase = 700, --- 700mb base file size for NPC data (+ randomize value)

            --- Proxy location states that show up on the bottom-right
            --- If you are a non-LS server, you can change this here! (Chicago / LA / NYC etc)
            ProxyLocations = {
                off = 'Los Santos', --- What city are we in if the VPN is off?
                on  = 'Paleto Bay', --- What city is the VPN in?
            },
        },

        Police = {
            PoliceJob = {"police", "sheriff"}, --- NEW: now supports multiple police jobs!
            DrawBlip = true, -- Draw a blip on their map when an alert happens?
        },

        Failure = {
            Enabled = true, -- Enable failure chances for sales?
            Chances = {
                Cards = 0.08, -- 8% chance of failure. [In real life, cloned cards are extremely difficult to detect and usually go through without issues.]
                Checks = 0.12, -- 12% chance of failure. [In real life, fraudulent checks can sometimes be easily flagged by a bank teller.]
                Sims = 0.15, -- 15% chance of failure. [In real life, SIM swaps are often reported to the phone carrier within an hour, and if not sold quickly, they may be reversed.]
                DataBroker = 0.05, -- 5% chance of failure. [In real life, selling data is often done undetected]
            }
        }
    },

    Job = {
        Enabled = false, --- Enable jobs? (if enabled, the specified job will only be allowed to use the laptop, print checks, cards etc)
        DistributionSystem = false, --- Allow default players (without jobs) to sell illegal items? (i.e unemployed can sell cloned cards, sims, checks)
        JobName = "scammer", --- Job name
    },

    DiscordRole = {
        Enabled = false, --- Would you like to enable Discord roles to also allow roles?
        Resource = '', --- Your Badger Discord API resource name
        RoleID = '' --- The Discord Role ID
    },

    Selling = {
        Clones = {
            Rewards = {
                Reward = {min = 350, max = 3500}, -- Randomized between values of $350 & $3500
                Account = "markedbills", -- cash, bank or dirty money?
            },

            RequiredPolice = 3, --- Requires 3 police to sell cloned cards? (set to 0 if you want to disable this)

            ATMFailure = {
                Enabled = true, --- NEW ATM Failure system: Inserting too many cards will cause it to enter lockdown mode
                MaxCards = { 7, 13 }, --- ATM will fail randomly between 7 and 13 total card inserts
                Notification = "This ATM has automatically suspected Fraud and is on lockdown mode! find another ATM!",
                Cooldown = 5, --- 5 minute cooldown before ATM is useable again
            },

            Models = { 'prop_atm_01', 'prop_fleeca_atm', 'prop_atm_02', 'prop_atm_03' }, --- Add models that you would like to use (Ox Target Only)
            Locations = false, --- Keep false : READ BELOW

            --- In case you still want to use static locations, uncomment this, and completely delete the line: 'Locations = false'
            -- Locations = {
            --     ["Pacific Bank"] = {
            --         Location = vec3(237.8048, 216.9053, 106.2868),
            --         Heading = 301.8932,
            --     },
            -- }
        },

        Checks = {
            Rewards = {
                Reward = {min = 350, max = 3500}, -- Randomized between values of $350 & $3500
                Account = "markedbills", -- cash, bank or dirty money?
            },

            RequiredPolice = 2, --- Requires 2 police to sell checks? (set to 0 if you want to disable this)

            Locations = {
                ["Pacific Bank"] = {
                    Heading = 337.0690,
                    Location = vec3(248.3301, 222.9014, 106.2868),

                    Ped = {
                        Enabled = true,
                        Coords = vec4(249.0421, 224.6193, 105.3, 155.6678),
                        Hash = "u_m_m_bankman",
                    },
                },
            }
        },

        Sims = {
            Rewards = {
                Reward = {min = 1350, max = 6500}, -- Randomized between values of $1,350 & $6,500
                Account = "markedbills", -- cash, bank or dirty money?
            },

            RequiredPolice = 3, --- Requires 3 police to sell SIM cards? (set to 0 if you want to disable this)

            Locations = {
                ["Sandy Shoes"] = {
                    Heading = 15.9248,
                    Location = vec3(1737.7275, 3709.7366, 34.1376),

                    Ped = {
                        Enabled = true,
                        Coords = vec4(1738.0103, 3709.0566, 33.15, 15.9248),
                        Hash = "hc_hacker"
                    }
                },
            }
        },

        DataBroker = {
            Rewards = {
                Reward = {min = 1480, max = 7225}, -- Randomized between values of $1,480 & $7,225
                Account = "markedbills",
            },

            RequiredPolice = 2, --- Requires 2 police to sell USB sticks? (set to 0 if you want to disable this)

            Locations = {
                ['Elysian Heights'] = {
                    Heading = 204.8246,
                    Location = vec3(1148.4286, -1641.8065, 36.3308),

                    Ped = {
                        Enabled = true,
                        Coords = vec4(1148.4286, -1641.8065, 35.3308, 204.8246),
                        Hash = "cs_lifeinvad_01",
                    }
                }
            }
        },
    },

    Blackmarket = {
        Locations = {

            ["Blackmarket"] = {
                Enabled = true,
                Location = vec3(-327.0636, -1300.5070, 31.3452),

                Ped = {
                    Enabled = true,
                    Location = vec4(-326.5181, -1300.4691, 30.4, 89.9135),
                    Hash = "ig_joeminuteman",
                },

                Items = {
                    { Item = "msr", Image = "nui://ox_inventory/web/images/msr.png", Label = "MSR Swiper", Count = 1, Price = 5000 },
                    { Item = "blank", Image = "nui://ox_inventory/web/images/blank.png", Label = "Blank Cards", Count = 5, Price = 500 },
                    { Item = "checkpaper", Image = "nui://ox_inventory/web/images/checkpaper.png", Label = "Checkpaper", Count = 5, Price = 500 },
                    { Item = "simcard", Image = "nui://ox_inventory/web/images/simcard.png", Label = "Sim Card", Count = 5, Price = 500 },
                    { Item = "fraud_usb", Image = "nui://ox_inventory/web/images/fraud_usb.png", Label = "USB Drive", Count = 5, Price = 900 },
                }
            },

            ["Electronic Shop"] = {
                Enabled = true,
                Location = vec3(-662.4022, -853.1427, 24.4536),

                Ped = {
                    Enabled = true,
                    Location = vec4(-662.4503, -853.9371, 23.45, 3.4931),
                    Hash = "ig_jay_norris",
                },

                Items = {
                    { Item = "laptop", Image = "nui://ox_inventory/web/images/laptop.png", Label = "Laptop", Count = 1, Price = 1000},
                    { Item = "printer", Image = "nui://ox_inventory/web/images/printer.png", Label = "Printer", Count = 1, Price = 500},
                    { Item = "burnerphone", Image = "nui://ox_inventory/web/images/burnerphone.png", Label = "Burner Phone", Count = 1, Price = 1500 },
                }
            }

        }
    },

    ---@param message string
    ---@param type? 'inform' | 'error' | 'success' | 'warning'
    Notify = function(message, type)
        lib.notify({
            title = "Scamming",
            description = message,
            type = type or 'inform',
            position = 'top',
            duration = 5000,
        })
    end,

    ---@alias dispatchOptions 'none' | 'rcore_dispatch' | 'qs-dispatch' | 'cd-dispatch' | 'lb-tablet'
    ---@type dispatchOptions --- ^ These are your available options for dispatch
    DispatchSystem = 'none', --- Leave empty if you don't have any dispatch systems and want to use the built in one.

    --- If the DispatchSystem is set to 'none', this function will be executed everytime someone successfully sells a check, clone, or SIM on the client. 
    ---@param index string | "check" | "atm"
    PoliceNotify = function(location, index)
        if Configuration.DispatchSystem ~= 'none' then return end

        if index == "check" then
            Configuration.Notify("The bank at: " ..location.. " has reported someone selling a fraudulent check!", 'warning')
            PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", true)
        elseif index == "atm" then
            Configuration.Notify("An ATM has reported someone using a fradulent card!", 'warning')
            PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", true)
        end
    end,

    Models = {
        Printer = "v_res_printer",
        Laptop = "spoody_leansy_laptop",
        MSR = "leansy_reader_card"
    },

    --- Only change the value if you have a different item name. Do NOT change the [code]
    --- [code] = item name
    Items = {
        ['Laptop'] = "laptop",
        ['Printer'] = "printer",
        ['MSR'] = "msr",
        ['Burner Phone'] = "burnerphone",
        ['Blank Card'] = "blank",
        ['Cloned Card'] = "ccard",
        ['Check Paper'] = "checkpaper",
        ['Forged Check'] = "fcheck",
        ['Swapped Sim Card'] = "sim",
        ['Empty Sim Card'] = "simcard",
        ['Empty USB'] = "fraud_usb",
        ['Filled USB'] = "usb_transfer",
    },
}