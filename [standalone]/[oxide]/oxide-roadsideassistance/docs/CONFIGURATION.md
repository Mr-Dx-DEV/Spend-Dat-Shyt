# Configuration Reference

Reference for the current `oxide-roadsideassistancejob` config layout.

## Config File Map

| File | Purpose |
|---|---|
| `shared/config.lua` | Core toggles, menu mode, summary mode, enums |
| `shared/config/job.lua` | Crew, payment, complaints, timer, call settings |
| `shared/config/levels.lua` | Level thresholds and rewards |
| `shared/config/locations.lua` | Tow yards and global towing delivery fallback |
| `shared/config/events.lua` | Event list used by dispatch |
| `shared/config/vehicles.lua` | Tow truck settings |
| `shared/config/props.lua` | Tool prop, animation, jack, and wheel settings |
| `shared/config/visuals.lua` | NPCs, blips, cones, safety zones, effects, waypoints |
| `shared/config/tutorials.lua` | Tutorial definitions |

## General Settings

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.Debug` | `boolean` | `false` | Enables debug logging |
| `Config.usePhone` | `boolean` | `true` | Sends service messages through `o-link.phone` instead of notification-only flow |
| `Config.shiftSummary` | `string` | `'text'` | `'nui'` for popup summary when menu mode is not `'menu'`, `'text'` for phone/toast summary |
| `Config.menuStyle` | `string` | `'nui'` | `'nui'` for the Vue menu, `'menu'` for `olink.menu` |
| `Config.MaxSlotsPerLocation` | `number` | `3` | Max concurrent shifts at a tow yard |

### Enums

#### `ShiftState`

- `idle`
- `waiting`
- `on_call`
- `working`

#### `JobType`

- `fuel_help`
- `change_wheel`
- `towing`
- `battery_change`

## Job Settings

**File:** `shared/config/job.lua`

### Crew

| Setting | Default | Description |
|---|---:|---|
| `Config.Crew.maxSize` | `2` | Crew size limit |
| `Config.Crew.inviteTimeout` | `60` | Crew invite expiry in seconds |
| `Config.Crew.coopBonusPercent` | `0.15` | Co-op bonus added to completed jobs |

### Payment

| Setting | Default | Description |
|---|---:|---|
| `Config.Payment.distanceBonusPerUnit` | `0.30` | Distance bonus multiplier |
| `Config.Payment.speedBonusAmount` | `25` | Bonus when finishing before timer expiry |
| `Config.Payment.vehicleDestroyFine` | `200` | Cash fine when the tow truck is destroyed |
| `Config.Payment.streakBonusPerDay` | `10` | Daily streak bonus amount |
| `Config.Payment.maxStreakDays` | `7` | Daily streak cap |
| `Config.Payment.gasFeePercent` | `0.05` | Gross-pay gas deduction |
| `Config.Payment.taxPercent` | `0.10` | Gross-pay tax deduction |

#### Base pay by job type

```lua
Config.Payment.basePay = {
    [JobType.FUEL_HELP]      = 60,
    [JobType.CHANGE_WHEEL]   = 80,
    [JobType.TOWING]         = 100,
    [JobType.BATTERY_CHANGE] = 70,
}
```

### Complaints

| Setting | Default | Description |
|---|---:|---|
| `Config.Complaints.maxComplaints` | `3` | Complaints before timeout |
| `Config.Complaints.timeoutMinutes` | `30` | Timeout duration |
| `Config.Complaints.vehicleDestroyPenalty` | `1` | Complaints added on vehicle destruction |
| `Config.Complaints.deathPenalty` | `1` | Complaints added on death/down |
| `Config.Complaints.decayPerJob` | `1` | Complaints removed per completed job |

### Timer

| Setting | Default | Description |
|---|---:|---|
| `Config.Timer.baseTime` | `90` | Base mission time in seconds |
| `Config.Timer.timePerDistanceUnit` | `0.20` | Added seconds per unit from call acceptance to event |
| `Config.Timer.expiredPenalty` | `0.85` | Pay multiplier for late completion |

Current timer formula:

```lua
timeLimit = Config.Timer.baseTime + math.floor(distance * Config.Timer.timePerDistanceUnit)
```

There is no `Config.Timer.extraTime` in the current implementation, and default events do not define `missionTime`.

### Calls

| Setting | Default | Description |
|---|---:|---|
| `Config.Calls.minIntervalSeconds` | `15` | Minimum delay between dispatches |
| `Config.Calls.maxIntervalSeconds` | `45` | Maximum delay between dispatches |
| `Config.Calls.responseTimeSeconds` | `30` | Accept/decline window |
| `Config.Calls.maxMissedCalls` | `3` | Misses/declines before auto clock-out |

## Levels

**File:** `shared/config/levels.lua`

Each level entry defines:

- `title`
- `requiredJobs`
- `payMultiplier`
- `tipChance`
- `tipRange`

Default progression is 5 levels from trainee through master technician.

## Locations

**File:** `shared/config/locations.lua`

### Global tow delivery fallback

```lua
Config.TowingDeliveryPoint = vector3(2387.94, 3088.48, 48.19)
```

This is used for towing jobs when an event does not define its own `deliveryCoords`.

### Tow yard fields

Each `Config.Locations` entry contains:

- `name`
- `coords`
- `heading`
- `vehicleSpawn`
- `menuCamera`

The default resource ships with 1 tow yard.

## Events

**File:** `shared/config/events.lua`

Each event defines a dispatchable roadside scene. Current fields are:

| Field | Description |
|---|---|
| `type` | One of the `JobType` values |
| `label` | Locale key for the job label |
| `vehicle` | GTA vehicle model |
| `coords` | Event spawn position and heading |
| `fuelBone` | Optional fuel-cap bone index for fuel jobs |
| `deliveryCoords` | Optional per-event towing drop-off override |
| `npcDriver` | Whether the scene spawns a stranded NPC driver |

The default package contains 40 events total. Dispatch groups events by shared scene coordinates to reduce repeated locations back-to-back.

## Vehicle

**File:** `shared/config/vehicles.lua`

| Setting | Default | Description |
|---|---:|---|
| `Config.Vehicle.model` | `'towtruck'` | Tow truck model |
| `Config.Vehicle.spawnDistance` | `5.0` | Spawn-clearance threshold |
| `Config.Vehicle.healthCheckInterval` | `1000` | Health monitor interval in ms |
| `Config.Vehicle.destroyedThreshold` | `150` | Engine-health destruction threshold |
| `Config.Vehicle.damageChargeRate` | `0.50` | Damage deduction per body-health point under threshold |
| `Config.Vehicle.damageChargeThreshold` | `950` | Body-health threshold for clock-out damage charges |

## Props

**File:** `shared/config/props.lua`

This file controls:

- tool prop models
- truck attachment offsets
- player carry attachment offsets
- fuel, wheel, and battery animations
- jack raise steps and timing
- wheel bone mappings

Primary props:

- `jack`
- `spareWheel`
- `jerryCan`
- `battery`

## Visuals

**File:** `shared/config/visuals.lua`

### NPC and blips

- `Config.NpcModel`
- `Config.NpcScenario`
- `Config.Blip`
- `Config.EventBlip`
- `Config.DeliveryBlip`

### Driver peds

`Config.DriverPeds` contains 16 possible stranded-driver models.

### Stranded NPC behavior

`Config.StrandedNPC` controls:

- stand offset
- animation cycle
- impatient animation
- far-away scenario
- animation distance threshold

### Breakdown visuals

`Config.BreakdownVisuals` controls damage points, smoke health, and hazards.

### Safety zones

`Config.SafetyZone` controls:

- whether safety zones run
- speed zone tiers
- scenario blocking radius
- parked vehicle clearing radius

### Cones

`Config.Cones` controls:

- enabled state
- cone model
- max cone count
- per-cone bonus
- placement range
- truck attach positions
- player attach position

### Repair effects

`Config.RepairEffects.spark` controls spark VFX during wheel and battery work.

### Waypoints

`Config.Waypoints` controls marker height, scaling, and render timing.

## Tutorials

**File:** `shared/config/tutorials.lua`

`Config.Tutorials` contains 13 first-time guidance prompts. Each entry defines:

- `icon`
- `title`
- `body`
- `position`
- `duration`

## Server Rate Limits

**File:** `server/main.lua`

Current rate-limited actions include:

- `clockIn`
- `clockOut`
- `acceptCall`
- `rejectCall`
- `completeJob`
- `crewInvite`
- `respondToInvite`
- `propSync`
- `coneSync`
- `repairStepSync`
- `updateVehicle`
- `updateStrandedVehicle`
- `vehicleDestroyed`

## Next Steps

- `INSTALLATION.md`
- `FEATURES.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
