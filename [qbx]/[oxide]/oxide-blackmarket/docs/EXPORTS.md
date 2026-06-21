# Exports, Callbacks, and Events

Reference for integrating with `oxide-blackmarket`.

`oxide-blackmarket` uses `Callback = olink.callback` internally. Client callback usage assumes your resource already has access to the same `o-link` callback object.

## Server Exports

### Dealer state

```lua
local netId = exports['oxide-blackmarket']:GetDealerNetId()
local coords = exports['oxide-blackmarket']:GetDealerCoords()
local spawnCoords = exports['oxide-blackmarket']:GetDealerSpawnCoords()
local active = exports['oxide-blackmarket']:IsDealerActive()
local valid = exports['oxide-blackmarket']:IsDealerValid()
```

Returns:

- `GetDealerNetId() -> number|nil`
- `GetDealerCoords() -> vector3|nil`
- `GetDealerSpawnCoords() -> vector3|nil`
- `IsDealerActive() -> boolean`
- `IsDealerValid() -> boolean`

### Stock

```lua
local stock = exports['oxide-blackmarket']:GetDealerStock()
local qty = exports['oxide-blackmarket']:GetItemStock('weapon_pistol')
local ok = exports['oxide-blackmarket']:UpdateDealerStock('weapon_pistol', -1)
```

Returns:

- `GetDealerStock() -> table`
- `GetItemStock(itemName) -> number`
- `UpdateDealerStock(itemName, amount) -> boolean`

### Reputation

```lua
local rep = exports['oxide-blackmarket']:GetPlayerReputation(source)
local ok1 = exports['oxide-blackmarket']:SetPlayerReputation(source, 500)
local ok2 = exports['oxide-blackmarket']:AddPlayerReputation(source, 50)
local ok3 = exports['oxide-blackmarket']:RemovePlayerReputation(source, 100)
local ok4 = exports['oxide-blackmarket']:AddReputationWithNotify(source, 50)
local ok5 = exports['oxide-blackmarket']:RemoveReputationWithNotify(source, 100)
```

Returns:

- `GetPlayerReputation(source) -> number`
- `SetPlayerReputation(source, amount) -> boolean`
- `AddPlayerReputation(source, amount) -> boolean`
- `RemovePlayerReputation(source, amount) -> boolean`
- `AddReputationWithNotify(source, amount) -> boolean`
- `RemoveReputationWithNotify(source, amount) -> boolean`

## Client Exports

### Dealer and menu state

```lua
local entity = exports['oxide-blackmarket']:GetDealerEntity()
local active = exports['oxide-blackmarket']:IsDealerActive()
local inMenu = exports['oxide-blackmarket']:IsInMenu()
exports['oxide-blackmarket']:SetInMenu(true)
```

Returns:

- `GetDealerEntity() -> number|nil`
- `IsDealerActive() -> boolean`
- `IsInMenu() -> boolean`

### UI

```lua
exports['oxide-blackmarket']:OpenShopUI(shopData)
exports['oxide-blackmarket']:CloseShopUI()
exports['oxide-blackmarket']:UpdateShopUI('stock', { item = 'weapon_pistol', stock = 5 })

local isShopOpen = exports['oxide-blackmarket']:IsShopOpen()
local isNuiOpen = exports['oxide-blackmarket']:IsNUIOpen()
```

Returns:

- `IsShopOpen() -> boolean`
- `IsNUIOpen() -> boolean`

### Player state

```lua
local loggedIn = exports['oxide-blackmarket']:IsLoggedIn()
local isPolice = exports['oxide-blackmarket']:IsPlayerPolice()
```

Returns:

- `IsLoggedIn() -> boolean`
- `IsPlayerPolice() -> boolean`

## Server Callbacks

### `oxide-blackmarket:server:GetReputation`

```lua
Callback.Trigger('oxide-blackmarket:server:GetReputation', function(data)
    print(data.rep, data.tier, data.tierName)
end)
```

Return shape:

```lua
{
    rep = number,
    tier = number,
    tierName = string
}
```

### `oxide-blackmarket:server:IsPlayerPolice`

```lua
Callback.Trigger('oxide-blackmarket:server:IsPlayerPolice', function(isPolice)
    print(isPolice)
end)
```

Returns `boolean`.

## State Bags

### `oxide-blackmarket:dealer`

Replicated entity state bag set on the active dealer ped. Set to `true` while the ped is the live dealer; cleared when the entity is deleted. Clients should identify the dealer via this bag rather than a captured entity reference, since out-of-scope clients only resolve the entity when it streams into their scope.

```lua
-- Client: check if a ped is the active dealer
if Entity(entity).state['oxide-blackmarket:dealer'] == true then
    -- this is the dealer
end

-- React to stream-in / stream-out
AddStateBagChangeHandler('oxide-blackmarket:dealer', nil, function(bagName, _, value)
    local entity = GetEntityFromStateBagName(bagName)
    -- value == true on spawn/stream-in, nil/false on despawn/stream-out
end)
```

## Client Events

### Dealer

- `oxide-blackmarket:client:SpawnHitSquad(coords)`
- `oxide-blackmarket:client:DealerBodyFade(netId)` — server-driven body fade triggered by the death flow

### Reputation

- `oxide-blackmarket:client:TierChanged(newTier, newTierName)`
- `oxide-blackmarket:client:TierUp(tierName)`
- `oxide-blackmarket:client:TierDown(tierName)`
- `oxide-blackmarket:client:ReputationLost()`

### Shop

- `oxide-blackmarket:client:OpenShop(shopData)`
- `oxide-blackmarket:client:TransactionResult(success, message, updateData)`

`shopData` contains:

```lua
{
    playerRep = number,
    playerTier = number,
    tierName = string,
    playerCash = number,
    buyInventory = table,
    sellInventory = table,
    enableTiers = boolean
}
```

### Loot

- `oxide-blackmarket:client:SpawnLoot(coords, lootId)`
- `oxide-blackmarket:client:RemoveLootBag(lootId)`
- `oxide-blackmarket:client:LootCollected()`

### Pager

- `oxide-blackmarket:client:PagerSending()`
- `oxide-blackmarket:client:PagerResult(success, message, coords, spawnCoords)`
- `oxide-blackmarket:client:SetDealerWaypoint(data)`

Pager result behavior:

- Tier 2-3 success sends `message = nil`, `coords = nil`, and `spawnCoords = vector3`
- Tier 4 success sends `message = string`, `coords = vector3`, and `spawnCoords = nil`
- Failure sends `message = string`

## Server Events

### Dealer and arrest

```lua
TriggerServerEvent('oxide-blackmarket:server:ArrestDealer', netId)
TriggerServerEvent('oxide-blackmarket:server:DealerKilled')
TriggerServerEvent('oxide-blackmarket:server:DealerSurrendered')
```

Notes:

- `DealerKilled` is fired by the in-scope client that owns the ped at the moment of death (`IsEntityDead` or health <= 0). Server validates reporter proximity and dedupes via a `ProcessingDeath` flag, then runs the rep loss, loot drop, hit squad, body fade broadcast, and respawn schedule. Server-side health polling is not viable because GetEntityHealth on a server-owned ped with no client owner returns 0.
- `DealerSurrendered` tracks state for the reduced police society payout if the dealer is killed instead of arrested.

### Shop

```lua
TriggerServerEvent('oxide-blackmarket:server:RequestShop')
TriggerServerEvent('oxide-blackmarket:server:Purchase', itemName, quantity)
TriggerServerEvent('oxide-blackmarket:server:Sell', itemName, quantity)
```

### Loot

```lua
TriggerServerEvent('oxide-blackmarket:server:CollectLoot', lootId)
```

## Integration Examples

### Grant blackmarket rep from another resource

```lua
RegisterNetEvent('my-heist:server:completed', function()
    local src = source
    exports['oxide-blackmarket']:AddReputationWithNotify(src, 100)
end)
```

### Check whether the dealer is currently up

```lua
local function getDealerLocation()
    if not exports['oxide-blackmarket']:IsDealerValid() then
        return nil
    end

    return exports['oxide-blackmarket']:GetDealerCoords()
end
```

### Use current dealer stock in another script

```lua
local function canBuyFromDealer(itemName, quantity)
    return exports['oxide-blackmarket']:GetItemStock(itemName) >= quantity
end
```

## Next Steps

- `CONFIGURATION.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
