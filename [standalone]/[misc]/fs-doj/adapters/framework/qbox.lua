-- MIT License
-- fs-doj QBox Framework Adapter

local QBX = nil

-- Initialize QBox
CreateThread(function()
    while QBX == nil do
        QBX = exports.qbx_core
        Wait(100)
    end
end)

FrameworkAdapter = {}

-- Get player object
function FrameworkAdapter.GetPlayer(source)
    if not QBX then return nil end
    return QBX:GetPlayer(source)
end

-- Get player identifier
function FrameworkAdapter.GetIdentifier(source)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return nil end
    return Player.PlayerData.citizenid
end

-- Get player name
function FrameworkAdapter.GetPlayerName(source)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return nil end
    return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
end

-- Get player job
function FrameworkAdapter.GetJob(source)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return nil, nil end
    return Player.PlayerData.job.name, Player.PlayerData.job.grade.level
end

-- Set player job
function FrameworkAdapter.SetJob(source, job, grade)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return false end
    Player.Functions.SetJob(job, grade)
    return true
end

-- Get player money
function FrameworkAdapter.GetMoney(source, account)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return 0 end
    account = account or 'cash'
    return Player.PlayerData.money[account] or 0
end

-- Add money
function FrameworkAdapter.AddMoney(source, amount, account, reason)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return false end
    account = account or 'cash'
    Player.Functions.AddMoney(account, amount, reason)
    return true
end

-- Remove money
function FrameworkAdapter.RemoveMoney(source, amount, account, reason)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return false end
    if not Player.PlayerData then return false end
    if not Player.PlayerData.money then return false end
    account = account or 'cash'
    if not Player.PlayerData.money[account] or Player.PlayerData.money[account] < amount then return false end
    Player.Functions.RemoveMoney(account, amount, reason)
    return true
end

-- Get player inventory
function FrameworkAdapter.GetInventory(source)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return {} end
    return Player.PlayerData.items or {}
end

-- Add item
function FrameworkAdapter.AddItem(source, item, count, meta)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return false end
    return Player.Functions.AddItem(item, count, nil, meta)
end

-- Remove item
function FrameworkAdapter.RemoveItem(source, item, count)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return false end
    return Player.Functions.RemoveItem(item, count)
end

-- Get item count
function FrameworkAdapter.GetItemCount(source, item)
    local Player = FrameworkAdapter.GetPlayer(source)
    if not Player then return 0 end
    local itemData = Player.Functions.GetItemByName(item)
    return itemData and itemData.amount or 0
end

-- Check if player has item
function FrameworkAdapter.HasItem(source, item, count)
    count = count or 1
    return FrameworkAdapter.GetItemCount(source, item) >= count
end

-- Notify player
function FrameworkAdapter.Notify(source, message, type, duration)
    if not QBX then return end
    TriggerClientEvent('QBCore:Notify', source, message, type, duration)
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
    if not QBX then return {} end
    local players = {}
    local allPlayers = QBX:GetQBPlayers()
    for _, player in pairs(allPlayers) do
        if player.PlayerData.job.name == jobName then
            table.insert(players, player.PlayerData.source)
        end
    end
    return players
end

-- Get player data by identifier (offline)
function FrameworkAdapter.GetOfflinePlayerData(identifier)
    local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', {identifier})
    return result and result[1] or nil
end

-- Get all vehicles owned by a player
function FrameworkAdapter.GetPlayerVehicles(identifier)
    if not identifier then return {} end
    -- Try both citizenid and license for compatibility
    local vehicles = MySQL.query.await('SELECT * FROM player_vehicles WHERE citizenid = ? OR license = ?', {identifier, identifier})
    return vehicles or {}
end

-- Get vehicle by plate
function FrameworkAdapter.GetVehicleByPlate(plate)
    if not plate then return nil end
    local vehicle = MySQL.single.await('SELECT * FROM player_vehicles WHERE plate = ?', {plate})
    return vehicle
end

-- Search vehicles by plate (partial match)
function FrameworkAdapter.SearchVehiclesByPlate(plateSearch)
    if not plateSearch or plateSearch == '' then return {} end
    local vehicles = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate LIKE ? LIMIT 100', {'%' .. plateSearch .. '%'})
    return vehicles or {}
end

-- Search vehicles by owner name (partial match)
function FrameworkAdapter.SearchVehiclesByOwner(ownerSearch)
    if not ownerSearch or ownerSearch == '' then return {} end

    -- First, find players matching the owner name
    local players = MySQL.query.await([[
        SELECT citizenid
        FROM players
        WHERE LOWER(JSON_EXTRACT(charinfo, '$.firstname')) LIKE LOWER(?)
        OR LOWER(JSON_EXTRACT(charinfo, '$.lastname')) LIKE LOWER(?)
        OR LOWER(CONCAT(JSON_EXTRACT(charinfo, '$.firstname'), ' ', JSON_EXTRACT(charinfo, '$.lastname'))) LIKE LOWER(?)
        LIMIT 50
    ]], {'%' .. ownerSearch .. '%', '%' .. ownerSearch .. '%', '%' .. ownerSearch .. '%'})

    if not players or #players == 0 then return {} end

    -- Get all vehicles owned by these players
    local vehicles = {}
    for _, player in ipairs(players) do
        local playerVehicles = MySQL.query.await('SELECT * FROM player_vehicles WHERE citizenid = ?', {player.citizenid})
        if playerVehicles then
            for _, vehicle in ipairs(playerVehicles) do
                table.insert(vehicles, vehicle)
            end
        end
    end

    return vehicles
end

-- Get vehicle owner name by identifier
function FrameworkAdapter.GetVehicleOwnerName(identifier)
    if not identifier then return 'Unknown' end
    local result = MySQL.single.await('SELECT charinfo FROM players WHERE citizenid = ?', {identifier})
    if result and result.charinfo then
        local success, charinfo = pcall(json.decode, result.charinfo)
        if success and charinfo then
            return (charinfo.firstname or '') .. ' ' .. (charinfo.lastname or '')
        end
    end
    return 'Unknown'
end

-- Parse QBox vehicle data to standardized format
function FrameworkAdapter.ParseVehicleData(vehicle)
    if not vehicle then return nil end

    local vehicleData = {}
    if vehicle.mods then
        local success, decoded = pcall(json.decode, vehicle.mods)
        if success and decoded then
            vehicleData = decoded
        end
    end

    local ownerIdentifier = vehicle.citizenid or vehicle.license

    return {
        plate = vehicle.plate,
        model = vehicle.vehicle or vehicle.hash or 'Unknown',
        owner_identifier = ownerIdentifier,
        owner_name = FrameworkAdapter.GetVehicleOwnerName(ownerIdentifier),
        stored = vehicle.state == 1 or vehicle.state == 0,
        garage = vehicle.garage or 'Unknown',
        fuel = vehicle.fuel or 100,
        engine = vehicle.engine or 1000,
        body = vehicle.body or 1000,
        mileage = vehicle.drivingdistance or 0,
        vehicle_type = 'car',
        in_garage = vehicle.state == 1,
        impounded = vehicle.state == 2 or false,
        job_vehicle = false
    }
end

return FrameworkAdapter
