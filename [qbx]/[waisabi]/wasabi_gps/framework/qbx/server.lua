-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not GetResourceState("qbx_core"):find('start') then return end

---@type table<string, any>
local QBX = exports.qbx_core

---@type string
FRAMEWORK = 'qbx'

---@param src number
---@return table<string, any>
function GetPlayer(src)
    return QBX:GetPlayer(src)
end

---@param src number
---@return string | nil
function GetIdentifier(src)
    local player = GetPlayer(src)
    return player and player.PlayerData and player.PlayerData.citizenid or nil
end

---@param src number
---@return string
function GetName(src)
    local player = GetPlayer(src)
    return player and player.PlayerData and player.PlayerData.charinfo and player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
end

---@param src number
---@return string | nil
function GetJob(src)
    local player = GetPlayer(src)
    return player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.name or nil
end

---@param src number
---@param job string
function HasJob(src, job)
    local player = GetPlayer(src)
    return player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.name == job or false
end

---@param src number
---@return string | nil
function GetJobLabel(src)
    local player = GetPlayer(src)
    return player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.label or nil
end

---@param src number
---@return boolean
function IsOnDuty(src)
    local player = GetPlayer(src)
    return player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.onduty or false
end

---@param src number
---@param item string
---@return boolean
function HasItem(src, item)
    local count = exports.ox_inventory:Search(src, 'count', item)
    return count > 0
end

---@param item string
---@param cb function
function RegisterUsableItem(item, cb)
    return QBX:CreateUseableItem(item, cb)
end

AddEventHandler("QBCore:Server:OnJobUpdate", function(source, jobData)
    local src = source
    if not jobData or not jobData.name then return end

    local idString = tostring(src)

    if not LastJob[idString] then
        RemoveActiveTracked(src)
    elseif LastJob[idString] and IsJobTracked(LastJob[idString].job) then
        RemoveActiveTracked(src)
    end

    if jobData.name and IsJobTracked(jobData.name) then
        if jobData.onduty ~= false then
            AddActiveTracked(src, jobData.name)
        end
    end
    LastJob[idString] = {
        job = jobData.name,
        onDuty = jobData.onduty
    }
    UpdateClientGPSState(src)
end)


AddEventHandler("QBCore:Server:SetDuty", function(source, onDuty)
    local src = source
    local job = GetJob(src)
    if not job then return end
    if IsJobTracked(job) then
        if onDuty then
            if not ActiveTracked[src] then
                AddActiveTracked(src, job)
            end
        else
            RemoveActiveTracked(src)
        end
    end
    LastJob[tostring(src)] = {
        job = job,
        onDuty = onDuty
    }
    UpdateClientGPSState(src)
end)