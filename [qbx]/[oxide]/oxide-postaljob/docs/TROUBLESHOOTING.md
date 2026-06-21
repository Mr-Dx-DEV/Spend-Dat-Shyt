# Troubleshooting Guide

Common issues and the current checks for `oxide-postaljob`.

## Shift Issues

### Can't clock in

Check:

1. The player is near a valid depot location.
2. The location still has free slots under `Config.MaxSlotsPerLocation`.
3. The player is not already on shift.
4. The player is not timed out from complaints.
5. The van spawn area is not blocked.

### Supervisor menu does not open

Check:

1. `o-link` is running before this resource.
2. Your `o-link.target` integration is working on the server.
3. The supervisor NPC spawned at the configured location.
4. The player has fully loaded and `olink:client:playerReady` has fired.

### NPC does not spawn

Check:

1. `Config.Locations` has valid coordinates.
2. `Config.NpcModel` (`s_m_m_postal_01`) is valid and not blocked.
3. The resource started without dependency errors.

## Loading Issues

### Pallet not spawning

Check:

1. `pickupPoints` in the location config contains valid `vector4` entries.
2. The pallet model (`bkr_prop_coke_pallet_01a`) loads correctly.
3. The pickup point is not underground or inside a collision.

### Cannot pick up box

Check:

1. The player is in `LOADING` state.
2. The player is not already carrying a box.
3. The player is not inside a vehicle.
4. The box entity still exists (was not already picked up).

### Box will not load into van

Check:

1. The van's rear doors (indices 2, 3) are physically open.
2. The player is within range of the van's rear.
3. The player is carrying a box.
4. The player is in `LOADING` state.

### Post box not appearing (letters)

Check:

1. The post box uses a sphere zone at the blip coordinates. No physical prop spawns. Walk to the blip location and look for the third-eye prompt.
2. `postBoxes` in the location config has valid `vector4` entries.
3. The player is not already carrying a mail bag.

## Delivery Issues

### No delivery blip appears

Check:

1. The shift transitioned to `DELIVERING` state.
2. Delivery orders were generated (enable `Config.Debug` to trace).
3. `deliveryZones` in the location config has entries matching the player's level.

### Cannot deliver package

Check:

1. The player is carrying a package (grabbed from the van).
2. The player is within 3m of the delivery zone coordinates.
3. The player is not inside a vehicle.
4. The `E` prompt is visible in the NUI hint text.

### Customer not spawning

Check:

1. `Config.CustomerPeds` models are valid.
2. Customer NPCs are only spawned for package deliveries, not letters.

### Timer feels wrong

The current timer is distance-based:

```lua
Config.Timer.baseTime + math.floor(distance * Config.Timer.timePerDistanceUnit)
```

If the value seems off, review the timer config and the distance between the depot and the delivery zone.

### Letterbox not targetable

Check:

1. Letterbox delivery uses a sphere zone at zone coordinates, not the physical prop.
2. The player is not inside a vehicle.
3. The shift is in `DELIVERING` state.
4. Only one letterbox target is active at a time (the current delivery).

## Vehicle Issues

### Van does not spawn

Check:

1. `Config.Vehicle.model` is valid.
2. `vehicleSpawn` in the location config is accessible and not blocked.

### No keys on the van

Check:

1. Your `o-link.vehiclekey` module is configured for the active key system.
2. `o-link` is started before this resource.

### Van destroyed mid-shift

This is intended behavior when engine health drops below `Config.Vehicle.destroyedThreshold` (150).

Current effects:

- current deliveries are cancelled
- a complaint is added
- the configured destroy fine is removed from cash
- player returns to `CLOCKED_IN` state

### Boxes not appearing in van

Check:

1. The box model `prop_cs_cardbox_01` loads correctly.
2. `Config.VanBoxOffsets` has enough entries for your batch size.
3. In crew mode, only the player who loaded the box sees the prop locally. The partner sees a synced count.

## Crew Issues

### Cannot invite partner

Check:

1. The inviter is already on shift.
2. The target is a valid nearby player.
3. The target is not already on shift or in a crew.
4. The invite action is not rate-limited.

### Partner does not get the invite

Check:

1. The target player entity exists server-side.
2. The target does not already have a pending invite.
3. If the partner is near the supervisor NPC, the invite appears in their menu. Otherwise a notification tells them to visit the supervisor.

### Crew state becomes inconsistent

Check:

1. Whether the shared van network entity resolved on both clients.
2. Whether one member disconnected, died, or clocked out.
3. Whether a vehicle ownership transfer occurred from leader to partner.

## Payment and Progression Issues

### No payout received

Check:

1. The shift was finalized through clock-out.
2. Net pay was above zero after deductions.
3. Your `o-link.money` integration is working for bank deposits.

### Payout amount looks wrong

Review:

1. distance bonus
2. speed bonus
3. streak bonus
4. random tip
5. co-op bonus (if in crew)
6. early finish penalty (undelivered packages at clock-out)
7. damage charge
8. gas fee
9. taxes

### Streak not counting

Check:

1. Streaks are tracked by real-world calendar date.
2. The streak only increments once per day (first delivery of the day).
3. Missing a day resets the streak to 1 (not 0).

### Progression is not saving

Check:

1. `oxmysql` is running.
2. `job_progression` table exists.
3. The row is being written with `job = 'postal'`.

### Timeout or complaints look incorrect

Query the unified table:

```sql
SELECT *
FROM job_progression
WHERE char_id = ?
  AND job = 'postal';
```

## UI Issues

### NUI does not load

Check:

1. `web/dist/index.html` exists.
2. Built UI files are present under `web/dist/assets`.
3. `ui_page` in `fxmanifest.lua` still points to `web/dist/index.html`.

### NUI summary or menu gets stuck

Check:

1. Client console errors.
2. Whether the issue only occurs with `Config.menuStyle = 'nui'`.
3. Whether switching to `Config.menuStyle = 'menu'` isolates the problem.

### Summary not showing as popup

Check:

1. `Config.shiftSummary = 'nui'`.
2. `Config.menuStyle ~= 'menu'`.

If both conditions are met and the popup still does not show, check the client F8 console for NUI errors.

### Text summary not sent

Check:

1. `Config.shiftSummary = 'text'`.
2. Your `o-link.phone` module is configured for the active phone script.

If `Config.menuStyle = 'menu'`, a notification is shown instead of a phone message.

## Debugging

Enable:

```lua
Config.Debug = true
```

This adds `[oxide-postaljob]` debug output for:

- shift state transitions
- clock-in and clock-out events
- delivery order generation
- box pickup and loading events
- payment calculations
- crew formation and dissolution
- pallet spawn and cleanup
- vehicle spawn and destruction
- progression level-ups and complaint changes
- bystander sync events

## When Reporting Issues

Include:

- `o-link` version or current branch
- active `o-link` modules used for target, phone, money, and vehicle keys
- server console errors
- client/F8 errors for UI issues
- reproduction steps
- whether the issue happened solo or in a crew

## Next Steps

- `INSTALLATION.md`
- `CONFIGURATION.md`
- `FEATURES.md`
- `ADMIN.md`
