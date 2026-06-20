if CodeStudio.ServerType == "QB" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif CodeStudio.ServerType == "ESX" then
    ESX = exports["es_extended"]:getSharedObject()
end

-- ─── Item usage triggers ──────────────────────────────────────────────────────

if CodeStudio.Main.UseWithItem.Enable then
    if CodeStudio.ServerType == "ESX" then
        ESX.RegisterUsableItem(CodeStudio.Main.UseWithItem.Item, function(source)
            TriggerClientEvent("cs:carplay:openUI", source)
        end)
    elseif CodeStudio.ServerType == "QB" then
        QBCore.Functions.CreateUseableItem(CodeStudio.Main.UseWithItem.Item, function(source)
            TriggerClientEvent("cs:carplay:openUI", source)
        end)
    end
end

-- ─── Command trigger ──────────────────────────────────────────────────────────

if CodeStudio.Main.UseWithCommand.Enable then
    lib.addCommand(CodeStudio.Main.UseWithCommand.Command, {
        help = "Open Car Play",
    }, function(source, _)
        TriggerClientEvent("cs:carplay:openUI", source)
    end)
end

-- ─── Player data ──────────────────────────────────────────────────────────────

function GetPlayerData(source)
    if CodeStudio.ServerType == "QB" then
        local player  = QBCore.Functions.GetPlayer(source)
        return {
            ident   = player.PlayerData.citizenid,
            name    = player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname,
            discord = GetIdentifier(source, "discord"),
        }
    elseif CodeStudio.ServerType == "ESX" then
        local player = ESX.GetPlayerFromId(source)
        return {
            ident   = player.identifier,
            name    = player.getName(),
            discord = GetIdentifier(source, "discord"),
        }
    else
        return {
            ident   = GetIdentifier(source, "license"),
            name    = GetPlayerName(source),
            discord = GetIdentifier(source, "discord"),
        }
    end
end

-- ─── Player job ───────────────────────────────────────────────────────────────

function GetPlayer_Job(source)
    if CodeStudio.ServerType == "QB" then
        local player = QBCore.Functions.GetPlayer(source)
        return player.PlayerData.job.name
    elseif CodeStudio.ServerType == "ESX" then
        local player = ESX.GetPlayerFromId(source)
        return player.job.name
    else
        return false
    end
end

-- ─── Radio installer item trigger ─────────────────────────────────────────────

if CodeStudio.Main.RadioInstall.Enable and CodeStudio.Main.RadioInstall.Options.RadioItem then
    local installerItem = CodeStudio.Main.RadioInstall.Options.RadioInstallerItem
    if CodeStudio.ServerType == "ESX" then
        ESX.RegisterUsableItem(installerItem, function(source)
            TriggerClientEvent("cs:carplay:installRadio", source)
        end)
    elseif CodeStudio.ServerType == "QB" then
        QBCore.Functions.CreateUseableItem(installerItem, function(source)
            TriggerClientEvent("cs:carplay:installRadio", source)
        end)
    end
end

-- ─── Owned vehicle check ──────────────────────────────────────────────────────

function checkOwnedVehicle(plate)
    local vehicleTable = CodeStudio.ServerType == "QB" and "player_vehicles" or "owned_vehicles"
    local result = MySQL.query.await(
        ("SELECT * FROM %s WHERE plate = ? LIMIT 1"):format(vehicleTable),
        { plate }
    )
    return result and #result > 0
end

-- ─── Radio item check ─────────────────────────────────────────────────────────

function checkRadioItem(source)
    local itemName = CodeStudio.Main.RadioInstall.Options.RadioItem

    if GetResourceState("ox_inventory") == "started" then
        local amount = exports.ox_inventory:Search(source, "count", itemName)
        return amount and tonumber(amount) >= 1
    elseif GetResourceState("qs-inventory") == "started" then
        local amount = exports["qs-inventory"]:GetItemTotalAmount(source, itemName)
        return amount and tonumber(amount) >= 1
    elseif CodeStudio.ServerType == "QB" then
        return exports["qb-inventory"]:HasItem(source, itemName, 1)
    elseif CodeStudio.ServerType == "ESX" then
        local player = ESX.GetPlayerFromId(source)
        return player and player.getInventoryItem(itemName).count >= 1
    end

    return false
end

-- ─── Add / remove radio item ──────────────────────────────────────────────────

function addItem(source)
    local itemName = CodeStudio.Main.RadioInstall.Options.RadioItem

    if GetResourceState("ox_inventory") == "started" then
        if exports.ox_inventory:CanCarryItem(source, itemName, 1) then
            exports.ox_inventory:AddItem(source, itemName, 1)
        end
    elseif GetResourceState("qs-inventory") == "started" then
        exports["qs-inventory"]:AddItem(source, itemName, 1)
    elseif CodeStudio.ServerType == "QB" then
        local player = QBCore.Functions.GetPlayer(source)
        if player then player.Functions.AddItem(itemName, 1) end
    elseif CodeStudio.ServerType == "ESX" then
        local player = ESX.GetPlayerFromId(source)
        if player then player.addInventoryItem(itemName, 1) end
    end
end

function removeItem(source)
    local itemName = CodeStudio.Main.RadioInstall.Options.RadioItem

    if GetResourceState("ox_inventory") == "started" then
        exports.ox_inventory:RemoveItem(source, itemName, 1)
    elseif GetResourceState("qs-inventory") == "started" then
        exports["qs-inventory"]:RemoveItem(source, itemName, 1)
    elseif CodeStudio.ServerType == "QB" then
        local player = QBCore.Functions.GetPlayer(source)
        if player then player.Functions.RemoveItem(itemName, 1) end
    elseif CodeStudio.ServerType == "ESX" then
        local player = ESX.GetPlayerFromId(source)
        if player then player.removeInventoryItem(itemName, 1) end
    end
end

function RadioInstallRemove(source, install)
    if install then
        removeItem(source)
    else
        addItem(source)
    end
end

-- ─── Discord log ──────────────────────────────────────────────────────────────

function SendDiscordLog(source, musicURL)
    local player = GetPlayerData(source)
    local embed  = {
        {
            title       = "Started Playing",
            color       = 16776960,
            footer      = { text = os.date("%c") },
            description = "Player: "          .. player.name
                       .. "\nPlayer ID: "     .. source
                       .. "\nPlayer Identifier: " .. player.ident
                       .. "\nPlayer Discord: " .. replaceDiscordID(player.discord)
                       .. "\nMusic Played: "  .. musicURL,
        }
    }
    PerformHttpRequest(
        CodeStudio.DiscordLog.Play_Webhook,
        function() end,
        "POST",
        json.encode({ username = "Music Player", embeds = embed }),
        { ["Content-Type"] = "application/json" }
    )
end
