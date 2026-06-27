--- In this code, you can edit/configure the police report system, or add your own!

---@class alert
alert = {}

---@param location any
---@param productType 'Clone' | 'Check' | 'SIM Card'
function alert.sendPoliceReport(location, productType)
    local label, coords

    if Configuration.DispatchSystem == 'none' then return end

    if type(location) ~= "string" then
        label = "ATM"
        coords = location
    end

    if type(location) == "string" then
        if productType == 'Clone' then
            label = ('An ATM at %s has reported a fradulent card swipe.'):format(location)
            coords = Configuration.Selling.Clones.Locations[location].Location
        elseif productType == 'Check' then
            label = ('The bank at %s has reported a fradulent check.'):format(location)
            coords = Configuration.Selling.Checks.Locations[location].Location
        elseif productType == 'SIM Card' then
            label = ('A phone provider has reported a stolen SIM card marked on your radar.')
            coords = Configuration.Selling.Sims.Locations[location].Location
        end
    end

    --- Edit This for RCore Dispatch
    if Configuration.DispatchSystem == 'rcore_dispatch' then
        local data = {
            code = '10-64',
            default_priority = 'medium',
            coords = coords,
            job = Configuration.Settings.Police.PoliceJob,
            text = 'LSPD Alert',
            type = 'alerts',
            blip_time = 5,
            blip = { sprite = 54,
                colour = 3,
                scale = 0.7,
                text = label,
                flashes = false,
            }
        }

        return TriggerEvent('rcore_dispatch:server:sendAlert', data)
    end

    --- Edit This for LB Tablet Dispatch
    if Configuration.DispatchSystem == 'lb-tablet' then
        local dispatch = {
            priority = 'medium',
            code = '10-39',
            title = 'Police Report',
            description = label,
            location = { label = label, coords = { x = coords.x, y = coords.y }},
            time = 5,
            job = Configuration.Settings.Police.PoliceJob,
        }

        return exports['lb-tablet']:AddDispatch(dispatch)
    end

    --- Edit This for QS Dispatch
    if Configuration.DispatchSystem == 'qs-dispatch' then
        return TriggerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = { Configuration.Settings.Police.PoliceJob },
            callLocation = coords,
            callCode = { code = '10-64', snippet = 'Incoming Report' },
            message = label,
            flashes = true,
            blip = {
                sprite = 488,
                scale = 1.5,
                colour = 1,
                flashes = true,
                text = 'Fraudulent Report',
                time = (60 * 1000),
            },
        })
    end

    --- Edit This for CD Dispatch
    if Configuration.DispatchSystem == 'cd-dispatch' then
        return TriggerClientEvent('cd_dispatch:AddNotification', -1, {
            job_table = { Configuration.Settings.Police.PoliceJob },
            coords = coords,
            title = '10-64 Police Report',
            message = label,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            sound = 1,
            blip = {
                sprite = 431,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = 'Filed Report',
                time = 5,
                radius = 0,
            }
        })
    end
end