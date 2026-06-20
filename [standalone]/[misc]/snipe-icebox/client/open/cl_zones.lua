function ShowUI(text, type)
    SendNUIMessage({
        action = "showStatus",
        text = text,
        type = type
    })
end

function HideUI()
    SendNUIMessage({
        action = "hideStatus"
    })
end

local currentShopType = nil

local function StartThread(type, data)
    if inZone then return end
    CreateThread(function()
        inZone = true
        while inZone do
            Wait(0)
            if IsControlJustPressed(0, 38) then
                if type == "inspect" or type == "buy" then
                    if wearingChain.hasChain or wearingWatch.hasWatch then
                        ShowNotification("error", Locales["already_wearing_chain_or_watch"])
                    else
                        InspectOrBuy(currentShopType, type)
                    end
                elseif type == "craft" then
                    CraftChains(currentShopType)
                elseif type == "safe" then
                    OpenSafe(data)
                end
            end
        end
    end)
end

local function onExit(self)
    -- lib.hideTextUI()
    if Config.UseLibTextUI then
        lib.hideTextUI()
    else
        HideUI()
    end
    inZone = false
end

local function OnEnter(self)
    if PlayerJob.name == self.job and self.zoneType == "craft" then
        if Config.UseLibTextUI then
            lib.showTextUI(Locales["craft_chain_e"], {})
        else
            ShowUI(Locales["craft_chain_e"], "warning")
        end
        StartThread("craft")
        currentShopType = self.shopType
    elseif PlayerJob.name == self.job and self.zoneType == "safe" then
        if Config.UseLibTextUI then
            lib.showTextUI(Locales["open_safe_e"])
        else
            ShowUI(Locales["open_safe_e"], "warning")
        end
        StartThread("safe", self)
    elseif self.zoneType == "inspect" or self.zoneType == "buy" then
        if Config.UseLibTextUI then
            lib.showTextUI(self.zoneType == "inspect" and Locales["inspect_chain_e"] or Locales["buy_chain_e"])
        else
            ShowUI(self.zoneType == "inspect" and Locales["inspect_chain_e"] or Locales["buy_chain_e"], "warning")
        end
        StartThread(self.zoneType)
        currentShopType = self.shopType
    end
end

local function CreateZone(index, data)
    if data.type == "safe" and (not data.stashName or not data.stashLabel or not data.stashslots or not data.stashsize) then
        print("Icebox Safe: " .. index .. " is missing stash data")
        return
    end
    boxZones[index] = lib.zones.box({
        coords = vec3(data.coords.x, data.coords.y, data.coords.z),
        size = vec3(data.size.x, data.size.y, data.size.z),
        rotation = data.rotation,
        debug = false,
        onEnter = OnEnter,
        onExit = onExit,
        zoneType = data.type,
        job = data.job or false,
        stashsize = data.stashsize or 1000,
        stashslots = data.stashslots or 50,
        stashName = data.stashName or "icebox_safe_1",
        stashLabel = data.stashLabel or "Icebox Safe",
        shopType = data.shopType or nil
    })
end



CreateThread(function()
    for k, v in pairs(Config.Zones) do
        CreateZone(k, v)
    end
end)