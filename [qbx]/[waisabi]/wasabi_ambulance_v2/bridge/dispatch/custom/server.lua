-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

AddEventHandler("wasabi_ambulance:Server:distressSignal", function(data)
    -- data = {
    --     source = number,      -- Server ID of the player in distress
    --     name = string,        -- Player name
    --     gender = number,      -- Player gender
    --     coords = vector3,     -- Player coordinates
    --     streetName = string,  -- Street name at player location
    --     timestamp = number    -- os.time() timestamp
    -- }

    -- Implement your own custom dispatch trigger logic here. Data example is above.
    -- (Client-side equivalent: wasabi_ambulance:Client:distressSignal)
end)
