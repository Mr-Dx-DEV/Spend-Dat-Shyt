-- Global tow delivery point (used when events don't have their own deliveryCoords)
-- Falls back to the player's tow yard location if not set
Config.TowingDeliveryPoint = vector3(2387.94, 3088.48, 48.19)

Config.Locations = {
    {
        name = 'location.tow_yard',
        coords = vector3(2403.55, 3127.90, 48.15),
        heading = 251.85,
        vehicleSpawn = vector4(2394.27, 3120.37, 48.15, 71.61),
        menuCamera = {
            coords = vector3(2410.19, 3131.07, 50.63),
            heading = 150.41,
            rotation = vector3(-15.0, 0.0, 0.0), -- pitch (x), roll (y), heading offset (z)
            fov = 50.0,
        },
    },
}
