# Troubleshooting Guide

Common issues and the current checks for `oxide-animalcontroljob`.

## Shift Issues

### Can't clock in

Check:

1. The player is near a valid office location.
2. The location still has free slots under `Config.MaxSlotsPerLocation`.
3. The player is not already on shift.
4. The player is not timed out from complaints.
5. The truck spawn area is clear enough to spawn the vehicle.

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

### Truck does not spawn

Check:

1. `Config.Vehicle.model` is valid and the addon vehicle is installed.
2. `vehicleSpawn` is accessible and not blocked.
3. The player is close enough to the dispatcher to clock in successfully.

### No keys on the truck

Check:

1. Your `o-link.vehiclekey` module is configured for the active key system.
2. `o-link` is started before this resource.

### Truck destroyed during shift

This is intended behavior when the truck drops below the configured destruction threshold.

Current effects:

- the active job is ended
- a complaint is added
- the configured destruction fine is removed from cash
- dispatch stops until the shift is finalized or transferred

## Animal Issues

### Animal does not spawn

Check:

1. Event coordinates in `shared/config/events.lua`.
2. Animal model names in the event data match entries in `Config.Animals`.
3. Whether the event position is blocked or invalid.

### Animal does not behave correctly

Check:

1. The animal model supports the expected behavior tasks.
2. For wildlife, `animalWaypoints` are defined for the event.
3. Relationship groups are not conflicting with other resources.
4. Debug mode for animal state transition messages.

### Animal escaped

This happens when the animal moves beyond its escape radius from spawn. To reduce escapes, increase the escape radius in `shared/config/animals.lua` or ensure event locations have enough open space.

### Animal killed

This happens when the animal takes lethal damage from any source. The dart gun is restricted to the active job animal, but other weapons or vehicle impacts can kill it.

### Animal woke up

This is intended behavior. Sedation lasts `Config.Tranquilizer.sedationDuration`. Players must load the animal before the timer expires, or tranquilize again.

## Tranquilizer Issues

### No dart gun after clock-in

Check:

1. The weapon item `weapon_g2` is registered in your inventory system.
2. Your `o-link.inventory` module is working for weapon items.
3. Server console errors related to weapon giving.
4. If using a custom weapon, `Config.Tranquilizer.weaponHash` matches.

### Darts not affecting animal

Check:

1. The dart gun only affects the active job's animal while on shift.
2. You are shooting the correct animal spawned for your current call.
3. The animal is not already sedated.
4. The weapon hash matches `Config.Tranquilizer.weaponHash`.
5. The server `weaponDamageEvent` handler is not overridden by another resource.

## Bait and Capture Issues

### Can't take bait from truck

Check:

1. Bait is only available during stray capture jobs in `WORKING` state.
2. Bait may already be taken or placed.
3. Target interactions are working with your `o-link.target` setup.

### Animal not approaching bait

Check:

1. The player is at least `Config.Props.bait.playerLeaveRadius` away from the bait.
2. There is a delay before the animal starts moving toward bait.
3. The animal was not recently spooked (wait for return delay).
4. The animal is in the `ALIVE` state.

### Can't capture animal

Check:

1. Player is within capture range of the animal.
2. The animal is in a capturable state (near bait, not fleeing).
3. The target interaction is showing on the animal.

## Delivery Issues

### Can't load animal into truck

Check:

1. The truck is within `Config.AnimalLoading.loadRange` of the animal.
2. The animal is in a loadable state (SEDATED or CAPTURED).
3. The truck entity still exists and hasn't been destroyed.

### Can't unload at shelter

Check:

1. The player is within `Config.AnimalLoading.shelterRange` of the shelter point.
2. The animal is in the LOADED state.
3. `Config.ShelterDeliveryPoint` coordinates are correct.

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
2. The target does not already have a pending invite.
3. Invites expire after `Config.Crew.inviteTimeout` seconds.

### Crew state becomes inconsistent

Check:

1. Whether the shared truck network entity resolved on both clients.
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
3. level multiplier
4. streak bonus
5. random tip
6. co-op bonus
7. vehicle damage charge
8. ammo resupply cost
9. gas fee
10. taxes

### Progression is not saving

Check:

1. `oxmysql` is running.
2. `job_progression` exists.
3. The row is being written with `job = 'animalcontrol'`.

### Timeout or complaints do not look correct

Use SQL against the unified table:

```sql
SELECT *
FROM job_progression
WHERE char_id = ?
  AND job = 'animalcontrol';
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

This adds `[oxide-animalcontroljob]` debug output for:

- shift flow
- dispatch timing
- animal spawning and state transitions
- bait and capture events
- tranquilizer hits
- crew actions
- progression saves
- vehicle handling

### Debug force job type

For testing specific job types:

```lua
Config.DebugForceJobType = JobType.STRAY_CAPTURE
```

Set to `nil` for normal operation.

## When Reporting Issues

Include:

- `o-link` version or current branch
- active `o-link` modules used for target, phone, money, inventory, and vehicle keys
- server console errors
- client/F8 errors for UI issues
- reproduction steps
- whether the issue happened solo or in a crew
- the job type when the issue occurred
