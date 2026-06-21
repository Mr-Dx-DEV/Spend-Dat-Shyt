# Admin & Developer Tools

Reference for commands, permissions, builder output, and progression management.

## Commands

| Command | Description | Permission |
|---|---|---|
| `/animalcontrolbuilder` | Opens the builder UI | `admin.animalcontroljob` |
| `/animalcontroltutorials` | Toggles tutorial prompts | None |
| `/animalcontroltutorialreset` | Clears tutorial seen-state | None |

## Builder

`/animalcontrolbuilder` opens the in-game builder used to create office locations and event sets without hand-editing config files.

### Permission

```cfg
add_ace group.admin admin.animalcontroljob allow
```

### Current builder workflow

1. Create an office location.
2. Set the vehicle spawn.
3. Finish the location.
4. Add event points for each job type.
5. Set the shelter delivery point.
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

- office location creation
- vehicle spawn capture
- per-type event creation (aggressive, stray, wildlife, deceased)
- shelter delivery point capture
- import of current config
- event editing and deletion
- undo
- vehicle preview testing
- 3D marker previews

## Tutorial Commands

### `/animalcontroltutorials`

Toggles the local player's tutorial system on or off.

### `/animalcontroltutorialreset`

Clears the local player's tutorial progress so all prompts can show again.

## Progression Management

Current progression lives in `job_progression`, not a per-resource table.

Use `job = 'animalcontrol'` for this resource.

### View progression

```sql
SELECT *
FROM job_progression
WHERE char_id = ?
  AND job = 'animalcontrol';
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
  AND job = 'animalcontrol';
```

### Clear complaints

```sql
UPDATE job_progression
SET complaints = 0
WHERE char_id = ?
  AND job = 'animalcontrol';
```

### Clear timeout

```sql
UPDATE job_progression
SET timeout_until = NULL
WHERE char_id = ?
  AND job = 'animalcontrol';
```

### Set level manually

```sql
UPDATE job_progression
SET level = 3
WHERE char_id = ?
  AND job = 'animalcontrol';
```

## Notes

- Shift payout is normally deposited to bank on shift finalization.
- Destroyed vehicle fines and animal kill fines are removed from cash immediately.
- Builder access is ACE-gated on the server side.

## Next Steps

- `INSTALLATION.md`
- `CONFIGURATION.md`
- `FEATURES.md`
- `TROUBLESHOOTING.md`
