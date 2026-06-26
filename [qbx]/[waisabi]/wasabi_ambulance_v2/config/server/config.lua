-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
local config = {

    -------------------------------------------------------------------------------------------------------------
    --                                   FIRST TIME CONFIGURATION NOTE:                                        --
    -- * Hopsitals/Facilities can be set up by executing the command: /facilitypanel while in an admin group.  --
    -------------------------------------------------------------------------------------------------------------

    checkForUpdates = true,                 -- To enable the update checker (recommended)

    inspectCommand = 'inspect',             -- Command to diagnose a player's injuries (Set to false to disable, if using drawText you will need this command)
    facilityPanelCommand = 'facilitypanel', -- Command to open the facility panel (Set to false to disable, if disabled you will not be able to modify hospital locations)

    --- Heal Command Settings
    --- Fully heals player health, injuries, hunger/thirst, and stress without reviving dead players
    --- Usage: /heal [playerId] (playerId optional, defaults to self)
    healCommand = {
        enabled = false,  -- Set to true to enable the /heal command
        command = 'heal', -- Command name
        adminOnly = true, -- If true, only admins can use the command
    },

    --- Kill Command Settings
    --- Allows players to kill themselves (or admins to kill others)
    --- Usage: /kill [playerId] (playerId optional, defaults to self)
    killCommand = {
        enabled = true,           -- Set to true to enable the /kill command
        command = 'kill',          -- Command name
        adminOnly = true,         -- If true, only admin groups can use the command
        adminCanKillOthers = true, -- If true, admins can specify a playerId to kill another player
    },

    muteDeadPlayers = true, -- Mute players via Mumble VOIP when fully dead (death state 2), unmute on revive

    adminGroups = {         -- Admin groups that can do things like revive command, facility panel, etc.
        'admin',
        'god',
    },


    --- Treatment Settings
    treatment = {
        treatmentCooldown = 30, -- Seconds before same player can check in again (prevents spam healing)
        maxEMSForSelfCheckIn = false, -- Set to a number to block self check-in when on-duty EMS count is above this value (0 = only allow when no EMS are on duty)

        --- Treatment Pricing
        --- Set enabled to true to charge players for check-in treatments
        --- Payment is taken when treatment completes successfully
        pricing = {
            enabled = false,      -- Enable/disable treatment charges
            account = 'bank',     -- Account to charge ('bank' or 'money')
            freeIfNoFunds = true, -- If true, treatment is free when player can't afford it. If false, treatment is denied.

            --- Pricing Mode: 'flat' or 'per_injury'
            --- 'flat' = charge a single flat rate regardless of injuries
            --- 'per_injury' = charge based on the number and type of injuries
            mode = 'flat',

            --- Flat rate pricing (used when mode = 'flat')
            flatRate = 500, -- Amount to charge per treatment

            --- Per-injury pricing (used when mode = 'per_injury')
            --- Base price plus additional cost per injury
            perInjury = {
                basePrice = 100,     -- Base treatment fee
                pricePerInjury = 50, -- Additional cost per injury (any type)

                --- Optional: Override price for specific injury types
                --- If not specified, uses pricePerInjury
                injuryPrices = {
                    cut = 25,
                    blunt = 30,
                    brokenbone = 100,
                    gunshot = 150,
                    fist = 15,
                    taser = 20,
                    burn = 40,
                },
            },

            --- Maximum charge cap (0 = no cap)
            maxCharge = 5000,

            --- Society payment
            --- When enabled, successful treatment charges are deposited into the configured society account.
            societyPayment = {
                enabled = false,
                society = 'ambulance', -- ESX will use society_ambulance automatically; QB/QBX use the job/account name
            },

            --- m-Insurance compatibility
            --- https://marcinhu.tebex.io/
            --- When enabled, insured patients receive a discount on check-in treatment charges.
            mInsurance = {
                enabled = false,
                checkInDiscount = 500,
            },
        },
    },

    --- Medic Payment Settings
    --- When enabled, medics earn money for treating patients
    --- Patient is NOT charged when treated by a medic
    medicPayment = {
        enabled = false,    -- Enable/disable medic payment
        account = 'bank',   -- Account to pay medics ('bank' or 'money')
        requireDuty = true, -- Require medic to be on duty to receive payment

        --- Payment Mode: 'flat' or 'per_injury'
        --- 'flat' = pay a single flat rate per treatment/revive
        --- 'per_injury' = pay based on the number and type of injuries treated
        mode = 'flat',

        --- Flat rate payment (used when mode = 'flat')
        flatRate = {
            perInjuryTreatment = 25, -- Payment per injury treated
            perRevive = 200,         -- Payment for reviving a patient
        },

        --- Per-injury payment (used when mode = 'per_injury')
        --- Pays based on specific injury types treated
        perInjury = {
            reviveBonus = 100, -- Bonus payment when reviving a patient

            --- Payment per injury type treated
            injuryPayments = {
                cut = 15,
                blunt = 20,
                brokenbone = 50,
                gunshot = 75,
                fist = 10,
                taser = 15,
                burn = 25,
            },
        },

        --- Maximum payment cap per treatment session (0 = no cap)
        maxPayment = 1000,
    },

    shops = {
        ['medical_general'] = {
            name = "Medical Supplies",
            inventory = {
                { name = 'medbag',  price = 200, label = 'Medical Bag' },
                { name = 'bandage', price = 10,  label = 'Bandage' },
                --  { name = 'water',   price = 10, label = 'Water' },
            }
        }
    },

    logger = {
        enabled = false,
        type = 'discord',    -- "ox", "discord"
        discordWebhook = '', -- Default Discord webhook URL (if using type "discord")
        webhooks = {         -- Optional per-event Discord webhook overrides. Falls back to discordWebhook when blank.
            death = '',      -- Death and last stand logs
            revive = '',     -- Revive logs
            respawn = '',    -- Hospital/facility respawn logs
            treatment = '',  -- Treatment logs
            duty = '',       -- Duty status logs
            action = '',     -- Generic action logs
            default = '',    -- Fallback for uncategorized logger.log/logger.logEvent calls
        },
    }
}

---@ignore
Modules.register('config', config, true)
