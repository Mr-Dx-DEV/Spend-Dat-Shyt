-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
local config = {

    -------------------------------------------------------------------------------------------------------------
    --                                   FIRST TIME CONFIGURATION NOTE:                                        --
    -- * Hopsitals/Facilities can be set up by executing the command: /facilitypanel while in an admin group.  --
    -------------------------------------------------------------------------------------------------------------

    ---@NOTE: drawText needs ox_lib context menu currently
    interact = "ox_target", -- "ox_target" or "qb-target" or "sleepless_interact" or "drawText"
    -- When using drawText or sleepless_interact, you need to use /inspect command to inspect nearby players

    progress = "circle", -- "circle" or "bar" (Only if using progress bar system compatible in bridge/progress/client.lua)

    -- if using drawText set Options here
    drawText = {
        maxDistance = 8.0,
        defaultInteractDistance = 2.0,
        useSprite = true,
        sprite = {
            dict = "shared",
            texture = "emptydot_32",
            color = { 28, 100, 184, 255 }
        }
    },

    uiColors = {
        death = '#29b181',         -- Death screen accent color (hex format)
        facilityPanel = '#29b181', -- Facility panel accent color (hex format)
        inspection = '#29b181',    -- Inspection UI accent color (hex format)
    },
    deathScreenStyle = "default",  -- "default" (detailed with buttons/timer) or "simple" (minimal text overlay)
    showHeartRate = true,          -- Show heart rate monitor in the injury inspection UI

    -- Camera used when the inspection UI opens while the player is lying in a facility bed.
    -- Adjust offset/rotation if hospital interiors place the default overhead camera inside walls or ceilings.
    inspectionBedCamera = {
        offset = vec3(0.0, 0.0, 4.0),      -- Relative to bed heading. Example side angle: vec3(0.0, -2.0, 2.0)
        rotation = vec3(-90.0, 0.0, 0.0),  -- Camera rotation. Example side angle: vec3(-45.0, 0.0, 0.0)
        fov = 40.0,
    },

    disableSpawnManager = true,    -- Leave as true unless you know what you are doing
    enableHealthRegen = false,     -- Enable the GTA style health regeneration by setting to true

    blips = {                      -- The blip settings for hospitals/facilities that have blip enabled
        sprite = 61,               -- Sprite of the blip https://docs.fivem.net/docs/game-references/blips/
        color = 2,                 -- Color of the blip https://docs.fivem.net/docs/game-references/blips/
        scale = 0.5                -- Scale of the blip
    },

    checkInProximityRadius = 5.0, -- Radius in meters from the check-in point to trigger the check-in while dead

    injurySettings = {
        disableLimp = false, -- Enable/disable the limp animation when legs are broken
        disableInjuryNotifications = false, -- Enable/disable the injury notifications
    },

    fistInjuryModifier = 0.5, -- Modifier for fist injuries - default GTA is 1.0, set to 0.1 to make fist injuries 1/10 severity or 0.5 for half severity

    death = {
        stayInVehicleOnDeath = true, -- When true, dying in a vehicle skips last stand and keeps the player seated like v1. When false, they exit beside the vehicle into last stand.
        disableAllControls = true, -- Disable all controls while in a death state (death or last stand) except the ones in allowedControls
        allowedControls = {
            -- Controls that are allowed while dead
            1, -- LookLeftRight
            2, -- LookUpDown
            245, -- T (chat)
        },
        disabledControls = {
            -- Controls that are always disabled while in death states, ignored if disableAllControls is true
            200, -- ESC
            38,  -- E
            32,  -- W
            33,  -- S
            34,  -- A
            35,  -- D
        },
        lastStand = {
            enable = true,              -- Enable/disable last stand feature
            bleedOutRate = 1,           -- Amount of health lost per second while in last stand. Decimals are supported (for example, 0.1 removes 1 health every 10 seconds).
            skipOnFatalHeadshot = true, -- When true, a lethal gunshot to the head skips last stand and goes straight to dead (medical client damage handler).
        },
        -- Optional per-ped animation overrides for custom peds that do not work with the default animations.
        -- Use model hashes as keys. If the player's ped is not listed here, the default animations are used automatically.
        animations = {
            [`mp_m_freemode_01`] = {
                death = { dict = 'missfinale_c1@', clip = 'lying_dead_player0' },
                vehicleDeath = { dict = 'veh@bus@passenger@common@idle_duck', clip = 'sit' },
                lastStand = { dict = 'move_injured_ground', clip = 'front_loop' },
            }
        },
        screenEffects = {
            blood = true,
            shake = true,
            vignette = true
        },
    },

    bleeding = {
        enabled = true,
        bleedStates = {
            light = { threshold = 1, damagePerSecond = 1 },
            moderate = { threshold = 33, damagePerSecond = 3 },
            heavy = { threshold = 66, damagePerSecond = 5 },
        }
    },

    stun = {
        enabled = true,
        stunDuration = { min = 5, max = 8 }, -- Duration range (in seconds) for stun effect. minimum must be at least 2.8 seconds for the animations to work properly
    },

    knockout = {
        enabled = true,             -- Enable/disable the knockout system entirely
        healthForKnockout = 150,    -- Health threshold below which melee combat can knock the player out (max health is 200)
        duration = 7000,            -- Duration of the knockout in ms
        stunTriggersKnockout = true,-- When stun reaches 100, route through knockout instead of the one-shot stun ragdoll

        -- Optional health regen WHILE the player is knocked out.
        -- `regainHealth` is a ceiling for critically-low players: if HP is BELOW this value
        -- during knockout, it gets topped up by `regainAmount` every tick, capped at this value.
        -- Players already at or above this value are left untouched. Set to false to disable.
        -- Example: regainHealth = 150 means "if HP drops below 150, regen back up to 150 during knockout".
        regainHealth = 130,          -- number|false
        regainAmount = 2,           -- HP restored per tick (~4/sec) while regen is active
    },

    injuries = {
        --- status types: bleed, stun, brokenbone, gunshot, fist
        cut = {
            limbHealthDamage = 100,
            statusPerLimb = {
                [1] = { status = "bleed", amount = 25 }, -- HEAD
                [2] = { status = "bleed", amount = 15 }, -- BODY
                [3] = { status = "bleed", amount = 3 },  -- LEFT_ARM
                [4] = { status = "bleed", amount = 3 },  -- RIGHT_ARM
                [5] = { status = "bleed", amount = 3 },  -- LEFT_LEG
                [6] = { status = "bleed", amount = 3 },  -- RIGHT_LEG
            }
        },
        blunt = {
            limbHealthDamage = 350,
            canBreakBones = true,
            statusPerLimb = {
                [1] = { status = "stun", amount = 25 },
                [2] = { status = "stun", amount = 15 },
                [3] = { status = "stun", amount = 3 },
                [4] = { status = "stun", amount = 3 },
                [5] = { status = "stun", amount = 3 },
                [6] = { status = "stun", amount = 3 },
            }
        },
        brokenbone = {
            limbHealthDamage = 500,
        },
        gunshot = {
            limbHealthDamage = 250,
            canBreakBones = true,
            statusPerLimb = {
                [1] = { status = "bleed", amount = 25 },
                [2] = { status = "bleed", amount = 15 },
                [3] = { status = "bleed", amount = 3 },
                [4] = { status = "bleed", amount = 3 },
                [5] = { status = "bleed", amount = 3 },
                [6] = { status = "bleed", amount = 3 },
            }
        },
        fist = {
            limbHealthDamage = 10,
            statusPerLimb = {
                [1] = { status = "stun", amount = 25 },
                [2] = { status = "stun", amount = 15 },
                [3] = { status = "stun", amount = 3 },
                [4] = { status = "stun", amount = 3 },
                [5] = { status = "stun", amount = 3 },
                [6] = { status = "stun", amount = 3 },
            }
        },
        taser = {
            limbHealthDamage = 100,
        },
        burn = {
            limbHealthDamage = 100,
        }
    },

    beds = {
        [`v_med_bed2`] = {
            inBed = {
                posOffset = vec3(0, 0, 1.05),
                rotOffset = vec3(0, 0, 180),
                model = `v_med_bed2`,
            },
            outBed = {
                posOffset = vec3(0.0, -1.3, 0.0),
                rotOffset = vec3(0, 0, 180),
            },
            animations = {
                layDown = {
                    dict = "anim@gangops@morgue@table@",
                    anim = "ko_front",
                    flag = 63,
                },
            },
        },
        [`v_med_bed1`] = {
            inBed = {
                posOffset = vec3(0, 0.15, 1.6),
                rotOffset = vec3(0, 0, 175),
                model = `v_med_bed1`,
            },
            outBed = {
                posOffset = vec3(0, -1.5, 0.0),
                rotOffset = vec3(0, 0, 180),
            },
            animations = {
                layDown = {
                    dict = "anim@gangops@morgue@table@",
                    anim = "ko_front",
                    flag = 63,
                },
            },
        },
        [`v_med_emptybed`] = {
            inBed = {
                posOffset = vec3(0, 0.15, 1.4),
                rotOffset = vec3(0, 0, 175),
                model = `v_med_bed1`,
            },
            outBed = {
                posOffset = vec3(0, -1.5, 0.0),
                rotOffset = vec3(0, 0, 180),
            },
            animations = {
                layDown = {
                    dict = "anim@gangops@morgue@table@",
                    anim = "ko_front",
                    flag = 63,
                },
            },
        }
    },

    cloakroom = {
        enabled = true,
        requireDuty = false,    -- If true, player must be on duty to access cloakroom
        skinScript = "default", -- "default", "qb", or "illenium"

        uniforms = {
            {
                label = "Paramedic",
                minGrade = 0,
                male = {
                    clothing = {
                        { component = 11, drawable = 250, texture = 0 },
                        { component = 8,  drawable = 159, texture = 0 },
                        { component = 4,  drawable = 96,  texture = 0 },
                        { component = 6,  drawable = 25,  texture = 0 },
                    },
                    props = {}
                },
                female = {
                    clothing = {
                        { component = 11, drawable = 258, texture = 0 },
                        { component = 8,  drawable = 187, texture = 0 },
                        { component = 4,  drawable = 99,  texture = 0 },
                        { component = 6,  drawable = 25,  texture = 0 },
                    },
                    props = {}
                }
            },
            {
                label = "Doctor",
                minGrade = 2,
                male = {
                    clothing = {
                        { component = 11, drawable = 31, texture = 0 },
                        { component = 8,  drawable = 31, texture = 0 },
                        { component = 4,  drawable = 28, texture = 0 },
                        { component = 6,  drawable = 10, texture = 0 },
                    },
                    props = {}
                },
                female = {
                    clothing = {
                        { component = 11, drawable = 31, texture = 0 },
                        { component = 8,  drawable = 31, texture = 0 },
                        { component = 4,  drawable = 28, texture = 0 },
                        { component = 6,  drawable = 10, texture = 0 },
                    },
                    props = {}
                }
            },
        }
    },

    -- weapons with debounce timers, can only trigger injury once per timer duration, prevents multiple injuries from same weapon in short time
   debouncedInjuryWeapons = {
        [`WEAPON_FIRE`] = 500,
        [`WEAPON_FALL`] = 1000,
        [`WEAPON_RAMMED_BY_CAR`] = 1000,
        [`WEAPON_RUN_OVER_BY_CAR`] = 1000,
    },

    bedExitControls = {
        enabled = true,
        controls = {
            200, -- ESC
            38,  -- E
            32,  -- W
            33,  -- S
            34,  -- A
            35,  -- D
        },
    },
}

---@ignore
Modules.register('config', config, true)
