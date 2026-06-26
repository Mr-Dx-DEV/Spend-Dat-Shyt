-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

RegisterNetEvent("wasabi_ambulance:Client:distressSignal", function(data)
    -- data = {
    --     source = number,      -- Server ID of the player in distress
    --     name = string,        -- Player name
    --     gender = number,      -- Player gender
    --     coords = vector3,     -- Player coordinates
    --     streetName = string,  -- Street name at player location
    --     timestamp = number    -- os.time() timestamp
    -- }

    if data and data.source and data.source ~= cache.serverId then return end

    local config = Modules.require('config')

    if config.dispatch.type == 'cd_dispatch' then
        local playerInfo = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = config.dispatch.allowedJobs,
            coords = playerInfo.coords,
            title = '10-52 - Injured Person',
            message = 'A person needs medical assistance at ' .. playerInfo.street,
            flash = 0,
            unique_id = playerInfo.unique_id,
            sound = 1,
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = '911 - Injured Person',
                time = 5,
                radius = 0,
            }
        })
    elseif config.dispatch.type == 'ps-dispatch' then
        exports['ps-dispatch']:DeceasedPerson()
    end

    -- Implement your own custom dispatch trigger logic here. Data example is above.
    -- (Server-side equivalent: wasabi_ambulance:Server:distressSignal)
end)
