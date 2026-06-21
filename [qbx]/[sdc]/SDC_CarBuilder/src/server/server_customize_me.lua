function GetCurrentCashAmount(src)
    return exports["SDC_Core"]:GetCurrentCashAmount(src)
end

function RemoveCashMoney(src, amt)
    exports["SDC_Core"]:RemoveCashMoney(src, amt)
end

function GiveCashMoney(src, amt)
    exports["SDC_Core"]:GiveCashMoney(src, amt)
end

function GiveItem(src, item, amt)
    exports["SDC_Core"]:GiveItem(src, item, amt)
end

function RemoveItem(src, item, amt)
    exports["SDC_Core"]:RemoveItem(src, item, amt)
end

function HasItemAmt(src, item, amt)
    return exports["SDC_Core"]:HasItemAmt(src, item, amt)
end

function GetItemAmt(src, item)
    return exports["SDC_Core"]:GetItemAmt(src, item)
end

function GetOwnerTag(src)
    return exports["SDC_Core"]:GetOwnerTag(src)
end

function SaveVehicleInDatabase(src, plate, vdata, model)
    exports["SDC_Core"]:SaveVehicleInDatabase(src, plate, vdata, model)
end

function GetRandomPlate()
    return exports["SDC_Core"]:GetRandomPlate()
end

function GetPlayerJob(src)
    return exports["SDC_Core"]:GetPlayerJob(src)
end

