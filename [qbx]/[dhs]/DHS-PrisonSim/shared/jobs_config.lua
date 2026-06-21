JobsConfig = {}

if Config.MLOSelection == 'prompt-prison' then
    JobsConfig.MetalShop = {
        enabled = true,
        coords = vec3(1590.85, 2560.75, 46.0),
        size = vec3(14.85, 8.5, 4.0),
        rotation = 0.0,
        ProgressBarSettings = {
            CuttingMetal = {
                duration = 3000,
            },
            LicensePlateEngraving = {
                duration = 10000,
            }
        },
        AmountOfTimeTakenOffSentence = 1, -- This is based off the time metric in config.lua
        AmountofMoneyGivenPerPlate = 2,
        TargetDistances = {
            GrabMetal = 2.0,
            CutMetal = 2.0,
            DrillMetal = 2.0,
            ExportBox = 2.0,
        }
    }

    JobsConfig.WoodShop = {
        enabled = true,
        coords = vec3(1575.0, 2548.0, 46.0),
        size = vec3(19.0, 6.0, 4.0),
        rotation = 0.0,
        ProgressBarSettings = {
            CuttingWood = {
                duration = 3000,
            },
            CraftingWoodenChair = {
                duration = 10000,
            },
            CraftingWoodenTable = {
                duration = 10000,
            },
            CraftingWoodenStorage = {
                duration = 10000,
            }
        },
        AmountOfTimeTakenOffSentence = 1, -- This is based off the time metric in config.lua
        AmountofMoneyGivenPerFurniture = 2,
        TargetDistances = {
            GrabWood = 2.0,
            UseWorkbench = 2.0,
            ExportBox = 2.0,
        }
    }

    JobsConfig.Laundry = {
        enabled = true,
        coords = vec3(1593.0, 2542.0, 46.0),
        size = vec3(10.0, 16.0, 4.0),
        rotation = 0.0,
        ProgressBarSettings = {
            UsingLaundryWasher = {
                duration = 10000,
            },
            UsingLaundryDryer = {
                duration = 10000,
            },
            UsingLaundryFolding = {
                duration = 10000,
            },
        },
        AmountOfTimeTakenOffSentence = 1, -- This is based off the time metric in config.lua
        AmountofMoneyGivenPerFurniture = 2,
        TargetDistances = {
            GrabLaundry = 2.0,
            UseLaundryWasher = 2.0,
            UseLaundryDryer = 2.0,
            UseLaundryFolding = 2.0,
            ExportBox = 2.0,
        }
    }
elseif Config.MLOSelection == 'molo-alcatraz' then
    JobsConfig.Mining = {
        enabled = true,
        coords = vector3(4019.76, 25.28, 22.05),
        size = vec3(40.0, 25.0, 10.0),
        rotation = 0.0,
        ProgressBarSettings = {
            MiningRock = {
                duration = 10000,
            },
        },
        AmountOfTimeTakenOffSentence = 1, -- This is based off the time metric in config.lua
        AmountofMoneyGivenPerRock = 2,
        TargetDistances = {
            GrabRock = 2.0,
            PickaxeBox = 2.0,
            ExportBox = 2.0,
        }
    }
    JobsConfig.Laundry = {
        enabled = true,
        coords = vector3(4070.29, 53.69, 18.79),
        size = vec3(20.0, 15.0, 5.0),
        heading = -171.0,
        ProgressBarSettings = {
            UsingLaundryWasher = {
                duration = 10000,
            },
            UsingLaundryDryer = {
                duration = 10000,
            },
            UsingLaundryFolding = {
                duration = 10000,
            },
        },
        AmountOfTimeTakenOffSentence = 1, -- This is based off the time metric in config.lua
        AmountofMoneyGivenPerFurniture = 2,
        TargetDistances = {
            GrabLaundry = 2.0,
            UseLaundryWasher = 2.0,
            UseLaundryDryer = 2.0,
            UseLaundryFolding = 2.0,
            ExportBox = 2.0,
        }
    }
    JobsConfig.Recycling = {
        enabled = true,
        coords = vector3(4002.44, 59.84, 12.3),
        size = vec3(40.0, 10.0, 2.0),
        heading = -17,
        ProgressBarSettings = {
            CompactMaterial = {
                duration = 10000,
            },
        },
        AmountOfTimeTakenOffSentence = 1, -- This is based off the time metric in config.lua
        AmountofMoneyGivenPerRecycledBlock = 2,
        TargetDistances = {
            GrabRecyclableMaterial = 2.0,
            CompactMaterial = 2.0,
            ExportBox = 2.0,
        }
    }

elseif Config.MLOSelection == 'gabz-prison' then
    --No Jobs Currently Available
elseif Config.MLOSelection == 'custom' then
    -- Open a Ticket So I can help you with your custom prison
end

