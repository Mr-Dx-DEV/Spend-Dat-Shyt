CodeWave_TechWorkz_Framework = CodeWave_TechWorkz_Framework or {}
CodeWave_TechWorkz_Framework.name = nil
CodeWave_TechWorkz_Framework.object = nil

local function getFrameworkName()
    if CodeWave_TechWorkz_Config.Framework == 'ESX' then
        return 'ESX'
    end

    if CodeWave_TechWorkz_Config.Framework == 'QBCore' then
        return 'QBCore'
    end

    local qbState = GetResourceState('qb-core')
    if qbState == 'started' or qbState == 'starting' then
        return 'QBCore'
    end

    local esxState = GetResourceState('es_extended')
    if esxState == 'started' or esxState == 'starting' then
        return 'ESX'
    end

    return nil
end

CreateThread(function()
    while not CodeWave_TechWorkz_Framework.name do
        CodeWave_TechWorkz_Framework.name = getFrameworkName()

        if not CodeWave_TechWorkz_Framework.name then
            Wait(500)
        end
    end

    if CodeWave_TechWorkz_Framework.name == 'ESX' then
        CodeWave_TechWorkz_Framework.object = exports['es_extended']:getSharedObject()
    elseif CodeWave_TechWorkz_Framework.name == 'QBCore' then
        CodeWave_TechWorkz_Framework.object = exports['qb-core']:GetCoreObject()
    end

    print(('[CodeWave_TechWorkz] CodeWave_TechWorkz_Framework detected: %s'):format(CodeWave_TechWorkz_Framework.name))
end)

function CodeWave_TechWorkz_Framework:IsESX()
    return self.name == 'ESX'
end

function CodeWave_TechWorkz_Framework:IsQBCore()
    return self.name == 'QBCore'
end

-- ─── Shared ─────────────────────────────────────────────────────────────────

if IsDuplicityVersion() then
    -- ═══════════════════════════════════════════════════════════════════════
    -- SERVER
    -- ═══════════════════════════════════════════════════════════════════════

    --- Get the raw framework player object.
    ---@param source number
    function CodeWave_TechWorkz_Framework:GetPlayer(source)
        if not self.object then return nil end
        if self:IsESX()    then return self.object.GetPlayerFromId(source) end
        if self:IsQBCore() then return self.object.Functions.GetPlayer(source) end
        return nil
    end

    --- Get a unique persistent identifier for the player.
    ---@param source number
    ---@return string|nil
    function CodeWave_TechWorkz_Framework:GetIdentifier(source)
        if self:IsESX() then
            local p = self:GetPlayer(source)
            return p and p.identifier or nil
        elseif self:IsQBCore() then
            local p = self:GetPlayer(source)
            return p and p.PlayerData.citizenid or nil
        end
        return nil
    end

    --- Check whether a player has at least 1 of an item.
    ---@param source number
    ---@param itemName string
    ---@return boolean
    function CodeWave_TechWorkz_Framework:HasItem(source, itemName)
        return self:GetItemCount(source, itemName) > 0
    end

    --- Get the count of a specific item in the player's inventory.
    ---@param source number
    ---@param itemName string
    ---@return number
    function CodeWave_TechWorkz_Framework:GetItemCount(source, itemName)
        local player = self:GetPlayer(source)
        if not player then return 0 end

        if self:IsESX() then
            local item = player.getInventoryItem(itemName)
            return item and item.count or 0
        elseif self:IsQBCore() then
            local item = player.Functions.GetItemByName(itemName)
            return item and item.amount or 0
        end

        return 0
    end

    --- Remove qty of an item from a player.
    ---@param source number
    ---@param itemName string
    ---@param qty? number  defaults to 1
    ---@return boolean success
    function CodeWave_TechWorkz_Framework:RemoveItem(source, itemName, qty)
        local player = self:GetPlayer(source)
        if not player then return false end
        qty = qty or 1

        if self:IsESX() then
            player.removeInventoryItem(itemName, qty)
            return true
        elseif self:IsQBCore() then
            return player.Functions.RemoveItem(itemName, qty) ~= false
        end

        return false
    end

    --- Add qty of an item to a player.
    ---@param source number
    ---@param itemName string
    ---@param qty? number  defaults to 1
    ---@return boolean success
    function CodeWave_TechWorkz_Framework:AddItem(source, itemName, qty)
        local player = self:GetPlayer(source)
        if not player then return false end
        qty = qty or 1

        if self:IsESX() then
            player.addInventoryItem(itemName, qty)
            return true
        elseif self:IsQBCore() then
            return player.Functions.AddItem(itemName, qty) ~= false
        end

        return false
    end

    --- Get the player's cash balance.
    ---@param source number
    ---@return number
    function CodeWave_TechWorkz_Framework:GetMoney(source)
        local player = self:GetPlayer(source)
        if not player then return 0 end

        if self:IsESX()    then return player.getMoney() end
        if self:IsQBCore() then return player.PlayerData.money['cash'] end
        return 0
    end

    --- Add cash to a player.
    ---@param source number
    ---@param amount number
    function CodeWave_TechWorkz_Framework:AddMoney(source, amount)
        local player = self:GetPlayer(source)
        if not player then return end

        if self:IsESX()    then player.addMoney(amount) end
        if self:IsQBCore() then player.Functions.AddMoney('cash', amount) end
    end

    --- Remove cash from a player.
    ---@param source number
    ---@param amount number
    function CodeWave_TechWorkz_Framework:RemoveMoney(source, amount)
        local player = self:GetPlayer(source)
        if not player then return end

        if self:IsESX()    then player.removeMoney(amount) end
        if self:IsQBCore() then player.Functions.RemoveMoney('cash', amount) end
    end

    --- Register a usable item with the framework.
    ---@param itemName string
    ---@param cb function(source, item)
    function CodeWave_TechWorkz_Framework:RegisterUsableItem(itemName, cb)
        while not self.object do Wait(250) end

        if self:IsESX() then
            self.object.RegisterUsableItem(itemName, function(source)
                cb(source, { name = itemName })
            end)
        elseif self:IsQBCore() then
            self.object.Functions.CreateUseableItem(itemName, function(source, item)
                cb(source, item)
            end)
        end
    end

    --- Send an ox_lib notification to a specific client.
    ---@param source number
    ---@param localeEntry table  ox_lib notify table
    function CodeWave_TechWorkz_Framework:Notify(source, localeEntry)
        TriggerClientEvent('ox_lib:notify', source, {
            title       = localeEntry.title or nil,
            description = localeEntry.description,
            type        = localeEntry.type or 'inform',
            icon        = localeEntry.icon or nil,
            duration    = localeEntry.duration or 4000,
            position    = localeEntry.position or 'top',
        })
    end

else
    -- ═══════════════════════════════════════════════════════════════════════
    -- CLIENT
    -- ═══════════════════════════════════════════════════════════════════════

    --- Get the local player's job name.
    ---@return string|nil
    function CodeWave_TechWorkz_Framework:GetPlayerJob()
        if self:IsESX() and self.object and self.object.GetPlayerData then
            local d = self.object.GetPlayerData()
            return d and d.job and d.job.name or nil
        elseif self:IsQBCore() and self.object and self.object.Functions.GetPlayerData then
            local d = self.object.Functions.GetPlayerData()
            return d and d.job and d.job.name or nil
        end
        return nil
    end

    --- Show an ox_lib notification locally.
    ---@param localeEntry table  ox_lib notify table
    function CodeWave_TechWorkz_Framework:Notify(localeEntry)
        lib.notify({
            title       = localeEntry.title or nil,
            description = localeEntry.description,
            type        = localeEntry.type or 'inform',
            icon        = localeEntry.icon or nil,
            duration    = localeEntry.duration or 4000,
            position    = localeEntry.position or 'top',
        })
    end
end