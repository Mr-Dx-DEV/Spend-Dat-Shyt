# Configuration Reference

Reference for the current `oxide-blackmarket` config layout.

## Config File Map

| File | Purpose |
|---|---|
| `shared/config.lua` | Runtime settings, rep, pager, police, loot, hit squad, locations |
| `shared/items.lua` | Sellable items, shop tiers, and rep-tier helper |

## General Settings

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.Debug` | `boolean` | `true` | Enables `[oxide-blackmarket]` debug logging |
| `Config.EnableTiers` | `boolean` | `true` | Enables rep gain/loss, tier notifications, and tier-gated inventory |
| `Config.RelocationInterval` | `number` | `2700000` | Dealer relocation interval in ms |
| `Config.DealerWeapon` | `string` | `'WEAPON_PISTOL'` | Dealer weapon used on spawn and breakout |
| `Config.DealerModel` | `string` | `'s_m_y_dealer_01'` | Dealer ped model |

## Dirty Money

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.DirtyMoney.mode` | `string` | `'account'` | `'account'` uses `olink.money`, `'item'` uses an inventory item |
| `Config.DirtyMoney.account` | `string` | `'cash'` | Money account name when using account mode |
| `Config.DirtyMoney.item` | `string` | `'black_money'` | Item name when using item mode |
| `Config.DirtyMoney.useMetadata` | `boolean` | `false` | When `mode = 'item'`, read/write value from item metadata instead of stack count |
| `Config.DirtyMoney.metadataKey` | `string` | `'worth'` | Metadata field holding the bill's value (only used when `useMetadata = true`) |

Account mode example:

```lua
Config.DirtyMoney = {
    mode = 'account',
    account = 'cash',
    item = 'black_money',
}
```

Item mode (count-based) example:

```lua
Config.DirtyMoney = {
    mode = 'item',
    account = 'cash',
    item = 'black_money',
}
```

Item mode with value in metadata (e.g. marked bills where each item carries its worth):

```lua
Config.DirtyMoney = {
    mode = 'item',
    item = 'markedbills',
    useMetadata = true,
    metadataKey = 'worth', -- the metadata field your bill item uses
}
```

In metadata mode, paying a price that doesn't match a single bill consumes the smallest set of bills that covers the cost and returns the overage as a new bill in the player's inventory.

## Blips and Discovery

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.BlipDetectionRange` | `number` | `200.0` | Range to trigger flash blips |
| `Config.BlipCooldown` | `number` | `120000` | Cooldown between flashes in ms |
| `Config.BlipSprite` | `number` | `140` | Dealer blip sprite |
| `Config.BlipColor` | `number` | `1` | Dealer blip color |

`Config.BlipDuration` defines flash length by tier:

```lua
Config.BlipDuration = {
    [0] = 3000,
    [1] = 4000,
    [2] = 5000,
    [3] = 6000,
    [4] = 10000,
}
```

## Reputation

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.KillPenalty` | `number` | `500` | Rep removed when the dealer is killed |

Tier definitions:

```lua
Config.Tiers = {
    [0] = { name = 'tier.unknown', minRep = 0 },
    [1] = { name = 'tier.street', minRep = 100 },
    [2] = { name = 'tier.connected', minRep = 300 },
    [3] = { name = 'tier.trusted', minRep = 600 },
    [4] = { name = 'tier.inner_circle', minRep = 1000 },
}
```

## Pager

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.PagerCooldown` | `number` | `300000` | Cooldown in ms |

Success chance by tier:

```lua
Config.PagerSuccessChance = {
    [2] = 0.40,
    [3] = 0.70,
    [4] = 1.00,
}
```

## Police and Arrest

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.ArrestReward` | `number` | `5000` | Cash paid to the arresting officer |
| `Config.DepartmentCut` | `number` | `2500` | Police account deposit amount |
| `Config.ArrestRespawnDelay` | `number` | `900000` | Respawn delay after arrest |
| `Config.DeathRespawnDelay` | `number` | `600000` | Respawn delay after death |
| `Config.SubduedDeathPayout` | `number` | `500` | Department payout if a surrendered dealer is killed |
| `Config.ArrestDistance` | `number` | `3.0` | Client-side prompt distance for arrest |
| `Config.PoliceJobs` | `table` | see file | Job names treated as police |

Default police jobs:

```lua
Config.PoliceJobs = { 'police', 'sheriff', 'bcso', 'sast', 'sasp', 'LSPD' }
```

## Dispatch Alerts

**File:** `shared/config.lua`

`Config.DispatchAlerts` contains `transaction` and `proximity` alert configs.

Common fields:

| Field | Type | Description |
|---|---|---|
| `enabled` | `boolean` | Turns the alert on or off |
| `chance` | `number` | Trigger probability from `0.0` to `1.0` |
| `message` | `string` | Locale key or message passed to dispatch |
| `code` | `string` | Dispatch code |
| `icon` | `string` | Font Awesome icon |
| `time` | `number` | Blip lifetime in ms |
| `blip` | `table` | Blip appearance |

`proximity` also includes `range`.

## Death and Loot

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.BodyFadeDelay` | `number` | `45000` | Body fade delay in ms |
| `Config.DeathNotifyRadius` | `number` | `500.0` | Radius for death notifications |
| `Config.DeathNotifyMinTier` | `number` | `1` | Minimum tier to receive death notifications |
| `Config.LootDropEnabled` | `boolean` | `true` | Enables loot bags on death |
| `Config.LootCashMin` | `number` | `500` | Minimum loot cash |
| `Config.LootCashMax` | `number` | `2500` | Maximum loot cash |
| `Config.LootStockPercent` | `number` | `0.3` | Portion of remaining stock used for loot counts |
| `Config.LootMaxItems` | `number` | `5` | Max distinct item types in one loot bag |
| `Config.LootBagModel` | `string` | `'prop_cs_heist_bag_01'` | Loot bag prop model |
| `Config.LootBagDespawnTime` | `number` | `300000` | Loot despawn time in ms |

## Target Settings

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.TargetDistance` | `number` | `2.5` | Dealer target distance |
| `Config.TargetIcon` | `string` | `'fas fa-handshake'` | Dealer target icon |
| `Config.TargetLabel` | `string` | `'target.trade_dealer'` | Locale key for the target label |

## Hit Squad

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.HitSquadEnabled` | `boolean` | `true` | Enables hit squad retaliation |
| `Config.HitSquadEscapeDistance` | `number` | `500.0` | Distance needed to lose the squad |
| `Config.HitSquadCheckInterval` | `number` | `1000` | General AI state check interval |
| `Config.HitSquadFootEngageDistance` | `number` | `50.0` | Distance where they switch to foot combat |
| `Config.HitSquadDriveSpeed` | `number` | `30.0` | Chase speed in m/s (~67 mph). Above ~40 the AI loses control on corners |
| `Config.HitSquadSpawnDistMin` | `number` | `200.0` | Minimum spawn distance from the death location |
| `Config.HitSquadSpawnDistMax` | `number` | `300.0` | Maximum spawn distance from the death location |
| `Config.HitSquadTaskRefreshInterval` | `number` | `5000` | Task refresh interval |
| `Config.HitSquadMaxChaseDuration` | `number` | `90000` | Release the squad if it spends this many ms driving without engaging the player on foot (safety net for bad pathing) |
| `Config.HitSquadDifficulty` | `string` | `'medium'` | Difficulty preset |
| `Config.HitSquadCombatMovement` | `number` | `2` | Combat movement style |
| `Config.HitSquadCombatRange` | `number` | `2` | Combat range |

Vehicles:

```lua
Config.HitSquadVehicles = {
    'sultan',
    'sultan2',
    'oracle',
    'oracle2',
    'schafter2',
    'tailgater',
}
```

Ped models:

```lua
Config.HitSquadPedModels = {
    'a_m_m_business_01',
    'a_m_y_business_01',
    'a_m_y_business_02',
    'a_m_m_soucent_01',
    'g_m_m_mexboss_01',
}
```

Weapons:

```lua
Config.HitSquadWeapons = {
    easy = {
        'WEAPON_PISTOL',
        'WEAPON_PISTOL',
        'WEAPON_PISTOL',
        'WEAPON_PISTOL',
    },
    medium = {
        'WEAPON_PISTOL50',
        'WEAPON_SMG',
        'WEAPON_SMG',
        'WEAPON_PUMPSHOTGUN',
    },
    hard = {
        'WEAPON_COMBATPISTOL',
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_ASSAULTRIFLE',
        'WEAPON_CARBINERIFLE',
    },
}
```

Combat ability:

```lua
Config.HitSquadCombatAbility = {
    easy = 50,
    medium = 75,
    hard = 100,
}
```

## Surrender and Flee

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.FleeDistanceThreshold` | `number` | `8.0` | Distance that can trigger flee checks |
| `Config.FleeChance` | `number` | `0.35` | Chance to flee per check |
| `Config.FleeCheckInterval` | `number` | `1000` | Flee check interval |
| `Config.SurrenderCooldownTime` | `number` | `1000` | Delay before another surrender can happen |
| `Config.AimSurrenderDistance` | `number` | `10.0` | Police aim range for surrender |
| `Config.IdleWanderCheckDistance` | `number` | `50.0` | Range for idle wander logic |

## Dealer Locations

**File:** `shared/config.lua`

The default dealer spawn list:

```lua
Config.Locations = {
    vector4(889.39, -2185.3, 30.52, 357.26),
    vector4(33.57, -1906.16, 21.76, 137.9),
    vector4(-690.83, -724.43, 28.72, 84.58),
    vector4(1065.79, -720.8, 56.77, 143.09),
    vector4(-3062.4, 599.71, 7.46, 113.42),
    vector4(1867.5, 3744.72, 33.0, 211.69),
    vector4(2259.36, 4759.79, 39.22, 343.04),
    vector4(346.51, 2578.13, 43.52, 29.79),
}
```

## Sellable Items

**File:** `shared/items.lua`

These items can be sold to the dealer:

```lua
Config.SellableItems = {
    ['weed_1g'] = { price = 30, rep = 1 },
    ['weed_eighth'] = { price = 100, rep = 3 },
    ['weed_quarter'] = { price = 190, rep = 5 },
    ['weed_half'] = { price = 360, rep = 8 },
    ['weed_ounce'] = { price = 700, rep = 15 },
    ['weed_brick'] = { price = 500, rep = 15 },
    ['joint'] = { price = 30, rep = 1 },
    ['blunt'] = { price = 40, rep = 1 },
    ['meth_baggy'] = { price = 250, rep = 10 },
    ['meth_baggy_glass'] = { price = 325, rep = 13 },
    ['meth_baggy_blue_sky'] = { price = 400, rep = 18 },
    ['meth_baggy_purple_haze'] = { price = 375, rep = 16 },
    ['meth_baggy_lean_crystal'] = { price = 300, rep = 11 },
    ['meth_baggy_green_rush'] = { price = 285, rep = 10 },
    ['meth_baggy_dirty_sprite'] = { price = 360, rep = 15 },
    ['meth_baggy_street_mix'] = { price = 175, rep = 6 },
    ['meth_baggy_rocket_fuel'] = { price = 340, rep = 14 },
    ['meth_baggy_club_special'] = { price = 385, rep = 17 },
    ['meth_baggy_ice'] = { price = 375, rep = 16 },
    ['phone'] = { price = 100, rep = 2 },
}
```

## Shop Inventory

**File:** `shared/items.lua`

Format:

```lua
{ item = 'item_name', label = 'Display Name', price = 1000, stock = 10 }
{ item = 'weapon_name', label = 'Name', price = 5000, stock = 2, info = { serie = '' } }
```

### Tier 0

```lua
Config.ShopInventory[0] = {
    { item = 'lockpick', label = 'Lockpick', price = 300, stock = 10 },
    { item = 'joint', label = 'Joint', price = 50, stock = 20 },
    { item = 'rolling_papers', label = 'Rolling Papers', price = 10, stock = 50 },
    { item = 'lighter', label = 'Lighter', price = 15, stock = 20 },
    { item = 'weapon_switchblade', label = 'Switchblade', price = 200, stock = 5 },
}
```

### Tier 1

```lua
Config.ShopInventory[1] = {
    { item = 'ammo_pistol', label = '9mm Ammo', price = 15, stock = 100 },
    { item = 'radio', label = 'Radio', price = 500, stock = 5 },
    { item = 'bandage', label = 'Bandage', price = 100, stock = 15 },
    { item = 'growing_manual', label = "Grower's Manual", price = 800, stock = 3 },
    { item = 'weapon_knife', label = 'Knife', price = 350, stock = 5 },
    { item = 'hydrogen_peroxide', label = 'Hydrogen Peroxide', price = 80, stock = 20 },
    { item = 'ammonia', label = 'Ammonia', price = 80, stock = 20 },
    { item = 'hydrochloric_acid', label = 'Hydrochloric Acid', price = 80, stock = 20 },
    { item = 'sodium_benzoate', label = 'Sodium Benzoate', price = 80, stock = 20 },
    { item = 'baggy', label = 'Empty Baggy', price = 10, stock = 50 },
}
```

### Tier 2

```lua
Config.ShopInventory[2] = {
    { item = 'blackmarket_pager', label = 'Burner Pager', price = 2500, stock = 2 },
    { item = 'weapon_pistol', label = 'Pistol (No Serial)', price = 5000, stock = 2, info = { serie = '' } },
    { item = 'weapon_snspistol', label = 'SNS Pistol', price = 3500, stock = 3, info = { serie = '' } },
    { item = 'weapon_sawnoffshotgun', label = 'Sawed-Off Shotgun', price = 4500, stock = 2, info = { serie = '' } },
    { item = 'ammo_smg', label = 'SMG Ammo', price = 25, stock = 100 },
    { item = 'weapon_molotov', label = 'Molotov', price = 500, stock = 5 },
    { item = 'meth_table', label = 'Meth Table', price = 3000, stock = 2 },
    { item = 'meth_crystallizer', label = 'Meth Crystallizer', price = 4500, stock = 2 },
    { item = 'meth_manual', label = "The Cook's Notebook", price = 1500, stock = 3 },
    { item = 'gas_mask', label = 'Gas Mask', price = 500, stock = 5 },
    { item = 'cough_syrup', label = 'Cough Syrup', price = 60, stock = 15 },
    { item = 'pain_killer', label = 'Pain Killer', price = 40, stock = 15 },
    { item = 'cannabis_leaf', label = 'Cannabis Leaf', price = 50, stock = 15 },
    { item = 'lax_to_the_max', label = 'Lax to the Max', price = 45, stock = 15 },
}
```

### Tier 3

```lua
Config.ShopInventory[3] = {
    { item = 'weapon_microsmg', label = 'Micro SMG', price = 12000, stock = 2, info = { serie = '' } },
    { item = 'weapon_pumpshotgun', label = 'Pump Shotgun', price = 15000, stock = 1, info = { serie = '' } },
    { item = 'ammo_rifle', label = 'Rifle Ammo', price = 50, stock = 100 },
    { item = 'ammo_shotgun', label = 'Shotgun Ammo', price = 40, stock = 50 },
    { item = 'med_armor', label = 'Body Armor', price = 5000, stock = 5 },
    { item = 'printer_usb', label = 'SNS Pistol USB', price = 2500, stock = 3, info = { blueprint = 'sns_pistol' } },
    { item = 'printer_usb', label = 'Pistol USB', price = 3000, stock = 3, info = { blueprint = 'pistol' } },
    { item = 'printer_usb', label = 'Micro SMG USB', price = 4000, stock = 2, info = { blueprint = 'micro_smg' } },
    { item = 'printer_usb', label = 'Pump Shotgun USB', price = 4000, stock = 2, info = { blueprint = 'pump_shotgun' } },
    { item = 'magnesium_oxide', label = 'Magnesium Oxide', price = 120, stock = 10 },
    { item = 'hazardous_waste', label = 'Hazardous Waste', price = 150, stock = 10 },
    { item = 'vanilla_unicorn_pills', label = 'V.U. Pills', price = 200, stock = 10 },
    { item = 'acetone', label = 'Acetone', price = 250, stock = 10 },
    { item = 'adrenaline', label = 'Adrenaline', price = 300, stock = 10 },
}
```

### Tier 4

```lua
Config.ShopInventory[4] = {
    { item = 'weapon_assaultrifle', label = 'Assault Rifle', price = 35000, stock = 1, info = { serie = '' } },
    { item = 'weapon_carbinerifle', label = 'Carbine Rifle', price = 40000, stock = 1, info = { serie = '' } },
    { item = 'weapon_smg', label = 'SMG', price = 20000, stock = 2, info = { serie = '' } },
    { item = 'heavy_armor', label = 'Heavy Armor', price = 10000, stock = 3 },
    { item = 'ammo_sniper', label = 'Sniper Ammo', price = 100, stock = 50 },
    { item = 'printer_usb', label = 'Assault Rifle USB', price = 8000, stock = 1, info = { blueprint = 'assault_rifle' } },
    { item = 'printer_usb', label = 'Carbine Rifle USB', price = 8500, stock = 1, info = { blueprint = 'carbine_rifle' } },
    { item = 'printer_usb', label = 'Combat Pistol USB', price = 5000, stock = 2, info = { blueprint = 'combat_pistol' } },
    { item = 'toluene', label = 'Toluene', price = 400, stock = 8 },
}
```

## Next Steps

- `INSTALLATION.md`
- `FEATURES.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
