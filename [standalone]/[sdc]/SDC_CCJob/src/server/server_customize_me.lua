function AddBankAmount(src, amt)
    exports["SDC_Core"]:AddBankAmount(src, amt)
end

function GiveItem(src, item, amt)
    exports["SDC_Core"]:GiveItem(src, item, amt)
end

function RemoveItem(src, item, amt)
    exports["SDC_Core"]:RemoveItem(src, item, amt)
end

function GetItemAmt(src, item)
    return exports["SDC_Core"]:GetItemAmt(src, item)
end