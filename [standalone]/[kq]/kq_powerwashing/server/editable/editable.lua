-- Generates supervisor dialogue for contract completion
-- stars: 1, 3, 4, or 5 (2 is not possible)
-- vehicleState: "perfect", "damaged", "missing", or nil (minor wear, no comment)
-- jobSize: "short", "medium", or "long" based on estimated duration
function GenerateSupervisorMessage(stars, vehicleState, jobSize)
    local messages = {}

    -- Prefix
    local prefix = L("supervisor.prefix")
    if type(prefix) == "string" then
        table.insert(messages, prefix .. '<br>')
    end

    -- Performance comments based on stars
    local starsKey = "supervisor.stars_" .. stars
    local starsMessages = L(starsKey)
    if type(starsMessages) == "table" and #starsMessages > 0 then
        table.insert(messages, starsMessages[math.random(#starsMessages)])
    end

    -- Job size comments
    if jobSize then
        local jobKey = "supervisor.job_" .. jobSize
        local jobMessages = L(jobKey)
        if type(jobMessages) == "table" and #jobMessages > 0 then
            table.insert(messages, jobMessages[math.random(#jobMessages)])
        end
    end

    -- Vehicle comments
    if vehicleState then
        local vehicleKey = "supervisor.vehicle_" .. vehicleState
        local vehicleMessages = L(vehicleKey)
        if type(vehicleMessages) == "table" and #vehicleMessages > 0 then
            table.insert(messages, vehicleMessages[math.random(#vehicleMessages)])
        end
    end

    return table.concat(messages, " ")
end

-- Determines job size category based on estimated duration in milliseconds
-- Returns "short", "medium", or "long"
function GetJobSizeCategory(estimatedMs)
    local minutes = estimatedMs / 1000 / 60

    if minutes <= 5 then
        return "short"
    elseif minutes <= 15 then
        return "medium"
    else
        return "long"
    end
end

function GetPlayerUniqueIdentifier(player)
    local id = exports.kq_link:GetPlayerCharacterId(player)

    if id and type(id) == 'string' then
        return id
    end

    -- Fallback, use native license
    return GetPlayerIdentifierByType(player, 'license')
end

-- Whether the player should be allowed to open the job board.
-- Useful for custom checks, for example disallow starting jobs at night time
function CanPlayerOpenJobBoard(player)
    return true
end

function DoesPlayerHavePowerwashingJob(player)
    if not Config.jobName then
        return true
    end

    local job = exports.kq_link:GetPlayerJob(player)

    return job == Config.jobName
end

-- Function responsible for spawning the job vehicle
function SpawnJobVehicle(modelHash, spawnPoint)
    local vehicle = CreateVehicle(
        modelHash,
        spawnPoint.x, spawnPoint.y, spawnPoint.z,
        spawnPoint.w,
        true,
        true
    )

    return vehicle
end

--
-- Collection of functions which may be useful to use for external integrations

Dummy = {
    OnContractStarted = function(player)
        -- This gets called when a player finishes a contract
    end,

    OnContractCompleted = function(player, summaryData)
        -- This gets called when a player finishes a contract
    end,

    -- Gets triggered short after the vehicle in the contract gets spawned
    OnVehicleSpawned = function(vehicle, playersInContract)
        for k, playerId in pairs(playersInContract) do
            exports.kq_link:GiveVehicleKeys(playerId, vehicle)
        end
    end,

    -- Gets triggered right before the vehicle gets deleted
    BeforeVehicleDelete = function(vehicle, playersInContract)
        for k, playerId in pairs(playersInContract) do
            exports.kq_link:RemoveVehicleKeys(playerId, vehicle)
        end
    end
}
