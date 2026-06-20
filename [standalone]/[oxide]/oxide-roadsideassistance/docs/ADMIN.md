# Admin & Developer Tools

Reference for commands, permissions, builder output, and progression management.

## Commands

| Command | Description | Permission |
|---|---|---|
| `/roadsidebuilder` | Opens the builder UI | `admin.roadsidejob` |
| `/roadsidetutorials` | Toggles tutorial prompts | None |
| `/roadsidetutorialreset` | Clears tutorial seen-state | None |

## Builder

`/roadsidebuilder` opens the in-game builder used to create tow yards and event sets without hand-editing config files.

### Permission

```cfg
add_ace group.admin admin.roadsidejob allow
```

### Current builder workflow

1. Create a tow yard.
2. Set the vehicle spawn.
3. Finish the location.
4. Add event points for each job type.
5. Set the shared tow delivery point if needed.
6. Export the result.

### Export behavior

Current exports are written to the resource root as:

- `exported_locations.lua`
- `exported_events.lua`

They are also printed to the server console.

Typical usage is to copy the exported content into:

- `shared/config/locations.lua`
- `shared/config/events.lua`

### Builder coverage

The builder supports:

- tow yard creation
- vehicle spawn capture
- per-type event creation
- tow delivery point capture
- import of current config
- event editing
- undo
- vehicle preview testing

## Tutorial Commands

### `/roadsidetutorials`

Toggles the local player's tutorial system on or off.

### `/roadsidetutorialreset`

Clears the local player's tutorial progress so all prompts can show again.

## Progression Management

Current progression lives in `job_progression`, not a per-resource table.

Use `job = 'roadside'` for this resource.

### View progression

```sql
SELECT *
FROM job_progression
WHERE char_id = ?
  AND job = 'roadside';
```

### Reset progression

```sql
UPDATE job_progression
SET level = 1,
    total_count = 0,
    daily_streak = 0,
    last_activity_date = NULL,
    complaints = 0,
    timeout_until = NULL
WHERE char_id = ?
  AND job = 'roadside';
```

### Clear complaints

```sql
UPDATE job_progression
SET complaints = 0
WHERE char_id = ?
  AND job = 'roadside';
```

### Clear timeout

```sql
UPDATE job_progression
SET timeout_until = NULL
WHERE char_id = ?
  AND job = 'roadside';
```

### Set level manually

```sql
UPDATE job_progression
SET level = 3
WHERE char_id = ?
  AND job = 'roadside';
```

## Notes

- Shift payout is normally deposited to bank on shift finalization.
- Destroyed vehicle fines are removed from cash immediately.
- Builder access is ACE-gated on the server side.

## Next Steps

- `INSTALLATION.md`
- `CONFIGURATION.md`
- `FEATURES.md`
- `TROUBLESHOOTING.md`
