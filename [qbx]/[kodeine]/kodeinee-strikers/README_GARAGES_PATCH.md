🚗 Kodeinee Strikers Garage Integration

If your server uses a garage system, you can prevent struck vehicles from being stored or retrieved while they are still locked.

Add the checks below into your garage script where vehicles are spawned or stored.

🧩 OP Garages v2

Add this before the vehicle is spawned:

local locked, lock = exports['strikerpads']:IsLockedFor(source, plate)
if locked then
    TriggerClientEvent('strikerpads:client:blockGarageSpawn', source, lock.expires_at)
    TriggerClientEvent('QBCore:Notify', source, ('This vehicle is struck. Available again in %d minutes.'):format(math.ceil((lock.expires_at - os.time())/60)), 'error')
    return
end
🧩 QB Garages

Add this before spawning or storing a vehicle:

local locked = exports['strikerpads']:IsLockedFor(source, plate)
if locked then
    TriggerClientEvent('QBCore:Notify', source, 'This vehicle is currently struck and cannot be used.', 'error')
    return
end
🧩 JG Advanced Garages

Add this before retrieving or spawning a vehicle:

local locked = exports['strikerpads']:IsLockedFor(source, plate)
if locked then
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Striker System',
        description = 'This vehicle is currently struck and locked.',
        type = 'error'
    })
    return
end
🧩 RX Garages

Add this before vehicle spawn or storage logic:

local locked = exports['strikerpads']:IsLockedFor(source, plate)
if locked then
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Striker System',
        description = 'Vehicle is currently struck and cannot be accessed.',
        type = 'error'
    })
    return
end
💡 Notes

• Prevents players from bypassing the striker system
• Works with most garage systems using plate-based vehicles
• Simple plug-and-play integration

👑 Kodeinee Development