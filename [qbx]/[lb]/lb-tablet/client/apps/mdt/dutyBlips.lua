---<b>Key:</b> source
---@type { [number]: { blip: number, hasJob: (fun(): boolean), ped?: number }? }
local gameBlips = {}

local function RemoveAllBlips()
    for source, blip in pairs(gameBlips) do
        RemoveBlip(blip.blip)

        gameBlips[source] = nil
    end
end

---@param employees StrippedEmployee[]
---@param hasJob fun(): boolean
local function RefreshDutyBlips(employees, hasJob)
    if not Config.DutyBlips.Options or not Config.DutyBlips.Options.Show then
        return
    end

    if Config.DutyBlips.RequireItem and not HasTabletItem() then
        RemoveAllBlips()
        return
    end

    local sourcesToKeep = {}

    for i = 1, #employees do
        local employee = employees[i]
        local player = GetPlayerFromServerId(employee.source)
        ---@type number?
        local ped = player ~= -1 and GetPlayerPed(player) or nil
        local oldBlip = gameBlips[employee.source]
        local blip = oldBlip and oldBlip.blip

        if ped and ped ~= 0 and DoesEntityExist(ped) then
            if oldBlip and oldBlip.ped ~= ped then
                RemoveBlip(oldBlip.blip)

                oldBlip = nil
            end

            if not oldBlip then
                blip = AddBlipForEntity(ped)
            end
        else
            ped = nil

            if oldBlip and oldBlip.ped then
                RemoveBlip(oldBlip.blip)

                oldBlip = nil
            end

            if oldBlip then
                SetBlipCoords(oldBlip.blip, employee.coords.x, employee.coords.y, 0.0)
            else
                blip = AddBlipForCoord(employee.coords.x, employee.coords.y, 0.0)
            end
        end

        if not blip then
            goto continue
        end

        if Config.DutyBlips.Options.Category then
            SetBlipCategory(blip, Config.DutyBlips.Options.Category)
        end

        local sprite = Config.DutyBlips.Options.Sprite or 1

        if employee.vehicle and Config.DutyBlips.Options.VehicleTypes and Config.DutyBlips.Options.VehicleTypes[employee.vehicle] then
            sprite = Config.DutyBlips.Options.VehicleTypes[employee.vehicle]
        end

        SetBlipSprite(blip, sprite)
        SetBlipColour(blip, Config.DutyBlips.Options.Color or 0)
        SetBlipScale(blip, Config.DutyBlips.Options.Scale or 0.9)
        SetBlipAsShortRange(blip, Config.DutyBlips.Options.ShortRange == true)
        DisplayPlayerNameTagsOnBlips(true)
        ShowHeightOnBlip(blip, false)

        if Config.DutyBlips.Options.FriendIndicator then
            ShowFriendIndicatorOnBlip(blip, true)
        end

        if Config.DutyBlips.Options.Outline then
            ShowOutlineIndicatorOnBlip(blip, true)

            if Config.DutyBlips.Options.OutlineColor then
                local r, g, b = table.unpack(Config.DutyBlips.Options.OutlineColor)

                SetBlipSecondaryColour(blip, r or 93, g or 182, b or 229)
            end
        end

        if Config.DutyBlips.Options.ShowHeading then
            SetBlipRotation(blip, math.floor(employee.heading))
            ShowHeadingIndicatorOnBlip(blip, true)
        end

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(
            FormatString(Config.DutyBlips.Options.Name, {
                name = employee.name,
                callsign = employee.callsign
            })
        )
        EndTextCommandSetBlipName(blip)

        sourcesToKeep[employee.source] = true
        gameBlips[employee.source] = {
            blip = blip,
            hasJob = hasJob,
            ped = ped
        }

        ::continue::
    end

    for source, blip in pairs(gameBlips) do
        if not sourcesToKeep[source] or not blip.hasJob() then
            RemoveBlip(blip.blip)

            gameBlips[source] = nil
        end
    end
end

---@param employee? RawEmployee
---@return StrippedEmployee | nil
local function FormatEmployee(employee)
    if not employee then
        debugprint("FormatEmployee: employee is nil")
        return
    end

    ---@type StrippedEmployee
    return {
        source = employee[1],
        name = employee[2],
        callsign = employee[3],
        avatar = employee[4],
        coords = vector2(employee[5][1], employee[5][2]),
        heading = employee[6],
        vehicle = employee[7],
        unit = employee[8],
        visible = employee[9]
    }
end

if Config.DutyBlips.Options and Config.DutyBlips.Options.Show then
    AddEventHandler("lb-tablet:jobUpdated", function()
        for source, blip in pairs(gameBlips) do
            if not blip.hasJob() then
                RemoveBlip(blip.blip)

                gameBlips[source] = nil
            end
        end
    end)
end

---@param mdtName string
---@param employeeBlips RawEmployee[]
RegisterNetEvent("tablet:mdt:updateEmployeeBlips", function(mdtName, employeeBlips)
    local mdt = MDTs[mdtName]

    if not mdt then
        debugprint("invalid mdt, or duty blips are disabled", mdtName)
        return
    end

    if not mdt.defaultPermissions[GetJob()] then
        debugprint("Received employee blips for MDT", mdtName, "but player does not have access")
        return
    end

    ---@type { source: number, name: string, unit?: string, callsign?: string, avatar?: string }[]
    local allEmployeesList = {}
    local formattedEmployees = {}
    local playerSource = GetPlayerServerId(PlayerId())

    for i = 1, #employeeBlips do
        local employee = FormatEmployee(employeeBlips[i])

        if employee and mdt.options.dutyBlips and employee.visible and employee.source ~= playerSource then
            formattedEmployees[#formattedEmployees+1] = employee
        end

        if employee then
            allEmployeesList[#allEmployeesList+1] = {
                source = employee.source,
                name = employee.name,
                unit = employee.unit,
                callsign = employee.callsign,
                avatar = employee.avatar
            }
        end
    end

    SendNUIAction(mdtName .. ":updateEmployees", allEmployeesList)

    if mdt.options.dutyBlips then
        SendNUIAction(mdtName .. ":updateEmployeeBlips", formattedEmployees)
        RefreshDutyBlips(formattedEmployees, function()
            return IsEmployeeOfMDT(mdtName)
        end)
    end
end)
