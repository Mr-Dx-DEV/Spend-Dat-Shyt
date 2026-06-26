local hasTabletItem = nil

---@return boolean
function HasTabletItem()
    if hasTabletItem == nil then
        hasTabletItem = HasItem()
    end

    return hasTabletItem
end

---@param hasTablet boolean
function HasItemChanged(hasTablet)
    debugprint("HasItemChanged", hasTablet)

    hasTabletItem = hasTablet

    if Config.Item.Require then
        if not hasTablet then
            ToggleOpen(false)
        end

        SendNUIAction("setHasTablet", hasTablet)
    end

    TriggerServerEvent("tablet:server:hasItemChanged")
end

function ItemCountChanged()
    Wait(500)

    local hasItem = HasItem()

    if hasItem == HasTabletItem() then
        return
    end

    HasItemChanged(hasItem)
end

if Config.MDT.ExportReports.Enabled then
    SetTimeout(1000, function()
        local oxState = GetResourceState("ox_inventory")

        if oxState ~= "started" and oxState ~= "starting" then
            return
        end

        exports.ox_inventory:displayMetadata({ title = "Title" })
    end)
end
