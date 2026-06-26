local talking = false

local function IsTalking()
    if Config.Voice.System == "salty" then
        return talking
    end

    return MumbleIsPlayerTalking(PlayerId())
end

local function ConvertProximityToUnits(proximity)
    return -0.3045 * proximity^2 + 5.016 * proximity - 2.5919
end

---@return number
function GetVoiceMaxDistance()
    local proximity = MumbleGetTalkerProximity()

    return ConvertProximityToUnits(proximity)
end

local sendTalkingInterval = Interval:new(function()
    local isTalking = IsTalking()

    if isTalking and not talking then
        talking = true

        SendNUIAction("camera:toggleMicrophone", talking)
    elseif not isTalking and talking then
        talking = false

        SendNUIAction("camera:toggleMicrophone", talking)
    end
end, 100, false)

if Config.Voice.System == "salty" then
    RegisterNetEvent("SaltyChat_TalkStateChanged", function(isTalking)
        talking = isTalking

        if sendTalkingInterval.enabled then
            SendNUIAction("camera:toggleMicrophone", talking)
        end
    end)
end

RegisterSyncNUICallback("isTalking", function()
    return IsTalking()
end)

---@param enabled? boolean
RegisterSyncNUICallback("toggleTalkingInterval", function(enabled)
    sendTalkingInterval:toggle(enabled == true)
end, "ok")
