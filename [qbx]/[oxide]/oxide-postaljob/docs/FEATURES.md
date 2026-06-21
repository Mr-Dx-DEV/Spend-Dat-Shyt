# Feature Guide

Overview of the current `oxide-postaljob` gameplay flow and systems.

## Shift Flow

Players manage the job from the supervisor NPC at the GoPostal depot using the configured `o-link` target integration.

### Menu modes

`Config.menuStyle` supports:

- `'nui'`: full-screen Vue menu with cinematic camera, crew headshot portraits, and progression card
- `'menu'`: `olink.menu` flow for servers that want a lighter interface

Both modes support:

- clocking in and out
- viewing progression and complaint state
- requesting a new task
- inviting a crew partner
- responding to pending crew invites
- toggling the GoPostal uniform

### Shift states

- `IDLE`
- `CLOCKED_IN`
- `LOADING`
- `DELIVERING`

Normal flow is:

`IDLE -> CLOCKED_IN -> LOADING -> DELIVERING -> CLOCKED_IN`

### Slot limits

Each depot has a configurable maximum number of concurrent shift slots (`Config.MaxSlotsPerLocation`, default 3). If all slots are full, new players cannot clock in at that location.

## Task Types

When requesting a task from the supervisor menu, the server randomly assigns one of two task types.

### Packages

- A pallet with cardboard boxes spawns at one of the depot's pickup points
- Player uses third-eye on individual boxes to pick them up (crouch animation, 3s)
- Player carries the box to the van's rear doors
- Player uses third-eye on the van to load the box (rear doors must be open)
- Box prop attaches inside the van at predefined offsets
- Repeat until all boxes are loaded
- Shift transitions to `DELIVERING`

### Letters

- A GPS blip guides the player to a randomly selected post box
- Player uses third-eye on the post box zone to collect the mail bag (crouch animation, 3s)
- Player carries the mail bag to the van's rear doors
- Player uses third-eye on the van to load the mail bag
- Shift transitions to `DELIVERING`

The number of deliveries per batch scales with the player's progression level.

## Delivery Phase

### Package delivery

- A GPS blip and route appear for the next delivery address
- A delivery timer starts based on distance
- Player drives to the delivery zone (marker visible within 20m)
- Player opens the van's rear doors and uses third-eye to grab a package
- Player carries the package to the delivery marker (within 3m) and presses `E`
- A customer NPC spawns, walks toward the player, and a handoff animation plays
- The box prop transfers from the player to the customer, who walks away and fades out
- Payment notification appears with a breakdown of earnings

### Letter delivery

- A GPS blip and route appear for the next letterbox location
- A delivery timer starts based on distance
- Player drives near the letterbox (marker visible within 20m)
- Player exits the vehicle and uses third-eye on the letterbox zone
- An envelope prop appears briefly during the delivery animation
- Payment notification appears

After all deliveries in a batch are complete, the shift returns to `CLOCKED_IN` state. The player can request another task or clock out.

## Mission Timers

Timers are distance-based, not fixed per delivery.

Current formula:

```lua
timeLimit = Config.Timer.baseTime + math.floor(distance * Config.Timer.timePerDistanceUnit)
```

If the timer expires:

- the delivery can still be completed
- the speed bonus is lost
- `Config.Timer.expiredPenalty` is applied to the pay calculation

## Route Intelligence

### Spread-aware zone selection

When generating a delivery batch, zones are selected based on the player's level `spreadFactor` rather than pure randomness:

- High spread factor (low-level players): deliveries are biased toward zones that are far apart, encouraging map exploration
- Low spread factor (high-level players): deliveries cluster in a tight area for efficient grinding
- Selection uses nearest-selected distance scoring with random-within-half selection for variety

### Route ordering

After zones are selected, orders are sorted into a logical driving loop using a greedy nearest-neighbor algorithm starting from the depot. When crew extra orders are added to a fresh batch, the route is re-sorted to integrate them. Mid-shift partner joins do not re-sort to avoid disrupting an in-progress route.

## Props and Van Setup

The delivery van (`boxville2`):

- white primary and secondary color, plate `GOPOST`
- keys provided through `o-link.vehiclekey`
- fuel set to 100 through `o-link.fuel`
- rear doors (indices 2, 3) must be open for loading and unloading
- health monitored every 1 second; destruction below threshold 150 ends current deliveries and adds a complaint

Package pallets use `bkr_prop_coke_pallet_01a` with up to 12 visible box entities. Letter tasks use `h4_prop_h4_med_bag_01b` as the carry prop.

## Progression

Progression is stored in the unified `job_progression` table under `job = 'postal'`.

### Level rewards

Levels increase:

- pay multiplier (1.0x to 1.5x)
- tip chance (10% to 40%)
- tip range ($5-15 to $15-50)
- batch size (3-9 packages, 3-6 letters)
- route clustering (spread factor 1.0 to 0.0)

Default progression is 5 levels from Trainee through Head Postman.

### Daily streaks

Completing at least one delivery on consecutive real-world days increases `daily_streak` up to `Config.Payment.maxStreakDays` (default 7). Missing a day resets the streak to 1.

### Complaints and timeout

Complaints are added for:

- delivery van destruction
- death or downed state during shift

Complaints decay as deliveries are completed. Reaching `Config.Complaints.maxComplaints` (default 3) causes a temporary timeout of `Config.Complaints.timeoutMinutes` (default 30 minutes).

## Payment

Per-delivery payment includes:

- base pay
- distance bonus
- on-time speed bonus
- level multiplier
- late-delivery penalty multiplier
- streak bonus
- random tip

Per-delivery formula:

```text
subtotal = floor((basePay + distanceBonus + speedBonus) * levelMultiplier * timerMultiplier)
total = subtotal + streakBonus + tip
```

Shift payout is settled when the shift is finalized.

Shift deductions include:

- early finish penalty (clocking out with undelivered packages)
- vehicle damage charge
- gas fee (`Config.Payment.gasFeePercent`)
- taxes (`Config.Payment.taxPercent`)

The vehicle destroy fine is removed from cash immediately when the van is lost.

Successful shift payouts are deposited to bank through `o-link.money`.

## Crew System

Crews are limited to 2 players.

### Crew behavior

- The leader must already be on shift
- The invite target must be nearby
- The target cannot already be in a crew or active shift
- Crew formation adds 2 extra deliveries to the current batch
- Either player can pick up boxes, load the van, grab packages, and deliver
- Deliveries completed in a crew earn a 15% co-op bonus (`Config.Crew.coopBonusPercent`)
- Both players receive per-delivery payment notifications

### Crew continuity

If one member leaves, disconnects, or dies, the remaining member can continue:

- Leader clocks out: vehicle and shift transfer to partner
- Partner clocks out: leader continues solo
- Either disconnects: remaining member continues, partner notified
- Either dies: death cleanup for the dead member, partner notified

## Customer Reactions

When delivering packages, a customer NPC spawns and reacts based on delivery timeliness:

- On-time: normal walk speed, `givetake1_a` accept animation
- Late: slow walk speed, `gesture_no_way` frustrated animation, complaint notification

Customer peds are randomly selected from `Config.CustomerPeds`. Customer NPCs are only spawned for package deliveries, not letters.

## Bystander System

Players who are not on a shift can see visual-only pallets at depot locations when other players are actively loading. Bystander pallets spawn via GlobalState synchronization, use non-networked collision-disabled objects, update box count in real-time, and despawn when the player moves out of range or starts their own shift.

## Uniform System

Players can toggle a GoPostal uniform on or off through the supervisor menu. Separate outfits are configured for male and female character models through `o-link.clothing`. The uniform is automatically removed when clocking out.

## Summary Output

`Config.shiftSummary` controls how end-of-shift information is shown:

- `'nui'`: NUI summary screen when `Config.menuStyle ~= 'menu'`
- `'text'`: phone email through `o-link.phone` on clock-out; notification when `Config.menuStyle = 'menu'`

## HUD Overlay

A NUI delivery panel appears during the `DELIVERING` state showing the current delivery timer, late indicator when expired, delivery progress count, and context hints.

## Waypoints

A 3D floating waypoint marker appears above the current delivery destination. The waypoint scales between `Config.Waypoints.scaleMin` and `Config.Waypoints.scaleMax` based on distance and shows distance text. Visibility can be toggled by holding `H`.

## Tutorials

The resource includes 9 tutorial prompts covering:

- first clock-in
- first loading phase
- first delivery start
- first delivery complete
- first timer expiry
- first vehicle damage
- first level-up
- first batch complete
- first crew formation

Players can toggle or reset tutorials with:

- `/postaltutorials`
- `/postaltutorialreset`

## Next Steps

- `INSTALLATION.md`
- `CONFIGURATION.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
