-- -
--  CLIENT ANIMATIONS  - Grim Development | Love Menu
-- -

local previewActive = false
local previewAnimId = nil
local previewThreadToken = 0
local activeScene = nil

-- - O KEY BINDING -
-- O key has no native GTA V control index, so we register a key mapping.
-- The command fires a client-side event that sets a flag we poll in the loop.

local grimPullOutPressed = false

RegisterCommand('grim_pullout', function()
    grimPullOutPressed = true
end, false)

RegisterKeyMapping('grim_pullout', '[Grim Love Menu] Pull Out', 'keyboard', 'o')

-- - HELPERS -

local function LoadDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0); RequestAnimDict(dict)
    end
end

local function PlayAnim(ped, dict, anim, flags)
    LoadDict(dict)
    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, flags or 0, 0, false, false, false)
end

local function HelpText(msg)
    AddTextEntry('GRIM_HT', msg)
    DisplayHelpTextThisFrame('GRIM_HT', false)
end

local function AttachTo(ped, target, att)
    AttachEntityToEntity(
        ped, target, GetPedBoneIndex(target, att.bone),
        att.xP, att.yP, att.zP, att.xR, att.yR, att.zR,
        false, false, false, true, 1, true
    )
end

-- - VALIDATION -

local function IsAnimAllowed(animDef)
    if not IsActionAllowed() then return false end
    if animDef.car and not IsPedInAnyVehicle(PlayerPedId(), false) then
        Bridge.Notify(Config.Strings.NotInCar, 'error'); return false
    end
    return true
end

-- - IN-WORLD PREVIEW (local-only) -

RegisterNUICallback('previewAnimInWorld', function(data, cb)
    cb('ok')

    local animIdx = tonumber(data.animId)
    local animDef = Config.Animations[animIdx]
    if not animDef or not IsAnimAllowed(animDef) then return end

    previewThreadToken = previewThreadToken + 1
    local myToken = previewThreadToken
    previewActive = false
    previewAnimId = animIdx

    local myPed      = PlayerPedId()
    local finishMode = data.finishMode or 'finish'
    local req        = animDef.Requester

    ClearPedTasksImmediately(myPed)
    DetachEntity(myPed, true, true)
    SetNuiFocus(false, false)

    if req.type == 'animation' then
        PlayAnim(myPed, req.dict, req.anim, req.flags)
    end

    previewActive = true

    CreateThread(function()
        local confirmed = false
        local cancelled = false
        local deadline  = GetGameTimer() + 30000

        while previewActive and myToken == previewThreadToken and not confirmed and not cancelled and GetGameTimer() < deadline do
            Wait(0)
            AddTextEntry('GRIM_PREV', '~g~[E]~w~ Confirm  ~r~[X]~w~ Cancel Preview')
            DisplayHelpTextThisFrame('GRIM_PREV', false)

            if IsControlJustReleased(0, 38) then
                confirmed = true
                break
            end
            if IsControlJustReleased(0, Config.CancelKey) then
                cancelled = true
                break
            end
        end

        ClearPedTasksImmediately(myPed)
        DetachEntity(myPed, true, true)
        previewActive = false

        if confirmed and myToken == previewThreadToken then
            TriggerEvent('grim_lovemenu:tablet:forceClose')
            Wait(200)
            RequestAnimation(animIdx, finishMode)
        else
            SetNuiFocus(true, true)
            SendNUIMessage({ action = 'previewCancelled' })
        end
    end)
end)

-- - DEBUG CLONE -

function PlayAnimDebug(animIdx)
    local animDef = Config.Animations[animIdx]
    if not animDef or not IsAnimAllowed(animDef) then return end

    local myPed    = PlayerPedId()
    local clone    = ClonePed(myPed, GetEntityHeading(myPed), true, true)
    local cancelled = false

    CreateThread(function()
        local acc      = animDef.Accepter
        if animDef.car then TaskWarpPedIntoVehicle(clone, GetVehiclePedIsUsing(myPed), 0) end
        if acc.attach  then AttachTo(clone, myPed, acc.attach) end
        Wait(750)
        if acc.type == 'animation' then PlayAnim(clone, acc.dict, acc.anim, acc.flags) end

        local req      = animDef.Requester
        local deadline = GetGameTimer() + 10000
        while not IsEntityPlayingAnim(myPed, req.dict, req.anim, 3) and not cancelled do
            Wait(0); SetEntityNoCollisionEntity(clone, myPed, true)
            if GetGameTimer() > deadline then cancelled=true; break end
        end
        DetachEntity(clone)
        while IsEntityPlayingAnim(myPed, req.dict, req.anim, 3) and not cancelled do
            Wait(0); SetEntityNoCollisionEntity(clone, myPed, true)
        end
        ClearPedTasks(clone); DeleteEntity(clone)
    end)

    CreateThread(function()
        local req      = animDef.Requester
        if req.attach  then AttachTo(myPed, clone, req.attach) end
        Wait(750)
        if req.type == 'animation' then PlayAnim(myPed, req.dict, req.anim, req.flags) end

        local acc      = animDef.Accepter
        local deadline = GetGameTimer() + 10000
        while not IsEntityPlayingAnim(clone, acc.dict, acc.anim, 3) and not cancelled do
            Wait(0); SetEntityNoCollisionEntity(myPed, clone, true)
            if GetGameTimer() > deadline then cancelled=true; break end
        end
        DetachEntity(myPed)
        while IsEntityPlayingAnim(clone, acc.dict, acc.anim, 3) and not cancelled do
            Wait(0); SetEntityNoCollisionEntity(myPed, clone, true)
            HelpText(Config.Strings.CancelPrompt)
            if IsControlJustReleased(0, Config.CancelKey) then
                cancelled=true; ClearPedTasks(myPed)
                Bridge.Notify(Config.Strings.AnimCancelled,'inform'); break
            end
        end
        ClearPedTasks(myPed)
    end)
end

-- - LIVE REQUEST -

function RequestAnimation(animIdx, finishMode)
    if not IsActionAllowed() then return end
    if not CurrentPartner then Bridge.Notify(Config.Strings.NoPartner,'error'); return end
    local animDef = Config.Animations[animIdx]
    if not animDef or not IsAnimAllowed(animDef) then return end
    TriggerServerEvent('grim_lovemenu:sv:requestAnim', CurrentPartner, animIdx, finishMode or 'finish')
    Bridge.Notify(Config.Strings.RequestSent, 'primary')
end

-- - INCOMING REQUEST (accepter) -

local incomingRequestActive = false  -- dedup: ignore new requests while one is pending

RegisterNetEvent('grim_lovemenu:cl:incomingRequest', function(requesterSID, animIdx, finishMode, requesterName)
    -- Discard if already handling a request - prevents notification spam
    if incomingRequestActive then return end

    local animDef = Config.Animations[animIdx]
    if not animDef then return end

    incomingRequestActive = true
    CurrentPartner = tonumber(requesterSID) or CurrentPartner

    -- Single notification only - no duplicate Bridge.Notify + toast
    Bridge.Notify(('- Request from %s - ENTER accept / BACKSPACE decline'):format(requesterName), 'inform')

    local accepted = false
    local deadline = GetGameTimer() + 15000

    CreateThread(function()
        while GetGameTimer() < deadline do
            Wait(0)
            HelpText(string.format(
                Config.Strings.RequestReceived .. '\n~INPUT_FRONTEND_ACCEPT~ Accept  ~INPUT_FRONTEND_RRIGHT~ Decline',
                requesterName, animDef.requesterLabel
            ))
            if IsControlJustReleased(0, 201) then accepted=true; break end
            if IsControlJustReleased(0, 194) then break end
        end
        incomingRequestActive = false
        if accepted then
            TriggerServerEvent('grim_lovemenu:sv:acceptAnim', requesterSID, animIdx, finishMode)
        else
            TriggerServerEvent('grim_lovemenu:sv:declineAnim', requesterSID, animIdx)
        end
    end)
end)

-- - PLAY SYNCED -

RegisterNetEvent('grim_lovemenu:cl:playSynced', function(partnerSID, animIdx, role, finishMode, meta)
    local animDef = Config.Animations[animIdx]
    if not animDef then return end

    meta = meta or {}

    local myPed      = PlayerPedId()
    local partnerPed = GetPlayerPed(GetPlayerFromServerId(partnerSID))

    if not DoesEntityExist(partnerPed) or partnerPed == 0 then
        Bridge.Notify(Config.Strings.TooFar,'error'); return
    end
    if #(GetEntityCoords(myPed) - GetEntityCoords(partnerPed)) > Config.MaxDistance then
        Bridge.Notify(Config.Strings.TooFar,'error'); return
    end

    local myAnim      = animDef[role]
    local partnerRole = (role == 'Requester') and 'Accepter' or 'Requester'
    local partnerAnim = animDef[partnerRole]

    -- Reset the O key flag before the scene starts so a stale press
    -- from outside the scene doesn't accidentally trigger pull out
    grimPullOutPressed = false

    -- finishChoice: nil = waiting | 'inside' = E | 'pullout' = O
    -- femaleSID from server meta ensures pregnancy always targets the right player
    activeScene = {
        partnerSID        = partnerSID,
        animIdx           = animIdx,
        role              = role,
        finishMode        = finishMode,
        allowFinishPrompt = meta.allowFinishPrompt == true,
        finishChoiceMade  = false,
        finishChoice      = nil,
        femaleSID         = meta.femaleSID,
        maleSID           = meta.maleSID,
    }

    if myAnim.attach then AttachTo(myPed, partnerPed, myAnim.attach) end
    Wait(750)
    if myAnim.type == 'animation' then PlayAnim(myPed, myAnim.dict, myAnim.anim, myAnim.flags) end

    local deadline = GetGameTimer() + 10000
    while not IsEntityPlayingAnim(partnerPed, partnerAnim.dict, partnerAnim.anim, 3) do
        Wait(0)
        SetEntityNoCollisionEntity(myPed, partnerPed, true)
        if GetGameTimer() > deadline or not DoesEntityExist(partnerPed) then
            ClearPedTasks(myPed); DetachEntity(myPed)
            activeScene = nil
            Bridge.Notify(Config.Strings.AnimCancelled,'inform'); return
        end
    end
    DetachEntity(myPed)

    -- - Active scene loop -
    while IsEntityPlayingAnim(partnerPed, partnerAnim.dict, partnerAnim.anim, 3) do
        Wait(0)
        if not DoesEntityExist(partnerPed) then break end
        if #(GetEntityCoords(myPed) - GetEntityCoords(partnerPed)) > (Config.MaxDistance + 3.0) then break end
        SetEntityNoCollisionEntity(myPed, partnerPed, true)

        if activeScene and activeScene.allowFinishPrompt and not activeScene.finishChoiceMade then
            -- - Unprotected: show E / O / X prompt until a choice is made -
            HelpText('[~g~E~w~] Finish Inside   [~y~O~w~] Pull Out   [~r~X~w~] Cancel')

            if IsControlJustReleased(0, 38) then
                -- [E] Finish Inside - ends animation immediately, 80% pregnancy roll
                activeScene.finishChoiceMade = true
                activeScene.finishChoice     = 'inside'
                grimPullOutPressed           = false
                Bridge.Notify('- Finished inside.', 'error')
                ClearPedTasks(myPed)
                break  -- end animation immediately

            elseif grimPullOutPressed then
                -- [O] Pull Out - ends animation immediately, 50/50 pregnancy roll
                grimPullOutPressed           = false
                activeScene.finishChoiceMade = true
                activeScene.finishChoice     = 'pullout'
                Bridge.Notify('- Pulled out.', 'inform')
                ClearPedTasks(myPed)
                break  -- end animation immediately

            elseif IsControlJustReleased(0, Config.CancelKey) then
                grimPullOutPressed = false
                ClearPedTasks(myPed)
                Bridge.Notify(Config.Strings.AnimCancelled, 'inform')
                activeScene = nil
                return
            end

        else
            -- Choice made, protected scene, or accepter role - show cancel only
            HelpText(Config.Strings.CancelPrompt)
            if IsControlJustReleased(0, Config.CancelKey) then
                grimPullOutPressed = false
                ClearPedTasks(myPed)
                Bridge.Notify(Config.Strings.AnimCancelled, 'inform')
                activeScene = nil
                return
            end
        end
    end

    ClearPedTasks(myPed)
    grimPullOutPressed = false

    -- Fire animFinished from Requester side only — pass femaleSID so server
    -- always assigns pregnancy to the correct player regardless of who sent the request
    if role == 'Requester' and activeScene then
        local choice = activeScene.finishChoice or 'none'
        TriggerServerEvent('grim_lovemenu:sv:animFinished', partnerSID, animIdx, finishMode, choice, activeScene.femaleSID)
    end

    activeScene = nil
end)
