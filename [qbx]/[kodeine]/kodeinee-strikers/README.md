💎 Kodeinee Development – Pro Pad Striker System



🔥 Features

• Striker pad vehicle strike system
• Custom striker pad hand prop animation
• Key fob requirement system
• Vehicle lockout & timed access system
• Strike garage (store your struck vehicles)
• Strike valet delivery command
• Chop shop system for vehicle parts
• Sell ped for part payouts
• Supplier ped for buying striker items
• Clone plate system
• Striker pad durability
• Configurable items & payouts
• Configurable supplier currency (cash, bank, or any item)

🧩 Supported Setups
Frameworks

• QBCore
• Qbox
• ESX

Inventories

• qb-inventory
• ak47_qb_inventory
• ox_inventory
• Framework inventory

Target Systems

• qb-target
• ox_target
• Optional (can be disabled)

⚙️ Requirements

• ox_lib
• oxmysql
• Your framework
• Inventory system
• Target system (if enabled)

📦 Installation
Drag kodeinee-strikers into your resources folder
Import install.sql into your database
Add required items to your inventory
Add striker pad prop files into the stream folder
Add to your server.cfg:
ensure kodeinee-strikers
Open config.lua and set your options:
Config.Framework = 'auto'
Config.Inventory = 'auto'
Config.Target = 'auto'

You can leave everything on auto or set it manually.

🧱 Prop Setup

Place your striker pad prop files inside the stream folder:

kodeineestrikepad.ydr  
kodeineestrikepad.ytyp  
kodeineestrikepad.ybn  

Default prop name:

Config.StrikerPadProp.model = 'kodeineestrikepad'

You can enable or disable the hand prop in config.lua.

🎒 Required Items

Make sure these items exist in your inventory:

strikerpad
keyfob
stolendoor
stolenrim
stolencarpart
💰 Currency & Payouts

Supplier and payouts can use:

• Cash
• Bank
• Any item (fully configurable)

Examples:
• blackmoney
• black_money
• markedbills
• rubies

📦 QB  
['strikerpad'] = { name = 'strikerpad', label = 'Striker Pad', weight = 500, type = 'item', image = 'strikerpad.png', unique = false, useable = true, shouldClose = true, description = 'Vehicle striker device' },
['keyfob'] = { name = 'keyfob', label = 'Key Fob', weight = 50, type = 'item', image = 'keyfob.png', unique = false, useable = true, shouldClose = true, description = 'Vehicle key fob' },
['stolendoor'] = { name = 'stolendoor', label = 'Stolen Door', weight = 100, type = 'item', image = 'stolendoor.png', unique = false, useable = false, shouldClose = true, description = 'Stolen vehicle door' },
['stolenrim'] = { name = 'stolenrim', label = 'Stolen Rim', weight = 100, type = 'item', image = 'stolenrim.png', unique = false, useable = false, shouldClose = true, description = 'Stolen vehicle rim' },
['stolencarpart'] = { name = 'stolencarpart', label = 'Stolen Car Part', weight = 100, type = 'item', image = 'stolencarpart.png', unique = false, useable = false, shouldClose = true, description = 'Stolen car part' },
📦 ox_inventory 
['strikerpad'] = { label = 'Striker Pad', weight = 500, stack = true, close = true },
['keyfob'] = { label = 'Key Fob', weight = 50, stack = true, close = true },
['stolendoor'] = { label = 'Stolen Door', weight = 100, stack = true, close = true },
['stolenrim'] = { label = 'Stolen Rim', weight = 100, stack = true, close = true },
['stolencarpart'] = { label = 'Stolen Car Part', weight = 100, stack = true, close = true },
🚗 Vehicle Keys

Supports major vehicle key systems.

Leave it on auto or choose manually in config:

Config.VehicleKeys = {
    System = 'auto',
    GiveOnStrike = true,
    GiveOnGarageSpawn = true
}
🎮 Commands

• /mystrikes — View your active struck vehicles
• /callstrike — Call your vehicle delivery

⚙️ Configuration

Everything is fully configurable in config.lua:

• Framework / Inventory / Target
• Item names
• Supplier currency
• Strike timers & limits
• Vehicle options (player / NPC)
• Durability
• Chop rewards
• Sell prices
• Locations
• Garage behavior

🚗 Garage Integration

If your server uses a garage system, you can prevent struck vehicles from being stored or retrieved while locked.

Add the check below in your garage script where vehicles are spawned or stored.

OP Garages
local locked, lock = exports['strikerpads']:IsLockedFor(source, plate)
if locked then
    TriggerClientEvent('strikerpads:client:blockGarageSpawn', source, lock.expires_at)
    TriggerClientEvent('QBCore:Notify', source, ('This vehicle is struck. Available again in %d minutes.'):format(math.ceil((lock.expires_at - os.time())/60)), 'error')
    return
end
QB Garages
local locked = exports['strikerpads']:IsLockedFor(source, plate)
if locked then
    TriggerClientEvent('QBCore:Notify', source, 'This vehicle is currently struck and cannot be used.', 'error')
    return
end
JG Advanced Garages
local locked = exports['strikerpads']:IsLockedFor(source, plate)
if locked then
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Striker System',
        description = 'This vehicle is currently struck and locked.',
        type = 'error'
    })
    return
end
RX Garages
local locked = exports['strikerpads']:IsLockedFor(source, plate)
if locked then
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Striker System',
        description = 'Vehicle is currently struck and cannot be accessed.',
        type = 'error'
    })
    return
end





👑 ----------------Kodeinee Development-----------------------