local Utils = require 'modules.utils.client'

local function illegalpack_GetStreetAndZone(coords)
    local zone   = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    return street .. ', ' .. zone
end

-- ps-dispatch alert definitions for each illegal job
local jobDispatchMap = {
    bag_snatch = {
        message    = 'Bag Snatch in Progress',
        codeName   = '0r_bag_snatch',
        code       = '10-35',
        icon       = 'fas fa-bag-shopping',
        priority   = 2,
    },
    car_theft = {
        message    = 'Vehicle Theft in Progress',
        codeName   = '0r_car_theft',
        code       = '10-35',
        icon       = 'fas fa-car-burst',
        priority   = 2,
    },
    chicken_kidnapping = {
        message    = 'Suspicious Activity - Animal Theft',
        codeName   = '0r_chicken_kidnapping',
        code       = '10-66',
        icon       = 'fas fa-question',
        priority   = 2,
    },
    chop_shop = {
        message    = 'Chop Shop Activity Detected',
        codeName   = '0r_chop_shop',
        code       = '10-66',
        icon       = 'fas fa-car',
        priority   = 2,
    },
    cocaine_job = {
        message    = 'Suspicious Drug Activity - Cocaine Lab',
        codeName   = '0r_cocaine_job',
        code       = '10-13',
        icon       = 'fas fa-tablets',
        priority   = 2,
    },
    container_heli = {
        message    = 'Suspicious Helicopter Activity',
        codeName   = '0r_container_heli',
        code       = '10-65',
        icon       = 'fas fa-helicopter',
        priority   = 2,
    },
    corner_deal = {
        message    = 'Drug Deal in Progress',
        codeName   = '0r_corner_deal',
        code       = '10-13',
        icon       = 'fas fa-hand-holding',
        priority   = 2,
    },
    counterfeit_money = {
        message    = 'Counterfeiting Operation Detected',
        codeName   = '0r_counterfeit_money',
        code       = '10-90',
        icon       = 'fas fa-money-bill',
        priority   = 2,
    },
    diving = {
        message    = 'Suspicious Diving Activity',
        codeName   = '0r_diving',
        code       = '10-66',
        icon       = 'fas fa-water',
        priority   = 2,
    },
    fraud = {
        message    = 'ATM Fraud in Progress',
        codeName   = '0r_fraud',
        code       = '10-90',
        icon       = 'fas fa-credit-card',
        priority   = 2,
    },
    gun_smuggling = {
        message    = 'Illegal Weapons Smuggling Detected',
        codeName   = '0r_gun_smuggling',
        code       = '10-95',
        icon       = 'fas fa-gun',
        priority   = 2,
    },
    illegal_delivery = {
        message    = 'Suspicious Illegal Delivery',
        codeName   = '0r_illegal_delivery',
        code       = '10-13',
        icon       = 'fas fa-truck',
        priority   = 2,
    },
    meth_job = {
        message    = 'Suspicious Drug Activity - Meth Lab',
        codeName   = '0r_meth_job',
        code       = '10-13',
        icon       = 'fas fa-flask',
        priority   = 2,
    },
    moonshine = {
        message    = 'Illegal Moonshine Operation',
        codeName   = '0r_moonshine',
        code       = '10-13',
        icon       = 'fas fa-wine-bottle',
        priority   = 2,
    },
    npc_boxing = {
        message    = 'Illegal Fight Club Activity',
        codeName   = '0r_npc_boxing',
        code       = '10-10',
        icon       = 'fas fa-hand-fist',
        priority   = 2,
    },
    plane_drug_delivery = {
        message    = 'Suspicious Aircraft - Drug Delivery',
        codeName   = '0r_plane_drug_delivery',
        code       = '10-65',
        icon       = 'fas fa-plane',
        priority   = 2,
    },
    weed_job = {
        message    = 'Suspicious Drug Activity - Weed Lab',
        codeName   = '0r_weed_job',
        code       = '10-13',
        icon       = 'fas fa-seedling',
        priority   = 2,
    },
}

local function SendIllegalPackDispatch(job)
    if GetResourceState('ps-dispatch') ~= 'started' then return end
    local alert = jobDispatchMap[job.name]
    if not alert then return end

    local coords = GetEntityCoords(PlayerPedId())
    local dispatchData = {
        message   = alert.message,
        codeName  = alert.codeName,
        code      = alert.code,
        icon      = alert.icon,
        priority  = alert.priority,
        coords    = coords,
        street    = illegalpack_GetStreetAndZone(coords),
        alertTime = nil,
        jobs      = { 'leo' },
    }
    TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
end

---@param source number
---@param job Job
---@return boolean
---Called before a job starts.
---Return `true` to allow the job to start, or `false` to block it.
function client.exports.beforeJobStart(source, job)
    -- ?
    return true
end

---@param source number
---@param job Job
---Called after a job has successfully started.
---You can use this to set up job data, targets, or notify the player.
function client.exports.onJobStarted(source, job)
    SendIllegalPackDispatch(job)
end

---@param source number
---@param lastJob Job
---Called after a job has been successfully stopped.
---Use this to clean up, give rewards, or log the completion.
function client.exports.onJobStopped(source, lastJob)
    -- ?
end

exports("activeJob", function()
    return client.currentJob
end)

--[[ Global Client Events ]]

---global event used to open the doors of a networked vehicle
---@param netId number
---@param door number
---@param open boolean
RegisterNetEvent('illegalpack:client:toggleEntityDoor', function(netId, door, open)
    local entity = NetToVeh(netId)
    for _, d in pairs(type(door) == 'table' and door or { door }) do
        (open and SetVehicleDoorOpen or SetVehicleDoorShut)(entity, d, false, false)
    end
end)
