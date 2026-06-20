-- MIT License
-- fs-doj ESX Framework Adapter

local ESX = nil

-- Initialize ESX
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        if not ESX then
            ESX = exports['es_extended']:getSharedObject()
        end
        Wait(100)
    end
end)

FrameworkAdapter = {}

-- Get player object
function FrameworkAdapter.GetPlayer(source)
    if not ESX then return nil end
    return ESX.GetPlayerFromId(source)
end

-- Get player identifier
function FrameworkAdapter.GetIdentifier(source)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return nil end
    return xPlayer.identifier
end

-- Get player name
function FrameworkAdapter.GetPlayerName(source)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return nil end
    return xPlayer.getName()
end

-- Get player job
function FrameworkAdapter.GetJob(source)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return nil, nil end
    return xPlayer.job.name, xPlayer.job.grade
end

-- Set player job
function FrameworkAdapter.SetJob(source, job, grade)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return false end
    xPlayer.setJob(job, grade)
    return true
end

-- Get player money
function FrameworkAdapter.GetMoney(source, account)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return 0 end
    account = account or 'money'
    return xPlayer.getAccount(account).money
end

-- Add money
function FrameworkAdapter.AddMoney(source, amount, account, reason)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return false end
    account = account or 'money'

    -- ESX uses 'money' not 'cash'
    if account == 'cash' then account = 'money' end

    xPlayer.addAccountMoney(account, amount, reason)
    return true
end

-- Remove money
function FrameworkAdapter.RemoveMoney(source, amount, account, reason)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return false end
    account = account or 'money'

    -- ESX uses 'money' not 'cash'
    if account == 'cash' then account = 'money' end

    local accountData = xPlayer.getAccount(account)
    if not accountData or not accountData.money or accountData.money < amount then return false end
    xPlayer.removeAccountMoney(account, amount, reason)
    return true
end

-- Get player inventory
function FrameworkAdapter.GetInventory(source)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return {} end
    return xPlayer.inventory or {}
end

-- Add item
function FrameworkAdapter.AddItem(source, item, count, meta)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return false end
    xPlayer.addInventoryItem(item, count, meta)
    return true
end

-- Remove item
function FrameworkAdapter.RemoveItem(source, item, count)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return false end
    xPlayer.removeInventoryItem(item, count)
    return true
end

-- Get item count
function FrameworkAdapter.GetItemCount(source, item)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return 0 end
    local item = xPlayer.getInventoryItem(item)
    return item and item.count or 0
end

-- Check if player has item
function FrameworkAdapter.HasItem(source, item, count)
    count = count or 1
    return FrameworkAdapter.GetItemCount(source, item) >= count
end

-- Notify player
function FrameworkAdapter.Notify(source, message, type, duration)
    local xPlayer = FrameworkAdapter.GetPlayer(source)
    if not xPlayer then return end
    xPlayer.showNotification(message, type, duration)
end

-- Get DOJ account balance (custom fs-doj finance system)
function FrameworkAdapter.GetSocietyAccount(accountName)
    local result = MySQL.query.await('SELECT balance FROM doj_account WHERE account_name = ?', {'doj_main'})
    local balance = result and result[1] and result[1].balance or 0
    return tonumber(balance) or 0
end

-- Add money to DOJ account
function FrameworkAdapter.AddSocietyMoney(accountName, amount)
    amount = tonumber(amount) or 0
    if amount <= 0 then return false end
    MySQL.update.await('UPDATE doj_account SET balance = balance + ? WHERE account_name = ?', {amount, 'doj_main'})
    return true
end

-- Remove money from DOJ account
function FrameworkAdapter.RemoveSocietyMoney(accountName, amount)
    amount = tonumber(amount) or 0
    if amount <= 0 then return false end
    local currentAmount = FrameworkAdapter.GetSocietyAccount(accountName)
    if currentAmount < amount then return false end
    MySQL.update.await('UPDATE doj_account SET balance = balance - ? WHERE account_name = ?', {amount, 'doj_main'})
    return true
end

-- Get all players with job
function FrameworkAdapter.GetPlayersWithJob(jobName)
    if not ESX then return {} end
    local players = {}
    local xPlayers = ESX.GetExtendedPlayers('job', jobName)
    for _, xPlayer in pairs(xPlayers) do
        table.insert(players, xPlayer.source)
    end
    return players
end

-- Get player data by identifier (offline)
function FrameworkAdapter.GetOfflinePlayerData(identifier)
    local result = MySQL.query.await('SELECT * FROM users WHERE identifier = ?', {identifier})
    return result and result[1] or nil
end

-- Get all vehicles owned by a player
function FrameworkAdapter.GetPlayerVehicles(identifier)
    if not identifier then return {} end
    local vehicles = MySQL.query.await('SELECT * FROM owned_vehicles WHERE owner = ?', {identifier})
    return vehicles or {}
end

-- Get vehicle by plate
function FrameworkAdapter.GetVehicleByPlate(plate)
    if not plate then return nil end
    local vehicle = MySQL.single.await('SELECT * FROM owned_vehicles WHERE plate = ?', {plate})
    return vehicle
end

-- Search vehicles by plate (partial match)
function FrameworkAdapter.SearchVehiclesByPlate(plateSearch)
    if not plateSearch or plateSearch == '' then return {} end
    local vehicles = MySQL.query.await('SELECT * FROM owned_vehicles WHERE plate LIKE ? LIMIT 100', {'%' .. plateSearch .. '%'})
    return vehicles or {}
end

-- Search vehicles by owner name (partial match)
function FrameworkAdapter.SearchVehiclesByOwner(ownerSearch)
    if not ownerSearch or ownerSearch == '' then return {} end

    -- First, find users matching the owner name
    local users = MySQL.query.await([[
        SELECT identifier
        FROM users
        WHERE LOWER(CONCAT(firstname, ' ', lastname)) LIKE LOWER(?)
        OR LOWER(firstname) LIKE LOWER(?)
        OR LOWER(lastname) LIKE LOWER(?)
        LIMIT 50
    ]], {'%' .. ownerSearch .. '%', '%' .. ownerSearch .. '%', '%' .. ownerSearch .. '%'})

    if not users or #users == 0 then return {} end

    -- Get all vehicles owned by these users
    local vehicles = {}
    for _, user in ipairs(users) do
        local userVehicles = MySQL.query.await('SELECT * FROM owned_vehicles WHERE owner = ?', {user.identifier})
        if userVehicles then
            for _, vehicle in ipairs(userVehicles) do
                table.insert(vehicles, vehicle)
            end
        end
    end

    return vehicles
end

-- Get vehicle owner name by identifier
function FrameworkAdapter.GetVehicleOwnerName(identifier)
    if not identifier then return 'Unknown' end
    local result = MySQL.single.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {identifier})
    if result then
        return (result.firstname or '') .. ' ' .. (result.lastname or '')
    end
    return 'Unknown'
end

-- Parse ESX vehicle data to standardized format
function FrameworkAdapter.ParseVehicleData(vehicle)
    if not vehicle then return nil end

    local vehicleData = {}
    if vehicle.vehicle then
        local success, decoded = pcall(json.decode, vehicle.vehicle)
        if success and decoded then
            vehicleData = decoded
        end
    end

    return {
        plate = vehicle.plate,
        model = vehicle.name or vehicleData.model or 'Unknown',
        owner_identifier = vehicle.owner,
        owner_name = FrameworkAdapter.GetVehicleOwnerName(vehicle.owner),
        stored = vehicle.stored == 1,
        garage = vehicle.garage or vehicle.garage_id or 'Unknown',
        fuel = vehicle.fuel or 100,
        engine = vehicle.engine or 1000,
        body = vehicle.body or 1000,
        mileage = vehicle.mileage or vehicle.totalkm or 0,
        vehicle_type = vehicle.type or vehicle.garage_type or 'car',
        in_garage = vehicle.in_garage == 1,
        impounded = vehicle.impound == 1 or false,
        job_vehicle = vehicle.job_vehicle == 1 or false
    }
end

return FrameworkAdapter
