-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if not GetResourceState("es_extended"):find('start') then return end

---@type table<string, any>
local ESX = exports.es_extended:getSharedObject()

---@type string
FRAMEWORK = 'esx'

---@param src number
---@return table<string, any>
function GetPlayer(src)
    local player = ESX.GetPlayerFromId(src)
    return player
end

---@param src number
---@return string | nil
function GetIdentifier(src)
    local player = GetPlayer(src)
    return player and player.identifier or nil
end

---@param src number
---@return string
function GetName(src)
    local player = GetPlayer(src)
    return player and player.name or nil
end

---@param src number
---@return string | nil
function GetJob(src)
    local player = GetPlayer(src)
    return player and player.job and player.job.name or nil
end

---@param src number
---@param job string
---@return boolean
function HasJob(src, job)
    local player = GetPlayer(src)
    return player and player.job and player.job.name == job or false
end

---@param src number
---@return string | nil
function GetJobLabel(src)
    local player = GetPlayer(src)
    return player and player.job and player.job.label or nil
end

---@param src number
---@return boolean
function IsOnDuty(src)
    local player = GetPlayer(src)
    return player and player.job and player.job.name:sub(0, 3) ~= 'off' or false
end

---@param src number
---@param item string
---@return boolean
function HasItem(src, item)
    local player = GetPlayer(src)
    if not player then return false end
    local _item = player.getInventoryItem(item)
    if not _item then return false end
    local count = _item.amount or _item.count or 0
    return count > 0
end

---@param item string
---@param cb function
function RegisterUsableItem(item, cb)
    return ESX.RegisterUsableItem(item, cb)
end

AddEventHandler("esx:setJob", function(source, job, lastJob)
    local src = source
    if IsJobTracked(lastJob.name) then
        RemoveActiveTracked(src)
    end
    if job.name:sub(0, 3) ~= 'off' and IsJobTracked(job.name) then
        AddActiveTracked(src, job.name)
    end
    UpdateClientGPSState(src)
end)