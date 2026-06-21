-- Emotes you add in the file will automatically be added to AnimationList.lua
-- If you have multiple custom list files they MUST be added between AnimationList.lua and Emote.lua in fxmanifest.lua!
-- Don't change 'CustomDP' it is local to this file!

-- Remove the } from the = {} then enter your own animation code ---
-- Don't forget to close the tables.

---@type AnimationListConfig?
---@diagnostic disable-next-line: missing-fields
local CustomDP = {}

CustomDP.Expressions = {}
CustomDP.Walks = {}
CustomDP.Shared = {
    ["phelie"] = {
        "pazeee@helie@animations",
        "pazeee@helie@clip",
        "Heli E Struggle",
        "phelif",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelif"] = {
        "pazeee@helif@animations",
        "pazeee@helif@clip",
        "Heli F Struggle",
        "phelie",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 24818,
            xPos = -0.300,
            yPos = 1.100,
            zPos = 0.000,
            xRot = 0.000,
            yRot = 0.000,
            zRot = 90.000
        }
    },
    ["phelig"] = {
        "pazeee@helig@animations",
        "pazeee@helig@clip",
        "Heli G Happy Dance",
        "phelih",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelih"] = {
        "pazeee@helih@animations",
        "pazeee@helih@clip",
        "Heli H Happy Dance",
        "phelig",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 24818,
            xPos = -0.200,
            yPos = 0.000,
            zPos = -0.0400,
            xRot = 0.000,
            yRot = 0.000,
            zRot = 90.000
        }
    },
    ["phelii"] = {
        "pazeee@helii@animations",
        "pazeee@helii@clip",
        "Heli I Angry",
        "phelij",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelij"] = {
        "pazeee@helij@animations",
        "pazeee@helij@clip",
        "Heli J Angry",
        "phelii",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 24818,
            xPos = -0.1900,
            yPos = 0.1000,
            zPos = 0.000,
            xRot = 0.000,
            yRot = 0.000,
            zRot = 70.000
        }
    },
    ["phelik"] = {
        "pazeee@helik@animations",
        "pazeee@helik@clip",
        "Heli K Hug Scared",
        "phelil",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelil"] = {
        "pazeee@helil@animations",
        "pazeee@helil@clip",
        "Heli L Hug Scared",
        "phelik",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 24818,
            xPos = 0.000,
            yPos = 0.1000,
            zPos = 0.000,
            xRot = 0.000,
            yRot = 0.000,
            zRot = 0.000
        }
    },
    ["phelim"] = {
        "pazeee@helim@animations",
        "pazeee@helim@clip",
        "Heli M Enjoy The View",
        "phelin",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelin"] = {
        "pazeee@helin@animations",
        "pazeee@helin@clip",
        "Heli N Enjoy The View",
        "phelim",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 24818,
            xPos = -0.42000,
            yPos = -0.15000,
            zPos = 0.000,
            xRot = 0.000,
            yRot = 0.000,
            zRot = -90.000
        }
    },
    ["phelio"] = {
        "pazeee@helio@animations",
        "pazeee@helio@clip",
        "Heli O Boss High",
        "phelip",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelip"] = {
        "pazeee@helip@animations",
        "pazeee@helip@clip",
        "Heli P Boss High",
        "phelio",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 11816,
            xPos = 0.6300,
            yPos = -0.4800,
            zPos = 0.000,
            xRot = 0.000,
            yRot = 0.000,
            zRot = -70.000
        }
    },
    ["pheliq"] = {
        "pazeee@heliq@animations",
        "pazeee@heliq@clip",
        "Heli Q Cowboy Enjoy",
        "phelir",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelir"] = {
        "pazeee@helir@animations",
        "pazeee@helir@clip",
        "Heli R Cowboy Enjoy",
        "pheliq",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 11816,
            xPos = 0.3000,
            yPos = -0.1000,
            zPos = 0.000,
            xRot = 0.000,
            yRot = 0.000,
            zRot = -80.000
        }
    },
    ["phelis"] = {
        "pazeee@helis@animations",
        "pazeee@helis@clip",
        "Heli S Sit Up",
        "phelit",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelit"] = {
        "pazeee@helit@animations",
        "pazeee@helit@clip",
        "Heli T Sit Up",
        "phelis",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 11816,
            xPos = -0.19000,
            yPos = 0.4400,
            zPos = 0.000,
            xRot = 0.000,
            yRot = 0.000,
            zRot = 100.000
        }
    },
    ["pheliu"] = {
        "pazeee@heliu@animations",
        "pazeee@heliu@clip",
        "Heli U Head High",
        "pheliv",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["pheliv"] = {
        "pazeee@heliv@animations",
        "pazeee@heliv@clip",
        "Heli V Head High",
        "pheliu",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 11816,
            xPos = -0.87000,
            yPos = 0.900,
            zPos = -0.100,
            xRot = 0.000,
            yRot = 0.000,
            zRot = -70.000
        }
    },
    ["pheliw"] = {
        "pazeee@heliw@animations",
        "pazeee@heliw@clip",
        "Heli W Pull Please Don't Go",
        "phelix",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelix"] = {
        "pazeee@helix@animations",
        "pazeee@helix@clip",
        "Heli X Pull Please Don't Go",
        "pheliw",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 11816,
            xPos = 1.14000,
            yPos = 0.600,
            zPos = -0.0300,
            xRot = 0.000,
            yRot = 0.000,
            zRot = -80.000
        }
    },
    ["pheliy"] = {
        "pazeee@heliy@animations",
        "pazeee@heliy@clip",
        "Heli Y Hold Front",
        "pheliz",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["pheliz"] = {
        "pazeee@heliz@animations",
        "pazeee@heliz@clip",
        "Heli Z Hold Front",
        "pheliy",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 11816,
            xPos = -1.42000,
            yPos = 0.100,
            zPos = 0.2200,
            xRot = 0.000,
            yRot = 0.000,
            zRot = -80.000
        }
    },
    ["pheliza"] = {
        "pazeee@heliza@animations",
        "pazeee@heliza@clip",
        "Heli ZA Steal Box",
        "phelizb",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelizb"] = {
        "pazeee@helizb@animations",
        "pazeee@helizb@clip",
        "Heli ZB Steal Box",
        "pheliza",
        AnimationOptions = {
            Prop = "hei_prop_heist_wooden_box",
            PropBone = 0,
            PropPlacement = {
                -0.03,
                0.180,
                -0.440,
                0.000,
                0.000,
                0.000
            },
            EmoteLoop = true,
            Attachto = true,
            bone = 11816,
            xPos = -0.36000,
            yPos = 0.9900,
            zPos = -0.0400,
            xRot = 0.000,
            yRot = 0.000,
            zRot = -70.000
        }
    },
    ["phelizc"] = {
        "pazeee@helizc@animations",
        "pazeee@helizc@clip",
        "Heli ZC Pointing A Gun",
        "phelizd",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["phelizd"] = {
        "pazeee@helizd@animations",
        "pazeee@helizd@clip",
        "Heli ZD Pointing A Gun",
        "phelizc",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 11816,
            xPos = -0.2000,
            yPos = 1.0400,
            zPos = 0.000,
            xRot = 0.000,
            yRot = 0.000,
            zRot = -80.000
        }
    },
    ["phelize"] = {
        "pazeee@helize@animations",
        "pazeee@helize@clip",
        "Heli ZE Best View!",
        "phelizf",
        AnimationOptions = {
			Flag = 2
        }
    },
    ["phelizf"] = {
        "pazeee@helizf@animations",
        "pazeee@helizf@clip",
        "Heli ZF Best View!",
        "phelize",
        AnimationOptions = {
            Attachto = true,
            bone = 11816,
            xPos = -0.4900,
            yPos = 1.0200,
            zPos = -0.0600,
            xRot = 0.000,
            yRot = 0.000,
            zRot = -70.000
        }
    },
    ["phelizh"] = {
        "pazeee@helizh@animations",
        "pazeee@helizh@clip",
        "Heli ZH Carry Toys",
        "phelizg",
        AnimationOptions = {
            EmoteLoop = true,
			EmoteMoving = true,
        }
    },
    ["phelizg"] = {
        "pazeee@helizg@animations",
        "pazeee@helizg@clip",
        "Heli ZG Carry Toys",
        "phelizh",
        AnimationOptions = {
            EmoteLoop = true,
            Attachto = true,
            bone = 24818,
            xPos = -0.0100,
            yPos = -0.1400,
            zPos = -0.300,
            xRot = 0.000,
            yRot = 0.000,
            zRot = 0.000
        }
    },
}
CustomDP.Dances = {}
CustomDP.AnimalEmotes = {}
CustomDP.Exits = {}
CustomDP.Emotes = {
    ["phelia"] = {
        "pazeee@helia@animations",
        "pazeee@helia@clip",
        "Heli A Idle",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["phelib"] = {
        "pazeee@helib@animations",
        "pazeee@helib@clip",
        "Heli B Idle Spin",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["phelic"] = {
        "pazeee@helic@animations",
        "pazeee@helic@clip",
        "Heli C Random Spin",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["phelid"] = {
        "pazeee@helid@animations",
        "pazeee@helid@clip",
        "Heli D Flee",
        AnimationOptions = {
			Flag = 4194337
        }
    },
    ["phelizi"] = {
        "pazeee@helizi@animations",
        "pazeee@helizi@clip",
        "Heli ZI Race Mode",
        AnimationOptions = {
			Flag = 4194337
        }
    },
}
CustomDP.PropEmotes = {}

-----------------------------------------------------------------------------------------
--| I don't think you should change the code below unless you know what you are doing |--
-----------------------------------------------------------------------------------------

function LoadAddonEmotes()
    local prefixes = {
        Shared = '🤼 ',
        AnimalEmotes = '🐶 ',
        PropEmotes = '📦 '
    }

    assert(CustomDP ~= nil, 'Addon emotes can only be loaded once')
    for arrayName, array in pairs(CustomDP) do
        if RP[arrayName] then
            local prefix = prefixes[arrayName]
            for emoteName, emoteData in pairs(array) do
                if prefix then
                    emoteData[3] = prefix .. emoteData[3]
                end
                RP[arrayName][emoteName] = emoteData
            end
        end
    end
    -- Free memory
    CustomDP = nil
end
