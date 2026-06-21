---@meta

-------------------------------------------------
-- Enums & Aliases
-------------------------------------------------

---@alias WasabiAmbulanceDeathState 0|1|2
---@alias WasabiAmbulanceDeathStateName 'ALIVE'|'LAST_STAND'|'DEAD'

---@alias WasabiAmbulanceReviveMethod 'player'|'hospital'|'item'|'admin'|'respawn'|'command'
---@alias WasabiAmbulanceRespawnType 'hospital'|'lastLocation'|'spawn'

---@alias WasabiAmbulanceInjuryType 'cut'|'blunt'|'brokenbone'|'gunshot'|'fist'|'taser'|'burn'
---@alias WasabiAmbulanceStatusType 'bleed'|'stun'|'brokenbone'|'gunshot'|'fist'

---@alias WasabiAmbulanceLimbIndex 1|2|3|4|5|6
---@alias WasabiAmbulanceLimbName 'HEAD'|'BODY'|'LEFT_ARM'|'RIGHT_ARM'|'LEFT_LEG'|'RIGHT_LEG'

---@alias WasabiAmbulanceInteractType 'ox_target'|'qb-target'|'sleepless_interact'|'drawText'
---@alias WasabiAmbulanceProgressType 'circle'|'bar'
---@alias WasabiAmbulanceDispatchType 'internal'|'cd_dispatch'|'ps-dispatch'|'none'
---@alias WasabiAmbulanceLoggerType 'ox'|'discord'
---@alias WasabiAmbulanceSkinScriptType 'default'|'qb'|'illenium'
---@alias WasabiAmbulanceAccountType 'bank'|'money'|'cash'
---@alias WasabiAmbulancePricingMode 'flat'|'per_injury'

-------------------------------------------------
-- Death & Revival Data
-------------------------------------------------

---@class WasabiAmbulanceDeathData
---@field source number Server ID of the player who died
---@field killer? number Server ID of the killer (nil if environmental/self)
---@field killerPed? number Ped handle of the killer
---@field causeOfDeath number Death cause hash
---@field position vector3 Position where death occurred
---@field weapon? number Weapon hash used (if applicable)

---@class WasabiAmbulanceClientDeathData
---@field cause number? Death cause weapon hash
---@field killer number? Server ID of the killer

---@class WasabiAmbulanceLastStandData
---@field source number Server ID of the player entering last stand
---@field attacker? number Server ID of the attacker (nil if environmental)
---@field causeOfDeath number Death cause hash
---@field position vector3 Position where last stand started

---@class WasabiAmbulanceLastStandAnimState
---@field moving boolean Whether player is crawling
---@field phase number? Animation phase when moving started
---@field current number? Current animation phase
---@field target number? Target animation phase
---@field coords vector3 Current position
---@field heading number Current heading

---@class WasabiAmbulanceReviveData
---@field source number Server ID of the player being revived
---@field reviver? number Server ID of the player who revived them (nil if hospital/self)
---@field method WasabiAmbulanceReviveMethod How the player was revived
---@field position vector3 Position where the revive occurred
---@field cost? number Cost paid for revival (if applicable)

---@class WasabiAmbulanceCheckInData
---@field source number Server ID of the player checking in
---@field hospitalId string Hospital identifier
---@field cost number Cost of check-in
---@field injuries table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData> Current injuries being treated

---@class WasabiAmbulanceDeadPlayerData
---@field state WasabiAmbulanceDeathState Death state (0=ALIVE, 1=LAST_STAND, 2=DEAD)
---@field timestamp number Unix timestamp when death occurred

-------------------------------------------------
-- Injury System
-------------------------------------------------

---@class WasabiAmbulanceLimbInjuryData
---@field health number Current health of the limb (0-1000)
---@field injuries table<WasabiAmbulanceInjuryType, number> Count of each injury type on this limb

---@class WasabiAmbulanceInjuryStatusEffect
---@field status WasabiAmbulanceStatusType Status effect to apply
---@field amount number Amount of status to apply

---@class WasabiAmbulanceInjuryConfig
---@field limbHealthDamage number Base damage to limb health
---@field canBreakBones? boolean Whether this injury can cause broken bones
---@field statusPerLimb? table<WasabiAmbulanceLimbIndex, WasabiAmbulanceInjuryStatusEffect> Status effects per limb

---@class WasabiAmbulanceWeaponInjuryConfig
---@field label string? Display label for death cause
---@field injuries WasabiAmbulanceInjuryType[] Array of injury types caused by this weapon

---@class WasabiAmbulanceBleedState
---@field threshold number Bleed percentage threshold to activate
---@field damagePerSecond number Damage dealt per second at this bleed level

---@class WasabiAmbulanceBleedingConfig
---@field enabled boolean Whether bleeding is enabled
---@field bleedStates table<string, WasabiAmbulanceBleedState> Bleed state thresholds

---@class WasabiAmbulanceStunConfig
---@field enabled boolean Whether stun is enabled
---@field stunDuration { min: number, max: number } Duration range in seconds

---@class WasabiAmbulanceKnockoutConfig
---@field enabled boolean Whether the knockout system is enabled
---@field healthForKnockout number Health threshold below which melee combat triggers a knockout
---@field duration number Duration of the knockout in milliseconds
---@field stunTriggersKnockout boolean When stun reaches 100, route through knockout instead of the fallback stun ragdoll
---@field regainHealth number|false When health is <= this value during knockout, regenerate regainAmount per tick (false to disable)
---@field regainAmount number HP restored per tick while regainHealth is active

---@class WasabiAmbulanceTreatInjuryData
---@field item { name: string } Item used for treatment
---@field index WasabiAmbulanceLimbIndex Limb index being treated

---@class WasabiAmbulanceLimbAnchor
---@field boneId number GTA bone ID for this limb
---@field zOffset number Z offset for UI positioning

-------------------------------------------------
-- Medical Items (Treatment)
-------------------------------------------------

---@class WasabiAmbulanceMedicalItemConfig
---@field healAmount? number Amount to heal limb health
---@field healType? WasabiAmbulanceInjuryType Specific injury type to treat

-------------------------------------------------
-- Hospital & Facilities
-------------------------------------------------

---@class WasabiAmbulanceBedPositionConfig
---@field posOffset vector3 Position offset from bed origin
---@field rotOffset vector3 Rotation offset
---@field model? number Model hash (for inBed only)

---@class WasabiAmbulanceBedAnimationConfig
---@field dict string Animation dictionary
---@field anim string Animation name
---@field flag number Animation flags

---@class WasabiAmbulanceBedConfig
---@field inBed WasabiAmbulanceBedPositionConfig Position when in bed
---@field outBed WasabiAmbulanceBedPositionConfig Position when exiting bed
---@field animations { layDown: WasabiAmbulanceBedAnimationConfig } Bed animations

---@class WasabiAmbulanceBlipConfig
---@field sprite number Blip sprite ID
---@field color number Blip color ID
---@field scale number Blip scale

-------------------------------------------------
-- Clothing & Uniforms
-------------------------------------------------

---@class WasabiAmbulanceClothingComponent
---@field component number Component ID
---@field drawable number Drawable ID
---@field texture number Texture ID

---@class WasabiAmbulancePropComponent
---@field prop number Prop ID
---@field drawable number Drawable ID
---@field texture number Texture ID

---@class WasabiAmbulanceGenderClothing
---@field clothing WasabiAmbulanceClothingComponent[] Clothing components
---@field props WasabiAmbulancePropComponent[] Prop components

---@class WasabiAmbulanceUniformConfig
---@field label string Display name
---@field minGrade number Minimum job grade required
---@field male WasabiAmbulanceGenderClothing Male outfit
---@field female WasabiAmbulanceGenderClothing Female outfit

---@class WasabiAmbulanceCloakroomConfig
---@field enabled boolean Enable cloakroom feature
---@field requireDuty boolean Require on-duty to access
---@field skinScript WasabiAmbulanceSkinScriptType Skin script to use
---@field uniforms WasabiAmbulanceUniformConfig[] Available uniforms

-------------------------------------------------
-- Shop System
-------------------------------------------------

---@class WasabiAmbulanceShopItem
---@field name string Item spawn name
---@field price number Item price
---@field label string Display label

---@class WasabiAmbulanceShopConfig
---@field name string Shop display name
---@field inventory WasabiAmbulanceShopItem[] Available items

-------------------------------------------------
-- Garage System
-------------------------------------------------

---@alias WasabiAmbulanceGarageType 'internal'

---@class WasabiAmbulanceGarageVehicleConfig
---@field label string Vehicle display label
---@field price number|false Vehicle price or false if free
---@field type 'automobile'|'bike'|'boat'|'heli'|'plane' Vehicle type
---@field maxUpgrades? boolean Whether to apply max upgrades
---@field livery? number|false Livery index or false
---@field paint? { primary?: number, secondary?: number } Paint color config
---@field extras? table<number, boolean> Extra toggle states

---@class WasabiAmbulanceGarageRankConfig
---@field vehicles? table<string, WasabiAmbulanceGarageVehicleConfig> Available vehicles by model name
---@field helicopters? table<string, WasabiAmbulanceGarageVehicleConfig> Available helicopters by model name

---@class WasabiAmbulanceGarageJobConfig
---@field ownedVehicles boolean Whether vehicles have persistent ownership
---@field plateFormat? string License plate format pattern
---@field onlyNumbers? boolean Use only numbers for plate randomization
---@field recoveryCost? number Cost to recover lost vehicles
---@field ranks table<number, WasabiAmbulanceGarageRankConfig> Vehicle access by job grade

---@class WasabiAmbulanceGarageConfig
---@field enabled boolean Enable garage feature
---@field requireDuty boolean Require on-duty to access
---@field type WasabiAmbulanceGarageType Garage system type
---@field account WasabiAmbulanceAccountType Account for purchases
---@field options table<string, WasabiAmbulanceGarageJobConfig> Per-job garage configurations

---@class WasabiAmbulanceVehiclePaintData
---@field primary number Primary color index (9999 if custom RGB)
---@field secondary number Secondary color index (9999 if custom RGB)
---@field pearlescent number Pearlescent color index
---@field custom? { primary?: { r: number, g: number, b: number }, secondary?: { r: number, g: number, b: number } } Custom RGB colors

---@class WasabiAmbulanceVehicleWheelData
---@field custom boolean Custom wheels equipped
---@field type number Wheel type index
---@field id number Wheel mod index (-1 if stock)
---@field color number Wheel color index
---@field pearlescent number Pearlescent color index
---@field smokeColor { r: number, g: number, b: number } Tire smoke color
---@field bulletproof boolean Bulletproof tires enabled

---@class WasabiAmbulanceVehicleNeonSide
---@field enabled boolean Neon enabled for this side
---@field color { r: number, g: number, b: number } Neon color

---@class WasabiAmbulanceVehicleXenonData
---@field enabled boolean Xenon mod installed
---@field color number|false Xenon color index or false

---@class WasabiAmbulanceVehicleProperties
---@field model number Vehicle model hash
---@field name string Display name of the vehicle
---@field plate string License plate text
---@field health number Entity health (0-1000)
---@field fuel number Fuel level
---@field engine number Engine upgrade level (-1 if stock)
---@field brakes number Brake upgrade level (-1 if stock)
---@field transmission number Transmission upgrade level (-1 if stock)
---@field suspension number Suspension upgrade level (-1 if stock)
---@field armor number Armor upgrade level (-1 if stock)
---@field turbo boolean Turbo installed
---@field spoiler number Spoiler mod index (-1 if stock)
---@field frontBumper number Front bumper mod index (-1 if stock)
---@field rearBumper number Rear bumper mod index (-1 if stock)
---@field sideSkirt number Side skirt mod index (-1 if stock)
---@field exhaust number Exhaust mod index (-1 if stock)
---@field frame number Frame mod index (-1 if stock)
---@field grille number Grille mod index (-1 if stock)
---@field hood number Hood mod index (-1 if stock)
---@field fender number Fender mod index (-1 if stock)
---@field rightFender number Right fender mod index (-1 if stock)
---@field roof number Roof mod index (-1 if stock)
---@field horn number Horn mod index (-1 if stock)
---@field windowTint number Window tint index
---@field livery number Livery index (-1 if none)
---@field plateIndex number License plate style index
---@field wheels WasabiAmbulanceVehicleWheelData Wheel configuration
---@field neon { left: WasabiAmbulanceVehicleNeonSide, right: WasabiAmbulanceVehicleNeonSide, front: WasabiAmbulanceVehicleNeonSide, back: WasabiAmbulanceVehicleNeonSide } Neon lights
---@field xenon WasabiAmbulanceVehicleXenonData Xenon headlights
---@field paint WasabiAmbulanceVehiclePaintData Paint configuration

-------------------------------------------------
-- Treatment & Payment
-------------------------------------------------

---@class WasabiAmbulanceInjuryPricing
---@field basePrice number Base treatment fee
---@field pricePerInjury number Cost per injury
---@field injuryPrices? table<WasabiAmbulanceInjuryType, number> Override prices per injury type

---@class WasabiAmbulanceMInsuranceConfig
---@field enabled boolean Enable m-Insurance check-in treatment discount
---@field checkInDiscount number Amount to deduct from check-in treatment charges for insured patients

---@class WasabiAmbulanceSocietyPaymentConfig
---@field enabled boolean Deposit successful normal facility treatment charges into society
---@field society string Society/job/account name to deposit into

---@class WasabiAmbulanceTreatmentPricingConfig
---@field enabled boolean Enable treatment charges
---@field account WasabiAmbulanceAccountType Account to charge
---@field freeIfNoFunds boolean Free treatment when player cannot afford
---@field mode WasabiAmbulancePricingMode Pricing calculation mode
---@field flatRate number Flat rate amount
---@field perInjury WasabiAmbulanceInjuryPricing Per-injury pricing config
---@field maxCharge number Maximum charge cap (0 = no cap)
---@field societyPayment WasabiAmbulanceSocietyPaymentConfig Society deposit settings
---@field mInsurance WasabiAmbulanceMInsuranceConfig m-Insurance compatibility settings

---@class WasabiAmbulanceMedicFlatPayment
---@field perInjuryTreatment number Payment per injury treated
---@field perRevive number Payment for reviving

---@class WasabiAmbulanceMedicPerInjuryPayment
---@field reviveBonus number Bonus for reviving
---@field injuryPayments table<WasabiAmbulanceInjuryType, number> Payment per injury type

---@class WasabiAmbulanceMedicPaymentConfig
---@field enabled boolean Enable medic payments
---@field account WasabiAmbulanceAccountType Account to pay
---@field requireDuty boolean Require on-duty status
---@field mode WasabiAmbulancePricingMode Payment calculation mode
---@field flatRate WasabiAmbulanceMedicFlatPayment Flat rate payments
---@field perInjury WasabiAmbulanceMedicPerInjuryPayment Per-injury payments
---@field maxPayment number Maximum payment cap

---@class WasabiAmbulanceTreatmentConfig
---@field minTreatmentTime number Minimum seconds for treatment
---@field treatmentCooldown number Cooldown between treatments
---@field pricing WasabiAmbulanceTreatmentPricingConfig Pricing configuration

-------------------------------------------------
-- Death & Last Stand Config
-------------------------------------------------

---@class WasabiAmbulanceLastStandConfig
---@field enable boolean Enable last stand feature
---@field bleedOutRate number Health lost per second
---@field skipOnFatalHeadshot boolean Skip last stand on headshot

---@class WasabiAmbulanceScreenEffectsConfig
---@field blood boolean Enable blood screen effect
---@field shake boolean Enable screen shake
---@field vignette boolean Enable vignette effect

---@class WasabiAmbulanceDeathAnimationConfig
---@field dict string Animation dictionary
---@field clip string Animation clip

---@alias WasabiAmbulanceDeathAnimationsConfig table<number, { death?: WasabiAmbulanceDeathAnimationConfig, vehicleDeath?: WasabiAmbulanceDeathAnimationConfig, lastStand?: WasabiAmbulanceDeathAnimationConfig }> Per-ped animation overrides keyed by model hash

---@class WasabiAmbulanceDeathConfig
---@field stayInVehicleOnDeath boolean Keep vehicle deaths seated and skip last stand
---@field allowedControls number[] Controls allowed while dead
---@field lastStand WasabiAmbulanceLastStandConfig Last stand settings
---@field animations WasabiAmbulanceDeathAnimationsConfig Death and last stand animation settings
---@field screenEffects WasabiAmbulanceScreenEffectsConfig Screen effect settings

-------------------------------------------------
-- UI Colors Config
-------------------------------------------------

---@class WasabiAmbulanceUIColorsConfig
---@field death string Death screen accent color (hex format)
---@field facilityPanel string Facility panel accent color (hex format)
---@field inspection string Inspection UI accent color (hex format)

---@class WasabiAmbulanceInspectionBedCameraConfig
---@field offset vector3 Camera offset relative to bed heading
---@field rotation vector3 Camera rotation; z is added to bed heading
---@field fov number Camera field of view

-------------------------------------------------
-- Respawn Config
-------------------------------------------------

---@class WasabiAmbulanceRespawnConfig
---@field respawnTime number Seconds before respawn available
---@field forcedRespawnTime number|nil Seconds before forced respawn (nil for no forced respawn)
---@field wipeItems boolean Wipe items on respawn
---@field itemsToKeep string[] Items to keep on respawn
---@field keepItemsIfNoEMS boolean Keep items if no EMS online
---@field allowClientStandaloneRespawn boolean Allow client listener to request standalone facility respawn
---@field keepItemsOnDeathScreenCheckIn boolean Keep items when using death screen Check In near a facility check-in point

-------------------------------------------------
-- Dispatch Config
-------------------------------------------------

---@class WasabiAmbulanceDispatchConfig
---@field type WasabiAmbulanceDispatchType Dispatch system type
---@field allowedJobs string[] Jobs with dispatch access / recipients
---@field keybind string Default keybind
---@field distressCooldown number Cooldown between distress calls

---@class WasabiAmbulanceDispatchCall
---@field id string Unique call identifier
---@field source number Server ID of caller
---@field coords vector3 Call location
---@field message? string Optional message
---@field timestamp number Call timestamp

---@class WasabiAmbulanceDistressData
---@field serverId number Server ID of distressed player
---@field name string Player display name
---@field coords vector3 Player location coordinates
---@field timestamp number Unix timestamp when distress was added
---@field streetName string Street name at distress location
---@field distance? number Distance from querying player (client-side only)

-------------------------------------------------
-- DrawText Config
-------------------------------------------------

---@class WasabiAmbulanceSpriteConfig
---@field dict string Sprite dictionary
---@field texture string Sprite texture
---@field color number[] RGBA color array

---@class WasabiAmbulanceDrawTextConfig
---@field maxDistance number Maximum interaction distance
---@field defaultInteractDistance number Default interact distance
---@field useSprite boolean Use sprite indicator
---@field sprite WasabiAmbulanceSpriteConfig Sprite configuration



-------------------------------------------------
-- Locker Config
-------------------------------------------------

---@class WasabiAmbulanceLockerConfig
---@field weight number Maximum weight
---@field slots number Number of slots

-------------------------------------------------
-- Logger Config & Module
-------------------------------------------------

---@class WasabiAmbulanceLoggerConfig
---@field enabled boolean Enable logging
---@field type WasabiAmbulanceLoggerType Logger type
---@field discordWebhook string Fallback Discord webhook URL
---@field discordWebhooks? table<string, string> Optional per-event Discord webhook URLs

---@class WasabiAmbulanceLoggerModule
---@field init fun() Initialize logger module
---@field log fun(source: number, event: string, message: string, ...) Generic log entry
---@field logEvent fun(source: number, eventType: string, data?: table) Log typed event
---@field logDeath fun(source: number, deathData: table) Log player death
---@field logRevive fun(source: number, reviveData: table) Log player revive
---@field logRespawn fun(source: number, respawnData: table) Log player respawn
---@field logTreatment fun(source: number, targetSource: number, treatmentData?: table) Log medical treatment
---@field logDuty fun(source: number, onDuty: boolean) Log duty status change
---@field logAction fun(source: number, action: string, data?: table) Log generic action

-------------------------------------------------
-- Kill Command Config
-------------------------------------------------

---@class WasabiAmbulanceKillCommandConfig
---@field enabled boolean Enable kill command
---@field command string Command name
---@field adminOnly boolean Restrict to admins
---@field adminCanKillOthers boolean Admins can kill other players

-------------------------------------------------
-- Player Data
-------------------------------------------------

---@class WasabiAmbulancePlayerBridgeData
---@field name string Full character name
---@field groups table<string, number> Job/group names mapped to grade levels
---@field duty boolean On-duty status
---@field charId string|number Character identifier
---@field loaded boolean Whether player data is loaded
---@field statuses table<WasabiAmbulanceStatusType, number> Current status effect levels
---@field limbs table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData> Current limb injury data

-------------------------------------------------
-- Listener Interfaces
-------------------------------------------------

---@alias WasabiAmbulanceDeathDataParam { cause: number?, killer: number? }?

---@class WasabiAmbulanceClientListeners
---@field shouldPlayDeathAnim fun(): boolean
---@field onLastStand fun(deathData: WasabiAmbulanceDeathDataParam)
---@field onDeath fun(deathData: WasabiAmbulanceDeathDataParam)
---@field onRevive fun()
---@field onRespawn fun(facilityId: number?, coords: vector3)
---@field getStandaloneRespawnFacility fun(): boolean|number|string|nil
---@field onFacilityHeal fun(facilityId: number, facilityName: string)
---@field onStretcherEnter fun(stretcherId: number, stretcherEntity: number)
---@field onStretcherExit fun(stretcherId: number, stretcherEntity: number)
---@field onHealingItemUsed fun(itemName: string, healAmount: number, healerId: number?)
---@field onInjuryUpdate fun(limbs: table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData>)
---@field onStatusChange fun(statusType: WasabiAmbulanceStatusType, amount: number, previousAmount: number)

---@class WasabiAmbulanceServerListeners
---@field onLastStand fun(source: number, deathData: WasabiAmbulanceDeathDataParam)
---@field onDeath fun(source: number, deathData: WasabiAmbulanceDeathDataParam)
---@field onRevive fun(source: number, reviver: number?, method: 'player'|'hospital'|'item'|'admin'|'command')
---@field onRespawn fun(source: number, facilityId: number?, coords: vector3)
---@field getStandaloneRespawnFacility fun(source: number): boolean|number|string|nil
---@field onFacilityHeal fun(source: number, facilityId: number, facilityName: string, cost: number)
---@field onStretcherEnter fun(source: number, stretcherId: number, placedBy: number)
---@field onStretcherExit fun(source: number, stretcherId: number, removedBy: number)
---@field onHealingItemUsed fun(source: number, itemName: string, healAmount: number, healerId: number?)
---@field onInjuryUpdate fun(source: number, limbs: table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData>, previousLimbs: table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData>)
---@field onDutyChange fun(source: number, onDuty: boolean, job: string)

-------------------------------------------------
-- Facility Types
-------------------------------------------------

---@class WasabiAmbulanceFacilityBedLocation
---@field coords vector4 Bed world coordinates
---@field model number? Bed prop model hash (0 or nil for coord-based beds)
---@field posOffsetZ number? Z position offset for bed placement

---@class WasabiAmbulanceFacilityGarageLocation
---@field interact vector4? Interaction point coordinates
---@field spawn vector4? Vehicle spawn coordinates
---@field model number? Ped model for garage attendant

---@class WasabiAmbulanceFacilityCloakroomLocation
---@field coords vector4 Cloakroom interaction coordinates
---@field uniforms WasabiAmbulanceUniformConfig[]? Facility-specific uniforms

---@class WasabiAmbulanceFacilityElevatorFloor
---@field interactCoords vector4 Elevator call button coordinates
---@field tpCoords vector4 Teleport destination coordinates
---@field label string Floor display name

---@class WasabiAmbulanceFacilityLocations
---@field center vector4 Center point of facility
---@field respawnArea vector4? Respawn spawn point
---@field beds WasabiAmbulanceFacilityBedLocation[]? Hospital bed locations
---@field clockIns vector4[]? Clock in/out locations
---@field checkIns vector4[]? Patient check-in locations
---@field elevators WasabiAmbulanceFacilityElevatorFloor[][]? Elevator configurations (array of floor arrays)
---@field personalLockers vector4[]? Personal locker locations
---@field heliGarages WasabiAmbulanceFacilityGarageLocation[]? Helicopter garage locations
---@field carGarages WasabiAmbulanceFacilityGarageLocation[]? Vehicle garage locations
---@field supplyShops vector4[]? Supply shop locations
---@field cloakrooms WasabiAmbulanceFacilityCloakroomLocation[]? Cloakroom locations
---@field bossMenus vector4[]? Boss menu locations

---@class WasabiAmbulanceFacilitySettings
---@field shopType string? Shop type identifier for supply shops
---@field useBeds boolean? Whether to use beds for check-in (default: true)
---@field standalone boolean? Whether to exclude this facility from normal nearest respawns
---@field standalonePayment boolean? Whether to override treatment pricing for this standalone facility
---@field standalonePaymentType 'account'|'item'? Standalone payment type
---@field standalonePaymentAccount string? Account/custom currency to charge for standalone treatment
---@field standalonePaymentItem string? Inventory item to require for standalone treatment
---@field standalonePaymentAmount number? Account amount or item count required for standalone treatment
---@field treatmentSocietyPayment boolean? Whether normal treatment charges from this facility should deposit into society
---@field treatmentSociety string? Society/job/account name for this facility's normal treatment payments
---@field blipSprite number? Custom blip sprite ID (falls back to config.blips.sprite)
---@field blipColor number? Custom blip color ID (falls back to config.blips.color)
---@field blipScale number? Custom blip scale (falls back to config.blips.scale)

---@class WasabiAmbulanceFacilityMetadata
---@field settings WasabiAmbulanceFacilitySettings? Facility settings

---@class WasabiAmbulanceFacilityBedState
---@field id string Bed identifier (coords formatted as string)
---@field coords vector4 Bed world coordinates
---@field model number? Bed prop model hash
---@field occupied number|false Player server ID occupying bed, or false

---@class WasabiAmbulanceFacilityData
---@field id number Unique facility ID
---@field name string Facility display name
---@field jobs table<string, number>? Allowed job names mapped to minimum grade
---@field locations WasabiAmbulanceFacilityLocations Location data
---@field metadata WasabiAmbulanceFacilityMetadata? Additional metadata
---@field beds table<string, WasabiAmbulanceFacilityBedState>? Current bed states (server-side)
---@field shopType string? Resolved shop type identifier

---@class WasabiAmbulanceFacilityExportLocations
---@field center vector3 Center point of facility
---@field respawnArea vector3? Respawn spawn point
---@field beds WasabiAmbulanceFacilityBedLocation[]? Hospital bed locations
---@field clockIns vector3[]? Clock in/out locations
---@field checkIns vector4[]? Patient check-in locations
---@field elevators table[]? Elevator configurations
---@field personalLockers vector3[]? Personal locker locations
---@field heliGarages vector4[]? Helicopter garage locations
---@field carGarages vector4[]? Vehicle garage locations
---@field supplyShops vector3[]? Supply shop locations
---@field cloakrooms table[]? Cloakroom locations
---@field bossMenus vector3[]? Boss menu locations

---@class WasabiAmbulanceFacilityExportData
---@field id number Unique facility ID
---@field name string Facility display name
---@field jobs table<string, number>? Allowed job names mapped to minimum grade
---@field locations WasabiAmbulanceFacilityExportLocations Facility location data
---@field metadata WasabiAmbulanceFacilityMetadata? Additional metadata

---@class WasabiAmbulanceCheckInResult
---@field id string Bed ID or 'respawn'
---@field coords vector4 Bed or respawn coordinates
---@field model number? Bed model hash (nil for respawn)
---@field isRespawn boolean? Whether this is a respawn check-in
---@field facilityId number? Facility ID (added after callback)
---@field inPlace boolean? Whether respawned in place (no facility nearby)

---@class WasabiAmbulanceCheckedInPlayerData
---@field facilityId number Facility ID player is checked into
---@field bedId string? Bed ID (nil for respawn check-ins)
---@field bedCoords vector4? Bed coordinates (nil for respawn check-ins)
---@field isRespawn boolean? Whether this is a respawn check-in
---@field deathScreenCheckIn boolean? Whether check-in came from the death screen Check In button
---@field checkInTime number Unix timestamp of check-in
---@field lastTreatmentComplete number? Unix timestamp of last completed treatment

---@class WasabiAmbulancePlayerBedData
---@field facilityId number Facility ID where bed is located
---@field bedId string Unique bed identifier
---@field coords vector4? Bed world coordinates

---@class WasabiAmbulanceInjuryTotals
---@field cut number Total cut injuries
---@field brokenbone number Total broken bones
---@field blunt number Total blunt injuries
---@field gunshot number Total gunshot injuries
---@field fist number Total fist injuries
---@field taser number Total taser injuries
---@field burn number Total burn injuries

-------------------------------------------------
-- Medical Module Types
-------------------------------------------------

---@class WasabiAmbulanceLimbsModule
---@field HEAD number Limb index for head (1)
---@field BODY number Limb index for body/torso (2)
---@field LEFT_ARM number Limb index for left arm (3)
---@field RIGHT_ARM number Limb index for right arm (4)
---@field LEFT_LEG number Limb index for left leg (5)
---@field RIGHT_LEG number Limb index for right leg (6)
---@field anchors table<number, WasabiAmbulanceLimbAnchor> Bone anchors for UI positioning
---@field boneMap table<number, WasabiAmbulanceLimbIndex> Maps GTA bone IDs to limb indexes
---@field getDefaults fun(): table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData> Returns default limb data

---@class WasabiAmbulanceInjuryModule
---@field doLimbDamage fun(limbIndex: WasabiAmbulanceLimbIndex, amount: number, canBreak?: boolean)
---@field addInjury fun(limbIndex: WasabiAmbulanceLimbIndex, newInjuries: WasabiAmbulanceInjuryType[])
---@field removeInjury fun(limbIndex: WasabiAmbulanceLimbIndex, _type?: WasabiAmbulanceInjuryType, healAmount?: number)
---@field removeAllInjuries fun()
---@field checkRevive fun()
---@field treatInjury fun(data: WasabiAmbulanceTreatInjuryData)
---@field calculateAndSetMaxHealth fun()
---@field isAnyLimbBroken fun(limbIndexes: WasabiAmbulanceLimbIndex[]): boolean
---@field init fun()

---@class WasabiAmbulanceInjuryServerModule
---@field playerLimbs table<string, table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData>> Limb data indexed by player identifier
---@field getInjuryTotals fun(playerId: number): WasabiAmbulanceInjuryTotals? Returns injury totals or nil
---@field init fun()

---@class WasabiAmbulanceDeathModule
---@field init fun()
---@field onPlayerDeath fun(isRestore?: boolean, deathData?: WasabiAmbulanceClientDeathData)
---@field revivePlayer fun()
---@field isPlayerDead fun(serverId?: number): boolean

---@class WasabiAmbulanceStatusesModule
---@field tickFuncs table<string, fun()> Registered tick functions per status
---@field init fun()
---@field register fun(name: string, value?: number, func?: fun())
---@field add fun(name: string, amount: number)
---@field remove fun(name: string, amount: number)
---@field get fun(name: string): number
---@field set fun(name: string, amount: number)

---@class WasabiAmbulanceBleedModule
---@field init fun()
---@field particles fun() Play blood particle effect
---@field add fun(amount: number)
---@field remove fun(amount: number)
---@field set fun(amount: number)
---@field tick fun()

---@class WasabiAmbulanceStunModule
---@field init fun()
---@field trigger fun() Trigger stun knockout effect
---@field add fun(amount: number)
---@field remove fun(amount: number)
---@field tick fun()

---@class WasabiAmbulanceKnockoutModule
---@field init fun()
---@field canTrigger fun(): boolean Whether a knockout can currently be applied (respects config, death state, disable flag, existing knockout state)
---@field isKnockedOut fun(): boolean Returns true while the player is in the knocked out state
---@field start fun(duration?: number) Enter the knockout state, optionally overriding the configured duration (ms)
---@field stop fun() Exit the knockout state immediately
---@field disable fun(state: boolean) Enable/disable automatic knockout detection
---@field manual fun(state: boolean) Manually force the knockout state on or off

---@class WasabiAmbulanceLimpModule
---@field active boolean Whether the limp clipset is currently applied
---@field set fun(state: boolean) Apply or remove the limp movement clipset
---@field isLimping fun(): boolean

---@class WasabiAmbulanceInspectionCurrent
---@field serverId number? Server ID of player being inspected
---@field limbs table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData> Current limb data

---@class WasabiAmbulanceInspectionModule
---@field isOpen boolean Whether inspection UI is currently open
---@field current WasabiAmbulanceInspectionCurrent Current inspection state
---@field init fun()
---@field open fun(targetPed: number, skipCam?: boolean, viewOnly?: boolean)
---@field close fun()
---@field setLimbs fun(_limbs: table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData>)
---@field updateMedsInventory fun()
---@field diagnosePlayer fun()

---@class WasabiAmbulanceDeathScreenModule
---@field isOpen boolean Whether death screen is currently open
---@field init fun()
---@field open fun() Show death screen
---@field close fun() Hide death screen
---@field updateTimer fun(newTime: number) Update respawn timer display
---@field setEMSCount fun(count: number) Update EMS count display
---@field setDeathState fun(state: WasabiAmbulanceDeathState) Update death state display
---@field setRespawnLocked fun(locked: boolean) Lock/unlock respawn button
---@field setNearCheckIn fun(facilityId: number|false) Set near check-in facility state
---@field getNearCheckIn fun(): number? Get cached near check-in state
---@field isUIOpen fun(): boolean Check if death screen is open

---@class WasabiAmbulanceMedicalDbModule
---@field ALIVE number Death state constant: alive (0)
---@field LAST_STAND number Death state constant: last stand (1)
---@field DEAD number Death state constant: dead (2)
---@field charTable table Character table info from bridge
---@field init fun()
---@field setup fun()
---@field fetch fun(charId: string): WasabiAmbulanceMedicalPlayerData?
---@field initializePlayerData fun(charId: string): WasabiAmbulanceMedicalPlayerData
---@field update fun(charId: string, updates: table)
---@field savePlayerData fun(charId: string, data: WasabiAmbulanceMedicalPlayerData)

---@class WasabiAmbulanceMedicalPlayerData
---@field charId string Character identifier
---@field health number Current health (0-200)
---@field armor number Current armor (0-100)
---@field deathState WasabiAmbulanceDeathState Death state
---@field limbs table<WasabiAmbulanceLimbIndex, WasabiAmbulanceLimbInjuryData> Limb injury data
---@field statuses table<string, number> Status effect values

---@class WasabiAmbulanceMedicalUtils
---@field sendNuiMessage fun(action: string, data: any)
---@field requestAnimDict fun(dict: string, timeout?: number)

-------------------------------------------------
-- Facility Module Types (Internal)
-------------------------------------------------

---@class WasabiAmbulanceFacilityClientInstance Client-side facility management instance
---@field id number Facility ID
---@field name string Facility display name
---@field groups table<string, number>? Allowed job names mapped to minimum grade
---@field metadata WasabiAmbulanceFacilityMetadata Additional metadata
---@field center vector3 Center point of facility
---@field respawnArea vector3? Respawn spawn point
---@field bedLocations WasabiAmbulanceFacilityBedLocation[]? Hospital bed locations
---@field clockIns vector3[]? Clock in/out locations
---@field checkIns vector4[]? Patient check-in locations
---@field elevators { name: string, floors: WasabiAmbulanceFacilityElevatorFloor[] }[]? Elevator configurations
---@field personalLockers vector3[]? Personal locker locations
---@field heliGarages WasabiAmbulanceFacilityGarageLocation[]? Helicopter garage locations
---@field carGarages WasabiAmbulanceFacilityGarageLocation[]? Vehicle garage locations
---@field supplyShops vector3[]? Supply shop locations
---@field cloakrooms WasabiAmbulanceFacilityCloakroomLocation[]? Cloakroom locations
---@field bossMenus vector3[]? Boss menu locations
---@field beds table<string, WasabiAmbulanceFacilityBedState>? Current bed states
---@field shopType string Shop type identifier for supply shops
---@field storageId string Storage identifier for personal lockers
---@field shopId string Shop identifier
---@field debug boolean Whether debug mode is enabled
---@field zoneIds number[] Registered interaction zone IDs
---@field pedPointIds number[] Registered ped point IDs
---@field checkInPointIds table[] Registered check-in proximity points
---@field debugThread boolean? Debug thread active flag
---@field setup fun(self: WasabiAmbulanceFacilityClientInstance) Setup all facility interaction points
---@field destroy fun(self: WasabiAmbulanceFacilityClientInstance) Cleanup facility resources
---@field doDebug fun(self: WasabiAmbulanceFacilityClientInstance) Render debug visualization
---@field setupClockIns fun(self: WasabiAmbulanceFacilityClientInstance) Setup clock in/out points
---@field setupBeds fun(self: WasabiAmbulanceFacilityClientInstance) Setup bed interaction points
---@field setupCheckIns fun(self: WasabiAmbulanceFacilityClientInstance) Setup check-in points
---@field setupElevators fun(self: WasabiAmbulanceFacilityClientInstance) Setup elevator systems
---@field setupPersonalLockers fun(self: WasabiAmbulanceFacilityClientInstance) Setup personal locker points
---@field setupHeliGarages fun(self: WasabiAmbulanceFacilityClientInstance) Setup helicopter garages
---@field setupCarGarages fun(self: WasabiAmbulanceFacilityClientInstance) Setup car garages
---@field setupCloakrooms fun(self: WasabiAmbulanceFacilityClientInstance) Setup cloakroom points
---@field setupBossMenu fun(self: WasabiAmbulanceFacilityClientInstance) Setup boss menu points
---@field setupSupplyShops fun(self: WasabiAmbulanceFacilityClientInstance) Setup supply shop points
---@field setupBlip fun(self: WasabiAmbulanceFacilityClientInstance) Setup facility map blip
---@field handleCheckin fun(self: WasabiAmbulanceFacilityClientInstance, bedInfo: WasabiAmbulanceCheckInResult) Handle patient check-in
---@field handleRespawnCheckin fun(self: WasabiAmbulanceFacilityClientInstance, respawnInfo: WasabiAmbulanceCheckInResult) Handle respawn check-in

---@class WasabiAmbulanceFacilityClientModule Client-side facility module
---@field init fun() Initialize module dependencies
---@field getNearCheckInFacilityId fun(): number? Get facility ID player is near check-in for
---@field new fun(self: WasabiAmbulanceFacilityClientModule, data: WasabiAmbulanceFacilityData): WasabiAmbulanceFacilityClientInstance Create new facility instance

---@class WasabiAmbulanceFacilityServerInstance Server-side facility management instance
---@field id number Facility ID
---@field name string Facility display name
---@field groups table<string, number>? Allowed job names mapped to minimum grade
---@field metadata WasabiAmbulanceFacilityMetadata Additional metadata
---@field locations WasabiAmbulanceFacilityLocations Facility location data
---@field shopType string Shop type identifier for supply shops
---@field storageId string Storage identifier for personal lockers
---@field shopId string Shop identifier
---@field beds table<string, WasabiAmbulanceFacilityBedState> Current bed states
---@field setupLockers fun(self: WasabiAmbulanceFacilityServerInstance) Setup personal locker stash
---@field setupShops fun(self: WasabiAmbulanceFacilityServerInstance) Setup supply shop
---@field initializeBeds fun(self: WasabiAmbulanceFacilityServerInstance) Initialize bed tracking from location data
---@field isBedOpen fun(self: WasabiAmbulanceFacilityServerInstance, coords: vector4): boolean Check if bed at coords is available
---@field checkInPlayer fun(self: WasabiAmbulanceFacilityServerInstance, playerSrc: number, isRespawn: boolean): WasabiAmbulanceCheckInResult|false Check player into facility
---@field releaseBed fun(self: WasabiAmbulanceFacilityServerInstance, bedId: string) Release bed by ID
---@field serialize fun(self: WasabiAmbulanceFacilityServerInstance): WasabiAmbulanceFacilityData Serialize facility data for client sync

---@class WasabiAmbulanceFacilityServerModule Server-side facility module
---@field init fun() Initialize module dependencies
---@field new fun(self: WasabiAmbulanceFacilityServerModule, data: WasabiAmbulanceFacilityData): WasabiAmbulanceFacilityServerInstance Create new facility instance

---@class WasabiAmbulanceFacilityDB Server-side facility database module
---@field cache table<number, WasabiAmbulanceFacilityData> Cached facility data
---@field isInitialized fun(value?: boolean): boolean Get/set initialization state
---@field init fun() Initialize database table
---@field new fun(name: string, jobs?: table, locations?: table, metadata?: table): number? Create new facility record
---@field update fun(id: number, updates: table) Update facility by ID
---@field fetch fun(id: number): WasabiAmbulanceFacilityData? Fetch single facility by ID
---@field delete fun(id: number): boolean Delete facility by ID
---@field fetchAll fun(): WasabiAmbulanceFacilityData[] Fetch all facilities and cache them

---@class WasabiAmbulanceBedModule Client-side bed management module
---@field cam number? Active camera handle
---@field currentBedConfig WasabiAmbulanceBedConfig? Current bed configuration
---@field currentBedObj number? Current bed entity
---@field currentBedCoords vector4? Current coord-based bed position
---@field exitListenerActive boolean Whether exit key listener is running
---@field init fun() Initialize module dependencies
---@field destroyCam fun() Destroy active bed camera
---@field createCam fun(bedCoords: vector3, bedHeading: number) Create overhead camera
---@field layInBed fun(bedObj: number, openViewOnlyInspection?: boolean, posOffsetZ?: number, bedCoords?: vector4) Place player in prop bed
---@field getOutOfBed fun(bedObj: number) Remove player from prop bed
---@field layInBedAtCoords fun(bedCoords: vector4, openViewOnlyInspection?: boolean, posOffsetZ?: number) Place player at coord bed
---@field getOutOfBedAtCoords fun(bedCoords: vector4) Remove player from coord bed

---@class WasabiAmbulanceCloakroomModule Client-side uniform/outfit management module
---@field init fun() Initialize module dependencies
---@field open fun(facilityUniforms?: WasabiAmbulanceUniformConfig[]) Open cloakroom menu
---@field getSavedOutfit fun(): WasabiAmbulanceSavedOutfit? Get saved civilian outfit
---@field setSavedOutfit fun(outfit: WasabiAmbulanceSavedOutfit) Set saved civilian outfit

---@class WasabiAmbulanceSavedOutfit
---@field clothing { component: number, drawable: number, texture: number }[] Clothing components
---@field props { component: number, drawable: number, texture: number }[] Prop components

---@class WasabiAmbulanceCreatorModule Client-side facility location creator module
---@field currentZone table? Active polygon zone
---@field refreshing boolean Zone refresh lock
---@field init fun() Initialize module dependencies
---@field refreshZone fun(points: vector3[], thickness?: number) Refresh polygon zone visualization
---@field zone fun(initialData?: table): vector3[]? Create polygon zone points
---@field beds fun(initialData?: table): WasabiAmbulanceFacilityBedLocation[]? Create bed locations
---@field respawnArea fun(initialData?: table): vector3? Create respawn area point
---@field clockInLocations fun(initialData?: table): vector3[]? Create clock in/out locations
---@field checkInNPCs fun(initialData?: table): vector4[]? Create check-in NPC locations
---@field checkInPoints fun(initialData?: table): vector4[]? Create check-in point locations
---@field medicalShopPoints fun(initialData?: table): vector3[]? Create medical shop points
---@field carGarages fun(initialData?: table): WasabiAmbulanceFacilityGarageLocation[]? Create car garage locations
---@field heliGarages fun(initialData?: table): WasabiAmbulanceFacilityGarageLocation[]? Create helicopter garage locations
---@field elevators fun(initialData?: table): { name: string, floors: WasabiAmbulanceFacilityElevatorFloor[] }[]? Create elevator configurations
---@field personalLockers fun(initialData?: table): vector3[]? Create personal locker locations
---@field bossMenus fun(initialData?: table): vector3[]? Create boss menu locations
---@field supplyShops fun(initialData?: table): vector3[]? Create supply shop locations
---@field cloakrooms fun(initialData?: table): WasabiAmbulanceFacilityCloakroomLocation[]? Create cloakroom locations
---@field center fun(initialData?: table): vector3? Create facility center point

---@class WasabiAmbulanceElevatorInstance Client-side elevator instance
---@field name string Elevator name
---@field floors WasabiAmbulanceFacilityElevatorFloor[] Floor configurations
---@field debug boolean Debug mode enabled
---@field doDebug fun(self: WasabiAmbulanceElevatorInstance) Render debug text at floor locations
---@field gotoFloor fun(self: WasabiAmbulanceElevatorInstance, floorIndex: number) Teleport player to specified floor
---@field useElevator fun(self: WasabiAmbulanceElevatorInstance, currentFloor: number) Open floor selection menu

---@class WasabiAmbulanceElevatorModule Client-side elevator module
---@field init fun() Initialize module dependencies
---@field new fun(self: WasabiAmbulanceElevatorModule, name: string, floors: WasabiAmbulanceFacilityElevatorFloor[], debug?: boolean): WasabiAmbulanceElevatorInstance Create new elevator instance

---@class WasabiAmbulancePanelModule Client-side facility management panel module
---@field visible boolean Panel visibility state
---@field activeCreator string? Currently active creator type
---@field init fun() Initialize module dependencies
---@field open fun(facilities?: WasabiAmbulanceFacilityData[], editFacility?: WasabiAmbulanceFacilityData) Open facility panel
---@field close fun() Close facility panel
---@field isVisible fun(): boolean Check if panel is visible
---@field getActiveCreator fun(): string? Get active creator type
---@field openWithFacilities fun() Open panel with all facilities loaded

---@class WasabiAmbulancePedSpawnData Ped spawn configuration
---@field coords vector4|vector4[] Spawn coordinates
---@field model number|string Ped model hash or name
---@field renderDistance number Distance to spawn/despawn ped
---@field interactOptions table[]? Interaction options for the ped
---@field animation { dict: string, anim: string, flag: number }? Animation to play
---@field scenario string? Scenario to play
---@field prop { propModel: number|string, bone?: number|string, pos?: vector3, rot?: vector3 }? Attached prop
---@field onSpawn fun(ped: number)? Callback when ped spawns
---@field onDespawn fun(ped: number)? Callback when ped despawns

---@class WasabiAmbulancePedManagerModule Client-side ped spawning and lifecycle management
---@field init fun() Initialize module dependencies
---@field addPed fun(data: WasabiAmbulancePedSpawnData): number[] Add ped(s) at specified coordinates with proximity spawning
---@field removePed fun(pointId: number) Remove single ped point by ID
---@field removePeds fun(pointIds: number[]) Remove multiple ped points

-------------------------------------------------
-- Death Screen NUI Data
-------------------------------------------------

---@class WasabiAmbulanceDeathScreenOpenData
---@field EMSCount number Number of EMS online
---@field enviMedicEnabled boolean Whether envi-medic is available
---@field timer number Respawn timer in milliseconds
---@field deathState WasabiAmbulanceDeathState Current death state
---@field style string? Death screen style ('default' or custom)
---@field nearCheckIn number? Facility ID if near check-in

---@class WasabiAmbulanceInspectionOpenData
---@field viewOnly boolean Whether in view-only mode
---@field toggle boolean Whether to show/hide
---@field inventoryImagePath string? Path to inventory images
---@field showHeartRate boolean Whether to show heart rate

---@class WasabiAmbulanceLimbScreenCoords
---@field x string X position as percentage string
---@field y string Y position as percentage string

-------------------------------------------------
-- Equipment: Healing Items
-------------------------------------------------

---@class WasabiAmbulanceHealOverTimeConfig
---@field amount number Amount to heal per tick
---@field interval number Time in ms between heal ticks
---@field duration number Total duration in ms

---@class WasabiAmbulanceStatusEffectConfig
---@field action 'remove'|'pause' Whether to remove or pause the status
---@field amount? number Amount to remove (for 'remove' action)
---@field pauseDuration? number Duration in ms to pause (for 'pause' action)
---@field removeChance? number Chance (1-100) to remove vs pause

---@class WasabiAmbulanceProgressDisableConfig
---@field move? boolean Disable movement
---@field car? boolean Disable vehicle controls
---@field combat? boolean Disable combat actions
---@field mouse? boolean Disable mouse/camera movement

---@class WasabiAmbulanceProgressAnimConfigFull
---@field dict string Animation dictionary
---@field clip string Animation clip name
---@field flag? number Animation flags
---@field blendIn? number Blend in speed
---@field blendOut? number Blend out speed
---@field duration? number Animation duration override
---@field playbackRate? number Animation playback rate
---@field lockX? boolean Lock X axis
---@field lockY? boolean Lock Y axis
---@field lockZ? boolean Lock Z axis

---@class WasabiAmbulanceProgressPropConfig
---@field model number|string Prop model hash or name
---@field bone? number Bone index to attach to
---@field pos? { x: number, y: number, z: number } Position offset
---@field rot? { x: number, y: number, z: number } Rotation offset

---@class WasabiAmbulanceProgressOptionsConfig
---@field label string Progress bar label
---@field useWhileDead? boolean Allow use while dead
---@field canCancel? boolean Allow cancellation
---@field disable? WasabiAmbulanceProgressDisableConfig Controls to disable
---@field anim? {self?: WasabiAmbulanceProgressAnimConfigFull, others?: WasabiAmbulanceProgressAnimConfigFull} Animation to play
---@field prop? WasabiAmbulanceProgressPropConfig Prop to attach

---@class WasabiAmbulanceHealingItemConfig
---@field healAmount? number Base healing amount applied immediately
---@field fullHeal? boolean If true, fully heals player health and clears all limb injuries
---@field healOverTime? WasabiAmbulanceHealOverTimeConfig Healing over time configuration
---@field healOthers? boolean If true, heals closest player (requires ambulance job)
---@field useTime number Time in ms for the progress bar
---@field progress? WasabiAmbulanceProgressOptionsConfig Progress bar options
---@field statusEffects? table<string, WasabiAmbulanceStatusEffectConfig> Status effects to apply/remove
---@field removeItem? boolean Whether to remove the item after use (default: true)
---@field requiredJob? string|string[]|table|false Optional item-specific job requirement; false allows anyone

---@class WasabiAmbulanceHealingItemsModule
---@field isStatusPaused fun(statusName: string): boolean Check if a status is currently paused
---@field cancelHoT fun(itemName: string) Cancel a specific heal over time effect
---@field cancelAllHoTs fun() Cancel all active heal over time effects

---@class WasabiAmbulanceHealingUtilsModule
---@field calculateTotalHealing fun(itemConfig: WasabiAmbulanceHealingItemConfig): number
---@field getHoTDuration fun(itemConfig: WasabiAmbulanceHealingItemConfig): number
---@field hasStatusEffects fun(itemConfig: WasabiAmbulanceHealingItemConfig): boolean
---@field getAffectedStatuses fun(itemConfig: WasabiAmbulanceHealingItemConfig): string[]
---@field validateConfig fun(itemConfig: WasabiAmbulanceHealingItemConfig): boolean, string?
---@field rollStatusAction fun(effectConfig: WasabiAmbulanceStatusEffectConfig): 'remove'|'pause'

---@class WasabiAmbulancePausedStatusData
---@field endTime number Game timer when pause expires
---@field originalValue number Original status value before pause

-------------------------------------------------
-- Equipment: Medbag
-------------------------------------------------

---@class WasabiAmbulanceMedbagItem
---@field [1] string Item spawn name
---@field [2] number Item quantity
---@field [3] string Item display label

---@class WasabiAmbulanceMedbagConfig
---@field model number Medbag prop model hash
---@field items WasabiAmbulanceMedbagItem[] Default bag contents
---@field allowedJobs? string|string[]|table|false Jobs/groups allowed to use/open medbags; false allows anyone
---@field groups? table<string, number> Legacy ox_inventory stash groups allowed to access

---@class WasabiAmbulanceMedbagSlotData
---@field name string Item name
---@field slot number Inventory slot
---@field metadata? table Item metadata
---@field info? table Item info (legacy)

---@class WasabiAmbulanceGroundBagData
---@field stashId string Stash identifier for inventory
---@field slotData WasabiAmbulanceMedbagSlotData Original slot data

---@class WasabiAmbulanceGroundBagPoint
---@field coords vector3 Bag world position
---@field stashId string Stash identifier
---@field bagId string Unique bag identifier
---@field bagHeading number Bag heading
---@field medbag? number Bag entity handle (when spawned)

---@class WasabiAmbulanceMedbagClientModule
---@field init fun()
---@field placeBagOnGround fun()
---@field pickupGroundBag fun(bagId: string)
---@field tick fun() Handle medbag equip state and key input
---@field createPlayerBag fun(ped: number, serverId: number)
---@field deletePlayerBag fun(serverId: number)
---@field spawnGroundBag fun(point: WasabiAmbulanceGroundBagPoint)
---@field deleteGroundBag fun(point: WasabiAmbulanceGroundBagPoint)
---@field createGroundBagPoint fun(bagId: string, stashId: string, coords: vector4)
---@field openMedbagMenu? fun() Open fallback menu when no ox_inventory

---@class WasabiAmbulanceMedbagServerModule
---@field init fun()
---@field use fun(src: number, slotData: WasabiAmbulanceMedbagSlotData)

-------------------------------------------------
-- Common Modules
-------------------------------------------------

---@class WasabiAmbulanceDrawTextModule
---@overload fun(coords: vector3, text: string, disabled?: boolean)

---@class WasabiAmbulanceCompatModule
---@field init? fun() Initialize compat module (server only)
---@field exportHandler fun(exportName: string, resourceName: string, callback: function) Register an export handler

---@class WasabiAmbulanceDebugModule
---@field enabled boolean Whether debug mode is enabled
---@field init fun() Initialize debug module from config

---@class WasabiAmbulanceStoreModule
---@field deadPlayers table<number, WasabiAmbulanceDeadPlayerData> Dead players indexed by server ID
---@field checkedInPlayers table<number, boolean> Players checked into facilities indexed by server ID

---@class WasabiAmbulanceValidationConfig
---@field maxDistanceForTreatment number Maximum distance allowed for treatment actions
---@field maxDistanceForInspection number Maximum distance allowed for inspection
---@field maxDistanceForBed number Maximum distance allowed for bed interactions
---@field limbHealthMin number Minimum limb health value (0)
---@field limbHealthMax number Maximum limb health value (1000)
---@field validLimbIndices WasabiAmbulanceLimbIndex[] Array of valid limb indexes (1-6)
---@field validInjuryTypes WasabiAmbulanceInjuryType[] Array of valid injury type strings
---@field maxInjuryCount number Maximum injuries allowed per limb
---@field maxHealthIncreasePerUpdate number Maximum health increase per update (dynamically adjusted)
---@field healthIncreaseBuffer number Buffer added to max health increase calculation
---@field rateLimitWindow number Rate limit window in milliseconds
---@field maxRequestsPerWindow number Maximum requests per rate limit window
---@field cooldowns WasabiAmbulanceValidationCooldowns Action cooldown durations

---@class WasabiAmbulanceValidationCooldowns
---@field updateLimbs number Cooldown for limb updates in ms
---@field revive number Cooldown for revive actions in ms
---@field treatInjury number Cooldown for injury treatment in ms
---@field heal number Cooldown for heal actions in ms
---@field setDead number Cooldown for death state changes in ms

---@class WasabiAmbulanceRateLimitEntry
---@field count number Number of requests in current window
---@field windowStart number Game timer when window started

---@class WasabiAmbulanceValidationModule
---@field rateLimits table<string, table<number, WasabiAmbulanceRateLimitEntry>> Rate limit tracking by event name and player source
---@field cooldowns table<string, table<number, number>> Action cooldown tracking by action name and player source
---@field config WasabiAmbulanceValidationConfig Validation configuration values
---@field init fun() Initialize module and calculate max health increase from config
---@field isRateLimited fun(source: number, eventName: string, silent: boolean | nil): boolean Check if player is rate limited for an event
---@field isOnCooldown fun(source: number, actionName: string): boolean Check if action is on cooldown
---@field isValidPlayer fun(source: number): boolean Validate player source exists and is connected
---@field isWithinRange fun(source: number, target: number, maxDistance: number): boolean Check if two players are within range
---@field isWithinRangeOfCoords fun(source: number, coords: vector3, maxDistance: number): boolean Check if player is within range of coordinates
---@field isValidLimbIndex fun(limbIndex: number): boolean Validate limb index (1-6)
---@field isValidInjuryType fun(injuryType: string): boolean Validate injury type string
---@field isValidHealthValue fun(health: number): boolean Validate health value is within bounds
---@field validateLimbsData fun(limbs: table): boolean, string? Validate complete limbs data structure
---@field hasPermission fun(source: number, requiredGroups: table|string): boolean Check if player has required group permissions
---@field isAdmin fun(source: number): boolean Check if player is an admin
---@field isValidItem fun(itemName: string, validItems: table<string, any>): boolean Validate item name exists in valid items table
---@field isInspecting fun(source: number, target: number, playersInspected: table<number, number>): boolean Check if source is currently inspecting target
---@field shouldBlockRequest fun(source: number, eventName: string, silent: boolean | nil): boolean Combined check for valid player and rate limiting
---@field isPlayerDead fun(source: number): boolean Check if player is in dead state
---@field isPlayerAlive fun(source: number): boolean Check if player is alive
---@field cleanup fun(source: number) Clean up tracking data for disconnected player
---@field validateLimbDelta fun(previousLimbs: table, currentLimbs: table, source: number): boolean, string? Validate limb data changes are within acceptable bounds

-------------------------------------------------
-- Equipment: Stretcher
-------------------------------------------------

---@class WasabiAmbulanceStretcherOffsetConfig
---@field pos { x: number, y: number, z: number } Position offset
---@field rot { x: number, y: number, z: number } Rotation offset

---@class WasabiAmbulanceStretcherConfig
---@field enabled boolean Enable stretcher feature
---@field model number Stretcher prop model hash
---@field stretcherKey number Control key for stretcher actions
---@field allowedJobs string[] Jobs that can use stretcher
---@field holdingOffset WasabiAmbulanceStretcherOffsetConfig Offset when holding
---@field ambulanceOffsets table<string, WasabiAmbulanceStretcherOffsetConfig> Per-vehicle offsets

---@class WasabiAmbulanceStretcherData
---@field id number Unique stretcher ID
---@field coords? vector3 Current world coordinates
---@field heading? number Entity heading
---@field distance? number Distance tracking
---@field netID? number Network ID of stretcher entity
---@field originalVehicleID? number Network ID of ambulance that spawned this stretcher
---@field moving number|false Server ID of player moving stretcher, or false
---@field occupied number|false Server ID of player on stretcher, or false
---@field inMenu? boolean|number Whether stretcher menu is open (or player ID)
---@field inVehicle number|false Vehicle network ID if inside ambulance, or false

---@class WasabiAmbulanceLocalStretcherData
---@field entity number Local stretcher entity handle
---@field stretcherID? number Associated stretcher ID

-------------------------------------------------
-- Module System Types
-------------------------------------------------

---@class WasabiAmbulanceModuleDefinition
---@field name string Module name identifier
---@field module table The module table itself
---@field dependencies string[] Required module dependencies
---@field optionalDependencies string[] Optional module dependencies
---@field init fun()? Initialization function
---@field initialized boolean Whether the module has been initialized
---@field loaded boolean Whether the module has been loaded

---@class WasabiAmbulanceModulesSystem
---@field modules table<string, WasabiAmbulanceModuleDefinition> Registered modules by name
---@field initializedModules table<string, boolean> Modules that have completed initialization
---@field register fun(name: string, module: table, opts?: { dependencies?: string[], optionalDependencies?: string[] }) Register a new module
---@field require fun(name: string): table Get a module (throws if not found)
---@field get fun(name: string): table? Get a module (returns nil if not found)
---@field isAllInitialized fun(): boolean Check if all modules are initialized
---@field awaitFullyReady fun(timeout?: number): boolean Wait for all modules to initialize

---@class WasabiAmbulanceStretcherStatebagData
---@field id? number Stretcher ID
---@field occupied? number|false Player occupying stretcher
---@field moving? number|false Player moving stretcher
---@field inVehicle? number|false Vehicle network ID
---@field originalVehicleID? number Original ambulance network ID

---@class WasabiAmbulanceAmbulanceStretcherState
---@field hasStretcher boolean Whether ambulance has stretcher
---@field stretcherID? number Stretcher ID
---@field stretcherNetID? number Stretcher network ID
---@field stretcherOccupied? boolean|number Whether stretcher is occupied

-------------------------------------------------
-- Export Definitions
-------------------------------------------------

exports.wasabi_ambulance = {}

-- Client Exports: Death & Medical

---`client` Check if a player is dead or in last stand
---@param serverId number? Optional server ID; uses local player if nil
---@return boolean isDead True if player is dead or in last stand
function exports.wasabi_ambulance:isPlayerDead(serverId) end

---`client` Open the injury inspection UI for a target ped
---@param targetPed number Ped entity to inspect
---@param skipCam? boolean Skip camera setup (default: false)
---@param viewOnly? boolean View-only mode without treatment options (default: false)
function exports.wasabi_ambulance:inspectInjuries(targetPed, skipCam, viewOnly) end

---`client` Close the injury inspection UI
function exports.wasabi_ambulance:stopInspectingInjuries() end

---`client` Open inspection UI for the closest player
function exports.wasabi_ambulance:diagnosePlayer() end

-- Client Exports: Stretcher

---`client` Toggle stretcher deployment from current vehicle
function exports.wasabi_ambulance:toggleStretcher() end

---`client` Delete stretcher from a specific vehicle
---@param vehicle number Vehicle entity handle
function exports.wasabi_ambulance:deleteStretcherFromVehicle(vehicle) end

---`client` Delete all stretchers and resync with server
function exports.wasabi_ambulance:deleteAllStretchers() end

---`client` Check if a player is using any stretcher (moving or on)
---@param targetID number Player ID
---@return boolean isUsing True if player is on or moving a stretcher
function exports.wasabi_ambulance:isPlayerUsingStretcher(targetID) end

---`client` Get the closest non-moving stretcher within range
---@param maxDistance number? Maximum search distance (default: 1000)
---@return WasabiAmbulanceStretcherData? stretcherData Closest stretcher data or nil
function exports.wasabi_ambulance:getClosestStretcher(maxDistance) end

---`client` Get data for stretcher currently being moved by local player
---@return WasabiAmbulanceStretcherData|false stretcherData Stretcher data or false
function exports.wasabi_ambulance:getEquippedStretcherData() end

-- Client Exports: Facilities

---`client` Get all registered facilities
---@return WasabiAmbulanceFacilityExportData[] facilities Array of facility data
function exports.wasabi_ambulance:getAllFacilities() end

-- Client Exports: Dispatch

---`client` Open the EMS dispatch menu
function exports.wasabi_ambulance:openDispatchMenu() end

---`client` Get number of locally cached distressed players
---@return number count Number of players in distress
function exports.wasabi_ambulance:getLocalDistressedCount() end

-- Server Exports: Medical

---`server` Revive a player by server ID
---@param serverId number Target player server ID
function exports.wasabi_ambulance:RevivePlayer(serverId) end

---`server` Heal specific/all injuries and optionally set specific/all limb health
---@param serverId number Target player server ID
---@param injuryType? string Injury type to heal; use `all`/nil for all injuries
---@param limb? string|number Limb name/index to heal; use `all`/nil for all limbs
---@param healAmount? number|boolean UI health amount to set from 1-100; false/nil/blank skips limb health
---@return boolean success True if applied
---@return string? error Error key/message when not applied
function exports.wasabi_ambulance:HealInjuries(serverId, injuryType, limb, healAmount) end

---`server` Fully heal a player by server ID without reviving them.
---Heals health, clears ambulance injuries, resets hunger/thirst, and clears stress when supported by the active framework bridge.
---@param serverId number Target player server ID
---@return boolean success True if the heal was dispatched
function exports.wasabi_ambulance:HealPlayer(serverId) end

---`server` Get total injury counts for a player across all limbs
---@param playerId number Server player ID
---@return WasabiAmbulanceInjuryTotals? totals Injury totals or nil if no data
function exports.wasabi_ambulance:getPlayerInjuryTotals(playerId) end

-- Server Exports: Facilities

---`server` Get bed data for a player currently checked into a facility
---@param playerId number Server player ID
---@return WasabiAmbulancePlayerBedData? bedData Bed data or nil if not in bed
function exports.wasabi_ambulance:getPlayerBed(playerId) end

-- Server Exports: Dispatch

---`server` Check if a player is currently in distress
---@param serverId number Server player ID
---@return boolean inDistress True if player has active distress call
function exports.wasabi_ambulance:isPlayerInDistress(serverId) end

---`server` Remove a player from the distress list
---@param serverId number Server player ID
function exports.wasabi_ambulance:removeFromDistress(serverId) end

---`server` Get count of players currently in distress
---@return number count Number of distressed players
function exports.wasabi_ambulance:getDistressedCount() end

---`server` Add a player to the distress list
---@param serverId number Server player ID
function exports.wasabi_ambulance:addToDistress(serverId) end
