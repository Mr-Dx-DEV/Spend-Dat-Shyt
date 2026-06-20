Dependency aware module registration with initialization ordering and entry point tracking.

## Module Registration

```lua
local config, bridge

local myModule = {}

function myModule.init()
    config = Modules.require('config')
    bridge = Modules.require('bridge')
end

Modules.register('myModule', myModule, {
    dependencies = { 'config', 'bridge' }
})
```

## Optional Dependencies

Use `optionalDependencies` for modules that may or may not exist. Use `Modules.get()` instead of `Modules.require()` for these.

```lua
local config, inventory

local myModule = {}

function myModule.init()
    config = Modules.require('config')
    inventory = Modules.get('inventory') -- returns nil if not registered
end

function myModule.doSomething()
    if inventory then
        return inventory.getItems()
    end
    -- fallback logic
end

Modules.register('myModule', myModule, {
    dependencies = { 'config' },
    optionalDependencies = { 'inventory' }
})
```

Optional dependencies:
- Are initialized before your module if they exist
- Don't block initialization if missing
- Should be accessed via `Modules.get()` which returns `nil` if not found

## Entry Point Tracking

Entry points are main files that register event handlers and exports.
Expected entries are defined in `module_system.lua`:

```lua
local CLIENT_ENTRIES = {
    'medical_main',
    'facilities_main',
    'stretcher_main',
    'healingItems_main',
    'medbag_main',
}
```

At the end of each main file:

```lua
-- ... all handlers registered, exports defined ...

Modules.resolveEntry('medical_main')
```

## Framework Bridge Usage

```lua
CreateThread(function()
    if not Modules.awaitFullyReady(15000) then
        lib.print.warn('[bridge] Timed out waiting for modules/entries')
    end

    local playerData = GetPlayerData()
    if playerData then
        TriggerEvent('wasabi_ambulance:PlayerLoaded', bridge.player)
    end
end)
```