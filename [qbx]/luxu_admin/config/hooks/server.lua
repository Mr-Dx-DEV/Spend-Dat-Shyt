exports("getHooks", function()
    local function deleteEntity(entity)
        DeleteEntity(entity)
    end

    local function deleteVehicle(entity)
        if GetResourceState("AdvancedParking") == "started" then
            return exports["AdvancedParking"]:DeleteVehicle(entity, false)
        end
        DeleteEntity(entity)
    end

    return {
        deleteEntity = deleteEntity,
        deleteVehicle = deleteVehicle,
    }
end)

--- Uncomment these if you need

-- Report Created
-- AddEventHandler("luxu_admin:server:report_created", function(data)
--     local chatId = data.reportId --[[@as number]]
--     local authorSource = data.author_source --[[@as number]]
--     local authorName = data.author_name --[[@as string]]
-- end)

-- Player Banned
-- AddEventHandler("luxu_admin:server:player_banned", function(data)
--     local banId = data.banId --[[@as number]]
--     local playerName = data.playerName --[[@as string]]
--     local reason = data.reason --[[@as string]]
--     local staffId = data.staffId --[[@as number|nil]]
--     local staffName = data.staffName --[[@as string|nil]]
-- end)
