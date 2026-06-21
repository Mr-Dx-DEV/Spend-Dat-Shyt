-- -
--  CLIENT TABLET  -  NUI bridge  | Grim Development | Love Menu
-- -

local tabletOpen = false
local TabletData = {}
local tabletOpenToken = 0
local tabletProp = nil
local tabletHoldThread = 0


local FEMALE_MODEL = joaat('mp_f_freemode_01')
local MALE_MODEL   = joaat('mp_m_freemode_01')
local ItemNames    = Config.Items or {}
local TABLET_MODEL = joaat('prop_cs_tablet')
local TABLET_ANIM = {
    dict = 'cellphone@tablet',
    clip = 'base',
    flag = 49,
}

local function ItemName(key, fallback)
    return ItemNames[key] or fallback
end

local function ItemEvent(key, fallback)
    return ('grim_lovemenu:item:%s'):format(ItemName(key, fallback))
end

local function LoadAnimDict(dict)
    if HasAnimDictLoaded(dict) then
        return true
    end

    RequestAnimDict(dict)
    local timeoutAt = GetGameTimer() + 800
    while not HasAnimDictLoaded(dict) and GetGameTimer() < timeoutAt do
        Wait(0)
    end

    return HasAnimDictLoaded(dict)
end

local function LoadModel(model)
    if HasModelLoaded(model) then
        return true
    end

    RequestModel(model)
    local timeoutAt = GetGameTimer() + 800
    while not HasModelLoaded(model) and GetGameTimer() < timeoutAt do
        Wait(0)
    end

    return HasModelLoaded(model)
end

local function StopTabletPresentation()
    tabletHoldThread = tabletHoldThread + 1

    local ped = PlayerPedId()
    if DoesEntityExist(ped) then
        StopAnimTask(ped, TABLET_ANIM.dict, TABLET_ANIM.clip, 1.5)
        ClearPedSecondaryTask(ped)
    end

    if tabletProp and DoesEntityExist(tabletProp) then
        DetachEntity(tabletProp, true, true)
        DeleteEntity(tabletProp)
    end

    tabletProp = nil
end

local function StartTabletPresentation()
    local ped = PlayerPedId()
    if not DoesEntityExist(ped) then
        return
    end

    StopTabletPresentation()

    if not LoadAnimDict(TABLET_ANIM.dict) then
        if Config.DebugPrint then
            print('[grim_lovemenu] Tablet anim dict failed to load.')
        end
        return
    end

    if not LoadModel(TABLET_MODEL) then
        if Config.DebugPrint then
            print('[grim_lovemenu] Tablet prop model failed to load.')
        end
        return
    end

    tabletProp = CreateObject(TABLET_MODEL, 1.0, 1.0, 1.0, true, true, false)
    if DoesEntityExist(tabletProp) then
        SetEntityCollision(tabletProp, false, false)
        AttachEntityToEntity(tabletProp, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.03, 0.0, 10.0, 0.0, 0.0, true, true, false, true, 1, true)
    end

    TaskPlayAnim(ped, TABLET_ANIM.dict, TABLET_ANIM.clip, 3.0, -3.0, -1, TABLET_ANIM.flag, 0.0, false, false, false)

    tabletHoldThread = tabletHoldThread + 1
    local myThread = tabletHoldThread
    CreateThread(function()
        while tabletOpen and myThread == tabletHoldThread do
            Wait(1000)
            if not tabletOpen or myThread ~= tabletHoldThread then
                break
            end

            if not DoesEntityExist(ped) then
                break
            end

            if not IsEntityPlayingAnim(ped, TABLET_ANIM.dict, TABLET_ANIM.clip, 3) then
                TaskPlayAnim(ped, TABLET_ANIM.dict, TABLET_ANIM.clip, 3.0, -3.0, -1, TABLET_ANIM.flag, 0.0, false, false, false)
            end
        end
    end)
end

local function MergeState(baseState, incoming)
    local merged = {}

    if type(baseState) == 'table' then
        for k, v in pairs(baseState) do
            merged[k] = v
        end
    end

    if type(incoming) == 'table' then
        for k, v in pairs(incoming) do
            merged[k] = v
        end
    end

    return merged
end


local function SyncBirthReminder(data)
    local pregnancy = type(data) == 'table' and data.pregnancy or nil
    if pregnancy == false or pregnancy == nil then
        TriggerEvent('grim_lovemenu:cl:birthReminderStop')
    end
end

local function RebuildPartnerCaches(data)
    if type(data) ~= 'table' then return end

    if data.selectedPartnerState and data.selectedPartnerState.serverId then
        CurrentPartner = tonumber(data.selectedPartnerState.serverId)
    elseif data.selectedPartnerState == false then
        CurrentPartner = nil
    end

    RegisteredPartners = {}
    if data.registeredPartners then
        for _, partner in ipairs(data.registeredPartners) do
            if partner and partner.serverId then
                RegisteredPartners[tonumber(partner.serverId)] = true
            end
        end
    end
end


local function IsCoffeePedAllowed()
    local ped = PlayerPedId()
    if not DoesEntityExist(ped) then return false end
    return GetEntityModel(ped) == FEMALE_MODEL  -- strictly mp_f_freemode_01 only
end

local function IsBroCodePedAllowed()
    local ped = PlayerPedId()
    if not DoesEntityExist(ped) then return false end
    return GetEntityModel(ped) == MALE_MODEL  -- strictly mp_m_freemode_01 only
end


-- - OPEN / CLOSE -

local function SetTabletFocusState(enabled)
    SetNuiFocus(enabled, enabled)
    if SetNuiFocusKeepInput then
        SetNuiFocusKeepInput(false)
    end
end

local function CloseTabletInternal(sendCloseMessage)
    if not tabletOpen then
        return
    end

    tabletOpen = false
    tabletOpenToken = tabletOpenToken + 1
    StopTabletPresentation()
    SetTabletFocusState(false)
    TriggerScreenblurFadeOut(180.0)

    if sendCloseMessage then
        SendNUIMessage({ action = 'closeTablet' })
    end
end

-- Pre-warm the tablet anim dict and prop model on resource start
-- so they're already loaded when the player hits Use on the item.
-- This eliminates the 2-5 second blocking delay on first open.
CreateThread(function()
    Wait(2000)  -- wait for player to be in game before preloading
    RequestAnimDict(TABLET_ANIM.dict)
    RequestModel(TABLET_MODEL)
    local deadline = GetGameTimer() + 5000
    while (not HasAnimDictLoaded(TABLET_ANIM.dict) or not HasModelLoaded(TABLET_MODEL)) and GetGameTimer() < deadline do
        Wait(50)
    end
    if Config.DebugPrint then
        print('[grim_lovemenu] Tablet assets pre-warmed: anim=' .. tostring(HasAnimDictLoaded(TABLET_ANIM.dict)) .. ' model=' .. tostring(HasModelLoaded(TABLET_MODEL)))
    end
end)

AddEventHandler('grim_lovemenu:tablet:open', function()
    if tabletOpen then
        -- Tablet is already open (e.g. player used item again, or command re-fired).
        -- Re-assert NUI focus, re-send openTablet, and request fresh data.
        -- Without this the tablet appears frozen or invisible after the first close/reopen.
        TriggerServerEvent('grim_lovemenu:sv:getMyData')
        SetTabletFocusState(true)
        SendNUIMessage({ action = 'openTablet' })
        return
    end

    tabletOpen = true
    tabletOpenToken = tabletOpenToken + 1
    local myToken = tabletOpenToken

    -- Open the NUI immediately — don't wait for server data
    -- Data arrives async and mergePlayerData re-renders when it lands
    SetTabletFocusState(false)
    SendNUIMessage({ action = 'openTablet' })
    StartTabletPresentation()

    -- Fire getMyData after NUI is open so UI shows instantly
    TriggerServerEvent('grim_lovemenu:sv:getMyData')

    CreateThread(function()
        Wait(80)  -- reduced from 160ms — just enough for NUI open animation
        if not tabletOpen or myToken ~= tabletOpenToken then
            return
        end

        TriggerScreenblurFadeIn(120.0)
        SetTabletFocusState(true)
    end)
end)

RegisterNUICallback('closeTablet', function(_, cb)
    CloseTabletInternal(false)
    cb('ok')
end)

RegisterNUICallback('getMyData', function(_, cb)
    TriggerServerEvent('grim_lovemenu:sv:getMyData')
    cb('ok')
end)

RegisterNUICallback('toggleStandby', function(data, cb)
    cb({ ok = true, standby = data and data.standby == true or false })
end)

RegisterNUICallback('refreshTablet', function(_, cb)
    TriggerServerEvent('grim_lovemenu:sv:getMyData')
    cb('ok')
end)
-- ESC key
CreateThread(function()
    while true do
        Wait(50)
        if tabletOpen and IsControlJustReleased(0, 200) then
            CloseTabletInternal(true)
        end
    end
end)

-- - SERVER - NUI DATA PUSH -

RegisterNetEvent('grim_lovemenu:cl:receiveMyData', function(data)
    TabletData = type(data) == 'table' and data or {}
    PlayerState.data = type(data) == 'table' and data or PlayerState.data or {}
    RebuildPartnerCaches(TabletData)
    SyncBirthReminder(TabletData)
    SendNUIMessage({ action = 'setPlayerData', data = TabletData })
end)

RegisterNetEvent('grim_lovemenu:cl:updateData', function(data)
    if type(data) ~= 'table' then return end
    TabletData = MergeState(TabletData, data)
    PlayerState.data = MergeState(PlayerState.data or {}, data)
    RebuildPartnerCaches(TabletData)
    SyncBirthReminder(TabletData)
    SendNUIMessage({ action = 'updateData', data = TabletData })
end)

RegisterNetEvent('grim_lovemenu:cl:notify', function(msg, ntype)
    Bridge.Notify(msg, ntype or 'primary')
    if tabletOpen then
        SendNUIMessage({ action = 'toast', message = msg, ntype = ntype or 'info' })
    end
end)

-- Direct NUI message relay - used to push feedback into the tablet
-- regardless of whether the caller knows tabletOpen state
RegisterNetEvent('grim_lovemenu:cl:nuiMsg', function(payload)
    if type(payload) == 'table' then
        SendNUIMessage(payload)
    end
end)

-- - PARTNERS -

RegisterNUICallback('getPartners', function(_, cb)
    local list = {}
    local seen = {}
    local myNetID = GetPlayerServerId(PlayerId())
    local nearbyPlayers = GetNearbyPlayers(25.0)

    local function addPartner(serverId, name, dist, registered)
        serverId = tonumber(serverId)
        if not serverId or serverId == myNetID or seen[serverId] then return end
        seen[serverId] = true
        list[#list + 1] = {
            serverId = serverId,
            name = (name and name ~= '' and name) or ('Player #' .. serverId),
            dist = math.floor(tonumber(dist) or 999),
            selected = (CurrentPartner == serverId),
            registered = registered == true,
        }
    end

    local registeredPartners = (TabletData and TabletData.registeredPartners) or (PlayerState.data and PlayerState.data.registeredPartners) or {}

    for _, p in ipairs(registeredPartners) do
        if p and p.online and p.serverId then
            local distance = 999
            for _, nearby in ipairs(nearbyPlayers) do
                if tonumber(nearby.serverId) == tonumber(p.serverId) then
                    distance = math.floor(tonumber(nearby.dist) or 0)
                    break
                end
            end
            addPartner(p.serverId, p.name, distance, true)
        end
    end

    for _, p in ipairs(nearbyPlayers) do
        local isRegistered = false
        for _, rp in ipairs(registeredPartners) do
            if rp and tonumber(rp.serverId) == tonumber(p.serverId) then
                isRegistered = true
                break
            end
        end
        addPartner(p.serverId, p.name, p.dist, isRegistered)
    end

    table.sort(list, function(a, b)
        local ar, br = a.registered and 0 or 1, b.registered and 0 or 1
        if ar ~= br then return ar < br end
        local ad = tonumber(a.dist or 9999)
        local bd = tonumber(b.dist or 9999)
        if ad == bd then return tostring(a.name or '') < tostring(b.name or '') end
        return ad < bd
    end)

    cb({ partners = list })
end)

RegisterNUICallback('selectPartner', function(data, cb)
    local sid = tonumber(data.serverId)
    if not sid then cb({ ok = false }) return end
    CurrentPartner = sid
    TriggerServerEvent('grim_lovemenu:sv:setSelectedPartner', sid)
    Bridge.Notify(Config.Strings.PartnerSelected:format(data.name or ('Player #' .. sid)), 'success')
    cb({ ok = true, serverId = sid })
end)

RegisterNUICallback('registerPartner', function(data, cb)
    local targetSID = tonumber(data.targetSID)
    if not targetSID then cb('ok') return end
    TriggerServerEvent('grim_lovemenu:sv:registerPartner', targetSID)
    cb('ok')
end)

RegisterNUICallback('requestUnregister', function(data, cb)
    local targetSID = data and data.targetSID or CurrentPartner
    TriggerServerEvent('grim_lovemenu:sv:requestUnregister', targetSID)
    cb('ok')
end)

-- - PARTNER REGISTER REQUEST (incoming) -

RegisterNetEvent('grim_lovemenu:cl:partnerRegRequest', function(requesterSID, requesterName)
    local accepted = false
    local deadline = GetGameTimer() + 20000

    CreateThread(function()
        while GetGameTimer() < deadline do
            Wait(50)
            local msg = ('- %s wants to register as your partner.\n~INPUT_FRONTEND_ACCEPT~ Accept  ~INPUT_FRONTEND_RRIGHT~ Decline'):format(requesterName)
            AddTextEntry('GRIM_PREG', msg)
            DisplayHelpTextThisFrame('GRIM_PREG', false)
            if IsControlJustReleased(0, 201) then accepted = true; break end
            if IsControlJustReleased(0, 194) then break end
        end
        if accepted then
            TriggerServerEvent('grim_lovemenu:sv:acceptPartnerReg', requesterSID)
        else
            TriggerServerEvent('grim_lovemenu:sv:declinePartnerReg', requesterSID)
        end
    end)
end)

-- - UNREGISTER REQUEST (incoming) -

RegisterNetEvent('grim_lovemenu:cl:unregRequest', function(requesterSID, requesterName, timeout)
    if tabletOpen then
        SendNUIMessage({ action = 'unregRequest', name = requesterName, requesterSID = requesterSID, timeout = timeout })
    else
        -- In-world prompt
        local accepted = false
        local deadline = GetGameTimer() + (timeout * 1000)
        CreateThread(function()
            while GetGameTimer() < deadline do
                Wait(50)
                local msg = ('- %s wants to end your connection.\n~INPUT_FRONTEND_ACCEPT~ Accept  ~INPUT_FRONTEND_RRIGHT~ Decline'):format(requesterName)
                AddTextEntry('GRIM_UNREG', msg)
                DisplayHelpTextThisFrame('GRIM_UNREG', false)
                if IsControlJustReleased(0, 201) then accepted = true; break end
                if IsControlJustReleased(0, 194) then break end
            end
            if accepted then
                TriggerServerEvent('grim_lovemenu:sv:acceptUnregister', requesterSID)
            else
                TriggerServerEvent('grim_lovemenu:sv:declineUnregister', requesterSID)
            end
        end)
    end
end)

RegisterNetEvent('grim_lovemenu:cl:unregTimeout', function()
    SendNUIMessage({ action = 'unregTimeout' })
end)

-- NUI accept/decline unregister
RegisterNUICallback('acceptUnregister', function(data, cb)
    TriggerServerEvent('grim_lovemenu:sv:acceptUnregister', tonumber(data.requesterSID))
    cb('ok')
end)

RegisterNUICallback('declineUnregister', function(data, cb)
    TriggerServerEvent('grim_lovemenu:sv:declineUnregister', tonumber(data.requesterSID))
    cb('ok')
end)

-- - ANIMATIONS -

RegisterNUICallback('getAnimList', function(_, cb)
    local list = {}
    for i, v in ipairs(Config.Animations) do
        local descInfo = Config.AnimDescriptions[v.label] or { desc='', solo=false }
        list[#list+1] = {
            id       = i,
            label    = v.label,
            category = v.category,
            car      = v.car,
            desc     = descInfo.desc,
            solo     = descInfo.solo,
        }
    end
    cb({ animations = list })
end)

RegisterNUICallback('startAnim', function(data, cb)
    CloseTabletInternal(true)
    Wait(300)
    if data.debug then
        PlayAnimDebug(tonumber(data.animId))
    else
        RequestAnimation(tonumber(data.animId), data.finishMode or 'finish')
    end
    cb('ok')
end)

RegisterNetEvent('grim_lovemenu:tablet:forceClose', function()
    CloseTabletInternal(true)
end)

-- - PREGNANCY -

RegisterNUICallback('usePregnancyTest',    function(_, cb) TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('PregnancyTest', 'pregnancy_test')); cb('ok') end)
RegisterNUICallback('usePrenatalVitamins', function(_, cb) TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('PrenatalVitamins', 'prenatal_vitamins')); cb('ok') end)
RegisterNUICallback('requestUltrasound',   function(_, cb) TriggerServerEvent('grim_lovemenu:sv:requestUltrasound');           cb('ok') end)
RegisterNUICallback('giveBirth',           function(_, cb) TriggerServerEvent('grim_lovemenu:sv:giveBirth');                   cb('ok') end)
RegisterNUICallback('usePlanC',            function(_, cb) TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('PlanC', 'plan_c')); cb('ok') end)

RegisterNetEvent('grim_lovemenu:cl:birthReady', function()
    if tabletOpen then
        SendNUIMessage({ action = 'toast', message = Config.Strings.BirthAlert, ntype = 'success' })
    end
end)

-- - PROTECTION -

RegisterNUICallback('useCondoms',         function(_, cb) TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('Condoms', 'condoms')); cb('ok') end)
RegisterNUICallback('useContraception',   function(_, cb) TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('Contraception', 'contraception')); cb('ok') end)

-- - STD -

RegisterNUICallback('useSTDTest',       function(_, cb) TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('STDTestKit', 'std_test_kit')); cb('ok') end)
RegisterNUICallback('usePrescription',  function(_, cb) TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('PrescriptionMeds', 'prescription_meds')); cb('ok') end)


-- - DNA -

RegisterNUICallback('useDNATest', function(data, cb)
    TriggerServerEvent('grim_lovemenu:sv:useDNATest', tonumber(data.targetSID))
    cb('ok')
end)

-- - PHARMACY -

RegisterNUICallback('buyPharmacyItem', function(data, cb)
    TriggerServerEvent('grim_lovemenu:sv:buyPharmacyItem', data.item, data.payment or 'cash')
    cb('ok')
end)

RegisterNUICallback('getPharmacyItems', function(_, cb)
    -- Wrap in object so JS always gets { items: [...] } - an empty Lua table
    -- serialises as {} not [] which breaks array checks in app.js
    cb({ items = Config.PharmacyItems or {} })
end)



-- - CHILD SUPPORT -

RegisterNUICallback('getChildSupportStatus', function(_, cb)
    TriggerServerEvent('grim_lovemenu:sv:getChildSupportStatus')
    cb('ok')
end)

RegisterNUICallback('claimChildSupport', function(data, cb)
    TriggerServerEvent('grim_lovemenu:sv:claimChildSupport', data and data.profileId)
    cb('ok')
end)

RegisterNetEvent('grim_lovemenu:cl:childSupportStatus', function(data)
    if type(data) == 'table' then
        TabletData = MergeState(TabletData, { childSupport = data })
        PlayerState.data = MergeState(PlayerState.data or {}, { childSupport = data })
        SendNUIMessage({ action = 'updateData', data = { childSupport = data } })
    end
end)

-- - COFFEE + BRO CODE APP -

RegisterNUICallback('getCoffeeAccess', function(_, cb)
    cb({ allowed = IsCoffeePedAllowed() })
end)

RegisterNUICallback('getCoffeeFeed', function(_, cb)
    if not IsCoffeePedAllowed() then
        cb({ ok = false, allowed = false, posts = {} })
        return
    end
    -- lib.callback.await yields - must run off the NUI callback thread
    CreateThread(function()
        local result = lib.callback.await('grim_lovemenu:sv:getCoffeeFeed', false)
        cb(result or { ok = true, allowed = true, posts = {} })
    end)
end)

RegisterNUICallback('createCoffeePost', function(data, cb)
    if not IsCoffeePedAllowed() then
        cb({ ok = false, allowed = false, error = 'Coffee is not available for this ped setup.' })
        return
    end
    CreateThread(function()
        local result = lib.callback.await('grim_lovemenu:sv:createCoffeePost', false, data or {})
        cb(result or { ok = false, error = 'Unable to post right now.' })
    end)
end)

RegisterNUICallback('createCoffeeComment', function(data, cb)
    if not IsCoffeePedAllowed() then
        cb({ ok = false, allowed = false, error = 'Coffee is not available for this ped setup.' })
        return
    end
    CreateThread(function()
        local result = lib.callback.await('grim_lovemenu:sv:createCoffeeComment', false, data or {})
        cb(result or { ok = false, error = 'Unable to comment right now.' })
    end)
end)

RegisterNUICallback('getBroCodeAccess', function(_, cb)
    cb({ allowed = IsBroCodePedAllowed() })
end)

RegisterNUICallback('getBroCodeFeed', function(_, cb)
    if not IsBroCodePedAllowed() then
        cb({ ok = false, allowed = false, posts = {} })
        return
    end
    CreateThread(function()
        local result = lib.callback.await('grim_lovemenu:sv:getBroCodeFeed', false)
        cb(result or { ok = true, allowed = true, posts = {} })
    end)
end)

RegisterNUICallback('createBroCodePost', function(data, cb)
    if not IsBroCodePedAllowed() then
        cb({ ok = false, allowed = false, error = 'Bro Code is not available for this ped setup.' })
        return
    end
    CreateThread(function()
        local result = lib.callback.await('grim_lovemenu:sv:createBroCodePost', false, data or {})
        cb(result or { ok = false, error = 'Unable to post right now.' })
    end)
end)

RegisterNUICallback('createBroCodeComment', function(data, cb)
    if not IsBroCodePedAllowed() then
        cb({ ok = false, allowed = false, error = 'Bro Code is not available for this ped setup.' })
        return
    end
    CreateThread(function()
        local result = lib.callback.await('grim_lovemenu:sv:createBroCodeComment', false, data or {})
        cb(result or { ok = false, error = 'Unable to comment right now.' })
    end)
end)

-- - THEME -

RegisterNUICallback('saveTheme', function(data, cb)
    -- Theme saved client-side via localStorage in JS; nothing server needs
    cb('ok')
end)

-- - DNA RESULT ITEM VIEW -

RegisterNetEvent('grim_lovemenu:cl:showDNAResult', function(data)
    -- Open tablet if not already open, route to DNA result view
    if not tabletOpen then
        tabletOpen = true
        tabletOpenToken = tabletOpenToken + 1
        TriggerServerEvent('grim_lovemenu:sv:getMyData')
        StartTabletPresentation()
        SetTabletFocusState(true)
        TriggerScreenblurFadeIn(180.0)
        SendNUIMessage({ action = 'openTablet' })
    end
    SetTimeout(450, function()
        SendNUIMessage({ action = 'showDNAResult', data = data })
    end)
end)

-- - BIRTH CERT ITEM VIEW -

RegisterNetEvent('grim_lovemenu:cl:showBirthCert', function(data)
    if not tabletOpen then
        tabletOpen = true
        tabletOpenToken = tabletOpenToken + 1
        TriggerServerEvent('grim_lovemenu:sv:getMyData')
        StartTabletPresentation()
        SetTabletFocusState(true)
        TriggerScreenblurFadeIn(180.0)
        SendNUIMessage({ action = 'openTablet' })
    end
    SetTimeout(450, function()
        SendNUIMessage({ action = 'showBirthCert', data = data })
    end)
end)

-- - ITEM USE - OPEN TABLET (for non-consumables routed through server hook) -

AddEventHandler(ItemEvent('DNAResult', 'dna_result'), function()
    TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('DNAResult', 'dna_result'))
end)

AddEventHandler(ItemEvent('BirthCertBoy', 'birth_cert_boy'), function()
    TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('BirthCertBoy', 'birth_cert_boy'))
end)

AddEventHandler(ItemEvent('BirthCertGirl', 'birth_cert_girl'), function()
    TriggerServerEvent('grim_lovemenu:sv:useItem', ItemName('BirthCertGirl', 'birth_cert_girl'))
end)

AddEventHandler(ItemEvent('UltrasoundReport', 'ultrasound_report'), function()
    -- Fetch stored scan data from server, then show scan modal
    TriggerServerEvent('grim_lovemenu:sv:viewUltrasound')
end)

RegisterNetEvent('grim_lovemenu:cl:showUltrasound', function(data)
    if not tabletOpen then
        tabletOpen = true
        tabletOpenToken = tabletOpenToken + 1
        TriggerServerEvent('grim_lovemenu:sv:getMyData')
        StartTabletPresentation()
        SetTabletFocusState(true)
        TriggerScreenblurFadeIn(180.0)
        SendNUIMessage({ action = 'openTablet' })
    end
    SetTimeout(450, function()
        SendNUIMessage({ action = 'showUltrasound', data = data })
    end)
end)


