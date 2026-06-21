# Installation Guide

Step-by-step setup for `oxide-animalcontroljob`.

## Prerequisites

### Required resources

| Resource | Purpose |
|---|---|
| `ox_lib` | Locale, callbacks, timers, UI helpers |
| `oxmysql` | Database driver |
| `o-link` | Framework and system abstraction used by this resource |

### `o-link` expectations

This resource depends on your server's `o-link` setup for:

- player identity and character lookup
- notifications
- phone messaging
- money handling
- inventory (dart weapon management)
- targeting
- progress bars
- menu support when `Config.menuStyle = 'menu'`

## Installation Steps

### 1. Place the resource

Place `oxide-animalcontroljob` inside your server's resources folder.

### 2. Add startup order

Start dependencies before the job resource:

```cfg
ensure ox_lib
ensure oxmysql
ensure o-link
ensure oxide-animalcontroljob
```

### 3. Install the SQL table

Run [`sql/install.sql`](../sql/install.sql) against your database.

This creates the unified progression table used by current Oxide jobs:

```sql
CREATE TABLE IF NOT EXISTS `job_progression` (
    `char_id`            VARCHAR(60)      NOT NULL,
    `job`                VARCHAR(40)      NOT NULL,
    `level`              TINYINT          NOT NULL DEFAULT 1,
    `total_count`        INT              NOT NULL DEFAULT 0,
    `daily_streak`       INT              NOT NULL DEFAULT 0,
    `last_activity_date` DATE             NULL,
    `complaints`         TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `timeout_until`      DATETIME         NULL,
    PRIMARY KEY (`char_id`, `job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

`oxide-animalcontroljob` stores progression rows with `job = 'animalcontrol'`.

### 4. Migrate old data if needed

If your server is migrating from an older Oxide job install, run [`sql/migrate_unified_progression.sql`](../sql/migrate_unified_progression.sql) once before moving to the unified progression table.

### 5. Vehicle model

The resource uses the `kennel` vehicle model by default (a Vapid Kennel Animal Control Truck addon). Ensure this vehicle model is installed on your server, or change `Config.Vehicle.model` in `shared/config/vehicles.lua` to a vehicle model available on your server.

### 6. Dart weapon registration

The tranquilizer gun uses the `WEAPON_G2` weapon hash by default (item name `weapon_g2`). You must register this weapon in your framework so the inventory system recognizes it. If you prefer to use a different tranquilizer weapon, update `Config.Tranquilizer.weaponHash` in `shared/config/animals.lua` instead.

> **Item image:** Copy `weapon_g2.png` from the `itemimages/` folder in this resource to your inventory's image directory:
> - **QBCore (qb-inventory):** `qb-inventory/html/images/`
> - **ESX (ox_inventory):** `ox_inventory/web/images/`

#### QBCore

**Step 1:** Add the weapon to `qb-core/shared/weapons.lua`:

```lua
[`weapon_g2`] = {
    name = 'weapon_g2',
    label = 'Tranquilizer Gun',
    weapontype = 'Pistol',
    ammotype = 'AMMO_PISTOL',
    damagereason = 'Tranquilized',
},
```

**Step 2:** Add the weapon item to `qb-core/shared/items.lua`:

```lua
weapon_g2 = { name = 'weapon_g2', label = 'Tranquilizer Gun', weight = 1000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'weapon_g2.png', unique = true, useable = true, shouldClose = true, description = 'A tranquilizer gun used by animal control' },
```

> `ammo_pistol` already exists in stock QBCore — no additional ammo registration needed. The default `Config.Tranquilizer.ammoItem` is already set to `'ammo_pistol'`.

#### ESX / QBX (ox_inventory)

**Step 1:** Add the weapon to `ox_inventory/data/weapons.lua`:

```lua
['WEAPON_G2'] = {
    label = 'Tranquilizer Gun',
    weight = 1000,
    durability = 0.1,
    ammoname = 'ammo-9',
},
```

**Step 2:** Update `Config.Tranquilizer.ammoItem` in `shared/config/animals.lua` to match ox_inventory's ammo item name:

```lua
ammoItem = 'ammo-9',
```

> The `ammo-9` item already exists in stock ox_inventory — no additional ammo registration needed. QBX uses ox_inventory, so these same steps apply.

### 7. Review configuration

Adjust:

- [`shared/config.lua`](../shared/config.lua)
- [`shared/config/job.lua`](../shared/config/job.lua)
- [`shared/config/locations.lua`](../shared/config/locations.lua)
- [`shared/config/events.lua`](../shared/config/events.lua)
- [`shared/config/animals.lua`](../shared/config/animals.lua)
- [`shared/config/vehicles.lua`](../shared/config/vehicles.lua)
- [`shared/config/props.lua`](../shared/config/props.lua)
- [`shared/config/visuals.lua`](../shared/config/visuals.lua)
- [`shared/config/tutorials.lua`](../shared/config/tutorials.lua)

See `CONFIGURATION.md` for the full reference.

## Verification

1. Start the server and confirm `ox_lib`, `oxmysql`, `o-link`, and `oxide-animalcontroljob` all load without dependency errors.
2. Join the server and verify the animal control office blip and dispatcher NPC appear.
3. Interact with the dispatcher through your configured `o-link` target system.
4. Clock in, confirm the animal control truck spawns, and wait for a dispatch call.
5. Accept a call and verify the timer, scene interactions, and completion payout work.

## Optional Setup

### Phone messaging

If `Config.usePhone = true`, service messages and text summaries are sent through `o-link.phone`. Make sure your `o-link` phone module is configured for the phone resource your server uses.

If you want a popup end-of-shift summary, use:

```lua
Config.menuStyle = 'nui'
Config.shiftSummary = 'nui'
```

If you prefer notifications only, set:

```lua
Config.usePhone = false
```

### Stealth detection

If your server uses a custom crouch system that the native `GetPedStealthMovement` does not detect, set `Config.Stealth.useNativeStealth` to `false` in `shared/config/animals.lua`. This switches spook checks to random chance instead of crouch detection.

### ACE permission for builder

`/animalcontrolbuilder` requires:

```cfg
add_ace group.admin admin.animalcontroljob allow
```

## Notes for UI developers

The packaged `web/dist` build is already included and referenced by the manifest. Rebuilding the UI is only necessary if you edit files under `web/src`.

## Next Steps

- `FEATURES.md`
- `CONFIGURATION.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
