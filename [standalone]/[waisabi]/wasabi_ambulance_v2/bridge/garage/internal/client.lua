local notify, config, bridge, vehicleKeys, listeners

local garage = {}

function garage.init()
    notify = Modules.require('notify')
    config = Modules.require('config')
    bridge = Modules.require('bridge')
    vehicleKeys = Modules.require('vehicleKeys')
    listeners = Modules.require('listeners')

    if not config.garages or config.garages.type ~= 'internal' then return end
end

local previewVehicleEntity, previousCoords = nil, nil

local vehicleMods = { engine = 11, brakes = 12, transmission = 13, suspension = 15, turbo = 18, armor = 16, spoiler = 0, frontBumper = 1, rearBumper = 2, sideSkirt = 3, exhaust = 4, frame = 5, grille = 6, hood = 7, fender = 8, rightFender = 9, roof = 10, horn = 14, plateHolder = 25, vanityPlates = 26, trimDesign = 27, ornaments = 28, dash = 29, dialDesign = 30, doorSpeakers = 31, seats = 32, steeringWheels = 33, shiftLeavers = 34, plaques = 35, speakers = 36, trunk = 37, hydraulics = 38, engineBlock = 39, airFilter = 40, strut = 41, archCover = 42, aerials = 43, trim = 44, tank = 45, headlights = 46 }

local function trimPlate(str)
    if not str then return nil end
    return (string.gsub(str, "^%s*(.-)%s*$", "%1"))
end

local function getVehicleSetterType(vehicle)
    if not DoesEntityExist(vehicle) then return false end
    local vehicleModel = GetEntityModel(vehicle)
    if not vehicleModel then return false end
    if IsThisModelAHeli(vehicleModel) then
        return 'heli'
    elseif IsThisModelAPlane(vehicleModel) then
        return 'plane'
    elseif IsThisModelABoat(vehicleModel) then
        return 'boat'
    elseif IsThisModelABike(vehicleModel) then
        return 'bike'
    else
        return 'automobile'
    end
end

local function getJobGarageData(garageType)
    local job, grade = bridge.getJob()
    if not job or not grade then return false, false, 0 end

    local jobData = config.garages.options[job]
    if not jobData then return false, false, 0 end

    local highestGrade = jobData.ranks[grade] and grade or false

    if not highestGrade then
        local previousGrade = false
        for rank, _ in pairs(jobData.ranks) do
            if not previousGrade then
                previousGrade = rank
                highestGrade = rank
            else
                if rank > previousGrade then
                    highestGrade = rank
                    previousGrade = rank
                end
            end
        end
        if not highestGrade then
            highestGrade = grade
        end
    end

    return jobData.ownedVehicles or false, jobData.ranks[highestGrade] and jobData.ranks[highestGrade][garageType] or false, jobData.recoveryCost or 0
end

local function getVehicleWheelColor(vehicle)
    if not DoesEntityExist(vehicle) then return end

    local pearlescent, wheelColor = GetVehicleExtraColours(vehicle)

    return wheelColor, pearlescent
end

local function getVehiclePaintData(vehicle)
    if not DoesEntityExist(vehicle) then return end

    local paint = {}
    local isPrimaryCustom = GetIsVehiclePrimaryColourCustom(vehicle)
    local isSecondaryCustom = GetIsVehicleSecondaryColourCustom(vehicle)

    if isPrimaryCustom then
        paint.primary = 9999
        if not paint.custom then paint.custom = {} end
        local r, g, b = GetVehicleCustomPrimaryColour(vehicle)
        paint.custom.primary = { r = r, g = g, b = b }
    else
        paint.primary, _ = GetVehicleColours(vehicle)
    end

    if isSecondaryCustom then
        paint.secondary = 9999
        if not paint.custom then paint.custom = {} end
        local r, g, b = GetVehicleCustomSecondaryColour(vehicle)
        paint.custom.secondary = { r = r, g = g, b = b }
    else
        _, paint.secondary = GetVehicleColours(vehicle)
    end

    paint.pearlescent, _ = GetVehicleExtraColours(vehicle)

    return paint
end

---@param vehicle number vehicle entity
---@return table|false Vehicle data or false if invalid. The returned table structure:
--@field model number Vehicle model hash
--@field name string Display name of the vehicle
--@field plate string License plate text
--@field health number Entity health (0-1000)
--@field fuel number Fuel level
-----
---- Performance mods (integer, -1 if stock):
--@field engine integer Engine upgrade level
--@field brakes integer Brake upgrade level
--@field transmission integer Transmission upgrade level
--@field suspension integer Suspension upgrade level
--@field armor integer Armor upgrade level
--@field turbo boolean Turbo installed
-----
---- Cosmetic mods (integer, -1 if stock):
--@field spoiler integer
--@field frontBumper integer
--@field rearBumper integer
--@field sideSkirt integer
--@field exhaust integer
--@field frame integer
--@field grille integer
--@field hood integer
--@field fender integer
--@field rightFender integer
--@field roof integer
--@field horn integer
--@field plateHolder integer
--@field vanityPlates integer
--@field trimDesign integer
--@field ornaments integer
--@field dash integer
--@field dialDesign integer
--@field doorSpeakers integer
--@field seats integer
--@field steeringWheels integer
--@field shiftLeavers integer
--@field plaques integer
--@field speakers integer
--@field trunk integer
--@field hydraulics integer
--@field engineBlock integer
--@field airFilter integer
--@field strut integer
--@field archCover integer
--@field aerials integer
--@field trim integer
--@field tank integer
--@field headlights integer
-----
--@field windowTint integer Window tint index
--@field livery integer Livery index (-1 if none)
--@field plateIndex integer License plate style index
-----
--@field wheels table Wheel data:
----  - custom (boolean): Custom wheels equipped
----  - type (integer): Wheel type index
----  - id (integer): Wheel mod index (-1 if stock)
----  - color (integer): Wheel color index
----  - pearlescent (integer): Pearlescent color index
----  - smokeColor (table): { r = integer, g = integer, b = integer }
----  - bulletproof (boolean): Bulletproof tires enabled
-----
--@field neon table Neon lights (keys: "left", "right", "front", "back"):
----  - [direction].enabled (boolean): Neon enabled for this side
----  - [direction].color (table): { r = integer, g = integer, b = integer }
-----
--@field xenon table Xenon headlights:
----  - enabled (boolean): Xenon mod installed
----  - color (integer|false): Xenon color index, or false if not enabled
-----
--@field paint table Paint data from getVehiclePaintData():
----  - primary (integer): Primary color index (9999 if custom RGB)
----  - secondary (integer): Secondary color index (9999 if custom RGB)
----  - pearlescent (integer): Pearlescent color index
----  - custom (table|nil): Only present if primary or secondary use custom RGB:
----    - primary (table|nil): { r = integer, g = integer, b = integer }
----    - secondary (table|nil): { r = integer, g = integer, b = integer }
local function getVehicleProperties(vehicle)
    if not vehicle or not DoesEntityExist(vehicle) then return false end

    local vehicleProperties = {
        model = GetEntityModel(vehicle),
        type = getVehicleSetterType(vehicle),
        name = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
        plate = GetVehicleNumberPlateText(vehicle),
        health = GetEntityHealth(vehicle),
        fuel = GetVehicleFuelLevel(vehicle)
    }

    -- iterate through possible mod types
    for part, modType in pairs(vehicleMods) do
        if modType == 18 then -- turbo
            vehicleProperties.turbo = IsToggleModOn(vehicle, modType)
        else
            vehicleProperties[part] = GetVehicleMod(vehicle, modType)
        end
    end

    vehicleProperties.wheels = {
        custom = GetVehicleModVariation(vehicle, 23),
        type = GetVehicleWheelType(vehicle),
        id = GetVehicleMod(vehicle, 23)
    }

    vehicleProperties.wheels.color, vehicleProperties.wheels.pearlescent = getVehicleWheelColor(vehicle)

    vehicleProperties.wheels.smokeColor = {}
    vehicleProperties.wheels.smokeColor.r, vehicleProperties.wheels.smokeColor.g, vehicleProperties.wheels.smokeColor.b =
        GetVehicleTyreSmokeColor(vehicle)
    vehicleProperties.wheels.bulletproof = not GetVehicleTyresCanBurst(vehicle)

    -- Window tint?
    vehicleProperties.windowTint = GetVehicleWindowTint(vehicle)

    -- Neon and it's respective color?
    vehicleProperties.neon = {}
    local direction = { [0] = "left", [1] = "right", [2] = "front", [3] = "back" }
    for i = 0, 3 do
        vehicleProperties.neon[direction[i]] = {}
        vehicleProperties.neon[direction[i]].enabled = IsVehicleNeonLightEnabled(vehicle, i) and true or false
        local color = {}
        color.r, color.g, color.b = GetVehicleNeonLightsColour(vehicle)
        vehicleProperties.neon[direction[i]].color = color
    end

    -- Xenon color?
    vehicleProperties.xenon = {}
    vehicleProperties.xenon.enabled = IsToggleModOn(vehicle, 22)
    if vehicleProperties.xenon.enabled then
        vehicleProperties.xenon.color = GetVehicleXenonLightsColour(vehicle)
    else
        vehicleProperties.xenon.color = false
    end

    -- Livery?
    vehicleProperties.livery = GetVehicleLivery(vehicle)

    -- Extras
    vehicleProperties.extras = {}
    for extraId = 0, 20 do
        vehicleProperties.extras[extraId] = IsVehicleExtraTurnedOn(vehicle, extraId) and true or false
    end

    -- Plate
    vehicleProperties.plateIndex = GetVehicleNumberPlateTextIndex(vehicle)

    -- Paint
    vehicleProperties.paint = getVehiclePaintData(vehicle)

    return vehicleProperties
end

local function setVehicleProperties(vehicle, vehicleData)
    if not DoesEntityExist(vehicle) then return end

    SetVehicleModKit(vehicle, 0)

    if not vehicleData or not next(vehicleData) then return end

    if vehicleData.plate or (vehicleData.data and vehicleData.data.plate) then -- If plate is provided, set the plate
        if type(vehicleData.plate) == 'string' then
            vehicleData.plate = trimPlate(vehicleData.plate or (vehicleData.data and vehicleData.data.plate))
        end

        SetVehicleNumberPlateText(vehicle, vehicleData.plate or (vehicleData.data and vehicleData.data.plate))
    end

    if vehicleData and vehicleData.data then
        vehicleData = vehicleData.data
    end

    SetVehicleLivery(vehicle, vehicleData.livery)

    if vehicleData.extras and vehicleData.type and vehicleData.type ~= 'heli' then
        for extraId, enabled in pairs(vehicleData.extras) do
            SetVehicleExtra(vehicle, extraId, enabled and true or false)
        end
    end

    if vehicleData.paint then
        if vehicleData.paint.primary == 9999 then
            SetVehicleCustomPrimaryColour(vehicle, vehicleData.paint.custom.primary.r, vehicleData.paint.custom.primary.g, vehicleData.paint.custom.primary.b)
        else
            if vehicleData.paint.secondary == 9999 then
                if GetIsVehiclePrimaryColourCustom(vehicle) then
                    ClearVehicleCustomPrimaryColour(vehicle)
                end
                SetVehicleColours(vehicle, vehicleData.paint.primary, 1)
                SetVehicleCustomSecondaryColour(vehicle, vehicleData.paint.custom.secondary.r, vehicleData.paint.custom.secondary.g, vehicleData.paint.custom.secondary.b)
            else
                if GetIsVehiclePrimaryColourCustom(vehicle) then
                    ClearVehicleCustomPrimaryColour(vehicle)
                end
                if GetIsVehicleSecondaryColourCustom(vehicle) then
                    ClearVehicleCustomSecondaryColour(vehicle)
                end
                SetVehicleColours(vehicle, vehicleData.paint.primary, vehicleData.paint.secondary)
            end
        end

        if vehicleData.paint.secondary == 9999 then
            SetVehicleCustomSecondaryColour(vehicle, vehicleData.paint.custom.secondary.r, vehicleData.paint.custom.secondary.g, vehicleData.paint.custom.secondary.b)
        else
            if vehicleData.paint.primary == 9999 then
                if GetIsVehicleSecondaryColourCustom(vehicle) then
                    ClearVehicleCustomSecondaryColour(vehicle)
                end
                SetVehicleColours(vehicle, 1, vehicleData.paint.secondary)
                SetVehicleCustomPrimaryColour(vehicle, vehicleData.paint.custom.primary.r, vehicleData.paint.custom.primary.g, vehicleData.paint.custom.primary.b)
            else
                if GetIsVehiclePrimaryColourCustom(vehicle) then
                    ClearVehicleCustomPrimaryColour(vehicle)
                end
                if GetIsVehicleSecondaryColourCustom(vehicle) then
                    ClearVehicleCustomSecondaryColour(vehicle)
                end
                SetVehicleColours(vehicle, vehicleData.paint.primary, vehicleData.paint.secondary)
            end
        end
    end

    if vehicleData.wheels then
        if vehicleData.wheels.type then
            SetVehicleWheelType(vehicle, vehicleData.wheels.type)
            SetVehicleMod(vehicle, 23, vehicleData.wheels.id, vehicleData.wheels.custom)
        end

        SetVehicleExtraColours(vehicle, vehicleData.wheels.color, vehicleData.wheels.pearlescent)
        SetVehicleTyresCanBurst(vehicle, not vehicleData.wheels.bulletproof and true or false)
        SetVehicleTyreSmokeColor(vehicle, vehicleData.wheels.smokeColor.r or 255, vehicleData.wheels.smokeColor.g or 255, vehicleData.wheels.smokeColor.b or 255)
    end

    if vehicleData.windowTint == -1 then
        SetVehicleWindowTint(vehicle, 0)
    else
        SetVehicleWindowTint(vehicle, vehicleData.windowTint)
    end

    if vehicleData.xenon then
        ToggleVehicleMod(vehicle, 22, vehicleData.xenon.enabled and true or false)

        if vehicleData.xenon.enabled and vehicleData.xenon.color then
            SetVehicleXenonLightsColour(vehicle, vehicleData.xenon.color)
        end
    end

    if vehicleData.neon then
        local directionLegend = { left = 0, right = 1, front = 2, back = 3 }
        if type(vehicleData.neon) == 'table' then
            for direction, neonData in pairs(vehicleData.neon) do
                if neonData.enabled then
                    SetVehicleNeonLightEnabled(vehicle, directionLegend[direction], true)
                    SetVehicleNeonLightsColour(vehicle, neonData.color.r, neonData.color.g, neonData.color.b)
                else
                    SetVehicleNeonLightEnabled(vehicle, directionLegend[direction], false)
                end
            end
        end
    end

    for modification, value in pairs(vehicleData) do
        if type(value) == 'number' and value and vehicleMods[modification] then
            if modification == 'turbo' then
                ToggleVehicleMod(vehicle, 18, value and true or false)
            elseif modification ~= 'fuel' then
                SetVehicleMod(vehicle, vehicleMods[modification], value, false)
            end
        end
    end
end

local function spawnVehicle(vehicleData, garageData)
    DoScreenFadeOut(800)
    while not IsScreenFadedOut() do
        Wait(0)
    end

    local spawnedVehicle = nil

    if not IsModelInCdimage(vehicleData.model or (vehicleData.data and vehicleData.data.model)) then
        DoScreenFadeIn(800)
        notify({
            title = locale('garage_title'),
            description = locale('garage_model_not_found', vehicleData.model or (vehicleData.data and vehicleData.data.model)),
            type = 'error'
        })
        return
    end

    lib.requestModel(vehicleData.model or (vehicleData.data and vehicleData.data.model), 5000)

    local netId = lib.callback.await('wasabi_ambulance:Garage:SpawnVehicle', false, vehicleData.model or (vehicleData.data and vehicleData.data.model), vector3(garageData.coords.x, garageData.coords.y, garageData.coords.z), garageData.coords.w, vehicleData.type or vehicleData.data and vehicleData.data.type or 'automobile')
    if not netId then
        DoScreenFadeIn(800)
        notify({
            title = locale('garage_title'),
            description = locale('garage_spawn_failed'),
            type = 'error'
        })
        return
    end
    Wait(1000)
    spawnedVehicle = NetworkGetEntityFromNetworkId(netId)
    local retries = 0
    while not spawnedVehicle and retries < 100 do
        Wait(100)
        spawnedVehicle = NetworkGetEntityFromNetworkId(netId)
        retries = retries + 1
    end
    if not spawnedVehicle then
        DoScreenFadeIn(800)
        notify({
            title = locale('garage_title'),
            description = locale('garage_spawn_failed'),
            type = 'error'
        })
        return
    end

    SetEntityInvincible(spawnedVehicle, true)
    FreezeEntityPosition(spawnedVehicle, true)
    SetEntityCollision(spawnedVehicle, false, true)
    SetVehicleDoorsLocked(spawnedVehicle, 9)
    SetVehicleOnGroundProperly(spawnedVehicle)
    if vehicleData.health or (vehicleData.data and vehicleData.data.health) then
        SetEntityHealth(spawnedVehicle, vehicleData.health or (vehicleData.data and vehicleData.data.health))
    end
    if vehicleData.fuel or (vehicleData.data and vehicleData.data.fuel) then
        SetVehicleFuelLevel(spawnedVehicle, vehicleData.fuel or (vehicleData.data and vehicleData.data.fuel))
    end

    setVehicleProperties(spawnedVehicle, vehicleData)
    TaskWarpPedIntoVehicle(cache.ped, spawnedVehicle, -1)

    DoScreenFadeIn(800)

    return spawnedVehicle
end

local function previewVehicleMenu(vehicleData, garageData, purchasing, price)
    local options = {}

    local function cancelPreview(withdrawn)
        local vehicle = previewVehicleEntity
        previewVehicleEntity = nil

        if not withdrawn then
            DoScreenFadeOut(800)
            while not IsScreenFadedOut() do
                Wait(0)
            end
        end

        if vehicle and DoesEntityExist(vehicle) then
            if withdrawn then
                SetEntityInvincible(vehicle, false)
                FreezeEntityPosition(vehicle, false)
                SetEntityCollision(vehicle, true, true)
                SetVehicleDoorsLocked(vehicle, 0)
                if vehicleKeys then
                    vehicleKeys.addKey(trimPlate(vehicleData.plate), vehicleData.model, vehicle)
                end
                return
            end

            DeleteEntity(vehicle)
        end

        if previousCoords then
            listeners.AntiCheatState(true)
            SetEntityCoords(cache.ped, previousCoords.x, previousCoords.y, previousCoords.z, false, false, false, false)
            SetEntityHeading(cache.ped, previousCoords.w)
            listeners.AntiCheatState(false)
            previousCoords = nil
        end

        DoScreenFadeIn(800)
        while not IsScreenFadedIn() do
            Wait(0)
        end

        garage.openGarage(garageData.coords, garageData.groups, garageData.type)
    end

    if not purchasing then
        options = {
            {
                title = locale('garage_menu_stored_cancel_title') or 'Cancel',
                description = locale('garage_menu_stored_cancel_desc') or 'Cancel the withdrawal and go back',
                icon = 'arrow-left',
                onSelect = function()
                    cancelPreview()
                end
            },
            {
                title = locale('garage_menu_stored_confirm_title') or 'Confirm',
                description = locale('garage_menu_stored_confirm_desc') or 'Confirm the withdrawal of the vehicle',
                icon = 'car',
                onSelect = function()
                    local result = lib.callback.await('wasabi_ambulance:Garage:WithdrawVehicle', false, vehicleData.plate or (vehicleData.data and vehicleData.data.plate), garageData.type)
                    if not result then
                        notify({
                            title = locale('garage_title'),
                            description = locale('garage_withdraw_failed'),
                            type = 'error'
                        })
                        cancelPreview()
                        return
                    end
                    notify({
                        title = locale('garage_title'),
                        description = locale('garage_withdraw_success'),
                        type = 'success'
                    })
                    cancelPreview(true)
                end
            }
        }
    else
        options = {
            {
                title = locale('garage_menu_purchase_cancel_title') or 'Cancel',
                description = locale('garage_menu_purchase_cancel_desc') or 'Cancel the purchase and go back',
                icon = 'arrow-left',
                onSelect = function()
                    cancelPreview()
                end
            },
            {
                title = locale('garage_menu_purchase_confirm_title') or 'Confirm',
                description = price and (locale('garage_menu_purchase_confirm_desc') or 'Confirm the purchase of the vehicle') .. ' - ' .. (locale('garage_menu_purchase_price') or 'Price: ') .. price or (locale('garage_menu_collect_confirm_desc') or 'Confirm the collection of the vehicle'),
                icon = 'circle-check',
                onSelect = function()
                    local vehicleProperties = getVehicleProperties(cache.vehicle)
                    if not vehicleProperties then
                        notify({
                            title = locale('garage_title'),
                            description = locale('garage_purchase_failed'),
                            type = 'error'
                        })
                        return
                    end
                    local result = lib.callback.await('wasabi_ambulance:Garage:PurchaseVehicle', false, vehicleProperties, price, garageData.type)
                    if result and result == 'no_funds' then
                        notify({
                            title = locale('garage_title'),
                            description = locale('garage_purchase_no_funds'),
                            type = 'error'
                        })
                        return
                    elseif result then
                        SetVehicleNumberPlateText(cache.vehicle, result)
                        notify({
                            title = locale('garage_title'),
                            description = locale('garage_purchase_success'),
                            type = 'success'
                        })
                        cancelPreview(true)
                        vehicleKeys.addKey(result, vehicleData.model, cache.vehicle)
                    end
                end
            }
        }
    end

    local title = nil
    if purchasing then
        title = (locale('garage_purchase_menu_title') .. ': ' .. vehicleData.label) or ('Purchasing: ' .. vehicleData.label)
    else
        local plate = trimPlate(vehicleData.plate)
        title = (locale('garage_preview_menu_title') .. ': ' .. plate) or ('Previewing: ' .. plate)
    end

    lib.registerContext({
        id = 'wasabi_garage_preview_menu',
        title = title,
        options = options,
        onExit = function()
            cancelPreview()
        end
    })

    lib.showContext('wasabi_garage_preview_menu')
end

local function openVehicleRecoveryMenu(plate, garageData)
    plate = trimPlate(plate)

    local options = {
        {
            title = locale('garage_menu_recovery_cancel_title') or 'Cancel',
            description = locale('garage_menu_recovery_cancel_desc') or 'Cancel and go back to the garage',
            icon = 'arrow-left',
            onSelect = function()
                garage.openGarage(garageData.coords, garageData.groups, garageData.type)
            end
        },
        {
            title = locale('garage_menu_recovery_confirm_title') or 'Recover Vehicle',
            description = locale('garage_menu_recovery_confirm_desc') or 'Recover the vehicle back to the garage. If the vehicle is found on the map, it will be deleted.',
            icon = 'rotate',
            onSelect = function()
                local result = lib.callback.await('wasabi_ambulance:Garage:RecoverVehicle', false, plate, garageData.type, garageData.recoveryCost)
                if not result then
                    notify({
                        title = locale('garage_title'),
                        description = locale('garage_recovery_failed') or 'Failed to recover the vehicle',
                        type = 'error'
                    })
                    garage.openGarage(garageData.coords, garageData.groups, garageData.type)
                    return
                elseif result == 'no_funds' then
                    notify({
                        title = locale('garage_title'),
                        description = locale('garage_recovery_no_funds') or 'You do not have enough funds to recover the vehicle',
                        type = 'error'
                    })
                    garage.openGarage(garageData.coords, garageData.groups, garageData.type)
                    return
                end
                notify({
                    title = locale('garage_title'),
                    description = locale('garage_recovery_success') or 'Vehicle has been recovered to the garage',
                    type = 'success'
                })
                garage.openGarage(garageData.coords, garageData.groups, garageData.type)
            end
        }
    }

    lib.registerContext({
        id = 'wasabi_garage_recovery_menu',
        title = (locale('garage_recovery_menu_title') or 'Recover Vehicle') .. ': ' .. plate,
        options = options
    })

    lib.showContext('wasabi_garage_recovery_menu')
end

---@param vehicleData table table containing the vehicle data
---@param garageData table table containing the garage data
---@param purchasing boolean | nil boolean indicating if the vehicle is being purchased or not
---@param price number | nil price of the vehicle if being purchased (nil if not purchasing or free)
local function previewVehicle(vehicleData, garageData, purchasing, price)
    if not vehicleData or not garageData then return end

    local function previewVehicleLoop()
        CreateThread(function()
            while previewVehicleEntity do
                if not DoesEntityExist(previewVehicleEntity) then
                    previewVehicleEntity = spawnVehicle(vehicleData, garageData)
                    previewVehicleLoop()
                    break
                end
                -- Prevent player from exiting the preview vehicle
                if cache.vehicle ~= previewVehicleEntity then
                    TaskWarpPedIntoVehicle(cache.ped, previewVehicleEntity, -1)
                    Wait(1000)
                end

                if GetVehicleDoorLockStatus(previewVehicleEntity) ~= 9 then
                    SetVehicleDoorsLocked(previewVehicleEntity, 9)
                end

                -- Block the F key (exit vehicle attempt)
                DisableControlAction(0, 75, true)  -- 75 is the F key (Exit Vehicle)
                DisableControlAction(27, 75, true) -- also block on alternative input group

                Wait(0)
            end
        end)
    end

    if previewVehicleEntity then
        if DoesEntityExist(previewVehicleEntity) then
            DeleteEntity(previewVehicleEntity)
        end
        previewVehicleEntity = nil
    end

    if not purchasing and not vehicleData.stored then
        openVehicleRecoveryMenu(vehicleData.plate or (vehicleData.data and vehicleData.data.plate), garageData)
        return
    end

    local playerCoords = GetEntityCoords(cache.ped)
    previousCoords = vec4(playerCoords.x, playerCoords.y, playerCoords.z, GetEntityHeading(cache.ped))
    previewVehicleEntity = spawnVehicle(vehicleData, garageData)
    previewVehicleMenu(vehicleData, garageData, purchasing, price)
    previewVehicleLoop()
end

local function openStoredVehiclesMenu(storedVehicles, garageData)
    -- TODO: check storedVehicles field and see whats going on for setting stored status, because allowing multiple vehicles to be withdrawn with same plate
    local options = {
        {
            title = locale('menu_go_back_title') or 'Go Back',
            description = locale('menu_go_back_description') or 'Go back to the previous menu',
            icon = 'arrow-left',
            onSelect = function()
                garage.openGarage(garageData.coords, garageData.groups, garageData.type)
            end
        }
    }
    if not storedVehicles then
        options[#options + 1] = {
            title = locale('garage_menu_no_stored_vehicles_title') or 'No Stored Vehicles',
            description = locale('garage_menu_no_stored_vehicles_description') or 'No stored vehicles found',
            icon = 'circle-xmark',
            disabled = true
        }
    else
        for plate, vehicleData in pairs(storedVehicles) do
            options[#options + 1] = {
                title = (locale('garage_menu_plate_title') or 'Plate') .. ': ' .. plate,
                description = vehicleData and vehicleData.stored and (locale('garage_menu_stored_vehicles_description') or 'Status: Stored - Select to preview the vehicle') or (locale('garage_menu_recovery_description') or 'Status: Not Found - Recover the vehicle back to the garage.'),
                icon = vehicleData and vehicleData.stored and 'warehouse' or 'truck-fast',
                onSelect = function()
                    vehicleData.plate = plate
                    if vehicleData.stored then
                        previewVehicle(vehicleData, garageData, false, nil)
                    else
                        openVehicleRecoveryMenu(plate, garageData)
                    end
                end
            }
        end
    end
    lib.registerContext({
        id = 'wasabi_garage_stored_vehicles_menu',
        title = locale('garage_menu_stored_vehicles_title') or 'Stored Vehicles',
        options = options
    })
    lib.showContext('wasabi_garage_stored_vehicles_menu')
end

local function openAvailableVehiclesMenu(vehicleOptions, garageData, ownedVehicles)
    local menuIcon = garageData.type == 'helicopters' and 'helicopter' or 'car'
    local options = {
        {
            title = locale('menu_go_back_title') or 'Go Back',
            description = locale('menu_go_back_description') or 'Go back to the previous menu',
            icon = 'arrow-left',
            onSelect = function()
                garage.openGarage(garageData.coords, garageData.groups, garageData.type)
            end
        }
    }

    local title = garageData.type == 'helicopters' and (locale('garage_available_helicopters_title') or 'Available Helicopters') or (locale('garage_available_vehicles_title') or 'Available Vehicles')

    for model, data in pairs(vehicleOptions) do
        options[#options + 1] = {
            title = data.label,
            description = data.price and (locale('garage_available_vehicles_price') or 'Price: ') .. data.price .. ' - ' .. (locale('garage_available_vehicles_description') or 'Select to preview the vehicle') or (locale('garage_available_vehicles_description') or 'Select to preview the vehicle'),
            icon = menuIcon,
            onSelect = function()
                previewVehicle({
                    model = model,
                    label = data.label,
                    price = data.price,
                    type = data.type or 'automobile',
                    paint = data.paint or false,
                    livery = data.livery or false,
                    extras = data.extras or false,
                }, garageData, true, data.price)
            end
        }
    end

    lib.registerContext({
        id = 'wasabi_garage_available_vehicles_menu',
        title = title,
        options = options
    })
    lib.showContext('wasabi_garage_available_vehicles_menu')
end

local function storeVehicle(ownedVehicles, type)
    local vehicle = cache.vehicle
    if not vehicle then return end

    if not ownedVehicles then
        DeleteEntity(vehicle)
        return true
    end

    local vehicleData = getVehicleProperties(vehicle)
    if not vehicleData then return false end

    local success = lib.callback.await('wasabi_ambulance:Garage:StoreVehicle', false, vehicleData.plate or (vehicleData.data and vehicleData.data.plate), vehicleData, type)
    if not success then
        notify({
            title = locale('garage_title'),
            description = locale('garage_store_failed'),
            type = 'error'
        })
        return false
    end

    notify({
        title = locale('garage_title'),
        description = locale('garage_store_success'),
        type = 'success'
    })

    DeleteEntity(vehicle)
    return true
end

function garage.openGarage(coords, groups, type)
    if not config.garages.enabled then
        notify({
            title = locale('garage_title'),
            description = locale('garage_disabled'),
            type = 'error'
        })
        return
    end

    local player = bridge.player
    if not player.loaded then return end

    if not bridge.hasGroup(groups) then
        notify({
            title = locale('garage_title'),
            description = locale('garage_no_access'),
            type = 'error'
        })
        return
    end

    -- Check if player is on duty
    if config.garages.requireDuty and not bridge.getDuty() then
        notify({
            title = locale("garage_title"),
            description = locale("garage_must_be_on_duty"),
            type = "error"
        })
        return
    end

    -- Check if player's job has respective garage configuration
    local ownedVehicles, vehicleOptions, recoveryCost = getJobGarageData(type)
    if not vehicleOptions then
        notify({
            title = locale("garage_title"),
            description = locale("garage_no_access"),
            type = "error"
        })
        return
    elseif not next(vehicleOptions) then
        if type == 'vehicles' then
            notify({
                title = locale("garage_title"),
                description = locale("garage_no_vehicles"),
                type = "error"
            })
            return
        elseif type == 'helicopters' then
            notify({
                title = locale("garage_title"),
                description = locale("garage_no_helicopters"),
                type = "error"
            })
            return
        end
    end

    -- Open garage menu
    local options = {
        {
            title = locale('garage_menu_store_title') or 'Store Vehicle',
            description = cache.vehicle and (locale('garage_menu_store_description') or 'Store the current vehicle in the garage') or (locale('garage_menu_store_description_disabled') or 'Enter a vehicle to store'),
            icon = 'warehouse',
            disabled = not cache.vehicle,
            onSelect = function()
                storeVehicle(ownedVehicles, type)
            end
        },
        {
            title = locale('garage_menu_retrieve_title') or 'New Vehicle Request',
            description = locale('garage_menu_retrieve_description') or 'Request a new vehicle from the garage',
            icon = 'circle-plus',
            onSelect = function()
                openAvailableVehiclesMenu(vehicleOptions, { coords = coords, groups = groups, type = type, recoveryCost = recoveryCost }, ownedVehicles)
            end
        }
    }

    if ownedVehicles then
        local storedVehicles = lib.callback.await('wasabi_ambulance:Garage:GetStoredVehicles', false, type)
        if storedVehicles then
            options[#options + 1] = {
                title = locale('garage_menu_stored_vehicles_title') or 'Stored Vehicles',
                description = locale('garage_menu_stored_vehicles_description') or 'View your stored vehicles',
                icon = 'warehouse',
                onSelect = function()
                    openStoredVehiclesMenu(storedVehicles, { coords = coords, groups = groups, type = type, recoveryCost = recoveryCost })
                end
            }
        end
    end

    lib.registerContext({
        id = 'wasabi_garage_menu',
        title = locale("garage_menu_title"),
        options = options
    })

    lib.showContext('wasabi_garage_menu')
end

Modules.register('garage', garage, {
    dependencies = { 'notify', 'config', 'bridge', 'vehicleKeys', 'listeners' }
})
