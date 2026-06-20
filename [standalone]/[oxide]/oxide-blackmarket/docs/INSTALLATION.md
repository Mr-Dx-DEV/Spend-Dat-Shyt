# Installation Guide

Step-by-step setup for `oxide-blackmarket`.

## Prerequisites

### Required resources

| Resource | Purpose |
|---|---|
| `ox_lib` | Locale, commands, utility helpers |
| `o-link` | Framework, job, money, inventory, notify, phone, banking, callback, and targeting abstraction |

### `o-link` expectations

This resource relies on your server's `o-link` setup for:

- player metadata via `olink.character`
- job lookup via `olink.job`
- target integration for dealer and loot interactions
- inventory item lookup, add, and remove
- money access for dirty-money account mode
- notifications
- phone/email for Tier 4 pager intel
- police banking deposits when configured

### OneSync

OneSync must be enabled. The dealer ped is created server-side and synced through the network.

```cfg
set onesync on
```

## Installation Steps

### 1. Place the resource

Place `oxide-blackmarket` in your server's resources folder.

### 2. Add startup order

Start `o-link` before this resource:

```cfg
ensure ox_lib
ensure o-link
ensure oxide-blackmarket
```

If your `o-link` stack depends on other framework or inventory resources, keep those above `o-link`.

### 3. Add the pager item

`oxide-blackmarket` registers the pager as a usable item through `olink.framework.RegisterUsableItem`, but the item still has to exist in your inventory system's item registry.

Example item definition:

```lua
blackmarket_pager = {
    name = 'blackmarket_pager',
    label = 'Burner Pager',
    weight = 100,
    type = 'item',
    image = 'blackmarket_pager.png',
    unique = true,
    useable = true,
    shouldClose = true,
    description = 'A disposable pager for underground contacts'
}
```

Add `blackmarket_pager.png` to the image folder used by your inventory resource if it supports item images.

### 4. Review configuration

Check these files before going live:

- [`shared/config.lua`](../shared/config.lua)
- [`shared/items.lua`](../shared/items.lua)

Important settings to review first:

- `Config.Debug`
- `Config.EnableTiers`
- `Config.DirtyMoney`
- `Config.PoliceJobs`
- `Config.DispatchAlerts`
- `Config.HitSquadEnabled`
- `Config.Locations`

See `CONFIGURATION.md` for the full reference.

## Verification

1. Start the server and confirm `ox_lib`, `o-link`, and `oxide-blackmarket` load without dependency errors.
2. Watch server console output for:

```text
[oxide-blackmarket] Resource starting...
[oxide-blackmarket] Pager item registered
[oxide-blackmarket] Initializing dealer...
```

3. Join the server and use `/dealerstatus` or `/godealer` as an admin to confirm the dealer exists.
4. Approach the dealer and confirm the target interaction opens the shop.
5. Buy and sell at least one item to verify inventory and dirty-money configuration.
6. If using police gameplay, test surrender and arrest with a job listed in `Config.PoliceJobs`.
7. If using pager intel, give yourself enough rep for Tier 2 or Tier 4 and verify the cooldown and phone/waypoint flow.

## Optional Setup

### Dirty money mode

The shop uses `Config.DirtyMoney` for both purchases and sales.

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

Item mode with value stored in item metadata (one bill carries its full worth):

```lua
Config.DirtyMoney = {
    mode = 'item',
    item = 'markedbills',
    useMetadata = true,
    metadataKey = 'worth', -- match whatever your bill item uses
}
```

### Dealer locations

The dealer chooses a random entry from `Config.Locations`:

```lua
Config.Locations = {
    vector4(x, y, z, heading),
}
```

Use open outdoor areas. The dealer wanders around the spawn point, and indoor or cramped spots tend to break pathing.

### Optional integrations

- Tier 4 pager intel uses `olink.phone` if available. If phone delivery fails, the resource still sets a waypoint and shows the fallback GPS notification.
- Police department deposits use `olink.banking` inside `pcall`. If banking is unavailable, the arrest flow still works and officer cash is still paid.

## Next Steps

- `FEATURES.md`
- `CONFIGURATION.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
