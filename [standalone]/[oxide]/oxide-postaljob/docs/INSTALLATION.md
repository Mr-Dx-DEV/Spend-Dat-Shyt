# Installation Guide

Step-by-step setup for `oxide-postaljob`.

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
- phone messaging (shift events, crew invites, clock-out summary)
- money handling
- clothing and uniform management
- fuel level setting
- vehicle keys
- targeting (NPC interaction, box pickup, van loading, delivery zones)
- menu support when `Config.menuStyle = 'menu'`

## Installation Steps

### 1. Place the resource

Place `oxide-postaljob` inside your server's resources folder.

### 2. Add startup order

Start dependencies before the job resource:

```cfg
ensure ox_lib
ensure oxmysql
ensure o-link
ensure oxide-postaljob
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

`oxide-postaljob` stores progression rows with `job = 'postal'`.

### 4. Migrate old data if needed

If your server is migrating from an older Oxide job install, run [`sql/migrate_unified_progression.sql`](../sql/migrate_unified_progression.sql) once before moving to the unified progression table.

### 5. Review configuration

Adjust:

- [`shared/config.lua`](../shared/config.lua)
- [`shared/config/job.lua`](../shared/config/job.lua)
- [`shared/config/levels.lua`](../shared/config/levels.lua)
- [`shared/config/locations.lua`](../shared/config/locations.lua)
- [`shared/config/npcs.lua`](../shared/config/npcs.lua)
- [`shared/config/outfits.lua`](../shared/config/outfits.lua)
- [`shared/config/vehicles.lua`](../shared/config/vehicles.lua)
- [`shared/config/visuals.lua`](../shared/config/visuals.lua)
- [`shared/config/tutorials.lua`](../shared/config/tutorials.lua)

See `CONFIGURATION.md` for the full reference.

## Verification

1. Start the server and confirm `ox_lib`, `oxmysql`, `o-link`, and `oxide-postaljob` all load without dependency errors.
2. Join the server and verify the GoPostal depot blip appears on the map.
3. Walk to the supervisor NPC and confirm the third-eye target appears.
4. Clock in, confirm the delivery van spawns, and pick up a task.
5. Complete a test delivery and verify the timer, delivery target, and payout work.

## Optional Setup

### Phone messaging

Shift event messages, crew invites, and the clock-out summary are sent through `o-link.phone` automatically. Make sure your `o-link` phone module is configured for the phone resource your server uses.

If you prefer the NUI popup summary on clock-out rather than a phone message, use:

```lua
Config.shiftSummary = 'nui'
```

### ACE permission for builder

`/postalbuilder` requires:

```cfg
add_ace group.admin admin.postaljob allow
```

## Notes for UI developers

The packaged `web/dist` build is already included and referenced by the manifest. Rebuilding the UI is only necessary if you edit files under `web/src`.

## Next Steps

- `FEATURES.md`
- `CONFIGURATION.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
