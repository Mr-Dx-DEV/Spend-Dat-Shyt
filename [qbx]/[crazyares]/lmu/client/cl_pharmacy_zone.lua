-- -
--  CLIENT PHARMACY ZONE  - ox_target interaction | Grim Development
-- -

-- Only register if ox_target is running
CreateThread(function()
    if not Config.PharmacyZoneEnabled then return end
    if GetResourceState('ox_target') ~= 'started' then
        print('^3[grim_lovemenu] ^7ox_target not running - pharmacy world zones disabled.')
        return
    end

    for i, loc in ipairs(Config.PharmacyLocations) do
        exports.ox_target:addSphereZone({
            coords  = loc.coords,
            radius  = loc.radius or 1.5,
            debug   = Config.Debug,
            options = {
                {
                    label   = '- ' .. (loc.label or 'Pharmacy'),
                    icon    = 'fas fa-pills',
                    onSelect = function()
                        -- Open tablet directly to pharmacy page
                        TriggerEvent('grim_lovemenu:openTablet')
                        -- After tablet opens, route to pharmacy tab
                        -- Small delay so tablet.js openTablet() fires first
                        SetTimeout(400, function()
                            SendNUIMessage({ action = 'gotoPage', page = 'pharmacy' })
                        end)
                    end,
                },
            },
        })
    end

    print('^2[grim_lovemenu] ^7Pharmacy zones registered (' .. #Config.PharmacyLocations .. ' locations).')
end)
