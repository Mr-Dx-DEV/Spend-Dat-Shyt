-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

-- Customize the notify system here
RegisterNetEvent('wasabi_gps:notify', function(title, message, type)
    TriggerEvent('wasabi_bridge:notify', title, message, type)
end)