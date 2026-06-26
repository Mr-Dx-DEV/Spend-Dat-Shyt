Bridge = Bridge or {}

local function started(res)
    return GetResourceState(res) == 'started'
end

local function lower(v)
    return tostring(v or ''):lower()
end

Bridge.Framework = lower(Config.Framework or 'auto')
Bridge.Inventory = lower(Config.Inventory or 'auto')
Bridge.Target = lower(Config.Target or 'auto')

if Bridge.Framework == 'auto' then
    if started('qb-core') then Bridge.Framework = 'qb'
    elseif started('qbx_core') then Bridge.Framework = 'qbox'
    elseif started('es_extended') then Bridge.Framework = 'esx'
    else Bridge.Framework = 'standalone' end
end

if Bridge.Inventory == 'auto' then
    if started('ox_inventory') then Bridge.Inventory = 'ox_inventory'
    elseif started('ak47_qb_inventory') then Bridge.Inventory = 'ak47_qb_inventory'
    elseif started('qb-inventory') then Bridge.Inventory = 'qb-inventory'
    else Bridge.Inventory = 'framework' end
end

if Bridge.Target == 'auto' then
    if started('ox_target') then Bridge.Target = 'ox_target'
    elseif started('qb-target') then Bridge.Target = 'qb-target'
    else Bridge.Target = 'none' end
end

Bridge.QBCore = nil
Bridge.ESX = nil
Bridge.QBX = nil

CreateThread(function()
    if Bridge.Framework == 'qb' and started('qb-core') then
        Bridge.QBCore = exports['qb-core']:GetCoreObject()
    elseif Bridge.Framework == 'qbox' and started('qbx_core') then
        Bridge.QBX = exports.qbx_core
    elseif Bridge.Framework == 'esx' and started('es_extended') then
        Bridge.ESX = exports['es_extended']:getSharedObject()
    end
end)

local function getQB()
    if not Bridge.QBCore and started('qb-core') then Bridge.QBCore = exports['qb-core']:GetCoreObject() end
    return Bridge.QBCore
end

local function getESX()
    if not Bridge.ESX and started('es_extended') then Bridge.ESX = exports['es_extended']:getSharedObject() end
    return Bridge.ESX
end

function Bridge.Notify(srcOrMsg, msgOrType, typeMaybe)
    if IsDuplicityVersion() then
        local src, msg, typ = srcOrMsg, msgOrType, typeMaybe or 'primary'
        if Bridge.Framework == 'qb' or Bridge.Framework == 'qbox' then
            TriggerClientEvent('QBCore:Notify', src, msg, typ)
        elseif Bridge.Framework == 'esx' then
            TriggerClientEvent('esx:showNotification', src, msg)
        elseif started('ox_lib') then
            TriggerClientEvent('ox_lib:notify', src, { description = msg, type = typ })
        else
            TriggerClientEvent('chat:addMessage', src, { args = { 'Kodeinee Strikers', msg } })
        end
    else
        local msg, typ = srcOrMsg, msgOrType or 'primary'
        if Bridge.Framework == 'qb' or Bridge.Framework == 'qbox' then
            local qb = getQB()
            if qb and qb.Functions and qb.Functions.Notify then return qb.Functions.Notify(msg, typ) end
            TriggerEvent('QBCore:Notify', msg, typ)
        elseif Bridge.Framework == 'esx' then
            local esx = getESX()
            if esx and esx.ShowNotification then return esx.ShowNotification(msg) end
            TriggerEvent('esx:showNotification', msg)
        elseif lib and lib.notify then
            lib.notify({ description = msg, type = typ })
        else
            print(('[Kodeinee Strikers] %s'):format(msg))
        end
    end
end

if IsDuplicityVersion() then
    function Bridge.GetPlayer(src)
        if Bridge.Framework == 'qb' then
            local qb = getQB(); return qb and qb.Functions.GetPlayer(src)
        elseif Bridge.Framework == 'qbox' then
            if exports.qbx_core and exports.qbx_core.GetPlayer then return exports.qbx_core:GetPlayer(src) end
            local qb = getQB(); return qb and qb.Functions.GetPlayer(src)
        elseif Bridge.Framework == 'esx' then
            local esx = getESX(); return esx and esx.GetPlayerFromId(src)
        end
        return nil
    end

    function Bridge.GetIdentifier(player)
        if not player then return nil end
        if Bridge.Framework == 'esx' then return player.identifier end
        if player.PlayerData then return player.PlayerData.citizenid or player.PlayerData.license or player.PlayerData.source end
        return nil
    end

    function Bridge.GetSource(player)
        if not player then return nil end
        if Bridge.Framework == 'esx' then return player.source end
        return player.PlayerData and player.PlayerData.source or player.source
    end

    function Bridge.GetItemCount(src, item)
        if not item or item == '' then return 0 end
        if Bridge.Inventory == 'ox_inventory' and started('ox_inventory') then
            return exports.ox_inventory:Search(src, 'count', item) or 0
        end
        local player = Bridge.GetPlayer(src)
        if not player then return 0 end
        if Bridge.Framework == 'esx' then
            local inv = player.getInventoryItem and player.getInventoryItem(item)
            return inv and tonumber(inv.count or inv.amount or 0) or 0
        end
        local it = player.Functions and player.Functions.GetItemByName and player.Functions.GetItemByName(item)
        return it and tonumber(it.amount or it.count or 1) or 0
    end

    function Bridge.HasItem(src, item, amount)
        return Bridge.GetItemCount(src, item) >= (amount or 1)
    end

    function Bridge.AddItem(src, item, amount, metadata)
        amount = tonumber(amount or 1) or 1
        if Bridge.Inventory == 'ox_inventory' and started('ox_inventory') then
            return exports.ox_inventory:AddItem(src, item, amount, metadata) ~= false
        end
        local player = Bridge.GetPlayer(src)
        if not player then return false end
        if Bridge.Framework == 'esx' then
            player.addInventoryItem(item, amount)
            return true
        end
        if player.Functions and player.Functions.AddItem then
            local ok = player.Functions.AddItem(item, amount, false, metadata)
            TriggerClientEvent('inventory:client:ItemBox', src, { name = item, label = item }, 'add', amount)
            return ok ~= false
        end
        return false
    end

    function Bridge.AddMoney(src, account, amount)
        amount = tonumber(amount or 0) or 0
        if amount <= 0 then return false end
        account = tostring(account or 'cash'):lower()

        local player = Bridge.GetPlayer(src)
        if not player then return false end

        if Bridge.Framework == 'esx' then
            if account == 'cash' or account == 'money' then
                player.addMoney(amount)
            else
                player.addAccountMoney(account, amount)
            end
            return true
        end

        if player.Functions and player.Functions.AddMoney then
            if account == 'money' then account = 'cash' end
            return player.Functions.AddMoney(account, amount) ~= false
        end

        return false
    end

    function Bridge.AddPayout(src, amount)
        local payout = Config.Payout or {}
        local payoutType = tostring(payout.Type or 'item'):lower()

        if payoutType == 'cash' or payoutType == 'bank' then
            return Bridge.AddMoney(src, payoutType, amount)
        end

        return Bridge.AddItem(src, payout.Item or 'blackmoney', amount)
    end

    function Bridge.GetPayoutName()
        local payout = Config.Payout or {}
        local payoutType = tostring(payout.Type or 'item'):lower()
        if payoutType == 'cash' then return 'cash' end
        if payoutType == 'bank' then return 'bank' end
        return payout.Label or payout.Item or 'blackmoney'
    end

    function Bridge.RemoveMoney(src, account, amount)
        amount = tonumber(amount or 0) or 0
        if amount <= 0 then return false end
        account = tostring(account or 'cash'):lower()

        local player = Bridge.GetPlayer(src)
        if not player then return false end

        if Bridge.Framework == 'esx' then
            if account == 'cash' or account == 'money' then
                if player.getMoney and player.getMoney() < amount then return false end
                player.removeMoney(amount)
                return true
            end
            local acc = player.getAccount and player.getAccount(account)
            if acc and tonumber(acc.money or 0) < amount then return false end
            player.removeAccountMoney(account, amount)
            return true
        end

        if player.Functions and player.Functions.RemoveMoney then
            if account == 'money' then account = 'cash' end
            local pdata = player.PlayerData or {}
            local money = pdata.money or {}
            if money[account] and tonumber(money[account]) < amount then return false end
            return player.Functions.RemoveMoney(account, amount) ~= false
        end

        return false
    end

    function Bridge.RemovePayment(src, payment, amount)
        payment = payment or {}
        local payType = tostring(payment.Type or 'cash'):lower()
        if payType == 'cash' or payType == 'bank' then
            return Bridge.RemoveMoney(src, payType, amount)
        end
        return Bridge.RemoveItem(src, payment.Item or 'markedbills', amount)
    end

    function Bridge.GetPaymentName(payment)
        payment = payment or {}
        local payType = tostring(payment.Type or 'cash'):lower()
        if payType == 'cash' then return payment.Label or 'Cash' end
        if payType == 'bank' then return payment.Label or 'Bank' end
        return payment.Label or payment.Item or 'markedbills'
    end

    function Bridge.RemoveItem(src, item, amount)
        amount = tonumber(amount or 1) or 1
        if Bridge.Inventory == 'ox_inventory' and started('ox_inventory') then
            return exports.ox_inventory:RemoveItem(src, item, amount) ~= false
        end
        local player = Bridge.GetPlayer(src)
        if not player then return false end
        if Bridge.Framework == 'esx' then
            player.removeInventoryItem(item, amount)
            return true
        end
        if player.Functions and player.Functions.RemoveItem then
            local ok = player.Functions.RemoveItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, { name = item, label = item }, 'remove', amount)
            return ok ~= false
        end
        return false
    end


    local function keyDebug(msg)
        if Config.VehicleKeys and Config.VehicleKeys.Debug then
            print(('[kodeinee-strikers keys] %s'):format(msg))
        end
    end

    local function resolveKeySystem()
        local cfg = Config.VehicleKeys or {}
        local system = tostring(cfg.System or 'none')
        if system == 'none' or system == 'custom' then return system end
        if system ~= 'auto' then return system end

        if started('wasabi_carlock') then return 'wasabi_carlock' end
        if started('ak47_qb_vehiclekeys') then return 'ak47_qb_vehiclekeys' end
        if started('qs-vehiclekeys') then return 'qs-vehiclekeys' end
        if started('Renewed-Vehiclekeys') then return 'Renewed-Vehiclekeys' end
        if started('mk_vehiclekeys') then return 'mk_vehiclekeys' end
        if started('MrNewbVehicleKeys') then return 'MrNewbVehicleKeys' end
        if started('qb-vehiclekeys') then return 'qb' end
        return 'none'
    end

    function Bridge.GiveVehicleKeys(src, plate, netId)
        local cfg = Config.VehicleKeys or {}
        plate = tostring(plate or ''):gsub('^%s*(.-)%s*$', '%1')
        if plate == '' then return false end

        local system = resolveKeySystem()
        if system == 'none' then
            keyDebug('No vehicle key system found. Skipping key give for plate '..plate)
            return false
        end

        if system == 'custom' then
            if type(cfg.CustomServerGive) == 'function' then
                local ok, result = pcall(cfg.CustomServerGive, src, plate, netId)
                if ok and result ~= false then return true end
                if not ok then keyDebug('CustomServerGive error: '..tostring(result)) end
            end
            TriggerClientEvent('kodeinee-strikers:client:giveVehicleKeys', src, plate, netId, 'custom')
            return true
        end

        local ok, err = pcall(function()
            if system == 'qb' or system == 'qbox' then
                TriggerClientEvent('vehiclekeys:client:SetOwner', src, plate)
                if cfg.FallbackQBEvents ~= false then
                    TriggerClientEvent('qb-vehiclekeys:client:SetOwner', src, plate)
                    TriggerClientEvent('qb-vehiclekeys:client:AddKeys', src, plate)
                    TriggerClientEvent('qb-vehiclekeys:client:GiveKeys', src, plate)
                end
            elseif system == 'wasabi_carlock' then
                exports['wasabi_carlock']:GiveKey(src, plate)
            elseif system == 'ak47_qb_vehiclekeys' then
                exports['ak47_qb_vehiclekeys']:GiveKey(src, plate, false)
            elseif system == 'qs-vehiclekeys' then
                exports['qs-vehiclekeys']:GiveKeys(src, plate, true)
            elseif system == 'Renewed-Vehiclekeys' then
                exports['Renewed-Vehiclekeys']:addKey(src, plate)
            elseif system == 'mk_vehiclekeys' then
                TriggerClientEvent('kodeinee-strikers:client:giveVehicleKeys', src, plate, netId, system)
            elseif system == 'MrNewbVehicleKeys' then
                TriggerClientEvent('kodeinee-strikers:client:giveVehicleKeys', src, plate, netId, system)
            else
                TriggerClientEvent('kodeinee-strikers:client:giveVehicleKeys', src, plate, netId, system)
            end
        end)

        if not ok then
            keyDebug(('Server key give failed for %s (%s): %s'):format(plate, system, tostring(err)))
            TriggerClientEvent('kodeinee-strikers:client:giveVehicleKeys', src, plate, netId, system)
            return false
        end

        return true
    end

    RegisterNetEvent('kodeinee-strikers:server:giveVehicleKeys', function(plate, netId)
        Bridge.GiveVehicleKeys(source, plate, netId)
    end)

    function Bridge.RegisterCallback(name, cb)
        lib.callback.register(name, function(source, ...)
            local p = promise.new()
            cb(source, function(...)
                p:resolve({ ... })
            end, ...)
            local result = Citizen.Await(p)
            return table.unpack(result)
        end)
    end

    function Bridge.CreateUsableItem(item, cb)
        if Bridge.Framework == 'qb' then
            local qb = getQB(); if qb then qb.Functions.CreateUseableItem(item, cb) end
        elseif Bridge.Framework == 'qbox' and exports.qbx_core and exports.qbx_core.CreateUseableItem then
            exports.qbx_core:CreateUseableItem(item, cb)
        elseif Bridge.Framework == 'esx' then
            local esx = getESX(); if esx then esx.RegisterUsableItem(item, function(src) cb(src, nil) end) end
        else
            RegisterCommand('usestrikerpad', function(src) cb(src, nil) end, false)
        end
    end
else

    local function keyDebug(msg)
        if Config.VehicleKeys and Config.VehicleKeys.Debug then
            print(('[kodeinee-strikers keys] %s'):format(msg))
        end
    end

    local function resolveKeySystem()
        local cfg = Config.VehicleKeys or {}
        local system = tostring(cfg.System or 'none')
        if system == 'none' or system == 'custom' then return system end
        if system ~= 'auto' then return system end

        if started('wasabi_carlock') then return 'wasabi_carlock' end
        if started('ak47_qb_vehiclekeys') then return 'ak47_qb_vehiclekeys' end
        if started('qs-vehiclekeys') then return 'qs-vehiclekeys' end
        if started('Renewed-Vehiclekeys') then return 'Renewed-Vehiclekeys' end
        if started('mk_vehiclekeys') then return 'mk_vehiclekeys' end
        if started('MrNewbVehicleKeys') then return 'MrNewbVehicleKeys' end
        if started('qb-vehiclekeys') then return 'qb' end
        return 'none'
    end

    function Bridge.GiveVehicleKeys(plate, vehicle, forcedSystem)
        local cfg = Config.VehicleKeys or {}
        plate = tostring(plate or ''):gsub('^%s*(.-)%s*$', '%1')
        if plate == '' then return false end

        local system = forcedSystem or resolveKeySystem()
        if system == 'none' then return false end

        if system == 'custom' then
            if type(cfg.CustomClientGive) == 'function' then
                local ok, result = pcall(cfg.CustomClientGive, plate, vehicle)
                if ok and result ~= false then return true end
                if not ok then keyDebug('CustomClientGive error: '..tostring(result)) end
            end
            return false
        end

        local ok, err = pcall(function()
            if system == 'qb' or system == 'qbox' then
                TriggerEvent('vehiclekeys:client:SetOwner', plate)
                if cfg.FallbackQBEvents ~= false then
                    TriggerEvent('qb-vehiclekeys:client:SetOwner', plate)
                    TriggerEvent('qb-vehiclekeys:client:AddKeys', plate)
                    TriggerEvent('qb-vehiclekeys:client:GiveKeys', plate)
                end
            elseif system == 'wasabi_carlock' then
                exports['wasabi_carlock']:GiveKey(plate)
            elseif system == 'ak47_qb_vehiclekeys' then
                exports['ak47_qb_vehiclekeys']:GiveKey(plate, false)
            elseif system == 'qs-vehiclekeys' then
                exports['qs-vehiclekeys']:GiveKeys(plate, true)
            elseif system == 'Renewed-Vehiclekeys' then
                exports['Renewed-Vehiclekeys']:addKey(plate)
            elseif system == 'mk_vehiclekeys' then
                TriggerEvent('mk_vehiclekeys:client:AddKeys', plate)
                TriggerEvent('mk_vehiclekeys:client:GiveKeys', plate)
            elseif system == 'MrNewbVehicleKeys' then
                if vehicle and vehicle ~= 0 then
                    exports['MrNewbVehicleKeys']:GiveKeys(vehicle)
                else
                    TriggerEvent('MrNewbVehicleKeys:client:GiveKeys', plate)
                end
            end
        end)

        if not ok then
            keyDebug(('Client key give failed for %s (%s): %s'):format(plate, system, tostring(err)))
            return false
        end
        return true
    end

    RegisterNetEvent('kodeinee-strikers:client:giveVehicleKeys', function(plate, netId, forcedSystem)
        local vehicle = 0
        if netId and netId ~= 0 then
            vehicle = NetworkGetEntityFromNetworkId(netId)
        end
        Bridge.GiveVehicleKeys(plate, vehicle, forcedSystem)
    end)

    function Bridge.TriggerCallback(name, cb, ...)
        local args = { ... }
        CreateThread(function()
            local result = { lib.callback.await(name, false, table.unpack(args)) }
            cb(table.unpack(result))
        end)
    end

    function Bridge.AddTargetEntity(entity, options, distance)
        if Bridge.Target == 'ox_target' and started('ox_target') then
            local oxOptions = {}
            for _, opt in ipairs(options or {}) do
                oxOptions[#oxOptions + 1] = {
                    name = opt.name or opt.label,
                    icon = opt.icon,
                    label = opt.label,
                    distance = distance or opt.distance,
                    onSelect = opt.action or opt.onSelect
                }
            end
            exports.ox_target:addLocalEntity(entity, oxOptions)
        elseif Bridge.Target == 'qb-target' and started('qb-target') then
            exports['qb-target']:AddTargetEntity(entity, { options = options, distance = distance or 2.0 })
        end
    end

    function Bridge.RemoveTargetEntity(entity)
        if Bridge.Target == 'ox_target' and started('ox_target') then
            exports.ox_target:removeLocalEntity(entity)
        elseif Bridge.Target == 'qb-target' and started('qb-target') then
            exports['qb-target']:RemoveTargetEntity(entity)
        end
    end
end
