---@class RawEmployee
---@field [1] number Source
---@field [2] string Character name
---@field [3] string? Callsign
---@field [4] string? Avatar
---@field [5] [number, number] Coords as array of x, y
---@field [6] number Heading
---@field [7] string Vehicle type, or
---@field [8] string? Unit, or nil if no unit
---@field [9] boolean Whether their blip should be visible

---@class StrippedEmployee
---@field source number
---@field name string
---@field callsign? string
---@field avatar? string
---@field coords? vector3 | vector2
---@field heading? number
---@field vehicle? string
---@field unit? string
---@field visible? boolean

---@class Employee : StrippedEmployee
---@field identifier string
---@field playerPed number

---@type { [string]: Employee[] }
local mdtEmployees = {}

---@param employees Employee[]
---@param source number
local function RemoveSourceFromEmployees(employees, source)
    for i = 1, #employees do
        if employees[i].source == source then
            table.remove(employees, i)
            return true
        end
    end

    return false
end

OnPlayerDisconnect(function(source)
    for job, employees in pairs(mdtEmployees) do
        if RemoveSourceFromEmployees(employees, source) then
            debugprint("Removed player", source, "from employees for", job, "due to disconnecting")
        end
    end
end)

---@param source number
---@param job string
---@param duty boolean
local function OnJobChange(source, job, duty)
    local identifier = GetIdentifier(source)

    if not identifier then
        return
    end

    debugprint("dutyBlips: OnJobChange", source, job, duty)

    for mdtName, mdt in pairs(MDTs) do
        local employees = mdtEmployees[mdtName]

        if mdt.options.dutyBlips and (not mdt.defaultPermissions[job] or not duty) and employees then
            if RemoveSourceFromEmployees(employees, source) then
                debugprint("Removed player", source, "from employees for", mdtName, "due to OnJobChange")
            end
        end
    end

    if not duty then
        return
    end

    for mdtName, mdt in pairs(MDTs) do
        if mdt.options.dutyBlips and mdt.defaultPermissions[job] then
            mdtEmployees[mdtName] = mdtEmployees[mdtName] or {}

            local employees = mdtEmployees[mdtName]

            for i = 1, #employees do
                if employees[i].source == source then
                    debugprint("Player", source, "is already in employee duty blips for MDT", mdtName)
                    return
                end
            end

            local firstname, lastname = GetCharacterName(source)
            local name = firstname .. " " .. lastname

            debugprint("Added player", source, "to", mdtName, "employee duty blips")

            employees[#employees + 1] = {
                source = source,
                identifier = identifier,
                name = name,
                playerPed = GetPlayerPed(source)
            }
        end
    end
end

---@param source number
---@param job string
---@param duty boolean
AddEventHandler("lb-tablet:jobUpdated", function(source, job, duty)
    OnJobChange(source, job, duty)
end)

RegisterNetEvent("lb-tablet:frameworkLoaded", function()
    local src = source

    Wait(1000)

    local job = GetJob(src)

    OnJobChange(src, job.name, IsOnDuty(src))
end)

---@param mdt string
local function UpdateEmployeeBlips(mdt)
    local employees = mdtEmployees[mdt]
    ---@type RawEmployee[]
    local employeesToSend = {}

    for i = 1, #employees do
        local employee = employees[i]
        local playerPed = employee.playerPed
        local visible = true

        if Config.DutyBlips.RequireItem and not HasTabletItem(employee.source) then
            visible = false
        end

        if not playerPed or playerPed == 0 or not DoesEntityExist(playerPed) then
            goto continue
        end

        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if vehicle and vehicle ~= 0 then
            local vehicleType = GetVehicleType(vehicle)

            if
                vehicleType == "bike"
                or vehicleType == "heli"
                or vehicleType == "boat"
                or vehicleType == "plane"
            then
                employee.vehicle = vehicleType
            else
                employee.vehicle = "car"
            end
        else
            employee.vehicle = nil
        end

        local account = GetMDTAccount(mdt, employee.identifier)

        employee.callsign = account?.callsign
        employee.avatar = account?.avatar
        employee.coords = GetEntityCoords(playerPed)
        employee.heading = GetEntityHeading(playerPed)

        employeesToSend[#employeesToSend + 1] = {
            employee.source,
            employee.name,
            employee.callsign,
            employee.avatar,
            {
                math.floor(employee.coords.x + 0.5),
                math.floor(employee.coords.y + 0.5)
            },
            math.floor(employee.heading + 0.5),
            employee.vehicle,
            GetPlayerUnit(employee.source),
            visible
        }

        ::continue::
    end

    local payload = msgpack.pack_args(mdt, employeesToSend)
    local length = #payload

    for i = 1, #employees do
        ---@diagnostic disable-next-line: param-type-mismatch
        TriggerLatentClientEventInternal("tablet:mdt:updateEmployeeBlips", employees[i].source, payload, length, -1)
    end
end

Wait(2500)

local interval = math.floor(math.max(Config.DutyBlipInterval or 5000, 100))

while true do
    -- local startTime = os.nanotime()

    for mdtName in pairs(mdtEmployees) do
        UpdateEmployeeBlips(mdtName)
    end

    -- local elapsed = FormatNanoSeconds(os.nanotime() - startTime)

    -- debugprint(("Duty blips update took %s"):format(elapsed))

    Wait(interval)
end
