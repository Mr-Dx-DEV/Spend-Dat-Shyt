UniqersMarriage = UniqersMarriage or {}


UniqersMarriage.LoyaltySystemEnabled = true -- Completely enables/disables the system
UniqersMarriage.WeeklyResetDay = 6 -- 1 = Monday (The day of the week when the reset occurs)
UniqersMarriage.WeeklyResetHour = 19 -- 20:00 (The hour when the reset occurs)
UniqersMarriage.WeeklyResetMinute = 34 -- Minute
UniqersMarriage.Props = {
    ['chocolate'] = "prop_choc_ego", 
    ['flower'] = "prop_single_rose"
}
UniqersMarriage.PoliceAlert = {
    enabled = true,
    jobs = {"police", "sheriff"},
}
UniqersMarriage.WeeklyRankedRewards = {
[1] = {
 label = "1. Rewards",
 loyaltyCard = true,
 rewards = {
 { type = "money", account = "bank", amount = 250000, label = "Money", image = "./img/moneydefault.webp" },
 { type = "item", name = "phone", amount = 1, label = "Phone", info = { type = "Phone" }, image = "./img/phone.webp" },
 { type = "vehicle", model = "btype3", label = "Albany Roosevelt Valor", image = "./img/rewardcar.webp" }
 }
},
[2] = {
 label = "2. Rewards",
 rewards = {
 { type = "money", account = "bank", amount = 150000, label = "Money", image = "./img/moneydefault.webp" },
 { type = "item", name = "phone", amount = 1, label = "Phone", info = { type = "Phone" }, image = "./img/phone.webp" },
 }
},
[3] = {
 label = "3. Rewards",
 rewards = {
 { type = "money", account = "bank", amount = 100000, label = "Money", image = "./img/moneydefault.webp" },
 }
},
[4] = {
 label = "4. Rewards",
 rewards = {
 { type = "money", account = "bank", amount = 10000, label = "Money", image = "./img/moneydefault.webp" },
 }
},
[5] = {
 label = "5. Rewards",
 rewards = {
 { type = "money", account = "bank", amount = 250000, label = "Money", image = "./img/moneydefault.webp" },
 }
},
[6] = {
 label = "6. Rewards",
 rewards = {
 { type = "money", account = "bank", amount = 250000, label = "Money", image = "./img/moneydefault.webp" },
 }
},
[7] = {
 label = "7. Rewards",
 rewards = {
 { type = "money", account = "bank", amount = 250000, label = "Money", image = "./img/moneydefault.webp" },
 }
},
[8] = {
 label = "8. Rewards",
 rewards = {
 { type = "money", account = "bank", amount = 250000, label = "Money", image = "./img/moneydefault.webp" },
 }
},
[9] = {
 label = "9. Rewards",
 rewards = {
 { type = "money", account = "bank", amount = 250000, label = "Money", image = "./img/moneydefault.webp" },
 }
},
[10] = {
 label = "10. Rewards",
 rewards = {
 { type = "money", account = "bank", amount = 250000, label = "Money", image = "./img/moneydefault.webp" },
 }
},
}


UniqersMarriage.Missions = {
    legal = {
        daily = {
            give_chocolate = {
                label = "Buy Chocolate for Your Spouse",
                description = "Buy chocolate for your spouse and make them happy to earn loyalty points.",
                points = 10,
                cooldown = 24,
                image = "./img/choclot.webp",
            },
            give_flower = {
                label = "Give Flowers to Your Spouse",
                description = "Buy a beautiful flower for your spouse and gift it to them.",
                points = 15,
                cooldown = 24,
                image = "./img/rose.webp",
            }
        },
        onetime = {
            kissyourwife = {
                label = "Romantic Activity",
                description = "Hug your spouse romantically and show your love.",
                points = 25,
                animDict = "missminuteman_1ig_2",
                animName = "dance_loop_mm",
                image = "./img/huge.webp",
            }
        }
    },
    illegal = {
        daily = {
            rob_store = {
                label = "Store Robbery",
                description = "Carry out a coordinated convenience store robbery together with your partner. Choose roles and get the job done!",
                points = 50,
                cooldown = 24,
                image = "./img/store.webp",
                enabled = true,
                robberyTimer = 120,
                policeRequired = 0,
                requiredWeapon = "weapon_pistol",
                requiredWeaponCount = 1,
                loot = {
                    type = "cash",
                    registerAmount = math.random(1500, 3000) 
                },
                locations = {
                    {
                        coords = vector3(24.404478, -1346.027, 29.497032),
                        heading = 266.39013,
                        name = "Grove Street Store",
                        cashierPed = "mp_m_shopkeep_01",
                        cashierprop = vector4(25.11, -1344.77, 29.71, 270.0),
                        customerSpawns = {
                            vector3(29.378948, -1343.062, 29.497003),
                        }
                    },
                },
                customerPeds = {
                    "a_m_m_fatwhite_01",
                    "a_f_y_business_02",
                    "g_m_y_ballaeast_01",
                    "a_m_y_skater_01",
                }
            }
        },
        onetime = {
            steal_car = {
                label = "Steal Lux Car",
                description = "Experience the thrill of stealing a valuable car with your partner.",
                points = 50,
                image = "./img/carthief.webp",
                hackTime = 45,
                policeRequired = 0,
                requiredItem = "lockpick",
                requiredItemCount = 1,
                roles = {
                    mechanic = {
                        label = "Mechanic",
                        description = "Unlocks the vehicle door using a lockpick."
                    },
                    hacker = {
                        label = "Hacker",
                        description = "Hacks the vehicle's ECU to start the engine."
                    }
                },
                deliveryPed = "s_m_y_dealer_01",
                deliveryLocation = vector4(-230.5621, -1177.347, 22.930646, 11.635438),
                deliverypedspawn = vector4(-207.317, -1180.059, 23.029382, 98.933731),
                targetVehicles = {
                    "zentorno", "t20", "osiris", "entityxf", "turismor",
                    "adder", "bullet", "cheetah", "vacca", "infernus"
                },
            }
        }
    }
}