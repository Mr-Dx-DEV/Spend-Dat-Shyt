-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not wsb then return print((Strings.no_wsb):format(GetCurrentResourceName())) end

IsPolice, EvidenceInHand, PreviousDriver, Gloves, Hands = false, {}, nil, nil, nil
local nearbyEvidence

QBCore = nil
if wsb.framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
end

-- Events

RegisterNetEvent('wasabi_bridge:onPlayerLoaded', function()
    while not wsb or (wsb and not wsb.playerLoaded) or (wsb and not wsb.playerData) do Wait(1000) end
    IsPolice = CheckJob()
end)


RegisterNetEvent('wasabi_bridge:setJob', function(job)
    if not job and job.name then return end
    IsPolice = CheckJob(job.name)
end)

RegisterNetEvent('wasabi_evidence:deleteEvidence', function(id)
    local alert = lib.alertDialog({
        header = Strings.delete_evidence_confirm,
        content = (Strings.delete_evidence_confirm_desc):format(id),
        centered = true,
        cancel = true
    })
    if alert == 'confirm' then
        if lib.callback.await('wasabi_evidence:deleteEvidence', false, id) then
            TriggerEvent('wasabi_bridge:notify', Strings.evidence_deleted, (Strings.evidence_deleted_desc):format(id), 'success')
        else
            TriggerEvent('wasabi_bridge:notify', Strings.error, (Strings.evidence_not_deleted_desc):format(id), 'error')
        end
    end
end)

RegisterNetEvent('wasabi_evidence:fingerprintVehicle', function()
    ScanForPrints()
end)

RegisterNetEvent('wasabi_evidence:cleanBloodSpot', function(net)
    local obj = NetToObj(net)
    if not DoesEntityExist(obj) then return end
    SetEntityAsMissionEntity(obj, true, true)
    DeleteObject(obj)
end)

RegisterNetEvent('wasabi_evidence:cl:setInteract', function(target)
    local player = GetPlayerFromServerId(target)
    local ped = GetPlayerPed(player)
    TaskTurnPedToFaceEntity(cache.ped, ped, 2000)
    Wait(2000)
    ClearPedTasks(cache.ped)
end)

AddEventHandler('wasabi_evidence:openEvidenceReport', function(data)
    if not IsPolice then return end
    OpenEvidenceReport(data, true)
end)

AddEventHandler('wasabi_evidence:analyzeEvidence', function()
    if not IsPolice then return end
    AnalyzeEvidence()
end)

AddEventHandler('wasabi_evidence:accessEvidenceHand', function(data)
    OpenEvidenceAnalyzed(data)
end)

AddEventHandler('wasabi_evidence:sendPrintsToDatabase', function(data)
    if not IsPolice then return end
    OpenAddToDatabase(data.closestPlayer, data.identifier)
end)

AddEventHandler('wasabi_evidence:openPrintHands', function(data)
    if not IsPolice then return end
    OpenEvidenceReport(data.evidence, false, data.data, true)
end)

AddEventHandler('wasabi_evidence:openEvidenceHand', function(data)
    if not IsPolice then return end
    OpenEvidenceReport(data.evidence, false, data.data)
end)

AddEventHandler('wasabi_evidence:accessEvidenceStorage', function()
    if not IsPolice then return end
    AccessEvidenceStorage()
end)

AddEventHandler('wasabi_evidence:fingerprintNearbyPlayer', function(data)
    if not IsPolice then return end
    local data = data
    if data and data?.noData then data = false end
    FingerprintNearbyPlayer(data)
end)

if wsb.framework == 'qb' then
    AddStateBagChangeHandler('isLoggedIn', '', function(_bagName, _key, value, _reserved, _replicated)
        if value then
            wsb.playerData = QBCore.Functions.GetPlayerData()
        end
        wsb.playerLoaded = value
    end)
end

CreateThread(function()
    while not wsb or (wsb and not wsb.playerLoaded) or (wsb and not wsb.playerData) do Wait(1000) end
    IsPolice = CheckJob()
end)


-- Main Thread
CreateThread(function()
    while not wsb?.playerData?.job do Wait(500) end
    local job, grade = wsb.getGroup()
    if Config.PoliceJobs[job] and grade >= Config.PoliceJobs[job] then IsPolice = true end
    if Config.Gloves.enabled then
        if Config.Gloves.hands then
            Hands = Config.Gloves.hands
        else
            Gloves = Config.Gloves.gloves
        end
    end
    -- Evidence creation thread
    CreateThread(function()
        while true do
            local sleep = 2000
            local ped = cache.ped
            local coords = GetEntityCoords(ped)
            if HasEntityBeenDamagedByAnyPed(ped) and not IsLastHitBlacklisted() then
                local street = GetLocationInfo(coords)
                AddBlood(coords, GetInteriorFromEntity(ped), street)
                ClearEntityLastDamageEntity(ped)
                if Config.BloodProps then SpawnBloodSplat(coords) end
            end
            local currentHand = GetPedDrawableVariation(ped, 3)
            local track = true
            if Hands then
                for i=1, #Hands do
                    if Hands[i] == currentHand then
                        track = true
                        break
                    else
                        track = false
                    end
                end
            elseif Gloves then
                for i=1, #Gloves do
                    if Gloves[i] == currentHand then
                        track = false
                        break
                    end
                end
            end
            if Config.BlacklistedWeapons[GetSelectedPedWeapon(ped)] then
                track = false
            end
            if IsPedArmed(ped, 4) then
                sleep = 0
                if IsPedShooting(ped) and track then
                    sleep = 500
                    local street = GetLocationInfo(coords)
                    AddBullet(GetWeaponType(GetSelectedPedWeapon(ped)), coords, GetInteriorFromEntity(ped), street)
                end
            end
            Wait(sleep)
        end
    end)
    -- Evidence Collection thread
    CreateThread(function()
        local sync = true
        local textUI
        while true do
            local sleep = 1500
            local ped = cache.ped
            local coords = GetEntityCoords(ped)
            local authorized = false
            if not Config.CriminalsCanCleanEvidence.enabled then
                authorized = IsPolice
            else
                authorized = true
            end
            if authorized and IsPlayerFreeAiming(cache.playerId) and cache.weapon == `WEAPON_FLASHLIGHT` then
                if sync then
                    nearbyEvidence = lib.callback.await('wasabi_evidence:getNearbyEvidence', false, coords, GetInteriorFromEntity(ped))
                    sync = false
                end
                if nearbyEvidence and #nearbyEvidence > 0 then
                    for k,v in pairs(nearbyEvidence) do
                        if v and v?.coords then
                            local dist = #(v.coords - coords)
                            if dist <= Config.FlashlightRange then
                                sleep = 0
                                if v.evidence == 'blood' then
                                    CreateEvidenceMarker(v.evidence, vec3(v.coords.x, v.coords.y, v.coords.z-0.75))
                                else
                                    sleep = 0
                                    CreateEvidenceMarker(v.evidence, vec3(v.coords.x, v.coords.y, v.coords.z-0.75))
                                end
                                if dist <= 1.0 then
                                    if not textUI then textUI = {} end
                                    if not textUI[k] then
                                        textUI[k] = true
                                        wsb.showTextUI(Strings.txtui_pickup_evidence)
                                    end
                                    if IsControlJustReleased(0,38) then
                                        PickupEvidence(nearbyEvidence[k])
                                        sleep = 2000
                                        wsb.hideTextUI()
                                        textUI = {}
                                        sync = true
                                    end
                                elseif dist >= 1.1 and textUI?[k] then
                                    wsb.hideTextUI()
                                    textUI = nil
                                end
                            elseif textUI?[k] then
                                textUI = nil
                                wsb.hideTextUI()
                            end
                        end
                    end
                end
            elseif authorized and not IsPlayerFreeAiming(cache.playerId) then
                if textUI then textUI = nil wsb.hideTextUI() end
                sync = true
            end
            Wait(sleep)
        end
    end)
    -- Evidence Labs Thread
    CreateThread(function()
        local textUI, points = nil, {}
        for k,v in pairs(Config.EvidenceLabs) do
            if v.analyze.target.enabled then
                local job = v.jobLock or {}
                local jobType = type(job)
                if jobType == 'boolean' then job = {} end
                if jobType ~= 'string' and #job < 1 then
                    for a,_ in pairs(Config.PoliceJobs) do
                        job[#job + 1] = a
                    end
                end
                wsb.target.boxZone(k..'_analyze', v.analyze.target.coords, v.analyze.target.width, v.analyze.target.length, {
                    debug = false,
                    heading = v.analyze.target.heading,
                    minZ = v.analyze.target.minZ,
                    maxZ = v.analyze.target.maxZ,
                    job = job,
                    distance = 2.0,
                    options = {
                        {
                            event = 'wasabi_evidence:analyzeEvidence',
                            icon = 'fa-solid fa-microscope',
                            label = v.analyze.target.label
                        }
                    }
                })
            end
            if v.fingerprinting.enabled and v.fingerprinting.target.enabled then
                local job = v.jobLock or {}
                local jobType = type(job)
                if jobType == 'boolean' then job = {} end
                if jobType ~= 'string' and #job < 1 then
                    for a,_ in pairs(Config.PoliceJobs) do
                        job[#job + 1] = a
                    end
                end
                wsb.target.boxZone(k..'_fingerprinting', v.fingerprinting.target.coords, v.fingerprinting.target.width, v.fingerprinting.target.length, {
                    debug = false,
                    heading = v.fingerprinting.target.heading,
                    minZ = v.fingerprinting.target.minZ,
                    maxZ = v.fingerprinting.target.maxZ,
                    job = job,
                    distance = 2.0,
                    options = {
                        {
                            event = 'wasabi_evidence:fingerprintNearbyPlayer',
                            icon = 'fa-solid fa-fingerprint',
                            label = v.fingerprinting.target.label,
                            noData = true,
                        }
                    }
                })
            end
            if v.storage.enabled and v.storage.target.enabled then
                local job = v.jobLock or {}
                if type(job) ~= 'string' and #job < 1 then
                    for a,_ in pairs(Config.PoliceJobs) do
                        job[#job + 1] = a
                    end
                end
                wsb.target.boxZone(k..'_storage', v.storage.target.coords, v.storage.target.width, v.storage.target.length, {
                    debug = false,
                    heading = v.storage.target.heading,
                    minZ = v.storage.target.minZ,
                    maxZ = v.storage.target.maxZ,
                    job = job,
                    distance = 2.0,
                    options = {
                        {
                            event = 'wasabi_evidence:accessEvidenceStorage',
                            icon = 'fa-solid fa-box-archive',
                            label = v.storage.target.label
                        }
                    }
                })
            end
            if not v.analyze.target.enabled then
                if not points[k] then points[k] = {} end
                points[k].analyze = lib.points.new({
                    coords = v.analyze.coords,
                    distance = v.analyze.range,
                    lab = k,
                    jobLock = v.jobLock
                })
            end
            if v.storage.enabled and not v.storage.target.enabled then
                points[k].storage = lib.points.new({
                    coords = v.storage.coords,
                    distance = v.storage.range,
                    lab = k
                }) 
            end
            if v.fingerprinting.enabled and not v.fingerprinting.target.enabled then
                points[k].fingerprinting = lib.points.new({
                    coords = v.fingerprinting.coords,
                    distance = v.fingerprinting.range,
                    lab = k
                })
            end
            for _,d in pairs(points) do
                function d.analyze:nearby()
                    if not self.isClosest then return end
                    local authorized
                    if Config.EvidenceLabs[self.lab].jobLock and wsb.hasGroup(Config.EvidenceLabs[self.lab].jobLock) then authorized = true elseif not Config.EvidenceLabs[self.lab].jobLock then authorized = true end

                    if authorized and IsPolice and self.currentDistance < self.distance then
                        if not textUI then
                            wsb.showTextUI(Config.EvidenceLabs[self.lab].analyze.label)
                            textUI = true
                        end
                        if IsControlJustReleased(0, 38) then
                            AnalyzeEvidence()
                        end
                    end
                end
                function d.analyze:onExit()
                    if not self.isClosest then return end
                    if textUI then
                        wsb.hideTextUI()
                        textUI = nil
                    end
                end

                function d.storage:nearby()
                    if not self.isClosest then return end
                    local authorized
                    if Config.EvidenceLabs[self.lab].jobLock and wsb.hasGroup(Config.EvidenceLabs[self.lab].jobLock) then authorized = true elseif not Config.EvidenceLabs[self.lab].jobLock then authorized = true end
                    if authorized and IsPolice and self.currentDistance < self.distance then
                        if not textUI then
                            wsb.showTextUI(Config.EvidenceLabs[self.lab].storage.label)
                            textUI = true
                        end
                        if IsControlJustReleased(0, 38) then
                            AccessEvidenceStorage()
                        end
                    end
                end
                function d.storage:onExit()
                    if not self.isClosest then return end
                    if textUI then
                        wsb.hideTextUI()
                        textUI = nil
                    end
                end

                function d.fingerprinting:nearby()
                    if not self.isClosest then return end
                    local authorized
                    if Config.EvidenceLabs[self.lab].jobLock and wsb.hasGroup(Config.EvidenceLabs[self.lab].jobLock) then authorized = true elseif not Config.EvidenceLabs[self.lab].jobLock then authorized = true end
                    if authorized and IsPolice and self.currentDistance < self.distance then
                        if not textUI then
                            wsb.showTextUI(Config.EvidenceLabs[self.lab].fingerprinting.label)
                            textUI = true
                        end
                        if IsControlJustReleased(0, 38) then
                            FingerprintNearbyPlayer()
                        end
                    end
                end
                function d.fingerprinting:onExit()
                    if not self.isClosest then return end
                    if textUI then
                        wsb.hideTextUI()
                        textUI = nil
                    end
                end

            end
        end
    end)
end)

lib.onCache('vehicle', function(vehicle)
    local track = true
    local currentHand = GetPedDrawableVariation(cache.ped, 3)
    if Hands then
        for i=1, #Hands do
            if Hands[i] == currentHand then
                track = true
                break
            end
        end
    elseif Gloves then
        for i=1, #Gloves do
            if Gloves[i] == currentHand then
                track = false
                break
            end
        end
    end
    if vehicle then
        PreviousDriver = lib.callback.await('wasabi_evidence:checkLastDriver', false, VehToNet(vehicle), (track or false))
    else
        PreviousDriver = nil
    end
end)
