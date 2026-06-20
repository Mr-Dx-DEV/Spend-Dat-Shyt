SharedObject = GetSharedObject()

if not SharedObject.GetPlayerFromId and SharedObject.Functions then
    SharedObject.RegisterUsableItem = function(itemName, callBack)
        SharedObject.Functions.CreateUseableItem(itemName, callBack)
    end

    SharedObject.GetPlayerFromId = function(source)
        local xPlayer = {}
        local qbPlayer = SharedObject.Functions.GetPlayer(source)
        ---------
        if not qbPlayer then
            return nil
        end
        ---------
        xPlayer.identifier = qbPlayer.PlayerData.citizenid
        ---------
        xPlayer.license = qbPlayer.PlayerData.license
        ---------
        local gradeName = "none"
        local gradeLevel = -1

        xPlayer.job = {
            name = qbPlayer.PlayerData.job.name,
            label = qbPlayer.PlayerData.job.label,
            grade = {
                name = gradeName,
                level = gradeLevel
            }
        }
        ---------
        xPlayer.removeInventoryItem = function(itemName, count)
            qbPlayer.Functions.RemoveItem(itemName, count)
        end
        ---------
        xPlayer.addInventoryItem = function(itemName, count)
            qbPlayer.Functions.AddItem(itemName, count, false)
        end
        ---------
        xPlayer.canCarryItem = function(itemName, count)
            if Config.ox_inv then
                return exports["ox_inventory"]:CanCarryItem(source, itemName, count)
            end

            local item = qbPlayer.Functions.GetItemByName(itemName) or {}
            local ItemInfo = {
                name = itemName,
                count = item.amount or 0,
                label = item.label or "none",
                weight = item.weight or 0,
                usable = item.useable or false,
                rare = false,
                canRemove = false,
            }

            local totalWeight = SharedObject.Player.GetTotalWeight(qbPlayer.PlayerData.items)
            local MaxWeight = 120000 -- default config is 120KG I have not found yet if the config can be fetched....

            if SharedObject.Config and SharedObject.Config.Player then
                if SharedObject.Config.Player.MaxWeight then
                    MaxWeight = SharedObject.Config.Player.MaxWeight
                end
            end

            return (totalWeight + (ItemInfo.weight * count)) <= MaxWeight
        end
        ---------
        return xPlayer
    end
end

if not SharedObject.Functions and not SharedObject.GetPlayerFromId then
    function PlayerIdentifier(source)
        local identifier = "none"

        for k, v in ipairs(GetPlayerIdentifiers(source)) do
            if string.match(v, 'license:') then
                identifier = string.sub(v, 9)
                break
            end
        end

        return identifier
    end

    SharedObject.RegisterUsableItem = function(itemName, callBack)
        RegisterCommand(itemName, callBack, false)
    end

    SharedObject.GetPlayerFromId = function(source)
        local xPlayer = {}
        ---------
        xPlayer.identifier = PlayerIdentifier(source)
        ---------
        xPlayer.license = PlayerIdentifier(source)
        ---------
        xPlayer.job = {
            name = "none",
            label = "none",
            grade = {
                name = "none",
                level = "none"
            }
        }
        ---------
        xPlayer.removeInventoryItem = function(itemName, count)
        end
        ---------
        xPlayer.addInventoryItem = function(itemName, count)
        end
        ---------
        xPlayer.canCarryItem = function(itemName, count)
            return true
        end
        ---------
        return xPlayer
    end
end

function IsPlayerAtJob(source, job)
    local player = SharedObject.GetPlayerFromId(source)

    local convertedJobArray = {}
    if type(job) == "table" then
        for k, v in pairs(job) do
            convertedJobArray[v] = true
        end
    else
        convertedJobArray[job] = true
    end

    if Config.Framework.Active == Framework.ESX or Config.Framework.Active == Framework.QBCORE then
        return convertedJobArray[player.job.name] ~= nil
    end

    if Config.Framework.Active == Framework.CUSTOM then
        return true
    end
end

if Config.Framework.Active == Framework.CUSTOM then
    SharedObject.RegisterUsableItem = function(itemName, callBack)
        RegisterCommand(itemName, callBack, false)
    end
end

if Config.codem_inventory then
    function CarCarryItem(source, item, count)
        local src = source
        local itemName = item
        local ItemList = exports["codem-inventory"]:GetItemlist()
        local weight = ItemList[itemName].weight
        local CanCarry = exports["codem-inventory"]:CanCarryItem(src, weight, count)

        return CanCarry
    end

    local GetPlayerFromId = SharedObject.GetPlayerFromId
    SharedObject.GetPlayerFromId = function(source)
        local player = GetPlayerFromId(source)

        player.canCarryItem = function(item, count)
            return CarCarryItem(source, item, count)
        end

        return player
    end
end

if Config.ox_inv then
    SharedObject.RegisterUsableItem = function(itemName, callBack)
        exports(itemName, function(event, item, inventory, slot, data)
            if event ~= "usingItem" then
                return
            end

            callBack(inventory.id)
        end)
    end
end