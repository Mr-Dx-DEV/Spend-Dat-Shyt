Config = {}

-- Locale setting (supported: 'en', 'es', 'fr', 'de', etc.)
Config.Locale = 'en'

-- Debug mode
Config.Debug = false
Config.DebugEffects = false  -- Set to true to see more information about particle effects

Config.ShopMenu = 'ui' -- ox or built-in ui

Config.InventoryImagesPath = 'ox_inventory/web/images/' -- MAKE SURE IT HAS THE / AT THE END OTHERWISE THE SCRIPT WILL BREAK
-- Config.InventoryImagesPath = 'qb-inventory/html/images/' -- MAKE SURE IT HAS THE / AT THE END OTHERWISE THE SCRIPT WILL BREAK

Config.ResourceNames = {
    ESX = 'es_extended',
    QBCore = 'qb-core',
    QBox = 'qbx_core'
}

-- Database settings
Config.Database = {
    AutoExecuteSQL = true, -- Whether to automatically execute the SQL setup on resource start
}   

Config.GroceryBags = {
    Slots = 50,
    Weight = 30000,
}

-- Persistent props settings
Config.PersistentProps = {
    Enabled = true,     -- Whether props persist after server restart
    SaveInterval = 600,  -- How often to save props to database (in seconds)
}

Config.AdminGroups = {
    'god',
    'management',
    'superadmin',
    'admin',
    'lead',
    'leadadmin',
    'senioradmin',
    'senior',
    'gameadmin'
}

-- Skill Check Configuration
Config.SkillCheck = false -- Master toggle for cooking skill checks

Config.AllowAllPlayersToUseProps = false -- Toggle for disabling the restriction of the player only being able to use the cooking prop if they are the one that has placed it
Config.AllowAllPlayersToPickUpProps = true -- Toggle for disabling the restriction of the player only being able to pick up the cooking prop if they are the one that has placed it

-- Prop Placement Configuration
Config.PropPlacement = {
    MaxDistance = 3.0, -- Maximum distance to place props from player
    SyncCheckDistance = 30.0, -- Maximum distance to check for unregistered props
}

-- Prop Sync Method
-- 'events' = Traditional event-based broadcasting (default)
-- 'statebags' = FiveM entity statebags for automatic replication
-- Only one method can be active at a time
Config.PropSyncMethod = 'statebags'

-- Get recipe by name
function Config.GetRecipe(recipeName)
    return Config.Recipes[recipeName]
end

-- Calculate total cooking time for a recipe from cooking flow
function Config.GetTotalCookingTime(recipeName)
    local recipe = Config.Recipes[recipeName]
    if not recipe or not recipe.cookingFlow then return 0 end
    
    local totalTime = 0
    for _, step in ipairs(recipe.cookingFlow) do
        totalTime = totalTime + (step.time or 0)
    end
    
    return totalTime
end

-- Get a specific cooking step from a recipe's cooking flow
function Config.GetCookingStep(recipeName, stepIndex)
    local recipe = Config.Recipes[recipeName]
    if not recipe or not recipe.cookingFlow then return nil end
    
    return recipe.cookingFlow[stepIndex]
end

-- Get total number of cooking steps for a recipe
function Config.GetCookingStepsCount(recipeName)
    local recipe = Config.Recipes[recipeName]
    if not recipe or not recipe.cookingFlow then return 0 end
    
    return #recipe.cookingFlow
end

-- Get prop by model
function Config.GetPropByModel(model)
    local modelHash = model
    
    -- If the model is a string, convert it to hash
    if type(model) == "string" then
        modelHash = joaat(model)
    end
    
    -- Check cooking props first
    for k, v in pairs(Config.CookingProps) do
        local propHash = joaat(v.model)
        if propHash == modelHash or v.model == model then
            return k, v, "cooking"
        end
    end
    
    -- Then check decoration props
    for k, v in pairs(Config.DecorationProps) do
        local propHash = joaat(v.model)
        if propHash == modelHash or v.model == model then
            return k, v, "decoration"
        end
    end
    
    return nil, nil, nil
end

-- Get prop by item
function Config.GetPropByItem(itemName)
    -- Check cooking props first
    for k, v in pairs(Config.CookingProps) do
        if v.item == itemName then
            return k, v, "cooking"
        end
    end
    
    -- Then check decoration props
    for k, v in pairs(Config.DecorationProps) do
        if v.item == itemName then
            return k, v, "decoration"
        end
    end
    
    return nil, nil, nil
end

-- Check if a prop is a decoration prop
function Config.IsDecorationProp(model)
    local modelHash = model
    
    -- If the model is a string, convert it to hash
    if type(model) == "string" then
        modelHash = joaat(model)
    end
    
    for k, v in pairs(Config.DecorationProps) do
        local propHash = joaat(v.model)
        if propHash == modelHash or v.model == model then
            return true
        end
    end
    return false
end
