# Feature Guide

Overview of the current `oxide-animalcontroljob` gameplay flow and systems.

## Shift Flow

Players manage the job from the dispatcher NPC at the animal control office using the configured `o-link` target integration.

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

### Slot limits

Each office location has a configurable maximum number of concurrent shift slots (default: 3). If all slots are full, new players cannot clock in at that location.

## Dispatch System

After clock-in, dispatch waits a random amount of time between `Config.Calls.minIntervalSeconds` and `Config.Calls.maxIntervalSeconds`, then sends an incoming animal report.

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

### Aggressive Animal

- Drive to the reported location where a reporting NPC is being attacked
- Use the tranquilizer dart gun to sedate the animal
- The animal becomes ragdolled for 30 seconds (sedation timer)
- Bring your truck close and interact to load the sedated animal
- Drive to the animal shelter delivery point and unload

The animal attacks the reporting NPC, then redirects aggression to the player within the configured attack range. Nearby world peds flee from the animal.

### Stray Capture

- Take bait from the truck via the target interaction
- Place the bait near the animal using the ghost preview system
- Move away from the bait (at least 15m) and wait for the animal to approach
- Once the animal is eating, sneak up while crouching to avoid spooking it
- Get within capture range and interact to calm the animal
- Load the calmed animal into the truck and deliver to the shelter

The animal wanders within its spawn radius. If the player approaches too quickly while standing, there is a configurable chance to spook the animal, causing it to flee before eventually returning.

### Wildlife Removal

- Drive to the reported location (no reporting NPC)
- The animal patrols between predefined waypoints, wandering at each point
- Stay crouched and approach carefully to avoid spooking the animal
- Use the tranquilizer dart gun to sedate the animal
- Load the sedated animal into the truck and deliver to the shelter

The animal follows a waypoint patrol route with detection ranges for standing vs crouching players. Nearby world peds flee within the configured radius.

### Deceased Pickup

- Drive to the reported location (no reporting NPC)
- The animal is lying on the ground in a dead state
- Interact to collect the remains into a body bag
- Carry the body bag back to the truck and load it

No tranquilization or shelter delivery needed.

## Tranquilizer System

A tranquilizer dart gun is provided through the inventory system when a player clocks in.

### Current behavior

1. On clock-in, the server gives the player a `weapon_g2` item through `o-link.inventory`
2. Each call provides `Config.Tranquilizer.ammoPerCall` darts
3. Dart damage is restricted to only affect the active job's animal while on shift
4. A successful hit sedates the animal for `Config.Tranquilizer.sedationDuration`
5. If the animal wakes up, it must be tranquilized again
6. On clock-out, the weapon is removed from the player's inventory

### Damage restriction

The server intercepts all `weaponDamageEvent` events for the dart weapon. While on shift, dart damage only passes through to the active job animal. All other targets are blocked.

### PvP tranq effect

Dart hits on other players trigger a brief screen effect and camera shake on the victim.

## Bait System

Bait is used in stray capture jobs to lure frightened animals.

### Current behavior

1. Take bait from the truck via target interaction
2. The bait attaches to the player's hand with a carry animation
3. A ghost preview appears where the player aims (max 8m range)
4. Press `E` to place the bait, or `Backspace` to cancel
5. A scent particle effect plays at the bait location
6. The player must move at least 15m away before the animal approaches
7. After a delay, the animal moves toward the bait
8. Once the animal is eating, the player can sneak up to capture range

### Spook mechanics

If the player approaches a stray too quickly while standing, there is a configurable chance to spook the animal. Spooked animals flee before eventually returning to the bait area.

## Stealth Detection

The stealth system determines whether a player is sneaking for animal spook checks.

### Native mode (default)

When `Config.Stealth.useNativeStealth` is `true`, the system uses `GetPedStealthMovement` to detect whether the player is crouching.

### Fallback mode

When `Config.Stealth.useNativeStealth` is `false` (for servers with custom crouch systems), spook checks use random chance via `Config.Stealth.fallbackSpookChance` and `Config.Stealth.fallbackSafeChance`.

## Animal Behavior

Each job type has distinct AI behavior that governs how the animal interacts with the player and the world.

### Animal state machine

All animals follow a unified state machine:

- `ALIVE` - Active, performing job-type-specific behavior
- `SEDATED` - Tranquilized and ragdolled (temporary, wakes up after sedation duration)
- `CAPTURED` - Calmed by player (stray capture only)
- `LOADED` - Loaded into the truck
- `DEAD` - Killed or spawned dead (deceased pickup)

### Escape detection

Each job type has an escape radius. If the animal moves beyond this distance from its spawn point, it is considered escaped. An escaped animal triggers a complaint and cancels the current job.

### World NPC reactions

Aggressive animals and wildlife cause nearby world NPCs to flee within their configured radius.

## Animal Loading and Delivery

After sedating or calming an animal, it must be loaded into the truck and (for most job types) delivered to the shelter.

### Loading

Bring the truck within range of the animal and interact to begin loading. The animal attaches to the vehicle cargo area at the configured offset.

### Shelter delivery

For jobs with `requiresDelivery = true`, a delivery blip and waypoint appear. Drive to the shelter and interact to unload the animal.

### Deceased remains

For deceased pickup jobs, interact with the animal to collect remains into a body bag, then carry it back to the truck and load it.

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

## Progression

Progression is stored in the unified `job_progression` table under `job = 'animalcontrol'`.

### Level rewards

Levels increase:

- pay multiplier
- tip chance
- tip range

Default progression is 5 levels from Volunteer through Chief Officer.

### Daily streaks

Completing at least one job on consecutive real-world days increases `daily_streak` up to the configured cap.

### Complaints and timeout

Complaints are added for:

- animal escape
- animal killed
- vehicle destruction
- death or downed state during shift

Complaints decay as jobs are completed. Reaching the configured limit causes a temporary timeout.

## Payment

Per-job payment includes:

- base pay by job type
- distance bonus
- on-time speed bonus
- level multiplier
- late-job penalty multiplier
- streak bonus
- random tip

Per-job formula:

```text
subtotal = floor((basePay + distanceBonus + speedBonus) * levelMultiplier * timerMultiplier)
total = subtotal + streakBonus + tip
```

Shift payout is settled when the shift is finalized and can also be paid during forced cleanup cases such as respawn or disconnect.

Shift deductions include:

- vehicle damage charge
- vehicle destruction fine
- ammo resupply costs
- gas fee
- taxes

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

## Reporting NPC

For aggressive animal, stray capture, and some wildlife events, a random civilian NPC spawns near the animal to represent the person who called in the report.

The NPC cycles through contextual animations (beckoning, frightened, hand gestures) when the player is within range, switches to an ambient scenario when far away, and plays a thank-you animation on job completion.

A pool of 16 civilian ped models is used, with a random selection per job.

## Vehicle System

An animal control truck spawns at the office's vehicle spawn point when a player clocks in.

Current behavior:

- license plate set to `ACSVC`
- vehicle keys provided through `o-link`
- health monitored at a configurable interval
- target interactions for taking bait, loading animals, and loading remains
- destruction triggers complaint + fine + dispatch stop

### Vehicle damage charges

At clock-out, if the truck's body health is below the configured threshold, a damage charge is calculated and deducted from the shift payout.

### Crew vehicle sharing

When a crew is formed, the partner receives a reference to the leader's truck. If the leader clocks out, ownership transfers to the partner.

## Safety Zones

Around each animal scene, safety zones slow down NPC traffic to reduce interference.

Current defaults:

- inner zone: 15m radius, 8 mph
- outer zone: 30m radius, 20 mph
- ambient ped scenarios blocked within 15m
- parked vehicles cleared within 8m

## HUD Overlay

A NUI panel appears during active jobs showing:

- mission timer countdown with late indicator
- job type label
- context-sensitive hint text synced to partner if in crew

## Waypoints

A 3D floating waypoint marker appears above the current job destination:

- configurable height offset above ground
- scales between min and max based on distance
- shows distance text
- toggles visibility by holding `H`

## Summary Output

`Config.shiftSummary` controls how end-of-shift information is shown:

- `'nui'`: NUI summary screen when `Config.menuStyle ~= 'menu'`
- `'text'`: service message through `o-link.phone` when `Config.usePhone = true`, otherwise notification

## Phone Integration

If `Config.usePhone = true`, email notifications are sent through `o-link.phone` for key shift events:

- shift start welcome message
- vehicle destruction alerts
- death/hospitalization notices
- animal escape and kill incident reports
- end-of-shift summary with full payment breakdown

## Tutorials

The resource includes 17 tutorial prompts covering:

- first clock-in
- incoming calls
- first decline or miss
- each job type
- tranquilizer hit
- bait placement
- animal loading and delivery
- timer expiry
- vehicle destruction
- first completion
- crew formation
- level-up

Players can toggle or reset tutorials with:

- `/animalcontroltutorials`
- `/animalcontroltutorialreset`

## Next Steps

- `INSTALLATION.md`
- `CONFIGURATION.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
