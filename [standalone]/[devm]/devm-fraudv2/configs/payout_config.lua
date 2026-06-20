payoutConfig = {}

payoutConfig.payoutMethod = 'black_money'
payoutConfig.contactPoliceOnFailure = true -- Wether or not to contact the police when the card gets fails
payoutConfig.chance = { -- Chance of the card paying out
    ['Bronze'] = 15,
    ['Classic'] = 20,
    ['Silver'] = 30,
    ['Gold'] = 40,
    ['Platinum'] = 50,
    ['Diamond'] = 60,
    ['Exclusive'] = 70,
    ['Premium'] = 80,

}

payoutConfig.policeChance = { -- Chance of police being notified
    ['Bronze'] = 90,
    ['Classic'] = 80,
    ['Silver'] = 70,
    ['Gold'] = 60,
    ['Platinum'] = 90,
    ['Diamond'] = 90,
    ['Exclusive'] = 90,
    ['Premium'] = 90,

}
--[[ 
Pay Grade for Subtypes:
Defines the relative value tiers of each subtype with minimum and maximum price ranges.
- Each subtype is associated with a pay range (min to max) to reflect its market value.
]]

payoutConfig.simPayouts = {
    ["Unlimited Data"] = { min = 15, max = 22 },
    ["5GB Data"] = { min = 12, max = 18 },
    ["40GB Data"] = { min = 14, max = 20 },
    ["2GB Data"] = { min = 10, max = 15 },
    ["10GB Data"] = { min = 14, max = 22 },
    ["500MB Data"] = { min = 8, max = 12 },
    ["20GB Data"] = { min = 12, max = 18 },
    ["International Roaming"] = { min = 18, max = 25 },
    ["5G"] = { min = 16, max = 22 },
    ["4G LTE"] = { min = 13, max = 20 },
    ["3G"] = { min = 9, max = 14 },
    ["Hotspot"] = { min = 15, max = 22 }
}

payoutConfig.payouts = {
    Bronze = { min = 400, max = 450 },       -- $40 - $60
    Classic = { min = 500, max = 550 },     -- $70 - $100
    Silver = { min = 600, max = 650 },     -- $120 - $160
    Gold = { min = 700, max = 750 },       -- $180 - $220
    Platinum = { min = 800, max = 850 },   -- $250 - $300
    Diamond = { min = 900, max = 950 },    -- $350 - $450
    Premium = { min = 1000, max = 1500 },    -- $600 - $800
    Exclusive = { min = 2000, max = 2500 }, -- $900 - $1000

}
