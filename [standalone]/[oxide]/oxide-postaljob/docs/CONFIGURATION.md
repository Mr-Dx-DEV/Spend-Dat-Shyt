# Configuration Reference

Reference for the current `oxide-postaljob` config layout.

## Config File Map

| File | Purpose |
|------|---------|
| `shared/config.lua` | General settings (debug, sync, slot limits) |
| `shared/config/job.lua` | Crew, payment, complaints, timer settings |
| `shared/config/levels.lua` | Progression level definitions |
| `shared/config/locations.lua` | Depot locations, delivery zones, letterboxes |
| `shared/config/npcs.lua` | NPC models, blip settings, customer reactions |
| `shared/config/outfits.lua` | Male/female GoPostal uniform components |
| `shared/config/vehicles.lua` | Van model, props, offsets, health settings |
| `shared/config/visuals.lua` | Markers, animations, waypoint rendering |
| `shared/init.lua` | ShiftState and TaskType enums |
| `server/main.lua` | Rate limit configuration |

## General Settings

**File:** `shared/config.lua`

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Debug` | `boolean` | `false` | Enable debug logging with `[oxide-postaljob]` prefix |
| `Config.shiftSummary` | `string` | `'text'` | `'nui'` for popup summary when menu mode is not `'menu'`, `'text'` for phone/toast summary |
| `Config.menuStyle` | `string` | `'nui'` | `'nui'` for the Vue menu, `'menu'` for `olink.menu` |
| `Config.Sync.broadcastRange` | `number` | `250.0` | Range in meters for broadcasting pallet sync events to nearby players |
| `Config.MaxSlotsPerLocation` | `number` | `3` | Max concurrent shifts at a depot |

## Job Settings

**File:** `shared/config/job.lua`

### Crew

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Crew.maxSize` | `number` | `2` | Maximum crew members (leader + partner) |
| `Config.Crew.inviteTimeout` | `number` | `60` | Seconds before a crew invite expires |
| `Config.Crew.coopBonusPercent` | `number` | `0.15` | Bonus percentage applied to deliveries completed while in a crew (15%) |
| `Config.Crew.extraDeliveries` | `number` | `2` | Extra deliveries added when a partner joins the crew |

### Payment

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Payment.basePay` | `number` | `40` | Base pay per delivery |
| `Config.Payment.distanceBonusPerUnit` | `number` | `0.40` | Bonus per distance unit from origin to delivery point |
| `Config.Payment.speedBonusAmount` | `number` | `20` | Flat bonus for completing a delivery before the timer expires |
| `Config.Payment.earlyFinishPenalty` | `number` | `0.80` | Multiplier applied when clocking out with undelivered packages (20% deduction) |
| `Config.Payment.vehicleDestroyFine` | `number` | `150` | Flat fine when the delivery van is destroyed |
| `Config.Payment.streakBonusPerDay` | `number` | `10` | Bonus added per consecutive daily streak day |
| `Config.Payment.maxStreakDays` | `number` | `7` | Maximum streak days (caps the streak bonus) |
| `Config.Payment.minDeliveryTimePerDistanceUnit` | `number` | `0.05` | Minimum delivery time scaling per distance unit |
| `Config.Payment.gasFeePercent` | `number` | `0.05` | Gross-pay gas deduction |
| `Config.Payment.taxPercent` | `number` | `0.10` | Gross-pay tax deduction |
| `Config.Payment.absoluteMinDeliveryTime` | `number` | `10` | Absolute minimum delivery time in seconds |

### Complaints

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Complaints.maxComplaints` | `number` | `3` | Complaints needed to trigger a suspension |
| `Config.Complaints.timeoutMinutes` | `number` | `30` | Suspension duration in minutes |
| `Config.Complaints.vehicleDestroyPenalty` | `number` | `1` | Complaints added when the van is destroyed |
| `Config.Complaints.deathPenalty` | `number` | `1` | Complaints added when the player dies on shift |
| `Config.Complaints.decayPerDelivery` | `number` | `1` | Complaints removed per successful delivery |

### Timer

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Timer.baseTime` | `number` | `60` | Base delivery timer in seconds |
| `Config.Timer.timePerDistanceUnit` | `number` | `0.25` | Additional seconds per distance unit from player to delivery point |
| `Config.Timer.expiredPenalty` | `number` | `0.85` | Payment multiplier when delivering after the timer expires (15% penalty) |

Current timer formula:

```lua
timeLimit = Config.Timer.baseTime + math.floor(distance * Config.Timer.timePerDistanceUnit)
```

## Levels

**File:** `shared/config/levels.lua`

Each level is defined as an entry in `Config.Levels`:

| Field | Type | Description |
|-------|------|-------------|
| `title` | `string` | Locale key for the level title |
| `requiredDeliveries` | `number` | Total deliveries needed to reach this level |
| `maxPackages` | `number` | Maximum packages per batch |
| `maxLetters` | `number` | Maximum letters per batch |
| `tipChance` | `number` | Probability of receiving a tip (0.0 - 1.0) |
| `tipRange` | `table` | Min/max tip amount `{ min, max }` |
| `payMultiplier` | `number` | Multiplier applied to base pay calculation |
| `spreadFactor` | `number` | Route spread bias (0.0 = tight clusters, 1.0 = spread apart). Controls how delivery zones are selected — low-level players get sparse routes for map exploration, high-level players get clustered routes for efficient grinding |

### Default Levels

```lua
Config.Levels = {
    [1] = { title = 'level.trainee',        requiredDeliveries = 0,   maxPackages = 3, maxLetters = 3, tipChance = 0.10, tipRange = { 5, 15 },  payMultiplier = 1.0,  spreadFactor = 1.0  },
    [2] = { title = 'level.mail_carrier',   requiredDeliveries = 20,  maxPackages = 4, maxLetters = 4, tipChance = 0.15, tipRange = { 5, 20 },  payMultiplier = 1.0,  spreadFactor = 0.75 },
    [3] = { title = 'level.senior_courier', requiredDeliveries = 50,  maxPackages = 5, maxLetters = 4, tipChance = 0.25, tipRange = { 10, 30 }, payMultiplier = 1.15, spreadFactor = 0.5  },
    [4] = { title = 'level.route_manager',  requiredDeliveries = 100, maxPackages = 7, maxLetters = 5, tipChance = 0.30, tipRange = { 10, 40 }, payMultiplier = 1.3,  spreadFactor = 0.25 },
    [5] = { title = 'level.head_postman',   requiredDeliveries = 200, maxPackages = 9, maxLetters = 6, tipChance = 0.40, tipRange = { 15, 50 }, payMultiplier = 1.5,  spreadFactor = 0.0  },
}
```

## Locations

**File:** `shared/config/locations.lua`

### Depot Structure

Each location in `Config.Locations` defines a complete depot:

| Field | Type | Description |
|-------|------|-------------|
| `name` | `string` | Locale key for the depot name |
| `coords` | `vector3` | NPC supervisor position |
| `heading` | `number` | NPC facing direction |
| `vehicleSpawn` | `vector4` | Van spawn position and heading |
| `pickupPoints` | `table` | Array of `vector4` pallet spawn locations |
| `postBoxes` | `table` | Array of `vector4` post box locations for letter tasks |
| `letterBoxes` | `table` | Array of letterbox definitions |
| `deliveryZones` | `table` | Array of delivery zone definitions |
| `menuCamera` | `table` | Camera used in `'nui'` menu mode. Fields: `coords` (vector3), `heading` (number), `fov` (number) |

### Delivery Zones

Each entry in `deliveryZones`:

| Field | Type | Description |
|-------|------|-------------|
| `coords` | `vector3` | Delivery destination coordinates |
| `minLevel` | `number` | Minimum player level required to receive this zone |
| `label` | `string` | Locale key for the zone label (e.g., street name) |

### Letterboxes

Each entry in `letterBoxes`:

| Field | Type | Description |
|-------|------|-------------|
| `coords` | `vector3` | Letterbox world coordinates |
| `minLevel` | `number` | Minimum player level required |
| `label` | `string` | Locale key for the letterbox label |

### Post Boxes

Each entry in `postBoxes` is a `vector4` defining the coordinates and heading of a post box where players collect mail bags for letter tasks.

## NPCs

**File:** `shared/config/npcs.lua`

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.NpcModel` | `string` | `'s_m_m_postal_01'` | Ped model for the supervisor NPC |
| `Config.NpcScenario` | `string` | `'WORLD_HUMAN_CLIPBOARD'` | Ambient scenario the NPC performs |

### Blip Settings

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Blip.sprite` | `number` | `480` | Map blip sprite ID |
| `Config.Blip.color` | `number` | `2` | Map blip color |
| `Config.Blip.scale` | `number` | `0.6` | Map blip scale |
| `Config.Blip.label` | `string` | `'blip.gopostal_office'` | Locale key for blip label |

### Customer Peds

`Config.CustomerPeds` is an array of ped model names used for spawning customer NPCs at delivery points. A random model is selected for each delivery.

### Customer Reactions

| Reaction | Walk Speed | Animation Dict | Animation Name | Message |
|----------|-----------|----------------|----------------|---------|
| `good` | 1.0 | `mp_common` | `givetake1_a` | None |
| `poor` | 0.8 | `gestures@m@standing@casual` | `gesture_no_way` | `notify.customer_took_long` |

## Outfits

**File:** `shared/config/outfits.lua`

Separate outfit configurations for male (`Config.PostalOutfitMale`) and female (`Config.PostalOutfitFemale`) characters. Each contains:

| Field | Type | Description |
|-------|------|-------------|
| `components` | `table` | Array of `{ component_id, drawable, texture }` entries |
| `props` | `table` | Array of `{ prop_id, drawable, texture }` entries |

## Vehicles

**File:** `shared/config/vehicles.lua`

### Van Settings

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Vehicle.model` | `string` | `'boxville2'` | Vehicle model name |
| `Config.Vehicle.spawnDistance` | `number` | `5.0` | Distance threshold for spawn area clearing |
| `Config.Vehicle.healthCheckInterval` | `number` | `1000` | Milliseconds between health checks |
| `Config.Vehicle.destroyedThreshold` | `number` | `150` | Engine health below which the van is considered destroyed |
| `Config.Vehicle.damageChargeRate` | `number` | `0.50` | Dollar charge per health point below damage threshold |
| `Config.Vehicle.damageChargeThreshold` | `number` | `950` | Body health below which damage charges apply |
| `Config.Vehicle.rearDoors` | `table` | `{ 2, 3 }` | Door indices that must be open for loading/unloading |
| `Config.Vehicle.primaryColor` | `table` | `{ 255, 255, 255 }` | RGB primary color |
| `Config.Vehicle.secondaryColor` | `table` | `{ 255, 255, 255 }` | RGB secondary color |

### Pallet & Box Props

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Pallet.model` | `string` | `'bkr_prop_coke_pallet_01a'` | Pallet prop model |
| `Config.Pallet.boxModel` | `string` | `'prop_cs_cardbox_01'` | Cardboard box prop model |
| `Config.Pallet.maxVisibleBoxes` | `number` | `12` | Maximum visible box entities on a pallet |
| `Config.Pallet.pickupTime` | `number` | `3000` | Pickup animation duration (ms) |
| `Config.Pallet.loadTime` | `number` | `2000` | Load animation duration (ms) |
| `Config.Pallet.vanProximity` | `number` | `5.0` | Distance to van required for loading |
| `Config.Pallet.palletProximity` | `number` | `2.5` | Distance to pallet required for pickup |
| `Config.Pallet.carryBone` | `number` | `24818` | Ped bone ID for carry attachment (SKEL_Spine3) |
| `Config.Pallet.carryOffset` | `vector3` | `(-0.2, 0.54, 0.0)` | Carry prop offset from bone |
| `Config.Pallet.carryRotation` | `vector3` | `(0.0, 90.0, 0.0)` | Carry prop rotation |

### Letter Props

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Letter.postBoxModel` | `string` | `'prop_postbox_01a'` | Post box prop model (for reference) |
| `Config.Letter.letterBoxModels` | `table` | 4 models | Letterbox prop models for scanning |
| `Config.Letter.mailBagModel` | `string` | `'h4_prop_h4_med_bag_01b'` | Mail bag carry prop model |
| `Config.Letter.envelopeModel` | `string` | `'prop_cash_envelope_01'` | Envelope prop for letter delivery animation |
| `Config.Letter.searchRadius` | `number` | `15.0` | Radius for letterbox prop searching |
| `Config.Letter.pickupTime` | `number` | `3000` | Mail bag pickup duration (ms) |
| `Config.Letter.loadTime` | `number` | `2000` | Mail bag load duration (ms) |
| `Config.Letter.deliverTime` | `number` | `2500` | Letter delivery animation duration (ms) |
| `Config.Letter.carryBone` | `number` | `57005` | Ped bone ID for mail bag carry (SKEL_R_Hand) |
| `Config.Letter.carryOffset` | `vector3` | `(0.35, 0.0, 0.0)` | Mail bag carry offset |
| `Config.Letter.carryRotation` | `vector3` | `(-5.0, -90.0, 40.0)` | Mail bag carry rotation |

### Van Box Offsets

`Config.BoxOffsets` defines 12 positions for boxes on the pallet. `Config.VanBoxOffsets` defines 11 positions for boxes inside the van. `Config.VanBoxRotation` sets the rotation for all van boxes (default: `vector3(0, 0, 0)`).

## Visuals

**File:** `shared/config/visuals.lua`

### Delivery Marker

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.DeliveryMarker.type` | `number` | `25` | GTA marker type |
| `Config.DeliveryMarker.scale` | `vector3` | `(1.0, 1.0, 0.5)` | Marker scale |
| `Config.DeliveryMarker.color` | `table` | `{ r=255, g=200, b=50, a=120 }` | Marker RGBA color |
| `Config.DeliveryMarker.bobUpAndDown` | `boolean` | `false` | Enable bobbing animation |
| `Config.DeliveryMarker.rotate` | `boolean` | `false` | Enable rotation animation |

### Animations

`Config.Animations` contains animation definitions for pickup and deliver actions:

| Animation | Dict | Clip | Duration | Label |
|-----------|------|------|----------|-------|
| `pickup` | `anim@heists@box_carry@` | `idle` | 3000ms | Picking up package... |
| `deliver` | `mp_common` | `givetake1_a` | 3000ms | Delivering package... |

### Waypoints

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `Config.Waypoints.heightOffset` | `number` | `5.0` | Height above ground for waypoint marker |
| `Config.Waypoints.updateInterval` | `number` | `0` | Render thread sleep time (0 = every frame) |
| `Config.Waypoints.scaleMin` | `number` | `0.5` | Minimum scale at far distance |
| `Config.Waypoints.scaleMax` | `number` | `1.0` | Maximum scale at near distance |
| `Config.Waypoints.scaleNearDist` | `number` | `30.0` | Distance at which maximum scale is used |
| `Config.Waypoints.scaleFarDist` | `number` | `300.0` | Distance at which minimum scale is used |

## Enums

**File:** `shared/init.lua`

### ShiftState

| Value | Constant | Description |
|-------|----------|-------------|
| `'idle'` | `ShiftState.IDLE` | Not on shift |
| `'clocked_in'` | `ShiftState.CLOCKED_IN` | On shift, ready for tasks |
| `'loading'` | `ShiftState.LOADING` | Loading items into van |
| `'delivering'` | `ShiftState.DELIVERING` | Delivering to addresses |

### TaskType

| Value | Constant | Description |
|-------|----------|-------------|
| `'packages'` | `TaskType.PACKAGES` | Package delivery task |
| `'letters'` | `TaskType.LETTERS` | Letter delivery task |

## Rate Limits

**File:** `server/main.lua`

Server-side rate limiting prevents action spam. Each action has a cooldown period in milliseconds:

| Action | Cooldown (ms) | Description |
|--------|--------------|-------------|
| `completeDelivery` | 5000 | Completing a delivery |
| `loadBox` | 2000 | Loading a box/bag into the van |
| `clockIn` | 2000 | Clocking in to a shift |
| `clockOut` | 2000 | Clocking out of a shift |
| `crewInvite` | 5000 | Sending a crew invite |
| `respondToInvite` | 2000 | Accepting/declining a crew invite |
| `vehicleDestroyed` | 10000 | Vehicle destruction event |
| `grabPackage` | 2000 | Grabbing a package from the van |
| `palletSpawned` | 5000 | Pallet spawn sync event |
| `boxPickedUp` | 1000 | Box pickup sync event |
| `palletCleanedUp` | 5000 | Pallet cleanup sync event |
| `updateVehicle` | 5000 | Vehicle network ID update |

## Next Steps

- `INSTALLATION.md`
- `FEATURES.md`
- `ADMIN.md`
- `TROUBLESHOOTING.md`
