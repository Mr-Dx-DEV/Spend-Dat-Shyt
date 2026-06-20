Config = {}

Config.Framework = 'QBcore'                                -- Framework used: 'ESX' or 'QBcore'
Config.OxLib = true                                     -- Use ox_lib (true/false)

Config.Language = 'pl'                                  -- Language
-- Available languages:
-- 'pl'  - Polish
-- 'en'  - English
-- 'fr'  - French
-- 'it'  - Italian
-- 'pt'  - Portuguese
-- 'sv'  - Swedish
-- 'es'  - Spanish
-- 'de'  - German
-- 'tr'  - Turkish

Config.SavaDrunkStatusInSQL = true                      -- Save player's drunk level to the database using oxmysql
Config.ClearAllEffectAfterDead = true                   

Config.AlcocholItems = {
    ["beer"] = {drunk = 0.50, notify = 'You drank a beer', prop = 'prop_beer_pissh', propoffset = {x = 0.03, y = -0.195, z = 0.045}, thirst = {"add", 100000}, stress = {"remove", 100}},  

    ["vodka"] = {drunk = 1.10, notify = 'You chugged a whole bottle of vodka', prop = 'prop_vodka_bottle', propoffset = {x = -0.011, y = -0.255, z = 0.090}, thirst = {"add", 100}, stress = {"remove", 100}}, 
    ["vodka_shot"] = {drunk = 0.70, notify = 'You took a vodka shot', prop = 'prop_cs_shot_glass', propoffset = {x = 0.12, y = -0.01, z = 0.045}, thirst = {"add", 50}, stress = {"remove", 50}}, 

    ["whiskey"] = {drunk = 1.20, notify = 'You downed a bottle of whiskey', prop = 'prop_whiskey_bottle', propoffset = {x = 0.02, y = -0.16, z = 0.05}, thirst = {"add", 100}, stress = {"remove", 100}},
    ["whiskey_glass"] = {drunk = 0.60, notify = 'You drank a glass of whiskey', prop = 'prop_drink_whisky', propoffset = {x = 0.12, y = -0.03, z = 0.055}, thirst = {"add", 50}, stress = {"remove", 50}}, 

    ["tequila"] = {drunk = 1.00, notify = 'You smashed a bottle of tequila', prop = 'prop_tequila_bottle', propoffset = {x = 0.01, y = -0.26, z = 0.06}, thirst = {"add", 100}, stress = {"remove", 100}}, 
    ["tequila_shot"] = {drunk = 0.50, notify = 'You took a shot of tequila', prop = 'prop_cs_shot_glass', propoffset = {x = 0.12, y = -0.01, z = 0.045}, thirst = {"add", 50}, stress = {"remove", 50}}, 

    ["wine"] = {drunk = 0.90, notify = 'You drank a bottle of wine', prop = 'prop_wine_bot_01', propoffset = {x = 0.00, y = -0.25, z = 0.07}, thirst = {"add", 50}, stress = {"remove", 50}}, 
    ["wine_glass"] = {drunk = 0.50, notify = 'You sipped a glass of wine', prop = 'p_wine_glass_s', propoffset = {x = 0.13, y = -0.045, z = 0.05}, thirst = {"add", 25}, stress = {"remove", 25}}, 

    ["rum"] = {drunk = 1.10, notify = 'You finished off a bottle of rum', prop = 'prop_rum_bottle', propoffset = {x = 0.03, y = -0.24, z = 0.065}, thirst = {"add", 100}, stress = {"remove", 100}},
    ["rum_glass"] = {drunk = 0.70, notify = 'You drank a glass of rum', prop = 'prop_drink_whisky', propoffset = {x = 0.12, y = -0.03, z = 0.055}, thirst = {"add", 50}, stress = {"remove", 50}}, 

    ["champagne_glass"] = {drunk = 0.60, notify = 'You drank a glass of champagne', prop = 'prop_drink_champ', propoffset = {x = 0.025, y = -0.16, z = 0.055}, thirst = {"add", 50}, stress = {"remove", 50}}, 
    ["mojito"] = {drunk = 0.40, notify = 'You drank a refreshing mojito', prop = 'prop_mojito', propoffset = {x = 0.05, y = -0.12, z = 0.06}, thirst = {"add", 25}, stress = {"remove", 25}},   
    ["martini"] = {drunk = 0.45, notify = 'You sipped a classy martini', prop = 'prop_tequila', propoffset = {x = 0.05, y = -0.10, z = 0.06}, thirst = {"add", 25}, stress = {"remove", 25}}, 
    ["bloody_mary"] = {drunk = 0.50, notify = 'You had a spicy Bloody Mary', prop = 'prop_daiquiri', propoffset = {x = 0.05, y = -0.10, z = 0.06}, thirst = {"add", 25}, stress = {"remove", 25}}, 
    ["sex_on_the_beach"] = {drunk = 0.55, notify = 'You enjoyed a fruity Sex on the Beach', prop = 'prop_tequsunrise', propoffset = {x = 0.08, y = -0.07, z = 0.045}, thirst = {"add", 25}, stress = {"remove", 25}}, 
    ["pina_colada"] = {drunk = 0.60, notify = 'You had a tropical Piña Colada', prop = 'prop_tequsunrise', propoffset = {x = 0.08, y = -0.07, z = 0.045}, thirst = {"add", 25}, stress = {"remove", 25}}, 

}


Config.DropDrunkLevelTime = 60                          -- Time interval (in seconds) between BAC reduction
Config.DropDrunkLevelCount = 0.1                        -- Amount of BAC reduced every DropDrunkLevelTime

Config.DrunkStageOneFrom = 0.10                         -- Stage 1 (tipsy) starts from this BAC
Config.DrunkStageTwoFrom = 0.60                         -- Stage 2 (drunk) starts from this BAC
Config.DrunkStageThreeFrom = 1.50                       -- Stage 3 (very drunk) starts from this BAC
Config.DrunkStageFourFrom = 3.80                        -- Stage 4 (wasted) starts from this BAC

Config.Vomit = true                                     -- Enables the vomiting feature when the player’s BAC drops from stage 4 to stage 3.
Config.VomitLos = 70                                    -- Sets the chance of vomiting occurring at 70% when the player’s BAC decreases from stage 4 to stage 3.

Config.BwFromOverDrink = true                           -- Enable blacking out (BW) from excessive drinking
Config.BwOverDrinkCount = 7.5                           -- BAC threshold for automatic blackout (BW)
Config.BwOverDrinkPassProcent = 10.5                    -- Currently ignored, blackout always occurs if threshold is passed
Config.ProcentForBw = 50                                -- Chance (%) for BW — currently unused/ignored

Config.CarDriveDifficultWhenDrunk = true                -- Enable driving difficulty when drunk
Config.CarDriveDefficultOver = 1.5                      -- BAC level where driving becomes harder
Config.CarDriveDefficultHold = {min = 200, max = 600}   -- Duration of driving effects (in ms)

Config.RagdollWhenDrunk = true                          -- Enable random ragdoll effect when drunk
Config.RagdollOverDrunk = 3.0                           -- BAC level that triggers random ragdoll
Config.NextRagdollRandomTimer = {min = 20, max = 40}    -- Time before next ragdoll trigger (in seconds)
Config.RagdollRandomTimer = {min = 1, max = 5}          -- Ragdoll duration (in seconds)

Config.LostControlFromOverDrink = true                  -- Enable losing control when severely drunk
Config.LostControlAction = true                         -- Temporarily disables player control (mouse & keyboard) at intervals when heavily intoxicated.
Config.LostControlCount = 4.5                           -- BAC level that triggers loss of control
Config.LostControlRadialToMove = 500.0                  -- Radius within which the player might move randomly
Config.LostControlTimeOut = 80                          -- Time before control returns if destination isn't reached (in seconds)
Config.ProcentForLostControl = 50                       -- Chance (%) of losing control when conditions are met

Config.BreathalyzerItemName = 'breathalyzer'            -- Item name used to measure BAC
Config.BreathalyzerCheckTimer = 10                      -- Duration of the breathalyzer check (in seconds)

Config.StomachLavageTarget = false                       -- Enable stomach pumping through target system; export works regardless
Config.StomachLavageTargetType = 'ox_target'            -- Target system type: 'ox_target' or 'qb-target'
Config.StomachLavageTargetAllow = {'ambulance'}         -- Jobs allowed to use stomach pumping via target