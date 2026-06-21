function BroadcastPlayerDropped(playerId)
    -- Namespaced event; only server id (number). Avoid broadcasting player names —
    -- generic "onPlayerDropped" + name strings can trigger citizen-playernames msgpack
    -- crashes when many players disconnect at once.
    TriggerClientEvent("ENDA:PlayerDropped", -1, tonumber(playerId) or 0)
end

function InitPlayerDrivebyStatebag(playerId)
    local playerState = Player(playerId).state

    if playerState.driveby_clipset == nil then
        playerState:set("driveby_clipset", "RESET", true)
    end
end

function LogENDAClientError(playerId, errorCode, errorContext)
    local playerName = GetPlayerName(playerId) or "unknown"
    local contextLabel = errorContext or "nil"

    print(("^1[ENDA]^7 Error %s | player %s (%s) | context: %s"):format(
        tostring(errorCode),
        playerId,
        playerName,
        contextLabel
    ))
end

AddEventHandler("playerDropped", function()
    BroadcastPlayerDropped(source)
end)

RegisterNetEvent("SetPedDriveByClipsetOverride:InitiateStatebag", function()
    InitPlayerDrivebyStatebag(source)
end)

RegisterNetEvent("ENDA:ErrorLog", function(errorCode, errorContext)
    if source == 0 then
        return
    end

    LogENDAClientError(source, errorCode, errorContext)
end)

AddEventHandler("onResourceStart", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    if GetResourceState("DD_UI_Aimstyle") ~= "started" then
        print("^3[ENDA]^7 DD_UI_Aimstyle is not started. Aimstyle UI will not be available until it is running.")
    end

    if GetResourceState("ENDA_01") ~= "started" then
        print("^3[ENDA]^7 ENDA_01 is not started. Pack 01 driveby clipsets will be unavailable.")
    end
end)
