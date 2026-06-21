# Feature Guide

Overview of the current `oxide-roadsideassistancejob` gameplay flow and systems.

## Shift Flow

Players manage the job from the dispatcher NPC at the tow yard using the configured `o-link` target integration.

### Menu modes

`Config.menuStyle` supports:

- `'nui'`: full-screen Vue menu with location camera, progression card, and crew portraits
- `'menu'`: `olink.menu` flow for servers that want a lighter interface

Both modes support:

- clocking in and out
- viewing progression and complaint state
- inviting a crew partner
- responding to pending crew invites

### Shift states

- `IDLE`
- `WAITING`
- `ON_CALL`
- `WORKING`

Normal flow is:

`IDLE -> WAITING -> ON_CALL -> WORKING -> WAITING`

## Dispatch System

After clock-in, dispatch waits a random amount of time between `Config.Calls.minIntervalSeconds` and `Config.Calls.maxIntervalSeconds`, then sends an incoming service call.

### Current call behavior

- Accept with `E`
- Decline with `Backspace`
- Response window is `Config.Calls.responseTimeSeconds`
- Missed and declined calls both count toward the same cap
- Hitting `Config.Calls.maxMissedCalls` automatically ends the shift

### Event rotation

The resource tracks used events during a shift and groups scenes by shared coordinates to reduce immediate repetition. Once all events are used, the pool resets.

## Job Types

There are 4 job types.

### Fuel Help

- Take the jerry can from the tow truck
- Move to the vehicle fuel target
- Complete the fueling interaction

### Wheel Change

- Take the jack from the truck
- Place the jack under the stranded vehicle
- Change the selected wheel using the spare
- Remove the jack

One tire index is selected at runtime for the scene.

### Battery Change

- Remove the dead battery from the stranded vehicle
- Retrieve the replacement battery from the truck
- Install the new battery

### Towing

- Attach the stranded vehicle to the tow truck
- Drive to the delivery location
- Complete at the delivery point

Towing uses `event.deliveryCoords` when present, otherwise `Config.TowingDeliveryPoint`, otherwise the tow yard as the last fallback.

## Mission Timers

Timers are distance-based, not fixed per event.

Current formula:

```lua
timeLimit = Config.Timer.baseTime + math.floor(distance * Config.Timer.timePerDistanceUnit)
```

If the timer expires:

- the job can still be completed
- the speed bonus is lost
- `Config.Timer.expiredPenalty` is applied to the pay calculation

## Props and Truck Setup

The tow truck carries:

- car jack
- spare wheel
- jerry can
- battery
- 3 safety cones

These are attached to the work vehicle and moved between truck, player, and job scene through current `o-link.target` interactions.

The truck also receives keys through `o-link.vehiclekey`.

## Safety Cone System

Cones can be taken from the truck, carried, ghost-placed, picked back up, and returned.

Current defaults:

- 3 cones max
- 6m placement range
- $5 per cone bonus

Placed cones also create traffic speed zones through the configured safety zone system.

## Progression

Progression is stored in the unified `job_progression` table under `job = 'roadside'`.

### Level rewards

Levels increase:

- pay multiplier
- tip chance
- tip range

### Daily streaks

Completing at least one job on consecutive real-world days increases `daily_streak` up to the configured cap.

### Complaints and timeout

Complaints are added for:

- tow truck destruction
- death or downed state during shift

Complaints decay as jobs are completed. Reaching the configured limit causes a temporary timeout.

## Payment

Per-job payment includes:

- base pay by job type
- distance bonus
- on-time speed bonus
- cone bonus
- level multiplier
- late-job penalty multiplier
- streak bonus
- random tip

Per-job formula:

```text
subtotal = floor((basePay + distanceBonus + speedBonus + coneBonus) * levelMultiplier * timerMultiplier)
total = subtotal + streakBonus + tip
```

Shift payout is settled when the shift is finalized and can also be paid during forced cleanup cases such as respawn or disconnect.

Shift deductions include:

- vehicle damage charge
- gas fee
- taxes

Destroyed vehicle fines are removed from cash immediately when the truck is lost.

Successful shift payouts are deposited to bank through `o-link.money`.

## Crew System

Crews are limited to 2 players.

### Crew behavior

- The leader must already be on shift
- The invite target must be nearby
- The target cannot already be in a crew or active shift
- The leader is the only member who accepts or rejects dispatch calls
- Both members can participate in the scene and receive payout breakdowns
- Crew jobs add `Config.Crew.coopBonusPercent`

### Crew continuity

If one member leaves, disconnects, or dies, the remaining member can continue and may inherit the truck and shift state depending on who left.

## NPC and Scene Presentation

For non-towing jobs, stranded NPC drivers exit the vehicle, wait nearby, and switch between ambient and reactive animations depending on player distance and timer state.

Breakdown scenes can include:

- hazards
- cosmetic damage
- engine smoke
- flat tires for wheel jobs

## Summary Output

`Config.shiftSummary` controls how end-of-shift information is shown:

- `'nui'`: NUI summary screen when `Config.menuStyle ~= 'menu'`
- `'text'`: service message through `o-link.phone` when `Config.usePhone = true`, otherwise notification

## Tutorials

The resource includes 13 tutorial prompts covering:

- first clock-in
- incoming calls
- first decline or miss
- each job type
- cone usage
- late completion
- vehicle destruction
- first completion
- crew formation
- level-up

Players can toggle or reset tutorials with:

- `/roadsidetutorials`
- `/roadsidetutorialreset`

## Next Steps

- `INSTALLATION.md`
- `CONFIGURATION.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
