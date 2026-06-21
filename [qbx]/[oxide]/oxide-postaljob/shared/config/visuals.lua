Config.DeliveryMarker = {
    type = 25,
    scale = vector3(1.0, 1.0, 0.5),
    color = { r = 255, g = 200, b = 50, a = 120 },
    bobUpAndDown = false,
    rotate = false,
}

Config.Animations = {
    pickup = {
        dict = 'anim@heists@box_carry@',
        anim = 'idle',
        duration = 3000,
        label = 'Picking up package...',
    },
    deliver = {
        dict = 'mp_common',
        anim = 'givetake1_a',
        duration = 3000,
        label = 'Delivering package...',
    },
}

Config.Waypoints = {
    heightOffset = 5.0,
    updateInterval = 0,
    scaleMin = 0.5,
    scaleMax = 1.0,
    scaleNearDist = 30.0,
    scaleFarDist = 300.0,
}
