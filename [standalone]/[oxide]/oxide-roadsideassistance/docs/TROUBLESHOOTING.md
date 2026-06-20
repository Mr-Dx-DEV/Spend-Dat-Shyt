# Troubleshooting Guide

Common issues and the current checks for `oxide-roadsideassistancejob`.

## Shift Issues

### Can't clock in

Check:

1. The player is near a valid tow yard.
2. The location still has free slots under `Config.MaxSlotsPerLocation`.
3. The player is not already on shift.
4. The player is not timed out from complaints.
5. The tow truck spawn area is clear enough to spawn the vehicle.

### Dispatcher menu does not open

Check:

1. `o-link` is running before this resource.
2. Your `o-link.target` integration is working on the server.
3. The dispatcher NPC spawned at the configured location.
4. The player has fully loaded and `olink:client:playerReady` has fired.

### Dispatcher NPC does not spawn

Check:

1. `Config.Locations` has valid coordinates.
2. `Config.NpcModel` is valid.
3. The resource started without dependency errors.

## Dispatch Issues

### No calls arrive

Check:

1. The player is in `WAITING` state.
2. Dispatch has had enough time to fire within the configured random interval.
3. The shift was not auto clocked out from missed calls.
4. Debug logging is enabled if you need to trace dispatch timing.

### Incoming call shows but cannot be accepted

Check:

1. The response window has not expired.
2. The player is the crew leader if in a crew.
3. Rate limiting is not blocking repeated inputs.

### Auto clock-out happens unexpectedly

This usually means the shift hit `Config.Calls.maxMissedCalls` through missed or declined calls.

## Vehicle Issues

### Tow truck does not spawn

Check:

1. `Config.Vehicle.model` is valid.
2. `vehicleSpawn` is accessible and not blocked.
3. The player is close enough to the dispatcher to clock in successfully.

### No keys on the tow truck

Check:

1. Your `o-link.vehiclekey` module is configured for the active key system.
2. `o-link` is started before this resource.

### Tow truck destroyed during shift

This is intended behavior when the truck drops below the configured destruction threshold.

Current effects:

- the active job is ended
- a complaint is added
- the configured destruction fine is removed from cash
- dispatch stops until the shift is finalized or transferred

## Job Issues

### Stranded vehicle or scene does not appear

Check:

1. Event coordinates in `shared/config/events.lua`.
2. Vehicle model names in the event data.
3. Whether the event position is blocked or invalid.

### Job will not complete

Check:

1. The correct repair sequence was followed for the active job type.
2. For towing, the player is close enough to the delivery point.
3. The player is not failing the distance validation at completion time.

### Timer feels wrong

The current timer is not per-event mission data. It is calculated from:

```lua
Config.Timer.baseTime + math.floor(distance * Config.Timer.timePerDistanceUnit)
```

If the value seems off, review the timer config and the distance between call acceptance and scene location.

## Target, Prop, and Cone Issues

### Targets do not appear

Check:

1. `o-link.target` is configured correctly.
2. The player is in the correct state for the interaction.
3. The player is within interaction range.

### Props do not appear on the truck

Check:

1. Prop models in `shared/config/props.lua`.
2. Tow truck model compatibility with configured attachment points.

### Cone placement does not work

Check:

1. `Config.Cones.enabled` is `true`.
2. The cone is being placed within `Config.Cones.placementRange`.
3. The player is aiming at valid ground.

## Crew Issues

### Cannot invite partner

Check:

1. The inviter is already on shift.
2. The target is a valid nearby player.
3. The target is not already on shift.
4. The target is not already in a crew.
5. The invite action is not rate-limited.

### Partner does not get the invite

Check:

1. The target player entity exists.
2. The players are close enough together.
3. The target does not already have a pending invite.

### Crew state becomes inconsistent

Check:

1. Whether the shared tow truck network entity resolved on both clients.
2. Whether one member disconnected, died, or clocked out during the scene.
3. Whether a transfer occurred from leader to partner.

## Payment and Progression Issues

### No payout received

Check:

1. The shift was actually finalized.
2. Net pay was above zero after deductions.
3. Your `o-link.money` integration is working for bank deposits.

### Payout amount looks wrong

Review:

1. distance bonus
2. speed bonus
3. cone bonus
4. streak bonus
5. random tip
6. co-op bonus
7. damage charge
8. gas fee
9. taxes

### Progression is not saving

Check:

1. `oxmysql` is running.
2. `job_progression` exists.
3. The row is being written with `job = 'roadside'`.

### Timeout or complaints do not look correct

Use SQL against the unified table:

```sql
SELECT *
FROM job_progression
WHERE char_id = ?
  AND job = 'roadside';
```

## UI Issues

### NUI does not load

Check:

1. `web/dist/index.html` exists.
2. The built UI files are present under `web/dist/assets`.
3. `ui_page` in `fxmanifest.lua` still points to `web/dist/index.html`.

### NUI summary or menu gets stuck

Check:

1. Client console errors.
2. Whether the issue only happens in `'nui'` mode.
3. Whether switching to `Config.menuStyle = 'menu'` isolates the problem.

### Text summary is not sent

Check:

1. `Config.shiftSummary = 'text'`.
2. `Config.usePhone = true` if you expect a phone message.
3. Your `o-link.phone` module is configured for the active phone script.

If `Config.usePhone = false`, the summary is sent as a notification instead.

If you expect a popup summary instead, make sure `Config.menuStyle` is not set to `'menu'`.

## Debugging

Enable:

```lua
Config.Debug = true
```

This adds `[oxide-roadsideassistancejob]` debug output for:

- shift flow
- dispatch timing
- crew actions
- progression saves
- vehicle handling
- cone and prop sync

## When Reporting Issues

Include:

- `o-link` version or current branch
- active `o-link` modules used for target, phone, money, and vehicle keys
- server console errors
- client/F8 errors for UI issues
- reproduction steps
- whether the issue happened solo or in a crew
