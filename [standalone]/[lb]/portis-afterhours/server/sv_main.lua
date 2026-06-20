local Phone = nil

function PhNotify(src, title, message)
    if Phone == 'lb-phone' then
        exports['lb-phone']:SendNotification(src, { app = 'portis-afterhours', title = title, content = message })
    elseif Phone == 'gksphone' then
        exports['gksphone']:sendNotification(src, { title = title, message = message, icon = '/ui/dist/img/icon.svg', duration = 6000, type = 'success', buttonactive = false })
    elseif Phone == 'yseries' or Phone == 'yflip-phone' then
        exports[Phone]:SendNotification({ app = 'portis-afterhours', title = title, text = message }, 'source', src)
    elseif Phone == '17mov_phone' then
        exports['17mov_Phone']:SendNotificationToSrc(src, { app = 'portis-afterhours', title = title, message = message })
    elseif Phone == 'codem-phone' then
        exports['codem-phone']:SendNotify(src, { app = 'portis-afterhours', title = title, message = message })
    elseif Phone == 'lb-tablet' then
        exports['lb-tablet']:SendNotification({ source = src, app = 'portis-afterhours', title = title, content = message })
    elseif Phone == 'custom' then
    end
end

local Framework = nil
local FrameworkType = nil

local IdentifierBySource = {}

local function DetectFramework()
    if GetResourceState('es_extended') == 'started' then
        Framework = exports['es_extended']:getSharedObject()
        FrameworkType = 'esx'
        APP.Utils.Debug('Framework detected: ESX')
    elseif GetResourceState('qb-core') == 'started' then
        Framework = exports['qb-core']:GetCoreObject()
        FrameworkType = 'qbcore'
        APP.Utils.Debug('Framework detected: QBCore')
    else
        FrameworkType = 'standalone'
        APP.Utils.Debug('Framework detected: standalone')
    end
end

function GetIdentifier(source)
    local cached = IdentifierBySource[source]
    if cached then return cached end

    local id
    if FrameworkType == 'esx' then
        local xPlayer = Framework.GetPlayerFromId(source)
        if xPlayer then id = xPlayer.identifier end
    elseif FrameworkType == 'qbcore' then
        local player = Framework.Functions.GetPlayer(source)
        if player then id = player.PlayerData.citizenid end
    end
    if not id then
        for _, ident in ipairs(GetPlayerIdentifiers(source)) do
            if ident:sub(1, 8) == 'license:' then
                id = ident
                break
            end
        end
    end
    if id then IdentifierBySource[source] = id end
    return id
end

AddEventHandler('playerDropped', function()
    IdentifierBySource[source] = nil
end)

function GetCharacterName(identifier)
    if not identifier or identifier == '' then return nil end

    if FrameworkType == 'esx' then
        local xPlayer = Framework.GetPlayerFromIdentifier(identifier)
        if xPlayer then
            local first = xPlayer.get and xPlayer.get('firstName') or xPlayer.variables and xPlayer.variables.firstName
            local last  = xPlayer.get and xPlayer.get('lastName')  or xPlayer.variables and xPlayer.variables.lastName
            if first or last then
                return ((first or '') .. ' ' .. (last or '')):gsub('^%s+', ''):gsub('%s+$', '')
            end
        end
        local rows = MySQL.query.await(
            'SELECT firstname, lastname FROM users WHERE identifier = ? LIMIT 1',
            {identifier}
        )
        if rows and rows[1] then
            local first = rows[1].firstname or ''
            local last  = rows[1].lastname  or ''
            local name  = (first .. ' ' .. last):gsub('^%s+', ''):gsub('%s+$', '')
            if name ~= '' then return name end
        end
        return nil
    elseif FrameworkType == 'qbcore' then
        local player = Framework.Functions.GetPlayerByCitizenId(identifier)
        if player and player.PlayerData and player.PlayerData.charinfo then
            local ci = player.PlayerData.charinfo
            local name = ((ci.firstname or '') .. ' ' .. (ci.lastname or '')):gsub('^%s+', ''):gsub('%s+$', '')
            if name ~= '' then return name end
        end
        local rows = MySQL.query.await(
            'SELECT charinfo FROM players WHERE citizenid = ? LIMIT 1',
            {identifier}
        )
        if rows and rows[1] and rows[1].charinfo then
            local ok, ci = pcall(json.decode, rows[1].charinfo)
            if ok and type(ci) == 'table' then
                local name = ((ci.firstname or '') .. ' ' .. (ci.lastname or '')):gsub('^%s+', ''):gsub('%s+$', '')
                if name ~= '' then return name end
            end
        end
        return nil
    end

    return nil
end

function GetPlayerMoney(source)
    if Config.Currency == '' then return math.huge end
    if FrameworkType == 'esx' then
        local xPlayer = Framework.GetPlayerFromId(source)
        if not xPlayer then return 0 end
        if Config.Currency == 'bank' then
            return xPlayer.getAccount('bank').money
        end
        return xPlayer.getMoney()
    elseif FrameworkType == 'qbcore' then
        local player = Framework.Functions.GetPlayer(source)
        if not player then return 0 end
        if Config.Currency == 'bank' then
            return player.PlayerData.money['bank'] or 0
        end
        return player.PlayerData.money['cash'] or 0
    end
    return math.huge
end

function RemovePlayerMoney(source, amount)
    if Config.Currency == '' then return true end
    if FrameworkType == 'esx' then
        local xPlayer = Framework.GetPlayerFromId(source)
        if not xPlayer then return false end
        if Config.Currency == 'bank' then
            xPlayer.removeAccountMoney('bank', amount)
        else
            xPlayer.removeMoney(amount)
        end
        return true
    elseif FrameworkType == 'qbcore' then
        local player = Framework.Functions.GetPlayer(source)
        if not player then return false end
        local moneyType = Config.Currency == 'bank' and 'bank' or 'cash'
        return player.Functions.RemoveMoney(moneyType, amount, 'portis-afterhours-purchase')
    end
    return true
end

function AddPlayerMoney(source, amount)
    if Config.Currency == '' then return true end
    if amount <= 0 then return true end
    if FrameworkType == 'esx' then
        local xPlayer = Framework.GetPlayerFromId(source)
        if not xPlayer then return false end
        if Config.Currency == 'bank' then
            xPlayer.addAccountMoney('bank', amount)
        else
            xPlayer.addMoney(amount)
        end
        return true
    elseif FrameworkType == 'qbcore' then
        local player = Framework.Functions.GetPlayer(source)
        if not player then return false end
        local moneyType = Config.Currency == 'bank' and 'bank' or 'cash'
        return player.Functions.AddMoney(moneyType, amount, 'portis-afterhours-payout')
    end
    return true
end

function RefundPlayerMoney(source, amount)
    return AddPlayerMoney(source, amount)
end

function FindOnlineSourceForIdentifier(identifier)
    if not identifier then return nil end
    if FrameworkType == 'esx' then
        local xPlayer = Framework.GetPlayerFromIdentifier(identifier)
        if xPlayer and xPlayer.source then return xPlayer.source end
        return nil
    elseif FrameworkType == 'qbcore' then
        local player = Framework.Functions.GetPlayerByCitizenId(identifier)
        if player and player.PlayerData and player.PlayerData.source then
            return player.PlayerData.source
        end
        return nil
    end

    for _, src in ipairs(GetPlayers()) do
        local s = tonumber(src)
        if s and GetIdentifier(s) == identifier then return s end
    end
    return nil
end

CreateThread(function()
    DetectFramework()

    local ok, err = pcall(Schema.Ensure)
    if not ok then
        print(('[%s] Schema install failed: %s'):format('portis-afterhours', tostring(err)))
    end

    local cfg = Config.Phone
    if cfg ~= 'auto' then
        Phone = cfg
    else
        if GetResourceState('lb-phone')    == 'started' then Phone = 'lb-phone'    end
        if GetResourceState('gksphone')    == 'started' then Phone = 'gksphone'    end
        if GetResourceState('yseries')     == 'started' then Phone = 'yseries'     end
        if not Phone and GetResourceState('yflip-phone') == 'started' then Phone = 'yflip-phone' end
        if GetResourceState('17mov_Phone') == 'started' then Phone = '17mov_phone' end
        if GetResourceState('codem-phone') == 'started' then Phone = 'codem-phone' end
        if not Phone and GetResourceState('lb-tablet') == 'started' then Phone = 'lb-tablet' end
    end
    APP.Utils.Debug('Server phone bridge:', Phone or 'none')

    local function OnCharacterLoaded(src)
        if not src or src == 0 then return end
        if Payouts and Payouts.DrainForSource then
            Payouts.DrainForSource(src)
        end
        if Invitations and Invitations.NotifyPendingForSource then
            Invitations.NotifyPendingForSource(src)
        end
    end

    if FrameworkType == 'esx' then
        RegisterNetEvent('esx:playerLoaded', function(playerId)
            OnCharacterLoaded(playerId or source)
        end)
    elseif FrameworkType == 'qbcore' then
        RegisterNetEvent('QBCore:Server:PlayerLoaded', function()
            OnCharacterLoaded(source)
        end)
    end

    Wait(2000)
    for _, playerId in ipairs(GetPlayers()) do
        OnCharacterLoaded(tonumber(playerId))
    end

    if Lifecycle and Lifecycle.OnResourceStart then
        Lifecycle.OnResourceStart()
    end

    print(('[%s] Resource started successfully'):format('portis-afterhours'))
end)
