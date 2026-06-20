if GetResourceState(Config.ResourceNames.QBox) ~= 'started' then return end

-- Detect which inventory system is running
local Inventory = 'ox' -- default
CreateThread(function()
    if GetResourceState('ox_inventory') == 'started' then
        Inventory = 'ox'
    elseif GetResourceState('qb-inventory') == 'started' then
        Inventory = 'qb'
    elseif GetResourceState('ps-inventory') == 'started' then
        Inventory = 'ps'
    end
    DebugPrint('Detected inventory system: ' .. Inventory)
end)

for k, v in pairs(Config.CookingProps) do
    if v.item then
        exports.qbx_core:CreateUseableItem(v.item, function(source, item)
            StartPropPlacement(source, v.item)
        end)
    end
end

for k, v in pairs(Config.DecorationProps) do
    if v.item then
        exports.qbx_core:CreateUseableItem(v.item, function(source, item)
            StartPropPlacement(source, v.item)
        end)
    end
end

-- Consumable Foods (restore hunger)
local ConsumableFoods = {
    'fsg_apple_pie', 'fsg_avocado_toast', 'fsg_bbq_bacon_wraps', 'fsg_bbq_burger',
    'fsg_bbq_chicken', 'fsg_bbq_chicken_flatbread', 'fsg_bbq_ribs', 'fsg_bbq_sausages',
    'fsg_bbq_veggie_skewers', 'fsg_bffriedrice', 'fsg_bpudding', 'fsg_bstirfry',
    'fsg_baked_potato', 'fsg_berrycream', 'fsg_breakfast_burrito', 'fsg_breakfast_muffin',
    'fsg_cheesy_toast', 'fsg_chicken_nuggets', 'fsg_chicken_pesto_pizza', 'fsg_chickensand',
    'fsg_chocolate_mousse', 'fsg_chocolate_spread', 'fsg_choccream', 'fsg_cinnamon_toast',
    'fsg_ckfriedrice', 'fsg_cooked_oatmeal', 'fsg_cooked_steak', 'fsg_crepes',
    'fsg_creme_brulee', 'fsg_curry', 'fsg_donuts', 'fsg_fancy_steak', 'fsg_fish_and_chips',
    'fsg_fried_calamari', 'fsg_fried_cheese_curds', 'fsg_fried_cheese_sticks',
    'fsg_fried_chicken', 'fsg_fried_chicken_wings', 'fsg_fried_okra', 'fsg_fried_potato',
    'fsg_fried_rice', 'fsg_fried_shrimp', 'fsg_fruit_salad', 'fsg_grilled_cheese',
    'fsg_grilled_chicken_breast', 'fsg_grilled_corn', 'fsg_grilled_fish',
    'fsg_grilled_pineapple', 'fsg_grilled_shrimp', 'fsg_grilled_vegetables',
    'fsg_ham_and_cheese_toast', 'fsg_hamtoastie', 'fsg_homemade_soup', 'fsg_mac_n_cheese_bake',
    'fsg_meatlovers_pizza', 'fsg_microwave_chocolate_mug_cake', 'fsg_microwave_mac_cheese',
    'fsg_microwave_omelette', 'fsg_microwave_pizza_slice', 'fsg_mozzarella_sticks',
    'fsg_nanacream', 'fsg_omelette', 'fsg_onion_rings', 'fsg_pan_seared_steak',
    'fsg_pancakes', 'fsg_pasta_dish', 'fsg_pepperoni_pizza', 'fsg_pepshrimp',
    'fsg_pineapple_pizza', 'fsg_popcorn', 'fsg_pulled_pork', 'fsg_quesadilla',
    'fsg_quiche', 'fsg_ramen', 'fsg_ramen_bowl', 'fsg_risotto', 'fsg_salmon',
    'fsg_scrambled_eggs', 'fsg_soup', 'fsg_spring_rolls', 'fsg_stir_fry', 'fsg_toast',
    'fsg_toasti', 'fsg_tv_dinner', 'fsg_veggie_puree', 'fsg_veggie_wrap', 'fsg_waffle',
    'fsg_applesauce'
}

-- Consumable Drinks (restore thirst)
local ConsumableDrinks = {
    'fsg_apple_juice', 'fsg_applejuice', 'fsg_beet_juice', 'fsg_cappuccino',
    'fsg_carrot_juice', 'fsg_celery_juice', 'fsg_coffee', 'fsg_fruit_punch',
    'fsg_grape_juice', 'fsg_hot_chocolate', 'fsg_ice_cream', 'fsg_iced_coffee',
    'fsg_lemonade', 'fsg_mocha', 'fsg_orange_juice', 'fsg_pineapple_juice',
    'fsg_smoothie', 'fsg_tomato_juice', 'fsg_vanilla_latte', 'fsg_watermelon_juice'
}

-- Register food items as consumables
for _, itemName in pairs(ConsumableFoods) do
    exports.qbx_core:CreateUseableItem(itemName, function(source, item)
        local Player = exports.qbx_core:GetPlayer(source)
        if not Player then return end
        if RemoveItem(source, itemName, 1) then
            TriggerClientEvent('fsg_cooking:client:consume', source, 'food', itemName)
        end
    end)
end

-- Register drink items as consumables
for _, itemName in pairs(ConsumableDrinks) do
    exports.qbx_core:CreateUseableItem(itemName, function(source, item)
        local Player = exports.qbx_core:GetPlayer(source)
        if not Player then return end
        if RemoveItem(source, itemName, 1) then
            TriggerClientEvent('fsg_cooking:client:consume', source, 'drink', itemName)
        end
    end)
end

function GetPlayer(source)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then
        DebugPrint("Player invalid")
        return
    end
    return player
end

function GetCharacterIdentifier(source)
    local player = GetPlayer(source)
    if not player then
        DebugPrint("Player invalid")
        return
    end
    return player.PlayerData.citizenid
end

function GetItemQuantity(source, itemName)
    if Inventory == 'ox' then
        return exports.ox_inventory:GetItem(source, itemName, nil, true) or 0
    elseif Inventory == 'qb' then
        local Player = exports.qbx_core:GetPlayer(source)
        if Player then
            local item = Player.Functions.GetItemByName(itemName)
            return item and item.amount or 0
        end
    elseif Inventory == 'ps' then
        local item = exports['ps-inventory']:GetItemByName(source, itemName)
        return item and item.amount or 0
    end
    return 0
end

function HasRequiredItems(playerId, requiredItems)
    if not playerId or not requiredItems then return false end

    for _, item in ipairs(requiredItems) do
        local count = GetItemQuantity(playerId, item.item)
        if count < item.count then
            return false
        end
    end

    return true
end

function RemoveItem(source, itemName, itemQuantity)
    if Inventory == 'ox' then
        return exports.ox_inventory:RemoveItem(source, itemName, itemQuantity)
    elseif Inventory == 'qb' then
        local Player = exports.qbx_core:GetPlayer(source)
        if Player then
            return Player.Functions.RemoveItem(itemName, itemQuantity)
        end
    elseif Inventory == 'ps' then
        return exports['ps-inventory']:RemoveItem(source, itemName, itemQuantity)
    end
    return false
end

function RemoveRequiredItems(playerId, requiredItems)
    if not playerId or not requiredItems then return end

    for _, item in ipairs(requiredItems) do
        RemoveItem(playerId, item.item, item.count)
    end
end

function AddItem(source, item, quantity)
    if Inventory == 'ox' then
        return exports.ox_inventory:AddItem(source, item, quantity)
    elseif Inventory == 'qb' then
        local Player = exports.qbx_core:GetPlayer(source)
        if Player then
            return Player.Functions.AddItem(item, quantity)
        end
    elseif Inventory == 'ps' then
        return exports['ps-inventory']:AddItem(source, item, quantity)
    end
    return false
end

function AddResultItems(playerId, resultItems)
    if not playerId or not resultItems then return end

    for _, item in ipairs(resultItems) do
        AddItem(playerId, item.item, item.count)
    end
end

function CanCarryItem(source, itemName, itemQuantity)
    if Inventory == 'ox' then
        return exports.ox_inventory:CanCarryItem(source, itemName, itemQuantity)
    else
        -- qb-inventory/ps-inventory: return true (weight check handled by inventory)
        return true
    end
end

function GetPlayerBankBalance(source)
    local Player = GetPlayer(source)
    return Player and Player.PlayerData.money.bank or 0
end

function GetPlayerCashBalance(source)
    local Player = GetPlayer(source)
    return Player and Player.PlayerData.money.cash or 0
end

function AddPlayerMoney(source, account, amount, reason)
    local player = GetPlayer(source)
    if not player then
        DebugPrint("Player Invalid")
        return
    end
    if account == 'money' then account = 'cash' end
    player.Functions.AddMoney(account, amount)
end

function RemovePlayerMoney(source, account, amount)
    local player = GetPlayer(source)
    if not player then
        DebugPrint("Player Invalid")
        return
    end
    if account == 'money' then account = 'cash' end
    player.Functions.RemoveMoney(account, amount)
end

RegisterNetEvent('QBCore:Server:PlayerLoaded', function(Player)
    local src = Player.PlayerData.source or source
    SyncPropsToPlayer(src)
end)

function isPlayerAdmin(source)
    local player = GetPlayer(source)
    if not player then return false end

    if Config.AdminGroups then
        for k, v in ipairs(Config.AdminGroups) do
            if IsPlayerAceAllowed(source, v) then
                return true
            end
        end
    end

    return false
end

lib.callback.register('fsg_cooking:getGroupStatus', function(source)
    return isPlayerAdmin(source)
end)
