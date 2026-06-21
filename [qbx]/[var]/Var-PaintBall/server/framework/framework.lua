-- Framework abstraction (ESX / QBCore / Standalone). Override Framework.* from
-- another resource to plug a custom framework.

Framework = Framework or {}

local Lang = Lang or {}
local Utils = Utils or {}

Framework.framework = Utils.getFramework()

if Framework.framework == "ESX" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Framework.framework == "QBCore" then
    QBCore = exports["qb-core"]:GetCoreObject()
end

function Framework.getIdentifier(source)
    local identifiers = GetPlayerIdentifiers(source)
    for _, id in ipairs(identifiers) do
        if id:find("license", 1, true) then
            return id
        end
    end
    return identifiers[1] or ("src:%s"):format(source)
end

function Framework.getLocale(source)
    if Framework.framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer and xPlayer.get then
            local locale = xPlayer.get("locale")
            if locale then return locale end
        end
    end
    return "en"
end

function Framework.notify(source, key)
    local locale = Framework.getLocale(source)
    local message = Lang.get(locale, key)
    TriggerClientEvent("var-paintball:client:notify", source, message)
end

-- account: "cash" | "bank"
function Framework.getMoney(source, account)
    account = account or "cash"
    if Framework.framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return 0 end
        if account == "bank" then
            local acc = xPlayer.getAccount("bank")
            return acc and acc.money or 0
        else
            return xPlayer.getMoney() or 0
        end
    elseif Framework.framework == "QBCore" then
        local player = QBCore.Functions.GetPlayer(source)
        if not player then return 0 end
        local moneyType = account == "bank" and "bank" or "cash"
        return player.PlayerData.money[moneyType] or 0
    end
    return 0
end

function Framework.removeMoney(source, amount, account)
    account = account or "cash"
    amount = math.floor(amount)
    if amount <= 0 then return false end
    if Framework.framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return false end
        if account == "bank" then
            xPlayer.removeAccountMoney("bank", amount)
        else
            xPlayer.removeMoney(amount)
        end
        return true
    elseif Framework.framework == "QBCore" then
        local player = QBCore.Functions.GetPlayer(source)
        if not player then return false end
        local moneyType = account == "bank" and "bank" or "cash"
        return player.Functions.RemoveMoney(moneyType, amount, "var-paintball")
    end
    return false
end

function Framework.addMoney(source, amount, account)
    account = account or "cash"
    amount = math.floor(amount)
    if amount <= 0 then return false end
    if Framework.framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return false end
        if account == "bank" then
            xPlayer.addAccountMoney("bank", amount)
        else
            xPlayer.addMoney(amount)
        end
        return true
    elseif Framework.framework == "QBCore" then
        local player = QBCore.Functions.GetPlayer(source)
        if not player then return false end
        local moneyType = account == "bank" and "bank" or "cash"
        return player.Functions.AddMoney(moneyType, amount, "var-paintball")
    end
    return false
end

local avatarCache = {}

function Framework.getSteamHex(source)
    for _, id in ipairs(GetPlayerIdentifiers(source)) do
        if id:find("steam:", 1, true) then
            return id
        end
    end
    return nil
end

function Framework.fetchSteamAvatar(source, cb)
    local steamHex = Framework.getSteamHex(source)
    if not steamHex then cb(nil) return end
    if avatarCache[steamHex] then cb(avatarCache[steamHex]) return end
    local apiKey = GetConvar("steam_webApiKey", "")
    if apiKey == "" or apiKey == "none" then cb(nil) return end

    local hex = steamHex:gsub("steam:", "")
    local steam64 = tostring(tonumber(hex, 16))

    PerformHttpRequest(
        ("https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=%s&steamids=%s"):format(apiKey, steam64),
        function(status, body)
            if status == 200 and body then
                local data = json.decode(body)
                if data and data.response and data.response.players and data.response.players[1] then
                    local avatar = data.response.players[1].avatarfull
                    avatarCache[steamHex] = avatar
                    cb(avatar)
                    return
                end
            end
            cb(nil)
        end,
        "GET"
    )
end

function Framework.clearLoadout(source)
    local ped = GetPlayerPed(source)
    if ped and ped ~= 0 then
        RemoveAllPedWeapons(ped, true)
    end
end

function Framework.setBucket(source, bucket)
    SetPlayerRoutingBucket(source, bucket)
end

return Framework
