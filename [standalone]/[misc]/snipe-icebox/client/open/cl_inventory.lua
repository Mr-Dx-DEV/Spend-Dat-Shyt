blacklistedChains = {}
blackListedWatches = {}
function GetItems()
    local returnData = {}
    if Config.Inventory == "ox" then
        local playerItems = exports.ox_inventory:GetPlayerItems()
        for k, v in pairs(playerItems) do
            Wait(10)
            returnData[#returnData + 1] = {
                label = v.label,
                count = v.count,
                name = v.name,
                slot = v.slot,
                metadata = v.metadata or nil,
            }
        end
        return returnData
    elseif Config.Inventory == "qsv2" then
        local playerItems = exports['qs-inventory']:getUserInventory()
        for k, v in pairs(playerItems) do
            returnData[#returnData + 1] = {
                label = v.label,
                count = v.amount,
                name = v.name,
                slot = v.slot,
                metadata = v.info or nil,
            }
        end
        return returnData

    elseif Config.Inventory == "qb" then
        local playerItem = QBCore.Functions.GetPlayerData().items
        for k, v in pairs(playerItem) do
            returnData[#returnData + 1] = {
                label = v.label,
                count = v.amount,
                name = v.name,
                slot = v.slot,
                metadata = v.info or nil,
            }
        end
        return returnData
    end
end

function Initialize()
    
    if Config.Inventory == "ox" then
        local metadataDisplayTable = {}
        for k, v in pairs(Config.InfuseItems) do
            metadataDisplayTable[k] = v.label
        end
        exports.ox_inventory:displayMetadata(metadataDisplayTable)
    end
end

local ignoreItemMovement = false
RegisterNetEvent("snipe-icebox:ignoreItemMovement", function(ignore)
    ignoreItemMovement = ignore
end)

local function DroppedChain(item)
    if ignoreItemMovement then
        ignoreItemMovement = false
        return
    end
    for k, v in pairs(wearingChain) do
        if v.name == item then
            if v.type == "prop" then
                DetachEntity(v.chain, true, false)
                DeleteEntity(v.chain)
            elseif v.type == "drawable" then
                local chainData = Config.Chains[v.name]
                local component = chainData.componentId or 7
                SetPedComponentVariation(PlayerPedId(), component, 0, 0, 0)
            end
            wearingChain[k] = nil
        end
    end

    for k, v in pairs(wearingWatch) do
        if v.name == item then
            if v.type == "prop" then
                DetachEntity(v.watch, true, false)
                DeleteEntity(v.watch)
            elseif v.type == "drawable" then
                local watchData = Config.Watches[v.name]
                local propIndex = watchData.propId or 6
                SetPedPropIndex(PlayerPedId(), propIndex, -1, -1, 2)
            end
            wearingWatch[k] = nil
        end
    end
end

RegisterNetEvent("esx:removeInventoryItem")
AddEventHandler("esx:removeInventoryItem", function(item)
    DroppedChain(item)
end)

RegisterNetEvent("ox_inventory:itemCount")
AddEventHandler("ox_inventory:itemCount", function(item)
    DroppedChain(item)
end)



RegisterNetEvent("inventory:client:ItemBox")
AddEventHandler("inventory:client:ItemBox", function(item, type)
    DroppedChain(item)
end)

RegisterNetEvent("snipe-icebox:client:removeItem")
AddEventHandler("snipe-icebox:client:removeItem", function(item)
    DroppedChain(item)
end)

function OpenSafe(data)
    if Config.Inventory == "qb" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", data.stashName, {
            maxweight = data.stashsize,
            slots = data.stashslots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", data.stashName)

    elseif Config.Inventory == "qsv2" then
        exports['qs-inventory']:RegisterStash(data.stashName, data.stashslots, data.stashsize) 
    elseif Config.Inventory == "ox" then
        exports.ox_inventory:openInventory('stash', data.stashName)
    end
end
