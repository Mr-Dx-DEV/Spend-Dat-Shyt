-- ▀█▀ █░█ ▄▀█ █▄░█ █▄▀   █▄█ █▀█ █░█   █▀▀ █▀█ █▀█   █▀█ █░█ █▀█ █▀▀ █░█ ▄▀█ █▀ █▀▀
-- ░█░ █▀█ █▀█ █░▀█ █░█   ░█░ █▄█ █▄█   █▀░ █▄█ █▀▄   █▀▀ █▄█ █▀▄ █▄▄ █▀█ █▀█ ▄█ ██▄

-- Do not touch.
Framework = (GetResourceState("es_extended") == "started" and exports['es_extended']:getSharedObject()) or (GetResourceState("qbx_core") == "started" and exports['qbx_core']) or (GetResourceState("qb-core") == "started" and exports['qb-core']:GetCoreObject()) or nil

Settings = {}
Settings.Debug = false -- enable debug prints
Settings.Framework = (GetResourceState("es_extended") == "started" and "ESX") or (GetResourceState("qbx_core") == "started" and "Qbox") or (GetResourceState("qb-core") == "started" and "QBCore") or nil
Settings.Inventory = (GetResourceState("ox_inventory") == "started" and "ox_inventory") or (GetResourceState("qb-inventory") == "started" and "qb-inventory") or "custom"
Settings.Target    = (GetResourceState("ox_target") == "started" and "ox_target") or (GetResourceState("qb-target") == "started" and "qb-target") or nil
Settings.Fuel      = (GetResourceState("ox_fuel") == "started" and "ox_fuel") or (GetResourceState("x-fuel") == "started" and "x-fuel") or (GetResourceState("LegacyFuel") == "started" and "LegacyFuel") or (GetResourceState("cdn-fuel") == "started" and "cdn-fuel") or (GetResourceState("Renewed-Fuel") == "started" and "Renewed-Fuel") or (GetResourceState("qb-fuel") == "started" and "qb-fuel") or (GetResourceState("lc_fuel") == "started" and "lc_fuel") or (GetResourceState("ps-fuel") == "started" and "ps-fuel") or (GetResourceState("rcore_fuel") == "started" and "rcore_fuel") or (GetResourceState("lj-fuel") == "started" and "lj-fuel") or "native"
Settings.Keys      = (GetResourceState("wasabi_carlock") == "started" and "wasabi_carlock") or (GetResourceState("Renewed-Vehiclekeys") == "started" and "Renewed-Vehiclekeys") or (GetResourceState("tgiann-hotwire") == "started" and "tgiann-hotwire") or (GetResourceState("qbx_vehiclekeys") == "started" and "qbx_vehiclekeys") or (GetResourceState("fast-vehiclekeys") == "started" and "fast-vehiclekeys") or (GetResourceState("qb-vehiclekeys") == "started" and "qb-vehiclekeys") or nil
-------------------------------------------------------------------------------
Settings.Measurment      = "kmh" -- kmh|mph
Settings.Plate           = "RENT" -- Plate of the rent vehicles
Settings.RentKey         = "i"
Settings.ReceiptItem     = "rent_receipt"
Settings.DespawnDistance = 30.0
Settings.Prices = {
    Security = 300,
    Insurance = 300,
    ProcessingFee = 50
}
Settings.PayingType = {
    UpFront    = "money", -- before renting a vehicle
    HourlyRent = "money"   -- type for paying hourly rent | if player doesn't pay this vehicle will be taken from player
}
Settings.ReceiptAnimation = { -- animation when gaving receipt shown to player
    enabled   = true,
    prop      = "p_amb_clipboard_01",
    boneIndex = 18905,
    animDict  = "amb@world_human_clipboard@male@idle_a",
    animName  = "idle_a",
    position  = { x = 0.15, y = 0.0, z = 0.15 },
    rotation  = { x = 70.0, y = 110.0, z = 180.0 }
}

Settings.Notify = (GetResourceState("ox_lib") == "started" and "ox_lib") or (GetResourceState("codem-notification") == "started" and "codem") or (GetResourceState("es_extended") == "started" and "esx") or (GetResourceState("qb-core") == "started" and "qb") or (GetResourceState("qbx_core") == "started" and "qb") or (GetResourceState("okokNotify") == "started" and "okok") or (GetResourceState("wasabi_notify") == "started" and "wasabi") or (GetResourceState("t-notify") == "started" and "t-notify") or (GetResourceState("r_notify") == "started" and "r_notify") or (GetResourceState("pNotify") == "started" and "pNotify") or (GetResourceState("mythic_notify") == "started" and "mythic") or "ox_lib"
Settings.NotifyFun = function(message, type, timeout)
    local ntype, cooldown = type, timeout
    if not cooldown then cooldown = 3000 end
    if not ntype then ntype = 'success' end
    local title = "BBS Rental"
    local translatedMessage = message
    if Settings.Notify == "codem" then
        TriggerEvent('codem-notification:Create', translatedMessage, "bminfo", title, cooldown)
    elseif Settings.Notify == "esx" then
        Framework?.ShowNotification(translatedMessage)
    elseif Settings.Notify == "qb" then
        Framework?.Functions?.Notify({ text = translatedMessage, caption = title }, ntype, cooldown)
    elseif Settings.Notify == "okok" then
        exports['okokNotify']:Alert(title, translatedMessage, cooldown, ntype)
    elseif Settings.Notify == 'wasabi' then
        exports.wasabi_notify:notify(title, translatedMessage, cooldown, ntype)
    elseif Settings.Notify == 't-notify' then
        exports['t-notify']:Alert({ style = ntype, message = translatedMessage, duration = cooldown, })
    elseif Settings.Notify == 'r_notify' then
        exports.r_notify:notify({
            title = title,
            content = translatedMessage,
            type = ntype,
            icon = "fas fa-check",
            duration = cooldown,
            position = 'top-right',
            sound = false
        })
    elseif Settings.Notify == 'pNotify' then
        exports['pNotify']:SendNotification({
            text = translatedMessage,
            type = ntype,
            timeout = cooldown,
            layout = 'centerRight'
        })
    elseif Settings.Notify == 'mythic' then
        exports['mythic_notify']:SendAlert('inform', translatedMessage, cooldown)
    elseif Settings.Notify == "ox_lib" then
        lib.notify({
            title = title,
            description = translatedMessage,
            type = ntype
        })
    end
end