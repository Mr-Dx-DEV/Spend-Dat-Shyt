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
CustomDP.Shared = {}
CustomDP.Dances = {}
CustomDP.AnimalEmotes = {}
CustomDP.Exits = {}
CustomDP.Emotes = {
    ["pmeme67a"] = {
        "pazeee@meme67a@animations",
        "pazeee@meme67a@clip",
        "Meme - 67 A",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pmeme67b"] = {
        "pazeee@meme67b@animations",
        "pazeee@meme67b@clip",
        "Meme - 67 B",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pmeme67c"] = {
        "pazeee@meme67c@animations",
        "pazeee@meme67c@clip",
        "Meme - 67 C",
        AnimationOptions = {
            EmoteLoop = true,
			EmoteMoving = true
        }
    },
    ["pmeme67d"] = {
        "pazeee@meme67d@animations",
        "pazeee@meme67d@clip",
        "Meme - 67 D",
        AnimationOptions = {
            EmoteLoop = true,
			EmoteMoving = true
        }
    },
    ["pmemespidermana"] = {
        "pazeee@memespidermana@animations",
        "pazeee@memespidermana@clip",
        "Meme - Spiderman A",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pmemespidermanb"] = {
        "pazeee@memespidermanb@animations",
        "pazeee@memespidermanb@clip",
        "Meme - Spiderman B",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pmemespidermanc"] = {
        "pazeee@memespidermanc@animations",
        "pazeee@memespidermanc@clip",
        "Meme - Spiderman C",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pmemespidermand"] = {
        "pazeee@memespidermand@animations",
        "pazeee@memespidermand@clip",
        "Meme - Spiderman D",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pmemespidermane"] = {
        "pazeee@memespidermane@animations",
        "pazeee@memespidermane@clip",
        "Meme - Spiderman E",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pmemeednaidle"] = {
        "pazeee@memeednaidle@animations",
        "pazeee@memeednaidle@clip",
        "Meme - Edna Idle",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pmemeednaidle"] = {
        "pazeee@memeednaidle@animations",
        "pazeee@memeednaidle@clip",
        "Meme - Edna Idle",
        AnimationOptions = {
            EmoteLoop = true
        }
    },
    ["pmemeednawalk"] = {
        "pazeee@memeednawalk@animations",
        "pazeee@memeednawalk@clip",
        "Meme - Edna Walk",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
        }
    },
    ["pmemeednarun"] = {
        "pazeee@memeednarun@animations",
        "pazeee@memeednarun@clip",
        "Meme - Edna Run",
        AnimationOptions = {
            EmoteLoop = true,
			Flag = 33
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
