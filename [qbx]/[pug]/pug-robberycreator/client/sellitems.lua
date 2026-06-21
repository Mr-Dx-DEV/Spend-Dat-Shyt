local AllSellItemsData
local SellItemsProp = {}
local SellItemsPed = {}
local CreatedTarget = {}
local SellItemsZoneTargets = {}
local SellItemsEntityTargets = {}
local SellItemsMenuContexts = {}
local SellItemsStreamEntries = {}
local SellItemsStreamActive = false
local SELL_ITEMS_STREAM_DISTANCE = 100.0
local SELL_ITEMS_DESPAWN_DISTANCE = 120.0

local function GroundSellTargetPedCoords(coords)
    if not coords then return coords end

    RequestCollisionAtCoord(coords.x, coords.y, coords.z)
    local found, groundZ = GetGroundZFor_3dCoord(coords.x + 0.0, coords.y + 0.0, coords.z + 2.0, false)
    if not found then
        found, groundZ = GetGroundZFor_3dCoord(coords.x + 0.0, coords.y + 0.0, coords.z + 50.0, false)
    end

    if found and groundZ then
        return vector3(coords.x, coords.y, groundZ)
    end

    return coords
end

local function DeleteSellItemsStreamEntity(entry)
    if not entry then return end

    if entry.entity and DoesEntityExist(entry.entity) then
        DeleteEntity(entry.entity)
    end

    if entry.entityType == "ped" then
        SellItemsPed[entry.targetName] = nil
    else
        SellItemsProp[entry.targetName] = nil
    end

    entry.entity = nil
end

local function SpawnSellItemsStreamEntity(entry)
    if not entry or entry.disabled or not entry.coords or not entry.model then
        return nil
    end

    if entry.entity and DoesEntityExist(entry.entity) then
        return entry.entity
    end

    LoadModel(entry.model)

    local coords = entry.coords
    local heading = tonumber(entry.heading) or 0.0
    local entity

    if entry.entityType == "ped" then
        entity = CreatePed(4, GetHashKey(entry.model), coords.x, coords.y, coords.z, heading + 0.0, false, true)
        if DoesEntityExist(entity) then
            SetEntityAsMissionEntity(entity, true, true)
            SetEntityCoords(entity, coords.x, coords.y, coords.z, false, false, false, false)
            SetEntityHeading(entity, heading + 0.0)
            SetEntityInvincible(entity, true)
            SetBlockingOfNonTemporaryEvents(entity, true)
            SetPedCanRagdoll(entity, false)
            SetPedFleeAttributes(entity, 0, false)
            FreezeEntityPosition(entity, true)
            SellItemsPed[entry.targetName] = entity
        end
    else
        entity = CreateObject(GetHashKey(entry.model), coords.x, coords.y, coords.z, true, true, false)
        if DoesEntityExist(entity) then
            SetEntityHeading(entity, heading)
            FreezeEntityPosition(entity, true)
            SellItemsProp[entry.targetName] = entity
        end
    end

    if not entity or entity == 0 or not DoesEntityExist(entity) then
        entry.entity = nil
        return nil
    end

    entry.entity = entity
    return entity
end

local function StartSellItemsStreamThread()
    if SellItemsStreamActive then
        return
    end

    SellItemsStreamActive = true
    CreateThread(function()
        while true do
            local hasEntries = false
            local playerCoords = GetEntityCoords(PlayerPedId())

            for _, entry in pairs(SellItemsStreamEntries) do
                hasEntries = true
                if entry.coords then
                    local distance = #(playerCoords - entry.coords)
                    if not entry.disabled and distance <= SELL_ITEMS_STREAM_DISTANCE then
                        SpawnSellItemsStreamEntity(entry)
                    elseif entry.entity and DoesEntityExist(entry.entity) and distance >= SELL_ITEMS_DESPAWN_DISTANCE then
                        DeleteSellItemsStreamEntity(entry)
                    end
                end
            end

            if not hasEntries then
                SellItemsStreamActive = false
                return
            end

            Wait(1000)
        end
    end)
end

local function RegisterSellItemsStreamEntity(targetName, entityType, model, coords, heading)
    if not targetName or not model or model == "" or not coords then
        return
    end

    if SellItemsStreamEntries[targetName] then
        DeleteSellItemsStreamEntity(SellItemsStreamEntries[targetName])
    end

    local entry = {
        targetName = targetName,
        entityType = entityType,
        model = model,
        coords = coords,
        heading = heading or 0.0,
    }

    SellItemsStreamEntries[targetName] = entry

    local playerPed = PlayerPedId()
    if playerPed and playerPed ~= 0 and DoesEntityExist(playerPed) then
        if #(GetEntityCoords(playerPed) - coords) <= SELL_ITEMS_STREAM_DISTANCE then
            SpawnSellItemsStreamEntity(entry)
        end
    end

    StartSellItemsStreamThread()
end

local function ClearSellItemsStreamEntries(deleteEntities)
    for targetName, entry in pairs(SellItemsStreamEntries) do
        if deleteEntities ~= false then
            DeleteSellItemsStreamEntity(entry)
        end
        SellItemsStreamEntries[targetName] = nil
    end
end

local function EndMultipleNetworkAnimation(stage, ObjectData)
    local ChosenAnimation
    local animationKey = stage and stage.animation
    if animationKey and Config.RobberyAnimations[animationKey] then
        ChosenAnimation = Config.RobberyAnimations[animationKey]
    else
        local animationIndex = tonumber(animationKey)
        if animationIndex then
            ChosenAnimation = Config.Animations[animationIndex]
        end
    end
    if not ChosenAnimation then
        ClearPedTasks(PlayerPedId())
        return
    end
    if ChosenAnimation.NetworkedAnimations then
        if #ChosenAnimation.NetworkedAnimations == 1 then
            if GetJewelryCases(stage.propName) then
            else
                if stage.propName == "tr_prop_tr_container_01a" then
                    Wait(4000)
                end
            end
            DestroyAllProps()
            if Config.RobberyAnimations[stage.animation] then
                if Config.RobberyAnimations[stage.animation].ReplaceProp then
                    if GetJewelryCases(stage.animation) then
                        ClearPedTasks(PlayerPedId()) 
                    end
                    if not GetJewelryCases(stage.animation) then
                        TriggerServerEvent("Pug:server:CreateSyncedProps",  ObjectData.Coords, ObjectData.Rotation, ChosenAnimation.NetworkedAnimations[1].AnimDict, ObjectData.RobberyName, stage.propName, ObjectData)
                    end
                else
                    ClearPedTasks(PlayerPedId()) 
                end
            end
            return
        end
        if ChosenAnimation.NetworkedAnimations[#ChosenAnimation.NetworkedAnimations] then
            if ChosenAnimation.NetworkedAnimations[2].AnimAction == "drill_straight_end_idle" and ChosenAnimation.NetworkedAnimations[2].AnimationOptions.SecondProp == "hei_prop_heist_drill" then
                StopSound(soundIdGolbal)
                ReleaseAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET")
                ReleaseAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL")
                ReleaseAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2")
            end
            DestroyAllProps()
            local i = #ChosenAnimation.NetworkedAnimations
            local k = tonumber(stage.animation)
            
            local ZOffset = ChosenAnimation.NetworkedAnimations[i].ZOffset
            local YOffset = ChosenAnimation.NetworkedAnimations[i].YOffset
            local XOffset = ChosenAnimation.NetworkedAnimations[i].XOffset
            loadAnimDict(ChosenAnimation.NetworkedAnimations[i].AnimDict)

            local PlayerCoords = GetEntityCoords(PlayerPedId())
            local PlayerHeading = GetEntityHeading(PlayerPedId())
        

            local radians = math.rad(PlayerHeading)
            local rotatedXOffset = XOffset * math.cos(radians) - YOffset * math.sin(radians)
            local rotatedYOffset = XOffset * math.sin(radians) + YOffset * math.cos(radians)
             
            local Location, Rotation = vector3(PlayerCoords.x + rotatedXOffset, PlayerCoords.y + rotatedYOffset, PlayerCoords.z + ZOffset), vector3(0.0, 0.0, PlayerHeading)
            if ObjectData then
                Location, Rotation = ObjectData.Coords, ObjectData.Rotation
                if Config.RobberyAnimations[stage.animation] then
                    if Config.RobberyAnimations[stage.animation].ReplaceProp then
                        TriggerServerEvent("Pug:server:CreateSyncedProps",  ObjectData.Coords, ObjectData.Rotation, ChosenAnimation.NetworkedAnimations[1].AnimDict, ObjectData.RobberyName, stage.propName, ObjectData)
                    end
                end
            end

            local NetworkScene = NetworkCreateSynchronisedScene(Location, Rotation, 2, true, false, 1065353216, 0, 1.3)
            NetworkAddPedToSynchronisedScene(PlayerPedId(), NetworkScene, ChosenAnimation.NetworkedAnimations[i].AnimDict, ChosenAnimation.NetworkedAnimations[i].AnimAction, 1.5, -4.0, 1, 1, 1148846080, 0)
            if ChosenAnimation.NetworkedAnimations[i].AnimationOptions then
				local PropName =  ChosenAnimation.NetworkedAnimations[i].AnimationOptions.Prop
				local SecondPropEmote
				PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack({0, 0, 0, 0, 0})
				if ChosenAnimation.NetworkedAnimations[i].AnimationOptions.SecondProp then
					SecondPropName = ChosenAnimation.NetworkedAnimations[i].AnimationOptions.SecondProp
					SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack({0, 0, 0, 0, 0})
					SecondPropEmote = true
				end
				AddPropToPlayer(PropName, PropBone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6, PlayerPedId(), true)
				while not DoesEntityExist(prop) do Wait(100) end
				NetworkAddEntityToSynchronisedScene(prop, NetworkScene, ChosenAnimation.NetworkedAnimations[i].AnimationOptions.PropAnimationDict, ChosenAnimation.NetworkedAnimations[i].AnimationOptions.PropAnimation, 4.0, -8.0, 1)
				if SecondPropEmote then
					AddPropToPlayer(SecondPropName, SecondPropBone, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6, PlayerPedId(), true)
					while not DoesEntityExist(prop) do Wait(100) end
					NetworkAddEntityToSynchronisedScene(prop, NetworkScene, ChosenAnimation.NetworkedAnimations[i].AnimationOptions.SecondPropAnimationDict, ChosenAnimation.NetworkedAnimations[i].AnimationOptions.SecondPropAnimation, 4.0, -8.0, 1)
				end
                if ChosenAnimation.NetworkedAnimations[i].AnimationOptions.ThirdProp then
					ThirdPropPl1, ThirdPropPl2, ThirdPropPl3, ThirdPropPl4, ThirdPropPl5, ThirdPropPl6 = table.unpack({0, 0, 0, 0, 0})
					AddPropToPlayer(ChosenAnimation.NetworkedAnimations[i].AnimationOptions.ThirdProp, ThirdPropPl1, ThirdPropPl2, ThirdPropPl3, ThirdPropPl4, ThirdPropPl5, ThirdPropPl6, PlayerPedId(), true)
					while not DoesEntityExist(prop) do Wait(100) end
					NetworkAddEntityToSynchronisedScene(prop, NetworkScene, ChosenAnimation.NetworkedAnimations[i].AnimationOptions.ThirdPropAnimationDict, ChosenAnimation.NetworkedAnimations[i].AnimationOptions.ThirdPropAnimation, 4.0, -8.0, 1)
				end
			end
            
            NetworkStartSynchronisedScene(NetworkScene)
            Wait(ChosenAnimation.NetworkedAnimations[i].WaitTime)
            DestoryCamera()
            DestroyAllProps()
            ClearPedTasks(PlayerPedId())
        end
    else
        ClearPedTasks(PlayerPedId())
    end
end

RegisterNUICallback('SaveSellLocationData', function(data, cb)
    TriggerServerEvent('Pug:saveSellItemsData', data)
    cb('ok')
end)

local function RemoveSellItemsTarget()
    ClearSellItemsStreamEntries(true)

    for k, _ in pairs(CreatedTarget) do
        CreatedTarget[k] = false
        if GetResourceState("RevoInteract") == 'started' then
            exports.RevoInteract:CloseHelp(k:gsub("[%s%.]+", ""))
        end
    end
    if not Config.Target or Config.DrawTextInsteadOfTarget then
        HideTextOption()
    end

    if GetResourceState("RevoInteract") ~= 'started' and Config.Target and not Config.DrawTextInsteadOfTarget then
        for k, entity in pairs(SellItemsEntityTargets) do
            if entity and DoesEntityExist(entity) then
                if Config.Target == 'ox_target' then
                    exports.ox_target:removeLocalEntity(entity)
                else
                    exports[Config.Target]:RemoveTargetEntity(entity)
                end
            end
        end

        if Config.Target == 'ox_target' then
            for k, _ in pairs(SellItemsZoneTargets) do
                exports.ox_target:removeZone(k)
            end
        else
            for k, _ in pairs(SellItemsZoneTargets) do
                exports[Config.Target]:RemoveZone(k)
            end
        end
    end

    for k, _ in pairs(SellItemsProp) do
        if SellItemsProp[k] and DoesEntityExist(SellItemsProp[k]) then
            DeleteEntity(SellItemsProp[k])
        end
    end

    for k, _ in pairs(SellItemsPed) do
        if SellItemsPed[k] and DoesEntityExist(SellItemsPed[k]) then
            DeleteEntity(SellItemsPed[k])
        end
    end

    SellItemsProp = {}
    SellItemsPed = {}
    CreatedTarget = {}
    SellItemsZoneTargets = {}
    SellItemsEntityTargets = {}
    SellItemsMenuContexts = {}
end

local SellingItems = false
local SELL_ITEMS_TRADE_ANIMATION_DURATION_MS = 1500
local PendingRewards = {}
local SellItemsOXItems, SellItemsOXCache = nil, {}

local function ParseSellItemsVector(value)
    if type(value) == "vector3" then
        return value
    end

    local vectorParts = {}
    for part in string.gmatch(tostring(value or ""), "[^,]+") do
        vectorParts[#vectorParts + 1] = tonumber(part)
    end

    if not vectorParts[1] or not vectorParts[2] or not vectorParts[3] then
        return nil
    end

    return vector3(vectorParts[1], vectorParts[2], vectorParts[3])
end

local function FormatSellItemsId(value)
    return tostring(value or "sell_items"):gsub("[^%w_]", "_")
end

local function GetSellItemImage(filename)
    filename = tostring(filename or "")
    if filename == "" then return nil end

    if filename:match("^https?://") then
        return filename
    end

    if filename:match("^nui://") then
        local resourceName, resourcePath = filename:gsub("^nui://", ""):match("^([^/]+)/(.+)$")
        if resourceName and resourcePath then
            return ("https://cfx-nui-%s/%s"):format(resourceName, resourcePath)
        end
        return filename
    end

    local inventoryType = tostring(Config.InventoryType or "qb-inventory")
    local base = "https://cfx-nui-"..inventoryType.."/html/images/"

    if inventoryType == "ox_inventory" then
        base = "https://cfx-nui-ox_inventory/web/images/"
        if not filename:match("%.png$") then
            filename = filename..".png"
        end
    elseif inventoryType == "codem-inventory" then
        base = "https://cfx-nui-codem-inventory/html/itemimages/"
    elseif inventoryType == "ak47_qb_inventory" then
        base = "https://cfx-nui-"..inventoryType.."/web/build/images/"
    elseif inventoryType == "ak47_inventory" then
        base = "https://cfx-nui-"..inventoryType.."/web/build/images/"
    end

    return base .. filename
end

local function GetSellOxItemAndLabel(itemName)
    local key = tostring(itemName or "")
    local lowerKey = string.lower(key)
    if SellItemsOXCache[lowerKey] then
        return SellItemsOXCache[lowerKey].image, SellItemsOXCache[lowerKey].label
    end

    if not SellItemsOXItems then
        SellItemsOXItems = exports.ox_inventory:Items()
    end

    local data = SellItemsOXItems and (SellItemsOXItems[key] or SellItemsOXItems[lowerKey])
    if not data then
        local fallback = lowerKey ~= "" and lowerKey or key
        local image, label = fallback..".png", fallback
        SellItemsOXCache[lowerKey] = { image = image, label = label }
        return image, label
    end

    local image = data.client and data.client.image and tostring(data.client.image):gsub("^nui://ox_inventory/web/images/", "") or (lowerKey..".png")
    local label = data.label or key
    SellItemsOXCache[lowerKey] = { image = image, label = label }
    return image, label
end

local function GetSellItemLabelAndImage(itemName)
    local key = tostring(itemName or "")
    local lowerKey = string.lower(key)

    if Config.InventoryType == "ox_inventory" and GetResourceState("ox_inventory") == 'started' then
        return GetSellOxItemAndLabel(key)
    end

    if Framework == "QBCore" and FWork and FWork.Shared and FWork.Shared.Items then
        local sharedItem = FWork.Shared.Items[key] or FWork.Shared.Items[lowerKey]
        if sharedItem then
            return sharedItem.image or (lowerKey..".png"), sharedItem.label or key
        end
    end

    if Config.InventoryType == "qs-inventory" and GetResourceState("qs-inventory") == 'started' then
        local itemList = exports['qs-inventory']:GetItemList()
        local item = itemList and (itemList[key] or itemList[lowerKey])
        if item then
            return item.image or (lowerKey..".png"), item.label or key
        end
    end

    return (lowerKey ~= "" and lowerKey or key)..".png", key
end

local function PugCreateMenu(menuId, menuTitle, options, parentId)
    if Config.Menu == "lation_ui" then
        local lationOptions = {}
        for _, item in ipairs(options) do
            lationOptions[#lationOptions+1] = {
                title = item.title,
                description = item.description or "",
                icon = item.icon,
                iconColor = item.iconColor,
                disabled = item.disabled,
                readOnly = item.readOnly,
                progress = item.progress,
                image = item.image,
                metadata = item.metadata,
                event = item.event,
                args = item.args,
                keybind = item.keybind,
                menu = item.menu
            }
        end

        local data = {
            id = menuId,
            title = menuTitle,
            subtitle = parentId and "" or nil,
            options = lationOptions
        }

        if parentId then
            data.menu = parentId
        end

        exports.lation_ui:registerMenu(data)
        exports.lation_ui:showMenu(menuId)
    elseif Config.Menu == "ox_lib" then
        local oxOptions = {}
        for _, item in ipairs(options) do
            oxOptions[#oxOptions+1] = {
                title = item.title,
                description = item.description or "",
                icon = item.icon,
                event = item.event,
                image = item.image,
                iconColor = item.iconColor,
                disabled = item.disabled,
                progress = item.progress,
                colorScheme = item.colorScheme,
                arrow = item.arrow,
                args = item.args,
            }
        end

        local data = {
            id = menuId,
            title = menuTitle,
            options = oxOptions
        }

        if parentId then
            data.menu = parentId
        end

        lib.registerContext(data)
        lib.showContext(menuId)
    else
        local qbOptions = {}
        for _, item in ipairs(options) do
            qbOptions[#qbOptions+1] = {
                header = item.title,
                txt = item.description or "",
                icon = item.icon,
                image = item.image,
                iconColor = item.iconColor,
                disabled = item.disabled,
                progress = item.progress,
                params = {
                    event = item.event,
                    args = item.args
                }
            }
        end

        exports[Config.Menu]:openMenu(qbOptions)
    end
end

local function GetSellItemsTargetLabel(sellTargetData)
    if sellTargetData.targetText and sellTargetData.targetText ~= "" and sellTargetData.targetText ~= " " then
        return sellTargetData.targetText
    end

    return "Sell / Trade Items"
end

local function BuildSellItemDescription(sellTargetData, itemData, playerItemCount)
    local requiredQuantity = math.floor(tonumber(itemData.quantity) or 0)
    local description = {}

    if sellTargetData.sellAllItems then
        description[#description + 1] = ("Required: %d minimum"):format(requiredQuantity)
        description[#description + 1] = ("You have: %d"):format(playerItemCount)
        description[#description + 1] = "Sells all"
    else
        description[#description + 1] = ("Required: %d"):format(requiredQuantity)
        description[#description + 1] = ("You have: %d"):format(playerItemCount)
    end

    local minMoney = tonumber(itemData.rewardMoneyMin) or 0
    local maxMoney = tonumber(itemData.rewardMoneyMax) or 0
    if maxMoney > 0 and maxMoney >= minMoney then
        description[#description + 1] = ("Money: $%d - $%d"):format(minMoney, maxMoney)
    end

    if type(itemData.rewardItems) == "table" and #itemData.rewardItems > 0 then
        local rewardLabels = {}
        for i, reward in ipairs(itemData.rewardItems) do
            if i > 3 then break end
            local _, rewardLabel = GetSellItemLabelAndImage(reward.rewardItemName or reward.itemName)
            rewardLabels[#rewardLabels + 1] = rewardLabel
        end
        if #itemData.rewardItems > 3 then
            rewardLabels[#rewardLabels + 1] = "+"..tostring(#itemData.rewardItems - 3).." more"
        end
        description[#description + 1] = "Rewards: "..table.concat(rewardLabels, ", ")
    end

    if itemData.delayReward and tonumber(itemData.rewardDelayTime) and tonumber(itemData.rewardDelayTime) > 0 then
        description[#description + 1] = ("Delay: %ss"):format(math.floor(tonumber(itemData.rewardDelayTime)))
    end

    return table.concat(description, " | ")
end

local function StartSellItemsTrade(sellTargetData, itemData, propCoords, pedCoordsFinal, propName)
    if SellingItems then
        Notify(Config.LangT["AlreadySellingItem"], "error")
        return
    end

    SellingItems = true

    local requiredQuantity = math.floor(tonumber(itemData.quantity) or 0)
    local playerItemCount = GetPlayerItemCount(itemData.itemName)
    local sellQuantity = 0

    if sellTargetData.sellAllItems then
        if playerItemCount < requiredQuantity then
            Notify(Config.T("NotEnoughItemsToSell"), "error")
            SellingItems = false
            return
        end
        sellQuantity = playerItemCount
    else
        sellQuantity = requiredQuantity
        if playerItemCount < sellQuantity then
            Notify(Config.T("NotEnoughItemsToSell"), "error")
            SellingItems = false
            return
        end
    end

    if sellQuantity <= 0 then
        Notify(Config.T("InvalidQuantityToSell"), "error")
        SellingItems = false
        return
    end

    if pedCoordsFinal then
        SetEntityCoords(PlayerPedId(), pedCoordsFinal)
    end

    local playerHeading = tonumber(sellTargetData.playerHeading)
    if playerHeading then
        SetEntityHeading(PlayerPedId(), playerHeading)
    end

    local animationType = sellTargetData.animation
    local ObjectData
    local stage = {
        animation = animationType,
        propName = propName,
    }
    local ChosenAnimation

    if animationType and animationType ~= "" then
        ChosenAnimation = Config.Animations[tonumber(animationType)] or Config.RobberyAnimations[animationType]
        if ChosenAnimation then
            if propName and propName ~= "" then
                local PropModel = propName
                if type(PropModel) == "string" then
                    PropModel = GetHashKey(propName)
                end

                local sceneObject = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.5, PropModel, 0, 0, 0)
                if sceneObject ~= 0 then
                    ObjectData = {
                        Coords = GetEntityCoords(sceneObject),
                        Rotation = GetEntityRotation(sceneObject),
                        PropName = propName,
                        Heist = "sellitems",
                        Stage = {},
                        DataObject = sceneObject,
                        Heading = GetEntityHeading(sceneObject),
                    }
                end
            end

            if not ChosenAnimation.ReplaceProp then
                TriggerEvent("Pug:client:DoRobberiesAnimation", animationType, PlayerPedId(), false, ObjectData, true)
            end
        end
    end

    CreateThread(function()
        if ChosenAnimation and ChosenAnimation.AnimDict and ChosenAnimation.AnimAction then
            local startTime = GetGameTimer()
            while GetGameTimer() - startTime < SELL_ITEMS_TRADE_ANIMATION_DURATION_MS do
                if not IsEntityPlayingAnim(PlayerPedId(), ChosenAnimation.AnimDict, ChosenAnimation.AnimAction, 3) then
                    TriggerEvent("Pug:client:DoRobberiesAnimation", animationType, PlayerPedId(), false, ObjectData, true)
                end
                Wait(250)
            end
        end
    end)

    if sellTargetData.sendAlert and math.random(1, 100) <= 30 then
        SendSuspiciousActivityCallToPolice()
    end

    FreezeEntityPosition(PlayerPedId(), true)
    Wait(SELL_ITEMS_TRADE_ANIMATION_DURATION_MS)
    FreezeEntityPosition(PlayerPedId(), false)
    SellingItems = false

    if itemData.delayReward and itemData.rewardDelayTime and tonumber(itemData.rewardDelayTime) > 0 then
        EndMultipleNetworkAnimation(stage, ObjectData)
        TriggerServerEvent("Pug:server:SellItems:Trade", tostring(itemData.itemName))
    else
        TriggerServerEvent("Pug:server:SellItems:Trade", tostring(itemData.itemName))
        EndMultipleNetworkAnimation(stage, ObjectData)
    end
end

local function OpenSellItemsMenu(menuContext)
    if not menuContext or not menuContext.sellTargetData or type(menuContext.sellTargetData.sellItems) ~= "table" then
        return
    end

    local menuId = "sell_items_menu_"..FormatSellItemsId(menuContext.targetName)
    SellItemsMenuContexts[menuId] = menuContext

    local menu = {}
    for index, item in ipairs(menuContext.sellTargetData.sellItems) do
        local itemName = tostring(item.itemName or "")
        local filename, itemLabel = GetSellItemLabelAndImage(itemName)
        local image = GetSellItemImage(filename)
        local playerItemCount = GetPlayerItemCount(itemName)
        local requiredQuantity = math.floor(tonumber(item.quantity) or 0)

        menu[#menu + 1] = {
            title = "Trade "..itemLabel,
            icon = image,
            image = image,
            iconColor = "#1e90ff",
            description = BuildSellItemDescription(menuContext.sellTargetData, item, playerItemCount),
            event = "Pug:client:SellItems:SelectTrade",
            disabled = requiredQuantity <= 0 or playerItemCount < requiredQuantity,
            args = {
                menuId = menuId,
                itemIndex = index,
            },
        }
    end

    PugCreateMenu(menuId, GetSellItemsTargetLabel(menuContext.sellTargetData), menu)
end

RegisterNetEvent("Pug:client:SellItems:SelectTrade", function(data)
    local args = data
    if type(args) == "table" and args.args then
        args = args.args
    end

    if type(args) ~= "table" then return end

    local menuContext = SellItemsMenuContexts[args.menuId]
    if not menuContext or not menuContext.sellTargetData or type(menuContext.sellTargetData.sellItems) ~= "table" then
        return
    end

    local itemData = menuContext.sellTargetData.sellItems[tonumber(args.itemIndex)]
    if not itemData then return end

    StartSellItemsTrade(menuContext.sellTargetData, itemData, menuContext.propCoords, menuContext.pedCoordsFinal, menuContext.propName)
end)

local function AddSellItemsInteractionTarget(targetName, location, options, targetEntity)
    if GetResourceState("RevoInteract") == 'started' or not Config.Target or Config.DrawTextInsteadOfTarget then
        return
    end

    if targetEntity and DoesEntityExist(targetEntity) then
        if Config.Target == 'ox_target' then
            exports.ox_target:addLocalEntity(targetEntity, options)
        else
            exports[Config.Target]:AddTargetEntity(targetEntity, {
                options = options,
                distance = 1.5
            })
        end
        SellItemsEntityTargets[targetName] = targetEntity
        return
    end

    if Config.Target == 'ox_target' then
        exports.ox_target:addSphereZone({
            name = targetName,
            coords = location,
            radius = 0.5,
            debug = Config.Debug,
            options = options
        })
    else
        exports[Config.Target]:AddCircleZone(targetName, location, 0.5, {
            name = targetName,
            debugPoly = Config.Debug,
            useZ = true
        }, {
            options = options,
            distance = 1.5
        })
    end

    SellItemsZoneTargets[targetName] = true
end

function CreateSellItemsTarget()
    for _, sellTargetData in ipairs(AllSellItemsData.targets) do
        local propName = sellTargetData.propName
        local pedModel = sellTargetData.pedModel
        local propHeading = tonumber(sellTargetData.propHeading) or 0.0
        local propCoords = ParseSellItemsVector(sellTargetData.targetVector)
        local PedCoordsFinal = ParseSellItemsVector(sellTargetData.pedCoords)

        if propCoords then
            local targetName = ('sellItemsTarget_%0.2f_%0.2f_%0.2f'):format(propCoords.x, propCoords.y, propCoords.z)
            local targetEntity = nil
            if pedModel and pedModel ~= "" then
                propCoords = GroundSellTargetPedCoords(propCoords)
                RegisterSellItemsStreamEntity(targetName, "ped", pedModel, propCoords, propHeading)
            elseif propName and propName ~= "" then
                RegisterSellItemsStreamEntity(targetName, "prop", propName, propCoords, propHeading)
            end

            CreatedTarget[targetName]  = true

            local location = propCoords
            if propName == "tr_prop_tr_elecbox_01a" then
                location = vector3(location[1], location[2], location[3] + 1)
            end

            if type(sellTargetData.sellItems) == "table" and #sellTargetData.sellItems > 0 then
                local menuContext = {
                    sellTargetData = sellTargetData,
                    propCoords = propCoords,
                    pedCoordsFinal = PedCoordsFinal,
                    propName = propName,
                    targetName = targetName,
                }
                local targetLabel = GetSellItemsTargetLabel(sellTargetData)

                if GetResourceState("RevoInteract") == 'started' or not Config.Target or Config.DrawTextInsteadOfTarget then
                    CreateThread(function()
                        local helpShown = false

                        while CreatedTarget[targetName] do
                            local playerCoords = GetEntityCoords(PlayerPedId())
                            local distance = #(playerCoords - propCoords)

                            if distance <= 1.5 then
                                if not helpShown then
                                    local formattedTargetName = targetName:gsub("[%s%.]+", "")
                                    if GetResourceState("RevoInteract") == 'started' then
                                        exports.RevoInteract:OpenHelp({
                                            ID = formattedTargetName,
                                            Text = targetLabel,
                                            Key = "[E]"
                                        })
                                    else
                                        DrawTextOption("[E] "..targetLabel)
                                    end
                                    helpShown = true
                                end

                                if IsControlJustPressed(0, 38) then
                                    if SellingItems then
                                        Notify(Config.LangT["AlreadySellingItem"], "error")
                                    else
                                        OpenSellItemsMenu(menuContext)
                                    end
                                    Wait(500)
                                end

                                Wait(0)
                            else
                                if helpShown then
                                    local formattedTargetName = targetName:gsub("[%s%.]+", "")
                                    if GetResourceState("RevoInteract") == 'started' then
                                        exports.RevoInteract:CloseHelp(formattedTargetName)
                                    else
                                        HideTextOption()
                                    end
                                    helpShown = false
                                end
                                Wait(1000)
                            end
                        end
                    end)
                else
                    local options = {}
                    if Config.Target == "ox_target" then
                        options[#options + 1] = {
                            name = 'OpenSellItemsMenu_' .. targetName,
                            icon = 'fas fa-box',
                            label = targetLabel,
                            distance = 1.5,
                            onSelect = function()
                                OpenSellItemsMenu(menuContext)
                            end
                        }
                    else
                        options[#options + 1] = {
                            name = 'OpenSellItemsMenu_' .. targetName,
                            icon = 'fas fa-box',
                            label = targetLabel,
                            distance = 1.5,
                            action = function()
                                OpenSellItemsMenu(menuContext)
                            end
                        }
                    end

                    AddSellItemsInteractionTarget(targetName, location, options, targetEntity)
                end
            else
                if GetResourceState("RevoInteract") == 'started' or not Config.Target or Config.DrawTextInsteadOfTarget then
                    if GetResourceState("RevoInteract") == 'started' then
                        exports.RevoInteract:OpenHelp({
                            ID = "NOITEMSSOLD",
                            Text = "YOU DIDN'T ADD ANY ITEMS TO SELL",
                            Key = "[E]"
                        })
                    else
                        DrawTextOption("[E] YOU DIDN'T ADD ANY ITEMS TO SELL")
                    end
                    Wait(1000)
                    if GetResourceState("RevoInteract") == 'started' then
                        exports.RevoInteract:CloseHelp("NOITEMSSOLD")
                    else
                        HideTextOption()
                    end
                else
                    AddSellItemsInteractionTarget(targetName, location, {
                        {
                            name = 'NoSellItems_' .. targetName,
                            icon = 'fas fa-box',
                            label = "YOU DIDN'T ADD ANY ITEMS TO SELL",
                            distance = 1.5,
                        },
                    }, targetEntity)
                end
            end
        end
    end
end


-- function GiveItemReward(itemData, pendingReward)
--     local rewardMessages = {}

--     -- Reward Items
--     if itemData.rewardItems and #itemData.rewardItems > 0 then
--         for _, rewardItem in ipairs(itemData.rewardItems) do
--             local chance = tonumber(rewardItem.rewardItemChance) or 100
--             if math.random(1, 100) <= chance then
--                 local minAmount = tonumber(rewardItem.rewardItemMin) or 1
--                 local maxAmount = tonumber(rewardItem.rewardItemMax) and tonumber(rewardItem.rewardItemMax) > minAmount and tonumber(rewardItem.rewardItemMax) or minAmount
--                 local rewardItemQuantity = math.random(minAmount, maxAmount)   
--                 if pendingReward then 
--                     rewardItemQuantity = rewardItemQuantity * pendingReward.sellQuantity
--                 end
--                 HandleItems(true, rewardItem.rewardItemName, rewardItemQuantity)
--                 table.insert(rewardMessages, "received " .. rewardItemQuantity .. " " .. rewardItem.rewardItemName)
--             end
--         end
--     end

--     -- Reward Money
--     if itemData.rewardMoneyType and itemData.rewardMoneyMin and itemData.rewardMoneyMax then
--         if tonumber(itemData.rewardMoneyMax) > 0 then
--             if tonumber(itemData.rewardMoneyMin) <= tonumber(itemData.rewardMoneyMax) then
--                 local rewardMoneyAmount = math.random(tonumber(itemData.rewardMoneyMin), tonumber(itemData.rewardMoneyMax))
--                 if pendingReward then
--                     rewardMoneyAmount = rewardMoneyAmount * pendingReward.sellQuantity
--                 end
--                 HandleMoney(itemData.rewardMoneyType, rewardMoneyAmount)
--                 table.insert(rewardMessages, "received $" .. rewardMoneyAmount .. " in " .. itemData.rewardMoneyType)
--             else
--                 Notify(Config.LangT["MaxGreaterThanMinReward"], "error")
--             end
--         end
--     end

--     -- Notify player
--     if #rewardMessages > 0 then
--         local message = "You traded " .. itemData.quantity .. " " .. itemData.itemName .. " and " .. table.concat(rewardMessages, " and ") .. "!"
--         Notify(message)
--     else
--         local message = "You traded " .. itemData.quantity .. " " .. itemData.itemName .. "!"
--         Notify(message)
--     end
-- end

-- function WaitForReadyTrade()
--     CreateThread(function()
--         while true do
--             Wait(1000)
--             if #PendingRewards > 0 then
--                 local currentTime = GetGameTimer()
--                 for i = #PendingRewards, 1, -1 do
--                     local pendingReward = PendingRewards[i]
--                     if currentTime >= pendingReward.readyTime then
--                         -- Create a target to claim the reward
--                         local rewardTargetName = 'rewardTarget_' .. tostring(pendingReward.propCoords[1]) .. "_" .. tostring(math.random(100, 999))
--                         local itemData = pendingReward.itemData
--                         local propCoords = pendingReward.propCoords
--                         local propName = pendingReward.propName

--                         local rewardOptions
--                         if Config.Target == "ox_target" then
--                             rewardOptions = {
--                                 {
--                                     name = 'ClaimReward_' .. itemData.itemName,
--                                     icon = 'fas fa-gift',
--                                     label = 'Claim Reward for ' .. GetItemsInformation(tostring(itemData.itemName)),
--                                     distance = 1.5,
--                                     onSelect = function()
--                                         if Config.Target == 'ox_target' then
--                                             exports.ox_target:removeZone(rewardTargetName)
--                                         else
--                                             exports[Config.Target]:RemoveZone(rewardTargetName)
--                                         end
--                                         GiveItemReward(itemData, pendingReward)
--                                     end
--                                 }
--                             }
--                         else
--                             rewardOptions = {
--                                 {
--                                     name = 'ClaimReward_' .. itemData.itemName,
--                                     icon = 'fas fa-gift',
--                                     label = 'Claim Reward for ' .. GetItemsInformation(tostring(itemData.itemName)),
--                                     distance = 1.5,
--                                     action = function()
--                                         if Config.Target == 'ox_target' then
--                                             exports.ox_target:removeZone(rewardTargetName)
--                                         else
--                                             exports[Config.Target]:RemoveZone(rewardTargetName)
--                                         end
--                                         GiveItemReward(itemData, pendingReward)
--                                     end
--                                 }
--                             }
--                         end

--                         if Config.Target == 'ox_target' then
--                             exports.ox_target:addSphereZone({
--                                 name = rewardTargetName,
--                                 coords = propCoords,
--                                 radius = 0.5,
--                                 debug = Config.Debug,
--                                 options = rewardOptions
--                             })
--                         else
--                             exports[Config.Target]:AddCircleZone(rewardTargetName, propCoords, 0.5, {
--                                 name = rewardTargetName,
--                                 debugPoly = Config.Debug,
--                                 useZ = true
--                             }, {
--                                 options = rewardOptions,
--                                 distance = 1.5
--                             })
--                         end

--                         Notify(Config.LangT["TradeReadyForPickup"], "success")
--                         table.remove(PendingRewards, i)
--                         break
--                     end
--                 end
--             end
--         end
--     end)
-- end

RegisterNetEvent('Pug:client:UpdateSellItemsData', function(ItemsData)
    AllSellItemsData = json.decode(ItemsData)
    RemoveSellItemsTarget()
    if AllSellItemsData.targets then
        CreateSellItemsTarget()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        RemoveSellItemsTarget()
    end
end)
