local QBCore = exports[Config.Core]:GetCoreObject()

WebhookURLs = {
    ["car-registration"] = "",
    ["car-insurance"] = "",
    ["car-accidents"] = "",
    ["health-insurance"] = "",
    ["general"] = "" 
}

for k, v in pairs(WebhookURLs) do
    if v == nil then
        print("^1[ERROR]^7 Webhook URL is missing for ^1"..k.."^7")
    end
end

function AddItemToPlayer(src, Player, item, amount, slot, info) 
    if Config.Inventory == "oldqb" then
        Player.Functions.AddItem(item, amount, slot, info)
    elseif Config.Inventory == "ox" then
        exports.ox_inventory:AddItem(src, item, amount, info)
    elseif Config.Inventory == "newqb" then
        exports['qb-inventory']:AddItem(src, item, amount, slot, info, "vehicle-insurance")
    elseif Config.Inventory == "qs" then
        exports['qs-inventory']:AddItem(src, item, amount, slot, info)
    elseif Config.Inventory == "tgiann" then
        exports["tgiann-inventory"]:AddItem(src, item, amount, nil, info, false)
    elseif Config.Inventory == "codem" then
        exports['codem-inventory']:AddItem(src, item, amount, slot, info)
    elseif Config.Inventory == "core" then
        exports['core_inventory']:AddItem(src, item, amount, slot, info)
    end
end

function RemoveMoneyFromPlayer(src, Player, amount, info)
    local success = false
    if Config.Inventory == "oldqb" then
        if Player.Functions.GetMoney("cash") >= amount then
            Player.Functions.RemoveMoney("cash", amount)
            success = true
        elseif Player.Functions.GetMoney("bank") >= amount then
            Player.Functions.RemoveMoney("bank", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "ox" then
        local currentCash = exports.ox_inventory:GetItemCount(src, "cash")
        if currentCash >= amount then
            exports.ox_inventory:RemoveItem(src, "cash", amount)
            success = true
        elseif Player.Functions.GetMoney("bank") >= amount then
            Player.Functions.RemoveMoney("bank", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "newqb" then
        if Player.Functions.GetMoney("cash") >= amount then
            Player.Functions.RemoveMoney("cash", amount)
            success = true
        elseif Player.Functions.GetMoney("bank") >= amount then
            Player.Functions.RemoveMoney("bank", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "qs" then
        if Player.Functions.GetMoney("cash") >= amount then
            Player.Functions.RemoveMoney("cash", amount)
            success = true
        elseif Player.Functions.GetMoney("bank") >= amount then
            Player.Functions.RemoveMoney("bank", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "tgiann" then
        local currentCash = exports["tgiann-inventory"]:GetItemCount(src, "money_item" )
        if currentCash >= amount then
            exports["tgiann-inventory"]:RemoveItem(src, "money_item", amount)
            success = true
        elseif Player.Functions.GetMoney("bank") >= amount then
            Player.Functions.RemoveMoney("bank", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "codem" then
        local currentCash = exports['codem-inventory']:GetItemsTotalAmount(src, "cash")
        if currentCash >= amount then
            exports['codem-inventory']:RemoveItem(src, "cash", amount)
            success = true
        elseif Player.Functions.GetMoney("bank") >= amount then
            Player.Functions.RemoveMoney("bank", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    elseif Config.Inventory == "core" then
        local currentCash = exports['core_inventory']:getItemCount(src, "cash")
        if currentCash >= amount then
            exports['core_inventory']:removeItem(src, "cash", amount)
            success = true
        elseif Player.Functions.GetMoney("bank") >= amount then
            Player.Functions.RemoveMoney("bank", amount)
            success = true
        else
            TriggerClientEvent("m-Insurance:Client:Notify", src, Language[Config.Language].noMoney, "error", 5000)
        end
    end
    return success
end

function AddSocietyAccoutMoney(society, amount)
    if Config.Society == "qb-management" then
        exports['qb-management']:AddMoney(society, amount)
    elseif Config.Society == "qb-banking" then
        exports['qb-banking']:AddMoney(society, amount)
    elseif Config.Society == "okokBanking" then
        exports['okokBanking']:AddMoney(society, amount)
    elseif Config.Society == "renewed-banking" then
        exports['renewed-banking']:addAccountMoney(society, amount)
    end
end

function GetMaxDaysInMonth(year, month)
    local daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    
    if month == 2 then
        if (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0) then
            return 29
        end
    end
    
    return daysInMonth[month]
end

function AddMonthsToDate(currentDate, monthsToAdd)
    currentDate.month = currentDate.month + monthsToAdd

    if currentDate.month > 12 then
        local extraYears = math.floor(currentDate.month / 12)
        currentDate.year = currentDate.year + extraYears
        currentDate.month = currentDate.month % 12
        if currentDate.month == 0 then
            currentDate.month = 12
            currentDate.year = currentDate.year - 1
        end
    end

    local maxDays = GetMaxDaysInMonth(currentDate.year, currentDate.month)
    if currentDate.day > maxDays then
        currentDate.day = maxDays
    end

    return currentDate
end


QBCore.Functions.CreateCallback("m-Insurance:Server:HaveCarInsurance", function(source, cb, plate)
    exports['m-Insurance']:HasCarInsurance(plate, function(hasInsurance)
        cb(hasInsurance)
    end)
end)
