-- utk_fingerprint Minigame | Download: https://github.com/utkuali/Finger-Print-Hacking-Game
if GetResourceState('utk_fingerprint') == 'started' and GetResourceState('utk_hackdependency') == 'started' then
    Config.MiniGames["fingerprint"] = {
        label = "Finger Print (GOOD)",
        Game = function()
            -- levels: how many levels you want. Max is 4, Min is 1
            -- lifes: how many life player has, Max is 6, Min is 1
            -- time: how much time player has in minutes, Max is 9, min is 1 (I highly recommend to set it between 3-1)
            local result = promise.new()  -- levels, lifes, time
            TriggerEvent("utk_fingerprint:Start", 3, 6, 2, function(outcome, reason)
                result:resolve(outcome)
            end)
            local won = Citizen.Await(result)
            return won
        end,
    }else
    print("^3utk_fingerprint ^2is not started. Make sure that the -main text is removed at the end of the minigame file and it is ensured before robbery creator if you have this minigame installed.")
end

-- ultra-voltlab Minigame  | (MAKE SURE TO DELETE THE VERSION AT THE END OF THE FILE NAME IF YOU DOWNLOAD IT) | Download: https://github.com/ultrahacx/ultra-voltlab/releases/tag/1.1.2
if GetResourceState('ultra-voltlab') == 'started' then
    Config.MiniGames["ultra-voltlab"] = {
        label = "Volt Lab (GOOD)",
        Game = function()
            local result = promise.new() 
            TriggerEvent('ultra-voltlab', 50    , function(status,reason)
            -- time: Time in seconds which player has. Min is 10, Max is 60
            -- result: Reason is the reason of result. Result is an integer code which represents result.
            -- 	   0: Hack failed by player
            -- 	   1: Hack successful
            -- 	   2: Time ran out and hack failed
            -- 	  -1: Error occured i.e. passed input or contents in config is wrong
                local Success
                if status == 1 then
                    Success = true
                end
                result:resolve(Success)
            end)
            local won = Citizen.Await(result)
            return won
        end,
    }else
    print("^3ultra-voltlab ^2is not started. Make sure that the -main text is removed at the end of the minigame file and it is ensured before robbery creator if you have this minigame installed.")
end

-- 8 Inspired Minigames PACK | Download: https://forum.cfx.re/t/free-standalone-fivem-minigames-nopixel-4-0-minigames/5248433
if GetResourceState('bd-minigames') == 'started' then
    Config.MiniGames["inspired-lockpick"] = {
        label = "Inspired Lockpick (GOOD)",
        Game = function()
            local result = promise.new()
                            -- THIS IS MATH RANDOM FOR HOW MANY CIRCLES YOU NEED TO COMPLETE  (MIN IS 2, MAX IS 5)
            local success = exports['bd-minigames']:Lockpick(3, 5)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["inspired-chopping-easy"] = {
        label = "Inspired Chopping Easy",
        Game = function()
            local result = promise.new()

            local success = exports['bd-minigames']:Chopping(12, 30)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["inspired-chopping-easy-medium"] = {
        label = "Inspired Chopping Easy Medium (GOOD)",
        Game = function()
            local result = promise.new()

            local success = exports['bd-minigames']:Chopping(25, 14)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["inspired-pincracker"] = {
        label = "Inspired Pin Cracker (VERY HARD)",
        Game = function()
            local result = promise.new()

            local success = exports['bd-minigames']:PinCracker(3, 20)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["inspired-roofrunning-easy"] = {
        label = "Inspired Roof Running Easy",
        Game = function()
            local result = promise.new()

            local success = exports['bd-minigames']:RoofRunning(10, 10, 30)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["inspired-thermite"] = {
        label = "Inspired Thermite (GOOD)",
        Game = function()
            local result = promise.new()

            local success = exports['bd-minigames']:Thermite(15, 7, 7, 30)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["inspired-thermite-hard"] = {
        label = "Inspired Thermite Hard (GOOD)",
        Game = function()
            local result = promise.new()

            local success = exports['bd-minigames']:Thermite(25, 7, 7, 30)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["inspired-terminal"] = {
        label = "Inspired Terminal Hard (REALLY GOOD)",
        Game = function()
            local result = promise.new()

            local success = exports['bd-minigames']:Terminal(4, 2, 10, 30, 4)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }else
    print("^3bd-minigames ^2is not started. Make sure that the -main text is removed at the end of the minigame file and it is ensured before robbery creator if you have this minigame installed.")
end

-- Original Safe Crack Minigame | Download: https://github.com/VHall1/pd-safe?tab=readme-ov-file
if GetResourceState('pd-safe') == 'started' then
    Config.MiniGames["safe-cracker"] = {
        label = "Safe Cracker (REALLY GOOD)",
        Game = function()
            local result = promise.new()
            local success = exports["pd-safe"]:createSafe({math.random(0,99),math.random(0,99),math.random(0,99),math.random(0,99)})

            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["safe-cracker-easy"] = {
        label = "Safe Cracker Easy",
        Game = function()
            local result = promise.new()
            local success = exports["pd-safe"]:createSafe({math.random(0,99)})

            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }else
    print("^3pd-safe ^2is not started. Make sure that the -main text is removed at the end of the minigame file and it is ensured before robbery creator if you have this minigame installed.")
end
-- ran-minigames pack | Download: https://github.com/RanDXDev/ran-minigames
if GetResourceState('ran-minigames') == 'started' then
    Config.MiniGames["memorycard"] = {
        label = "Memory Card Easy",
        Game = function()
            local result = promise.new()
                                                ---time is optional, time is in seconds
            local success = exports['ran-minigames']:MemoryCard(120)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["memorycard-medium"] = {
        label = "Memory Card Medium (REALLY GOOD)",
        Game = function()
            local result = promise.new()
                                                ---time is optional, time is in seconds
            local success = exports['ran-minigames']:MemoryCard(100)
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["minesweep"] = {
        label = "Mine Sweep (meh)",
        Game = function()
            local result = promise.new()
            --[[
                money, bomb, bombfail are required.
                money: number; (Maximum money amount to get)
                bomb: number; (How much bomb the minigame has)
                bombfail: number; (How much bomb limit we get to force cash out)
                position?: "left" | "right" | "center"
            ]]
            local success = exports['ran-minigames']:MineSweep(12000, 12, 3, "center")
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["openterminal"] = {
        label = "Open Terminal Easy (meh)",
        Game = function()
            local result = promise.new()
            --[[
                money, bomb, bombfail are required.
                money: number; (Maximum money amount to get)
                bomb: number; (How much bomb the minigame has)
                bombfail: number; (How much bomb limit we get to force cash out)
                position?: "left" | "right" | "center"
            ]]
            local success = exports['ran-minigames']:OpenTerminal()
            result:resolve(success)
            
            local won = Citizen.Await(result)
            return won
        end,
    }else
    print("^3ran-minigames ^2is not started. Make sure that the -main text is removed at the end of the minigame file and it is ensured before robbery creator if you have this minigame installed.")
end

if GetResourceState('boii_minigames') == 'started' then
    Config.MiniGames["anagram_game"] = {
        label = "Anagram Game Hard (GOOD)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:anagram({
                style = 'default', -- Style template
                loading_time = 5000, -- Total time to complete loading sequence in (ms)
                difficulty = 10, -- Game difficulty refer to `const word_lists` in `html/scripts/anagram/anagram.js`
                guesses = 5, -- Amount of guesses until fail
                timer = 30000 -- Time allowed for guessing in (ms)
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["button_mash_game"] = {
        label = "Button Mash Game (can be good)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:button_mash({
                style = 'default', -- Style template
                difficulty = 10 -- Difficulty; increasing the difficulty decreases the amount the notch increments on each keypress making the game harder to complete
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["chip_hack_game"] = {
        label = "Chip Hack Game (GOOD)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:chip_hack({
                style = 'default', -- Style template
                loading_time = 8000, -- Total time to complete loading sequence in (ms)
                chips = 2, -- Amount of chips required to find
                timer = 20000 -- Total allowed game time in (ms)
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["hangman_game"] = {
        label = "Hangman Game (GOOD)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:hangman({
                style = 'default', -- Style template
                loading_time = 5000, -- Total time to complete loading sequence in (ms)
                difficulty = 4, -- Game difficulty refer to `const hangman_word_lists` in `html/scripts/hangman/hangman.js`
                guesses = 5, -- Amount of guesses until fail
                timer = 30000 -- Time allowed for guessing in (ms)
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["key_drop_game"] = {
        label = "Key Drop Game Easy (GREAT)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:key_drop({
                style = 'default', -- Style template
                score_limit = 5, -- Amount of keys needed for success
                miss_limit = 3, -- Amount of keys allowed to miss before fail
                fall_delay = 2000, -- Time taken for keys to fall from top to bottom in (ms)
                new_letter_delay = 1000 -- Time taken to drop a new key in (ms)
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["key_drop_game-medium"] = {
        label = "Key Drop Game Medium (GREAT)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:key_drop({
                style = 'default', -- Style template
                score_limit = 12, -- Amount of keys needed for success
                miss_limit = 3, -- Amount of keys allowed to miss before fail
                fall_delay = 2000, -- Time taken for keys to fall from top to bottom in (ms)
                new_letter_delay = 600 -- Time taken to drop a new key in (ms)
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["pincode_game"] = {
        label = "Pincode Game (meh)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:pincode({
                style = 'default', -- Style template
                difficulty = 4, -- Difficuly; increasing the value increases the amount of numbers in the pincode; level 1 = 4 number, level 2 = 5 numbers and so on // The ui will comfortably fit 10 numbers (level 6) this should be more than enough
                guesses = 5 -- Amount of guesses allowed before fail
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["safe_crack_game"] = {
        label = "Safe Crack Game (meh)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:safe_crack({
                style = 'default', -- Style template
                difficulty = 5 -- Difficuly; This increases the amount of lock a player needs to unlock this scuffs out a little above 6 locks I would suggest to use levels 1 - 5 only.
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["skill_bar_game"] = {
        label = "Skill Bar Game (meh)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:skill_bar({
                style = 'default', -- Style template
                icon = 'fa-solid fa-paw', -- Any font-awesome icon; will use template icon if none is provided
                orientation = 2, -- Orientation of the bar; 1 = horizontal centre, 2 = vertical right.
                area_size = 20, -- Size of the target area in %
                perfect_area_size = 5, -- Size of the perfect area in %
                speed = 0.5, -- Speed the target area moves
                moving_icon = true, -- Toggle icon movement; true = icon will move randomly, false = icon will stay in a static position
                icon_speed = 3, -- Speed to move the icon if icon movement enabled; this value is / 100 in the javascript side true value is 0.03
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["skill_circle_game"] = {
        label = "Skill Circle Game (meh)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:skill_circle({
                style = 'default', -- Style template
                icon = 'fa-solid fa-paw', -- Any font-awesome icon; will use template icon if none is provided
                area_size = 4, -- Size of the target area in Math.PI / "value"
                speed = 0.02, -- Speed the target area moves
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["wire_cut_game"] = {
        label = "Wire Cut Game (meh)",
        Game = function()
            local result = promise.new()

            exports['boii_minigames']:wire_cut({
                style = 'default', -- Style template
                timer = 60000 -- Time allowed to complete game in (ms)
            }, function(success)
                result:resolve(success)
            end)
            
            local won = Citizen.Await(result)
            return won
        end,
    }else
    print("^3boii_minigames ^2is not started. Make sure that the -main text is removed at the end of the minigame file and it is ensured before robbery creator if you have this minigame installed.")
end

-- ps-ui Minigame pack |  Download: https://github.com/Project-Sloth/ps-ui
if GetResourceState('ps-ui') == 'started' then
    Config.MiniGames["maze"] = {
        label = "Maze Game (very good)",
        Game = function()
            local result = promise.new()

            exports['ps-ui']:Maze(function(success)
                result:resolve(success)
            end, 20) -- Hack Time Limit
            
            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["circlelock"] = {
        label = "Circle Lock (meh)",
        Game = function()
            local result = promise.new()

            exports['ps-ui']:Circle(function(success)
                result:resolve(success)
            end, 1, 20) -- NumberOfCircles, MS

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["var"] = {
        label = "Var Hack Easy",
        Game = function()
            local result = promise.new()

            exports['ps-ui']:VarHack(function(success)
                result:resolve(success)
            end, 2, 10) -- Number of Blocks, Time (seconds)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["var_hard"] = {
        label = "Var Hack Hard (good)",
        Game = function()
            local result = promise.new()

            exports['ps-ui']:VarHack(function(success)
                result:resolve(success)
            end, 6, 10) -- Number of Blocks, Time (seconds)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["thermite"] = {
        label = "Thermite Hack (good)",
        Game = function()
            local result = promise.new()

            exports['ps-ui']:Thermite(function(success)
                result:resolve(success)
            end, 10, 5, 3) -- Time, Gridsize (5, 6, 7, 8, 9, 10), IncorrectBlocks

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["scrambler"] = {
        label = "Scrambler Hack (VERY GOOD)",
        Game = function()
            local result = promise.new()

            exports['ps-ui']:Scrambler(function(success)
                result:resolve(success)
            end, "numeric", 30, 0) -- Type (alphabet, numeric, alphanumeric, greek, braille, runes), Time (Seconds), Mirrored (0: Normal, 1: Normal + Mirrored 2: Mirrored only )

            local won = Citizen.Await(result)
            return won
        end,
    }else
    print("^3ps-ui ^2is not started. Make sure that the -main text is removed at the end of the minigame file and it is ensured before robbery creator if you have this minigame installed.")
end

if GetResourceState('tgg-minigames') == 'started' then
    Config.MiniGames["tgg-balance"] = {
        label = "TGG Balance (meh)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Balance({
                greenSize = 35,
                yellowSize = 35,
                redSize = 30,
                driftForce = 35,
                pushStrength = 55,
                gameTime = 20
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-circleclick"] = {
        label = "TGG Circle Click (GOOD)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:CircleClick({
                targetZoneSize = 50,
                segmentSpeed = 300,
                numberOfClicks = 10,
                movingTarget = false,
                changeDirectionChance = 100
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-lockpick"] = {
        label = "TGG Lockpick (meh)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Lockpick({
                slowMovementThreshold = 7,
                sections = 36,
                lightShakeTolerance = 6,
                successZoneTolerance = 2
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-masher"] = {
        label = "TGG Masher (meh)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Masher({
                numberOfStages = 3,
                keyPressesPerStage = 25,
                timeLimit = 7,
                randomizeKey = true
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-rhythmclick"] = {
        label = "TGG Rhythm Click (good)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:RhythmClick({
                numberOfStages = 3,
                circlesPerStage = 7,
                circleCloseSpeed = 1.0,
                perfectWindow = 0.12,
                goodWindow = 0.22,
                maxMisses = 2
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-slider"] = {
        label = "TGG Slider (meh)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Slider({
                numberOfStages = 3,
                minNumber = 10,
                maxNumber = 99,
                sliderSpeed = 0.1,
                targetTolerance = 2
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-skillbar"] = {
        label = "TGG Skill Bar (good)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:SkillBar({
                segmentSpeed = 90,
                targetZoneSize = 5,
                hitsRequired = 10,
                minimalMode = true
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-circlezones"] = {
        label = "TGG Circle Zones (meh)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:CircleZones({
                numberOfStages = 3,
                targetZoneSize = 35,
                segmentSpeed = 240,
                clicksRequired = 8,
                movingTarget = true
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-progresstiming"] = {
        label = "TGG Progress Timing (meh)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:ProgressTiming({
                numberOfStages = 3,
                progressSpeed = 1.25,
                targetsPerStage = 5,
                targetWidth = 3
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-arrows"] = {
        label = "TGG Arrows (good ish)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Arrows({
                numberOfStages = 3,
                arrowsPerStage = 12,
                timeLimit = 10,
                useWASD = true
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-reach"] = {
        label = "TGG Reach (GOOD)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Reach({
                numberOfStages = 2,
                mazeSize = 15,
                stageTimer = 20,
                visionRadius = 85
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-cutit"] = {
        label = "TGG Cut It Hard (GOOD)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:CutIt({
                numberOfStages = 2,
                numberOfCables = 10,
                cablesToCut = 3,
                cablesToCutVariation = 1,
                revealAreaSize = 70,
                timePerStage = 55
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-pairs"] = {
        label = "TGG Pairs (OK)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Pairs({
                numberOfStages = 3,
                gridSize = 4,
                previewTime = 3,
                timePerStage = 35
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-locked"] = {
        label = "TGG Locked (meh)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Locked({
                numberOfStages = 2,
                instantFail = false,
                timeLimit = 40,
                slowMovementThreshold = 7,
                penaltySeconds = 3
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-aimit"] = {
        label = "TGG Aim It (meh)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:AimIt({
                numberOfStages = 2,
                instantFail = true,
                targetsCount = 8,
                targetSize = 85,
                stageTimer = 6,
                penaltySeconds = 0.25
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-matchit"] = {
        label = "TGG Match It",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:MatchIt({
                numberOfStages = 3,
                tilesCount = 10,
                tileSpeed = 2,
                tileSpawnInterval = 3
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-destroylinks"] = {
        label = "TGG Destroy Links",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:DestroyLinks({
                numberOfStages = 3,
                instantFail = false,
                timeLimit = 8,
                targetBlocks = 30,
                penaltySeconds = 1
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-getit"] = {
        label = "TGG Get It",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:GetIt({
                numberOfStages = 3,
                speed = 120,
                foodTarget = 12
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-intime"] = {
        label = "TGG In Time (GOOD)",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:InTime({
                numberOfStages = 3,
                blocksPerStage = 25,
                spawnFrequency = 3,
                fallSpeed = 5.55,
                useLetters = false,
                useNumbers = true
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-game20471"] = {
        label = "TGG 2047+1",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Game20471({
                numberOfStages = 3,
                targetNumber = 128,
                stageTimer = 90,
                fourProbability = 0.15
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-amess"] = {
        label = "TGG A Mess (good) key pad",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:AMess({
                numberOfStages = 3,
                numberOfDots = 8,
                minCrossingLines = 4,
                timeLimit = 60
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-mines"] = {
        label = "TGG Mines",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Mines({
                numberOfStages = 3,
                gridSize = 5,
                minesCount = 5,
                previewTime = 4,
                stageTime = 12,
                maxFails = 2
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-onthedot"] = {
        label = "TGG On The Dot (good) key pad",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:OnTheDot({
                numberOfStages = 3,
                ballSpeed = 1.5,
                ballSpacing = 50,
                deflectorSpeed = 8,
                ballsPerStage = 25
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-crackit"] = {
        label = "TGG Crack It",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:CrackIt({
                numberOfStages = 3,
                pinSize = 4,
                timePerStage = 45
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-towerofhanoi"] = {
        label = "TGG Tower Of Hanoi",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:TowerOfHanoi({
                numberOfStages = 3,
                numberOfDisks = 3,
                timePerStage = 120
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-sequencememory"] = {
        label = "TGG Sequence Memory (GOOD) Safe Game",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:SequenceMemory({
                numberOfStages = 3,
                maxBoxesPerStage = 6,
                revealTime = 400,
                gridSize = 4,
                timePerStage = 60
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-iveseenit"] = {
        label = "TGG I've Seen It",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:IveSeenIt({
                numberOfStages = 3,
                wordsPerStage = 20,
                timePerStage = 18,
                repeatWordChance = 50
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-numbers"] = {
        label = "TGG Numbers",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Numbers({
                numberOfStages = 3,
                instantFail = true,
                gridSize = 4,
                timePerStage = 30,
                scrambleCount = 3,
                penaltySeconds = 3
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-unlocked"] = {
        label = "TGG Unlocked",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:Unlocked({
                numberOfStages = 3,
                instantFail = false,
                totalCircles = 4,
                emptySpacePercentage = 30,
                timerPerStage = 45,
                penaltySeconds = 3
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-stickit"] = {
        label = "TGG Stick It",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:StickIt({
                numberOfStages = 3,
                pinsToComplete = 8,
                rotationSpeed = 50,
                changeRotationChance = 50
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["tgg-breachprotocol"] = {
        label = "TGG Breach Protocol",
        Game = function()
            local result = promise.new()

            local success = exports['tgg-minigames']:BreachProtocol({
                numberOfStages = 3,
                instantFail = false,
                matrixSize = 5,
                sequenceLength = 4,
                timeLimit = 60,
                penaltySeconds = 2
            })

            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }else
    -- print("^3tgg-minigames ^2is not started. Make sure it is ensured before robbery creator if you have this minigame installed.")
end


-- bl_ui Minigames Pack
if GetResourceState('bl_ui') == 'started' then
    Config.MiniGames["bl-circle-sum"] = {
        label = "BL Circle Sum",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:CircleSum(3, {
                length = 4,
                duration = 15000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-digit-dazzle"] = {
        label = "BL Digit Dazzle",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:DigitDazzle(3, {
                length = 4,
                duration = 5000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-lights-out"] = {
        label = "BL Lights Out (IDK HOW TO PLAY)",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:LightsOut(3, {
                level = 1,
                duration = 135000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-minesweeper"] = {
        label = "BL Mine Sweeper",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:MineSweeper(3, {
                grid = 10,
                duration = 10000,
                target = 6,
                previewDuration = 2000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-minesweeper-safe"] = {
        label = "BL Mine Sweeper Safe",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:MineSweeper(3, {
                grid = 7,
                duration = 10000,
                target = 7,
                previewDuration = 1000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-path-find-medium"] = {
        label = "BL Path Find Medium",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:PathFind(2, {
                numberOfNodes = 8,
                duration = 15000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-path-find-hard"] = {
        label = "BL Path Find Hard",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:PathFind(3, {
                numberOfNodes = 10,
                duration = 5000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-print-lock"] = {
        label = "BL Print Lock (AMAZING)",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:PrintLock(3, {
                grid = 4,
                duration = 12000,
                target = 4,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-untangle"] = {
        label = "BL Untangle (AMAZING)",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:Untangle(3, {
                numberOfNodes = 10,
                duration = 10000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-wave-match"] = {
        label = "BL Wave Match (GOOD)",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:WaveMatch(3, {
                duration = 20000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["bl-word-wiz"] = {
        label = "BL Word Wiz",
        Game = function()
            local result = promise.new()

            local success = exports.bl_ui:WordWiz(3, {
                length = 4,
                duration = 5000,
            })
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }else
    print("^3bl_ui ^2is not started. Make sure it is ensured before robbery creator if you have this minigame installed.")
end

-- t3_lockpick Minigame
if GetResourceState('t3_lockpick') == 'started' then
    Config.MiniGames["t3-lockpick-easy"] = {
        label = "T3 Lockpick Easy",
        Game = function()
            local result = promise.new()

            local item = "lockpick"
            local difficulty = 1
            local pins = 3

            local success = exports["t3_lockpick"]:startLockpick(item, difficulty, pins)
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["t3-lockpick-medium"] = {
        label = "T3 Lockpick Medium",
        Game = function()
            local result = promise.new()

            local item = "lockpick"
            local difficulty = 3
            local pins = 4

            local success = exports["t3_lockpick"]:startLockpick(item, difficulty, pins)
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }Config.MiniGames["t3-lockpick-hard"] = {
        label = "T3 Lockpick Hard",
        Game = function()
            local result = promise.new()

            local item = "lockpick"
            local difficulty = 3
            local pins = 6

            local success = exports["t3_lockpick"]:startLockpick(item, difficulty, pins)
            result:resolve(success)

            local won = Citizen.Await(result)
            return won
        end,
    }else
    print("^3t3_lockpick ^2is not started. Make sure it is ensured before robbery creator if you have this minigame installed.")
end