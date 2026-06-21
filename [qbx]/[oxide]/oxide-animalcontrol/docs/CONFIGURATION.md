# Configuration Reference

Reference for the current `oxide-animalcontroljob` config layout.

## Config File Map

| File | Purpose |
|---|---|
| `shared/config.lua` | Core toggles, menu mode, summary mode, enums |
| `shared/config/job.lua` | Crew, payment, complaints, timer, call settings |
| `shared/config/levels.lua` | Level thresholds and rewards |
| `shared/config/locations.lua` | Office locations and shelter delivery point |
| `shared/config/events.lua` | Event list used by dispatch |
| `shared/config/vehicles.lua` | Animal control truck settings |
| `shared/config/animals.lua` | Animal models, tranquilizer, stealth, per-type behavior, loading |
| `shared/config/props.lua` | Bait, deceased bag, and animation settings |
| `shared/config/visuals.lua` | NPCs, blips, reporting NPC, safety zones, waypoints |
| `shared/config/tutorials.lua` | Tutorial definitions |

## General Settings

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---|---|---|---|
| `Config.Debug` | `boolean` | `false` | Enables debug logging |
| `Config.usePhone` | `boolean` | `true` | Sends service messages through `o-link.phone` instead of notification-only flow |
| `Config.shiftSummary` | `string` | `'text'` | `'nui'` for popup summary when menu mode is not `'menu'`, `'text'` for phone/toast summary |
| `Config.menuStyle` | `string` | `'nui'` | `'nui'` for the Vue menu, `'menu'` for `olink.menu` |
| `Config.MaxSlotsPerLocation` | `number` | `3` | Max concurrent shifts at an office |

### Enums

#### `ShiftState`

- `idle`
- `waiting`
- `on_call`
- `working`

#### `JobType`

- `aggressive_animal`
- `stray_capture`
- `wildlife_removal`
- `deceased_pickup`

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
| `Config.Payment.vehicleDestroyFine` | `200` | Cash fine when the truck is destroyed |
| `Config.Payment.streakBonusPerDay` | `10` | Daily streak bonus amount |
| `Config.Payment.maxStreakDays` | `7` | Daily streak cap |
| `Config.Payment.gasFeePercent` | `0.05` | Gross-pay gas deduction |
| `Config.Payment.taxPercent` | `0.10` | Gross-pay tax deduction |

#### Base pay by job type

```lua
Config.Payment.basePay = {
    [JobType.AGGRESSIVE_ANIMAL] = 85,
    [JobType.STRAY_CAPTURE]     = 70,
    [JobType.WILDLIFE_REMOVAL]  = 110,
    [JobType.DECEASED_PICKUP]   = 55,
}
```

### Complaints

| Setting | Default | Description |
|---|---:|---|
| `Config.Complaints.maxComplaints` | `3` | Complaints before timeout |
| `Config.Complaints.timeoutMinutes` | `30` | Timeout duration |
| `Config.Complaints.animalEscapePenalty` | `1` | Complaints added on animal escape |
| `Config.Complaints.animalKillPenalty` | `1` | Complaints added on animal kill |
| `Config.Complaints.animalKillFine` | `150` | Cash fine on animal kill |
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

Default progression is 5 levels from Volunteer through Chief Officer.

## Locations

**File:** `shared/config/locations.lua`

### Shelter delivery point

```lua
Config.ShelterDeliveryPoint = vector3(-1139.70, -319.82, 37.67)
```

This is used for all live animal transport jobs that require shelter delivery.

### Office fields

Each `Config.Locations` entry contains:

- `name`
- `coords`
- `heading`
- `vehicleSpawn`
- `menuCamera`

The default resource ships with 1 office.

## Events

**File:** `shared/config/events.lua`

Each event defines a dispatchable animal report. Current fields are:

| Field | Description |
|---|---|
| `type` | One of the `JobType` values |
| `label` | Locale key for the job label |
| `animalModel` | GTA animal model name |
| `coords` | Event spawn position and heading |
| `reportingNpc` | Whether to spawn a reporting civilian NPC |
| `requiresDelivery` | Whether the animal must be delivered to the shelter |
| `animalWaypoints` | (Wildlife removal only) Array of patrol waypoints |

The default package contains 55 events. Dispatch groups events by shared scene coordinates to reduce repeated locations back-to-back.

### Event count by type

| Job Type | Events |
|---|---:|
| Aggressive Animal | 13 |
| Stray Capture | 15 |
| Wildlife Removal | 5 |
| Deceased Pickup | 22 |

## Vehicle

**File:** `shared/config/vehicles.lua`

| Setting | Default | Description |
|---|---:|---|
| `Config.Vehicle.model` | `'kennel'` | Animal control truck model |
| `Config.Vehicle.spawnDistance` | `5.0` | Spawn-clearance threshold |
| `Config.Vehicle.healthCheckInterval` | `1000` | Health monitor interval in ms |
| `Config.Vehicle.destroyedThreshold` | `150` | Engine-health destruction threshold |
| `Config.Vehicle.damageChargeRate` | `0.50` | Damage deduction per body-health point under threshold |
| `Config.Vehicle.damageChargeThreshold` | `950` | Body-health threshold for clock-out damage charges |

## Animals

**File:** `shared/config/animals.lua`

### Animal models

`Config.Animals` maps model names to display name and health values. The default package includes 14 animal models (dogs, cats, coyote, mountain lion, panther, deer).

### Tranquilizer

| Setting | Default | Description |
|---|---:|---|
| `Config.Tranquilizer.weaponHash` | `'WEAPON_G2'` | Weapon hash for the dart gun |
| `Config.Tranquilizer.ammoPerCall` | `5` | Darts provided per dispatch call |
| `Config.Tranquilizer.sedationDuration` | `30000` | Sedation duration in ms |

### Stealth detection

| Setting | Default | Description |
|---|---:|---|
| `Config.Stealth.useNativeStealth` | `true` | Use native crouch detection |
| `Config.Stealth.fallbackSpookChance` | `0.35` | Spook chance when not using native stealth |
| `Config.Stealth.fallbackSafeChance` | `0.70` | Safe chance when using fallback mode |

### Animal behavior

Per-job-type behavior settings in `Config.AnimalBehavior`. Each job type defines:

- task type
- detection and escape radii
- spook/flee distances
- wander behavior
- NPC reaction radii

### Animal loading

| Setting | Default | Description |
|---|---:|---|
| `Config.AnimalLoading.loadDuration` | `5000` | Loading progress bar duration in ms |
| `Config.AnimalLoading.unloadDuration` | `4000` | Unloading progress bar duration in ms |
| `Config.AnimalLoading.loadRange` | `3.0` | Max distance from animal to begin loading |
| `Config.AnimalLoading.shelterRange` | `5.0` | Max distance from shelter to unload |

## Props

**File:** `shared/config/props.lua`

This file controls:

- bait prop model and placement range
- bait scent particle effect
- bait player attachment offsets
- deceased bag model and durations
- deceased bag carry animation
- capture, bait place, load, and unload progress bar animations

Primary props:

- `bait` (dog bowl)
- `deceasedBag` (bin bag)

## Visuals

**File:** `shared/config/visuals.lua`

### NPC and blips

- `Config.NpcModel`
- `Config.NpcScenario`
- `Config.Blip`
- `Config.EventBlip`
- `Config.DeliveryBlip`

### Reporting NPC models

`Config.ReportingNpcModels` contains 16 possible civilian models for the person who reported the animal incident.

### Reporting NPC behavior

`Config.ReportingNPC` controls:

- stand offset from animal
- animation cycle (beckoning, frightened, hand gestures)
- thank-you animation
- far-away scenario
- animation distance threshold

### Safety zones

`Config.SafetyZone` controls:

- whether safety zones run
- speed zone tiers
- scenario blocking radius
- parked vehicle clearing radius

### Waypoints

`Config.Waypoints` controls marker height, scaling, and render timing.

## Tutorials

**File:** `shared/config/tutorials.lua`

`Config.Tutorials` contains 17 first-time guidance prompts. Each entry defines:

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
- `animalSync`
- `updateAnimal`
- `updateReportingNpc`
- `updateVehicle`
- `vehicleDestroyed`
- `animalEscaped`
- `animalKilled`

## Next Steps

- `INSTALLATION.md`
- `FEATURES.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
