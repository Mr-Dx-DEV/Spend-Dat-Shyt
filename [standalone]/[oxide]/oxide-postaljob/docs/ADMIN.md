# Admin & Developer Tools

Reference for commands, permissions, builder output, and progression management.

## Commands

| Command | Description | Permission |
|---|---|---|
| `/postalbuilder` | Opens the builder UI | `admin.postaljob` |
| `/postaltutorials` | Toggles tutorial prompts | None |
| `/postaltutorialreset` | Clears tutorial seen-state | None |

## Builder

`/postalbuilder` opens the in-game builder used to create depot locations, scan for props, and export config without hand-editing files.

### Permission

```cfg
add_ace group.admin admin.postaljob allow
```

### Current builder workflow

1. Run `/postalbuilder` and choose **New Location** — captures your position as the depot coords.
2. Move to the van spawn point and choose **Set Vehicle Spawn**.
3. Move to each pallet pickup point and choose **Add Pickup Point** (at least 1 required).
4. Use **Scan Post Boxes** and **Scan Letterboxes** to find nearby GTA props. Select individual results or use **Add All Remaining** for batch add.
5. Move to each delivery address and choose **Add Delivery Zone** — label is auto-suggested from the GTA street name.
6. Use **View Status** to check progress and see what's missing.
7. Choose **Finish Location** when all required fields are set.
8. Choose **Export All** to write `exported_locations.lua`.

### Export behavior

Exports are written to the resource root as `exported_locations.lua` and printed to the server console.

Copy the exported content into `shared/config/locations.lua`.

### Builder coverage

The builder supports:

- depot location creation
- vehicle spawn capture
- pickup point capture
- delivery zone creation (with street-name auto-suggestion)
- post box scanning and batch add
- letterbox scanning and batch add (with auto-naming and min level prompts)
- import of current config for editing
- editing finished locations
- undo (up to 20 steps)
- prop attachment testing
- scan marker visualization and cleanup

## Tutorial Commands

### `/postaltutorials`

Toggles the local player's tutorial system on or off.

### `/postaltutorialreset`

Clears the local player's tutorial progress so all 9 prompts can show again.

## Progression Management

Current progression lives in `job_progression`, not a per-resource table.

Use `job = 'postal'` for this resource.

### View progression

```sql
SELECT *
FROM job_progression
WHERE char_id = ?
  AND job = 'postal';
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
  AND job = 'postal';
```

### Clear complaints

```sql
UPDATE job_progression
SET complaints = 0
WHERE char_id = ?
  AND job = 'postal';
```

### Clear timeout

```sql
UPDATE job_progression
SET timeout_until = NULL
WHERE char_id = ?
  AND job = 'postal';
```

### Set level manually

```sql
UPDATE job_progression
SET level = 3
WHERE char_id = ?
  AND job = 'postal';
```

## Notes

- Shift payout is deposited to bank on shift finalization through `o-link.money`.
- Vehicle destroy fines are removed from cash immediately when the van is lost.
- Builder access is ACE-gated on the server side.

## Next Steps

- `INSTALLATION.md`
- `CONFIGURATION.md`
- `FEATURES.md`
- `TROUBLESHOOTING.md`
