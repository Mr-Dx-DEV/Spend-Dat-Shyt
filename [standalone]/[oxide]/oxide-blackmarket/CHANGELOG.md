# Changelog

All notable changes to oxide-blackmarket will be documented in this file.

## [1.4.2] - 2026-05-21

### Fixed
- **Dealer not interactable for players who weren't nearby when it spawned** - players who joined after the dealer relocated, or teleported in from across the map, often couldn't open the trade menu (target option didn't appear). The dealer is now identified consistently for every player regardless of when they came into range.
- **Dealer standing still after spawn** - the dealer would freeze in place until interacted with instead of wandering. They now begin wandering reliably as soon as someone is nearby.
- **One-shot kills not registering** - killing the dealer in a single fatal hit (sniper headshot, vehicle ram, explosive) sometimes didn't trigger death detection. No loot, no hit squad, body left on the ground. All death types are now detected reliably.
- **Hit squad never arriving** - the retaliation squad would spawn and just sit there, never reaching the player. They now drive to the player and engage as intended.
- **Hit squad spawning on top of the player** - some spawns placed the squad almost in your lap instead of out of sight. Spawn distance is now consistent regardless of where the dealer dies.
- **Hit squad teleporting members into the driver seat mid-firefight** - if you killed the driver while the squad was fighting on foot, another member would instantly warp into the car. They now stay on foot and only switch drivers if they actually need to drive somewhere.

### Added
- `Config.HitSquadMaxChaseDuration` - safety net that releases the hit squad if it spends too long driving without reaching the player (e.g. if AI pathing gets stuck). Defaults to 90 seconds.

### Changed
- Default `Config.HitSquadDriveSpeed` lowered from `80.0` to `30.0`. The value is m/s; the old default was effectively ~180 mph which caused the AI vehicle to constantly lose control and reroute. `30.0` is ~67 mph - a realistic chase speed.
- Default `Config.HitSquadSpawnDistMin` and `HitSquadSpawnDistMax` lowered (from `350-450` to `200-300`). Closer spawns reliably trigger AI chase behavior and arrive in a reasonable time.

## [1.4.1] - 2026-05-12

### Fixed
- **Dealer becoming invincible / unkillable / unarrestable** - the dealer ped used a huge entity culling radius (50,000) which forced every player on the server into the entity's scope at once. Under OneSync this thrashed ownership migration between players and could leave the dealer in a state where damage and arrest attempts had no effect. The dealer now uses the default culling radius with orphan-mode persistence, so ownership migrates cleanly between nearby players and the dealer remains damageable and arrestable as intended.
- Dealer initialization no longer reports success when the dealer ped fails to spawn - the failure is now surfaced so you can see it.

### Added
- **Structured logging via oxide-logger** - money movements, transactions, dealer spawns/kills/arrests, loot collection, reputation changes, admin commands, and security rejections (proximity exploits, invalid input, unauthorized arrest attempts) are now logged through the optional `oxide-logger` resource. Install `oxide-logger` to get a full audit trail in your console, file logs, or Discord webhooks. No effect if `oxide-logger` is not installed.
- **Dirty money metadata mode** - new `Config.DirtyMoney.useMetadata` option lets you store dirty money as the value of a metadata field (default `worth`) on the configured item rather than stack count. Useful for inventory systems that use marked-bills patterns. Bills are consumed greedily by highest value first, and any change is returned as a new bill.

### Changed
- Removed verbose `[oxide-blackmarket]` `print` lines from the arrest flow that were appearing in the console regardless of `Config.Debug`. All debug output is now gated by `Config.Debug` or the oxide-logger configuration.

## [1.4.0] - 2026-04-14

### Changed
- Optimized OneSync health sync loop in dealer death processing - reduced polling iterations from 20x100ms to 8x250ms while maintaining the same timeout window
- Converted framework/integration usage from `community_bridge` to `o-link`

## [1.3.0] - 2026-03-26

### Added
- `Config.EnableTiers` option to disable the reputation/tier system entirely - when set to `false`, all shop items are available to all players, reputation is not gained or lost, tier notifications are suppressed, pager works without tier requirements, and tier/rep display is hidden from the shop UI

## [1.2.2] - 2026-03-03

### Changed
- **Dirty money now supports inventory items** - new `Config.DirtyMoney` table replaces `Config.MoneyAccount`, allowing dirty money to be handled as either a framework account (`'account'` mode for ESX) or an inventory item (`'item'` mode for QBCore/QBX)
- Transactions now properly fail with user feedback when inventory is full in item mode (buying, selling, and loot collection)
- Selling items refunds the sold items back if dirty money can't be added to inventory

### Removed
- `Config.MoneyAccount` - replaced by `Config.DirtyMoney` table

## [1.2.1] - 2026-02-21

### Added
- **Configurable money account type** - new `Config.MoneyAccount` setting lets you choose which account type is used for all blackmarket transactions (buying, selling, loot drops)
  - ESX: set to `'black_money'` for native dirty money
  - QBCore/QBX: set to `'crypto'`, `'black_money'`, or whatever your server uses
  - Defaults to `'cash'` - existing behavior is unchanged out of the box
- Police arrest rewards always pay in regular cash regardless of `Config.MoneyAccount`

### Changed
- Shop UI label updated from "Cash" to "Balance" to reflect configurable account types
- "Not enough cash" notification updated to "Not enough funds"

## [1.2.0] - 2026-02-16

### Added
- **Multi-framework support** via [Community Bridge](https://community-bridge.com) - now works with QBCore, ESX, QBox, and more out of the box
- **Universal dispatch alerts** - compatible with 17+ dispatch systems (ps-dispatch, cd_dispatch, etc.) via configurable `Config.DispatchAlerts`
- **Universal phone support** - pager emails work with any phone system supported by Community Bridge
- **Universal target support** - works with qb-target, ox_target, and any target system supported by Community Bridge
- **Universal inventory support** - item images resolve automatically per inventory system, no manual path config needed
- **Universal progress bar support** - loot bag searching uses Bridge progress bar (compatible with ox_lib, qb, etc.)
- **Transaction rate-limiting** - prevents rapid-fire buy/sell exploit attempts
- **Server-side killer tracking** - dealer killer is now identified via `weaponDamageEvent` on the server, preventing client-side spoofing
- **Distance-based performance scaling** - dealer monitoring thread adjusts polling rate based on player distance (2s at 100m+ vs 100ms nearby)
- **Automatic area name resolution** - pager messages now resolve location names from GTA natives instead of a hardcoded list
- **Proper cleanup on disconnect** - all client state (hit squad, loot bags, NUI, blips) is fully cleaned up on character switch or disconnect
- **Pager cooldown cleanup** - server-side pager cooldowns are removed when players disconnect (prevents memory leaks)
- New dealer spawn locations (Cypress Flats, Davis, Little Seoul, Mirror Park, Banham Canyon, Sandy Shores, Grapeseed, Grand Senora Desert)

### Fixed
- Loot proximity check now validates distance **before** removing loot from storage, preventing edge case where loot is lost if player is too far
- Hit squad now targets the actual killer (server-tracked) instead of relying on client-side detection which could miss one-shot kills
- Reputation tier change events now properly fire to the blip system on every tier transition
- Admin commands (`/setblackmarketrep`, `/checkblackmarketrep`) now validate that the target player is online before executing
- ESC key detection loop no longer runs at full framerate when shop is closed
- Selling items now properly triggers tier-up notifications via `AddReputationWithNotify`

### Changed
- **Dependency changed from `qb-core` to `community_bridge`** - this is the only required dependency now
- Removed `@oxmysql/lib/MySQL.lua` dependency - handled by Community Bridge
- Removed `Config.TargetSystem`, `Config.InventorySystem`, `Config.InventoryImagePath`, `Config.PhoneSystem` settings - Community Bridge auto-detects these
- Removed hardcoded `Config.AreaNames` table - area names are now resolved dynamically from coordinates
- Removed `Config.PoliceDispatchEvent` and `Config.PoliceAlertChance` - replaced by `Config.DispatchAlerts` table with per-alert-type configuration
- Dispatch alerts (transaction + proximity) are now configurable with individual chance, message, code, icon, and blip settings
- Cuff sound effect replaced with native GTA sound (removed `InteractSound` dependency)
- Death report distance threshold increased from 50m to 200m to allow any nearby client to report (server validates independently)

## [1.1.0] - 2026-01-27

### Added
- Target system wrapper for unified interaction with qb-target and ox_target
- `Config.TargetSystem` setting to switch between targeting systems
- `Config.InventorySystem` setting to support both qb-inventory and qs-inventory
- `Config.InventoryImagePath` for configurable item image paths
- `Config.PoliceJobs` setting to configure which jobs can arrest dealers
- Unique loot ID generation for secure loot tracking

### Fixed
- Dealer death processing now prevents duplicate loot drops
- Item name validation in purchase and sell events

### Changed
- Dealer and loot bag interactions now use unified target system wrapper

## [1.0.1] - 2026-01-24

### Added
- LB Phone support for Tier 4 pager notifications
- `Config.PhoneSystem` setting to switch between 'qb-phone' and 'lb-phone'

### Fixed
- Police dispatch blip now properly removes after 60 seconds or when dealer despawns/dies

## [1.0.0] - Initial Release

### Features
- Dynamic black market dealer system with single dealer instance
- Reputation-based progression (5 tiers: Unknown, Street, Connected, Trusted, Inner Circle)
- Buy/sell shop with tier-locked inventory
- Police surrender/arrest mechanics
- Hit squad retaliation on dealer death
- Pager-based dealer discovery
- Server-side secured loot drops
- Proximity-based blip discovery
- Dealer relocation every 45 minutes
