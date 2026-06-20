# Installation Guide

Step-by-step setup for `oxide-roadsideassistancejob`.

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
- vehicle keys
- targeting
- progress bars
- menu support when `Config.menuStyle = 'menu'`

## Installation Steps

### 1. Place the resource

Place `oxide-roadsideassistancejob` inside your server's resources folder.

### 2. Add startup order

Start dependencies before the job resource:

```cfg
ensure ox_lib
ensure oxmysql
ensure o-link
ensure oxide-roadsideassistancejob
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

`oxide-roadsideassistancejob` stores progression rows with `job = 'roadside'`.

### 4. Migrate old data if needed

If your server is migrating from an older Oxide job install, run [`sql/migrate_unified_progression.sql`](../sql/migrate_unified_progression.sql) once before moving to the unified progression table.

### 5. Review configuration

Adjust:

- [`shared/config.lua`](../shared/config.lua)
- [`shared/config/job.lua`](../shared/config/job.lua)
- [`shared/config/locations.lua`](../shared/config/locations.lua)
- [`shared/config/events.lua`](../shared/config/events.lua)
- [`shared/config/vehicles.lua`](../shared/config/vehicles.lua)
- [`shared/config/props.lua`](../shared/config/props.lua)
- [`shared/config/visuals.lua`](../shared/config/visuals.lua)
- [`shared/config/tutorials.lua`](../shared/config/tutorials.lua)

See `CONFIGURATION.md` for the full reference.

## Verification

1. Start the server and confirm `ox_lib`, `oxmysql`, `o-link`, and `oxide-roadsideassistancejob` all load without dependency errors.
2. Join the server and verify the tow yard blip and dispatcher NPC appear.
3. Interact with the dispatcher through your configured `o-link` target system.
4. Clock in, confirm the tow truck spawns, and wait for a dispatch call.
5. Accept a call and verify the timer, scene targets, and completion payout work.

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

### ACE permission for builder

`/roadsidebuilder` requires:

```cfg
add_ace group.admin admin.roadsidejob allow
```

## Notes for UI developers

The packaged `web/dist` build is already included and referenced by the manifest. Rebuilding the UI is only necessary if you edit files under `web/src`.

## Next Steps

- `FEATURES.md`
- `CONFIGURATION.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
