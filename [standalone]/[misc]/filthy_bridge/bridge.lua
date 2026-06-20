
FLBridge = FLBridge or {}
FLBridge.framework = Config.GetFramework()
FLBridge.targetSystem = Config.GetTarget()
FLBridge.inventorySystem = Config.GetInventory()
FLBridge.bankingSystem = Config.GetBanking()
FLBridge.keysSystem = Config.GetKeys()
FLBridge.fuelSystem = Config.GetFuel()
FLBridge.dispatchSystem = Config.GetDispatch()
FLBridge.dispatch = {}

if Config.Debug then
    print("^2[FILTHY BRIDGE]^7 Framework: " .. (FLBridge.framework or "unknown"))
    print("^2[FILTHY BRIDGE]^7 Target: " .. (FLBridge.targetSystem or "unknown"))
    print("^2[FILTHY BRIDGE]^7 Inventory: " .. (FLBridge.inventorySystem or "unknown"))
    print("^2[FILTHY BRIDGE]^7 Banking: " .. (FLBridge.bankingSystem or "none"))
    print("^2[FILTHY BRIDGE]^7 Keys: " .. (FLBridge.keysSystem or "none"))
    print("^2[FILTHY BRIDGE]^7 Fuel: " .. (FLBridge.fuelSystem or "native"))
    print("^2[FILTHY BRIDGE]^7 Dispatch: " .. (FLBridge.dispatchSystem or "filthy_bridge"))
end

function FLBridge.getFramework()
    return FLBridge.framework
end

function FLBridge.getTargetSystem()
    return FLBridge.targetSystem
end

function FLBridge.getInventorySystem()
    return FLBridge.inventorySystem
end

function FLBridge.getDispatchSystem()
    return FLBridge.dispatchSystem
end

function FLBridge.getCore()
    if FLBridge.framework == 'QBCore' then
        return exports['qb-core']:GetCoreObject()
    elseif FLBridge.framework == 'Qbox' then
        return exports.qbx_core
    elseif FLBridge.framework == 'ESX' then
        return exports.es_extended:getSharedObject()
    end
    return nil
end

function FLBridge.getPlayer(source)
    if FLBridge.framework == 'QBCore' then
        local QBCore = exports['qb-core']:GetCoreObject()
        return QBCore.Functions.GetPlayer(source)
    elseif FLBridge.framework == 'Qbox' then
        return exports.qbx_core:GetPlayer(source)
    elseif FLBridge.framework == 'ESX' then
        local ESX = exports.es_extended:getSharedObject()
        return ESX.GetPlayerFromId(source)
    end
    return nil
end

function FLBridge.getIdentifier(source)
    local player = FLBridge.getPlayer(source)
    if not player then return nil end

    if FLBridge.framework == 'QBCore' or FLBridge.framework == 'Qbox' then
        return player.PlayerData.citizenid
    elseif FLBridge.framework == 'ESX' then
        return player.identifier
    end
    return nil
end

function FLBridge.getName(source)
    local player = FLBridge.getPlayer(source)
    if not player then return 'Unknown' end

    if FLBridge.framework == 'QBCore' or FLBridge.framework == 'Qbox' then
        if player.PlayerData.charinfo then
            return player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
        end
    elseif FLBridge.framework == 'ESX' then
        return player.getName()
    end
    return 'Unknown'
end

function FLBridge.getJobData(source)
    local player = FLBridge.getPlayer(source)
    if not player then return nil end

    if FLBridge.framework == 'QBCore' or FLBridge.framework == 'Qbox' then
        return player.PlayerData.job
    elseif FLBridge.framework == 'ESX' then
        return player.job
    end
    return nil
end

function FLBridge.addMoney(source, moneyType, amount)
    local player = FLBridge.getPlayer(source)
    if not player then return false end

    if FLBridge.framework == 'QBCore' or FLBridge.framework == 'Qbox' then
        if moneyType == 'money' then moneyType = 'cash' end
        player.Functions.AddMoney(moneyType, amount)
        return true
    elseif FLBridge.framework == 'ESX' then
        if moneyType == 'money' then moneyType = 'cash' end
        player.addMoney(moneyType, amount)
        return true
    end
    return false
end

function FLBridge.removeMoney(source, moneyType, amount)
    local player = FLBridge.getPlayer(source)
    if not player then return false end

    if FLBridge.framework == 'QBCore' or FLBridge.framework == 'Qbox' then
        if moneyType == 'money' then moneyType = 'cash' end
        local success = player.Functions.RemoveMoney(moneyType, amount)
        return success ~= false
    elseif FLBridge.framework == 'ESX' then
        if moneyType == 'money' then moneyType = 'cash' end
        player.removeMoney(moneyType, amount)
        return true
    end
    return false
end

function FLBridge.getPlayerAccountFunds(source, moneyType)
    local player = FLBridge.getPlayer(source)
    if not player then return 0 end

    if moneyType == 'cash' or moneyType == 'money' then moneyType = 'cash' end

    if FLBridge.framework == 'QBCore' or FLBridge.framework == 'Qbox' then
        return player.PlayerData.money[moneyType] or 0
    elseif FLBridge.framework == 'ESX' then
        local account = player.getAccount(moneyType)
        return account and account.money or 0
    end
    return 0
end

function FLBridge.setJob(source, job, grade)
    local player = FLBridge.getPlayer(source)
    if not player then return false end

    if FLBridge.framework == 'QBCore' or FLBridge.framework == 'Qbox' then
        player.Functions.SetJob(job, grade)
        return true
    elseif FLBridge.framework == 'ESX' then
        player.setJob(job, grade)
        return true
    end
    return false
end

function FLBridge.isPlayerBoss(source)
    if FLBridge.framework == 'QBCore' or FLBridge.framework == 'Qbox' then
        local player = FLBridge.getPlayer(source)
        if not player then return false end
        local job = player.PlayerData.job
        return job and (job.isboss or false)
    elseif FLBridge.framework == 'ESX' then
        local player = FLBridge.getPlayer(source)
        if not player then return false end
        return player.job.grade_name == 'boss'
    end
    return false
end

function FLBridge.hasJob(source, jobName)
    local job = FLBridge.getJobData(source)
    return job and job.name == jobName
end

function FLBridge.hasGroup(groups)
    if not flb or not flb.playerData or not flb.playerData.job then return false end
    local playerJob = flb.playerData.job.name
    if type(groups) == 'string' then
        return playerJob == groups
    elseif type(groups) == 'table' then
        for _, job in ipairs(groups) do
            if playerJob == job then return true end
        end
    end
    return false
end

FLBridge.client = FLBridge.client or {}

function FLBridge.client.Notify(source, message, type, duration, title)
    title = title or 'Notification'

    if source then
        TriggerClientEvent('filthy_bridge:notify', source, message, type, duration, title)
        return
    end

    if GetResourceState('wasabi_notify') == 'started' then
        if type == 'inform' or type == 'primary' then type = 'info' end
        exports.wasabi_notify:notify(title, message, duration or 3500, type or 'info', false)
        return
    end

    if GetResourceState('wasabi_uikit') == 'started' then
        exports.wasabi_uikit:Notification(title, message, type or 'info')
        return
    end

    if GetResourceState('ox_lib') == 'started' then
        if type == 'info' then type = 'inform' end
        lib.notify({
            title = title,
            description = message,
            duration = duration or 5000,
            type = type or 'inform'
        })
        return
    end

    if GetResourceState('okokNotify') == 'started' then
        exports['okokNotify']:Alert(title, message, duration or 5000, type or 'info')
        return
    end

    -- Fallback native
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName('[' .. title .. '] ' .. message)
    EndTextCommandThefeedPostTimed(duration or 5000)
end

function FLBridge.client.Progress(options)
    if not options then return false end
    if lib and lib.progressCircle then
        return lib.progressCircle({
            duration = options.duration or 3000,
            label = options.label or 'Loading...',
            position = options.position or 'bottom',
            useWhileDead = options.useWhileDead or false,
            canCancel = options.canCancel ~= false,
            disable = options.disable or { move = true, car = true, combat = true },
            anim = options.anim,
            dict = options.dict,
            clip = options.clip
        })
    end
    return false
end

function FLBridge.client.RegisterContext(menu)
    if lib and lib.registerContext then
        lib.registerContext(menu)
    end
end

function FLBridge.client.ShowContext(menuId)
    if lib and lib.showContext then
        lib.showContext(menuId)
    end
end

function FLBridge.client.RegisterAction(action)
    if lib and lib.registerAction then
        lib.registerAction(action)
    end
end
function FLBridge.client.Input(options)
    if not options then return nil end
    if lib and lib.inputDialog then
        local result = lib.inputDialog(options.title or 'Input', {
            { type = 'text', label = options.label or 'Enter value', password = options.password or false }
        })
        return result and result[1] or nil
    end
    return nil
end

FLBridge.target = FLBridge.target or {}

function FLBridge.target.addSphereZone(coords, radius, options)
    local target = Config.GetTarget()

    if target == 'ox_target' and exports.ox_target then
        exports.ox_target:addSphereZone({
            coords = coords,
            radius = radius,
            options = options
        })
    elseif target == 'qb-target' and exports['qb-target'] then
        exports['qb-target']:AddCircleZone(options[1].name or 'zone', coords, radius, {
            name = options[1].name or 'zone',
            debugPoly = false
        }, {
            options = options,
            distance = radius
        })
    end
end

function FLBridge.target.removeZone(id)
    local target = Config.GetTarget()

    if target == 'ox_target' and exports.ox_target then
        exports.ox_target:removeZone(id)
    elseif target == 'qb-target' and exports['qb-target'] then
        exports['qb-target']:RemoveZone(id)
    end
end

function FLBridge.openBossMenu()
    local framework = FLBridge.framework

    if framework == 'QBCore' then
        TriggerEvent('qb-bossmenu:client:OpenMenu')
    elseif framework == 'Qbox' and exports.qbx_management then
        exports.qbx_management:OpenBossMenu('job')
    elseif framework == 'ESX' then
        local ESX = exports.es_extended:getSharedObject()
        local job = ESX.GetPlayerData().job
        TriggerEvent('esx_society:openBossMenu', job.name, function() end)
    end
end

FLBridge.callbacks = FLBridge.callbacks or {}
function FLBridge.callbacks.registerServer(name, handler)
    if lib and lib.callback then
        lib.callback.register(name, handler)
    end
end
function FLBridge.callbacks.awaitServer(name, ...)
    if lib and lib.callback then
        return lib.callback.await(name, false, ...)
    end
    return nil
end

FLBridge.inventory = FLBridge.inventory or {}

function FLBridge.bankingAddSocietyMoney(societyName, amount)
    return FLBridge.banking and FLBridge.banking.AddSocietyMoney(societyName, amount) or false
end

function FLBridge.bankingGetSocietyBalance(societyName)
    return FLBridge.banking and FLBridge.banking.GetSocietyBalance(societyName) or 0
end

function FLBridge.bankingRemoveSocietyMoney(societyName, amount)
    return FLBridge.banking and FLBridge.banking.RemoveSocietyMoney(societyName, amount) or false
end

function FLBridge.keysGiveKeys(source, plate, vehicleNetId)
    return FLBridge.keys and FLBridge.keys.GiveKeys(source, plate, vehicleNetId)
end

function FLBridge.fuelGetVehicleFuel(vehicle)
    return FLBridge.fuel and FLBridge.fuel.GetVehicleFuel(vehicle) or GetVehicleFuelLevel(vehicle)
end

function FLBridge.fuelSetVehicleFuel(vehicle, amount)
    if FLBridge.fuel then
        FLBridge.fuel.SetVehicleFuel(vehicle, amount)
    else
        SetVehicleFuelLevel(vehicle, amount)
    end
end

FLBridge.Utils = FLBridge.Utils or {}
FLBridge.Helpers = FLBridge.Helpers or {}

function FLBridge.Utils.DebugPrint(msg)
    if Config.Debug then
        print('[FL-BRIDGE] ' .. tostring(msg))
    end
end

function FLBridge.Utils.Notify(source, message, type, duration, title)
    FLBridge.client.Notify(source, message, type, duration, title)
end

function FLBridge.Utils.GetPlayer(source)
    return FLBridge.getPlayer(source)
end

function FLBridge.Utils.GetPlayerName(source)
    return FLBridge.getName(source)
end

function FLBridge.Utils.GetPlayerIdentifier(source)
    return FLBridge.getIdentifier(source)
end

function FLBridge.Utils.HasJob(source, jobName)
    return FLBridge.hasJob(source, jobName)
end

function FLBridge.Utils.IsBoss(source)
    return FLBridge.isPlayerBoss(source)
end

function FLBridge.Helpers.AddMoney(source, amount)
    return FLBridge.addMoney(source, 'cash', amount)
end

function FLBridge.Helpers.RemoveMoney(source, amount)
    return FLBridge.removeMoney(source, 'cash', amount)
end

function FLBridge.Helpers.GetPlayerBalance(source)
    return FLBridge.getPlayerAccountFunds(source, 'cash')
end

function FLBridge.Helpers.AddItem(source, item, count, metadata)
    if FLBridge.inventory and FLBridge.inventory.AddItem then
        return FLBridge.inventory.AddItem(source, item, count, metadata)
    end
    return false
end

function FLBridge.Helpers.RemoveItem(source, item, count, slot)
    if FLBridge.inventory and FLBridge.inventory.RemoveItem then
        return FLBridge.inventory.RemoveItem(source, item, count, slot)
    end
    return false
end

function FLBridge.Helpers.GetItemCount(source, item)
    if FLBridge.inventory and FLBridge.inventory.GetItemCount then
        return FLBridge.inventory.GetItemCount(source, item)
    end
    return 0
end

exports("GetBridgeObject", function()
    return FLBridge
end)

exports("GetBridge", function()
    return FLBridge
end)

if Config.Debug then
    print("^2[FILTHY BRIDGE]^7 Bridge functions initialized!")
    print("^2[FILTHY BRIDGE]^7 Ready to use!")
end

if not IsDuplicityVersion() then
    RegisterNetEvent('filthy_bridge:notify', function(msg, type, duration, title)
        FLBridge.client.Notify(nil, msg, type, duration, title)
    end)
end