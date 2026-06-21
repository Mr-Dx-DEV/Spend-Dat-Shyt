UniqersMarriage = UniqersMarriage or {}

function UniqersMarriage.GiveKey(model, plate)
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
end

UniqersMarriage.SendPoliceAlert = function(targetSource, data)
    -- The data table contains the following:
    -- data.code (e.g., "10-90" or "10-91H")
    -- data.title (e.g., "Store Robbery")
    -- data.message (e.g., "The silent alarm is going off...")
    -- data.coords (vector3)

    TriggerClientEvent('QBCore:Notify', targetSource, data.message, "error")

    -- EXAMPLE 1: qb-policealerts (Uncomment to use)
    -- TriggerClientEvent('qb-policealerts:client:AddPoliceAlert', targetSource, {
    --     code = data.code,
    --     title = data.title,
    --     message = data.message,
    --     coords = data.coords,
    --     blip = {
    --         sprite = 458,
    --         color = 1,
    --         scale = 1.0,
    --         time = 300,
    --     }
    -- })

    -- EXAMPLE 2: ps-dispatch (Uncomment to use)
    -- TriggerClientEvent('ps-dispatch:client:addCall', targetSource, {
    --     title = data.title,
    --     message = data.message,
    --     coords = data.coords,
    --     dispatchCode = data.code
    -- }, "police")
    
    -- EXAMPLE 3: cd_dispatch (Uncomment to use)
    -- TriggerEvent('cd_dispatch:AddNotification', {
    --     job_table = UniqersMarriage.PoliceAlert.jobs, -- Police jobs from the config
    --     title = data.title,
    --     message = data.message,
    --     location = data.coords,
    --     code = data.code,
    --     -- Other cd_dispatch options...
    -- })
end

UniqersMarriage.RandomAvatars = { -- if steam avatar is not available, we will use Initials avatar
    [1] = {background = 'ffffff', color = '308BFF'},
    [2] = {background = 'E2E519', color = '222'},
    [3] = {background = 'FF306E', color = 'ffffff'},
    [4] = {background = 'F000FF', color = 'ffffff'},
    [5] = {background = '2F2730', color = 'ffffff'},
}


function JobCheck(job)
  for k, v in pairs(UniqersMarriage.JobsNames) do
      if job == v then
    return true
      end
  end
  return false
end

function AdminCheck(admin)
  for k, v in pairs(UniqersMarriage.StaffPermissionNames) do
      if admin == v then
    return true
      end
  end
  return false
end





function UniqersMarriageNotifyClient(text,status)
if UniqersMarriage.Notify == "qbcore" then
    TriggerEvent('QBCore:Notify', text, status)
elseif UniqersMarriage.Notify == "esx" then 
    UniqersMarriage.CoreName.ShowNotification(text)
elseif UniqersMarriage.Notify == "standalone" then
    TriggerEvent('chat:addMessage', -1, { args = { status, text }, color = 255,255,255 })
elseif UniqersMarriage.Notify == "uniqers-notify" then
	TriggerEvent('uniqers:marriage:notify', status, text)	
elseif UniqersMarriage.Notify == "custom" then -- add your notify trigger
-- you can add here custom code
end
end

function UniqersMarriageNotifyServer(source,text,status)
if UniqersMarriage.Notify == "qbcore" then
    TriggerClientEvent('QBCore:Notify', source, text, status)
elseif UniqersMarriage.Notify == "esx" then 
    TriggerClientEvent('esx:showNotification', source, text)
elseif UniqersMarriage.Notify == "standalone" then 
TriggerClientEvent('chat:addMessage', -1, { args = { status, text }, color = 255,255,255 })
elseif UniqersMarriage.Notify == "uniqers-notify" then
	TriggerClientEvent('uniqers:marriage:notify', source, status, text)
elseif UniqersMarriage.Notify == "custom" then -- add your notify trigger
-- you can add here custom code
end
end


UniqersMarriage.Database = function(plugin,type,query,var)
    local wait = promise.new()
    if type == 'fetchAll' and plugin == 'mysql-async' then
        MySQL.Async.fetchAll(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'mysql-async' then
        MySQL.Async.execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'ghmattimysql' then
        exports['ghmattimysql']:execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'fetchAll' and plugin == 'ghmattimysql' then
        exports.ghmattimysql:execute(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'execute' and plugin == 'oxmysql' then
        exports.oxmysql:query(query, var, function(result)
            wait:resolve(result)
        end)
    end
    if type == 'single' and plugin == 'oxmysql' then
        exports.oxmysql:single(query, var, function(result)
            wait:resolve(result)
        end)
    end	
    if type == 'fetchAll' and plugin == 'oxmysql' then
        exports.oxmysql:query(query, var, function(result)
            wait:resolve(result)
        end)
    end
    return Citizen.Await(wait)
end