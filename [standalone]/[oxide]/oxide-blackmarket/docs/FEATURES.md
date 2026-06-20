# Feature Guide

Overview of the current `oxide-blackmarket` gameplay flow and systems.

## Dealer Lifecycle

One dealer exists at a time. The server creates the ped, tracks the active net ID, and syncs it to all players through OneSync.

### Spawn and relocation

- The dealer spawns at a random entry from `Config.Locations`
- Relocation runs on `Config.RelocationInterval`
- Relocation despawns the current ped, waits for cleanup, then spawns a fresh dealer with reset stock
- Players pick up the dealer automatically via the `oxide-blackmarket:dealer` entity state bag the moment the ped streams into their scope — no per-player sync needed

### Wandering and trade state

- The dealer wanders when idle
- Opening the shop pauses wandering and faces the player
- If the dealer is damaged or breaks out of surrender, normal trading stops until the next spawn

## Reputation and Tiers

Reputation is stored in the player's `blackmarket_rep` metadata through `olink.character`.

### Tier thresholds

| Tier | Name | Rep |
|---|---|---|
| `0` | Unknown | `0` |
| `1` | Street | `100` |
| `2` | Connected | `300` |
| `3` | Trusted | `600` |
| `4` | Inner Circle | `1000` |

### Rep gain and loss

- Selling items listed in `Config.SellableItems` grants cash and rep
- Killing the dealer removes `Config.KillPenalty` rep
- Tier changes trigger client notifications and blip refresh through `TierChanged`, `TierUp`, and `TierDown`

### Tier toggle

If `Config.EnableTiers = false`:

- all buy tiers are exposed to all players
- rep gain and rep loss are skipped
- tier notifications are not shown
- `GetTierFromRep` effectively returns Tier 4 access

## Shop and Dirty Money

The shop is a buy/sell UI backed by server validation.

### Buy flow

- The player must be near the dealer
- The server builds the buy list from all tiers up to the player's current tier
- Dealer stock is shared globally and decreases on purchase
- Stock fully resets when the dealer respawns

### Sell flow

- Only items in `Config.SellableItems` are accepted
- The sell list is generated from the player's current inventory via `olink.inventory`
- Selling pays out through the dirty-money helpers and can award rep

### Dirty money modes

`Config.DirtyMoney` controls how all shop and loot cash is handled:

- `mode = 'account'`: money comes from `olink.money` using `Config.DirtyMoney.account`
- `mode = 'item'`: money comes from an inventory item using `Config.DirtyMoney.item`
  - default: each item in the stack counts as one currency unit
  - `useMetadata = true`: each item's value is read from `metadata[metadataKey]` (e.g. marked bills where one item stores `worth = 5000`). Removing money consumes bills greedily and returns any overage as a new bill.

This affects:

- purchases
- sales
- loot-bag cash rewards

## Police Pressure

Police detection is based on the current job name matching `Config.PoliceJobs`.

### Surrender and arrest

- A police player aiming at the dealer within `Config.AimSurrenderDistance` can force surrender
- While surrendered, officers can move in and arrest
- The arrest event is server-validated for police job, matching dealer net ID, live dealer state, and proximity

### Arrest rewards

- Officer cash is paid through `olink.money`
- Department cut is attempted through `olink.banking`
- Arrested dealers respawn after `Config.ArrestRespawnDelay`

### Flee and breakout

- If police back away beyond `Config.FleeDistanceThreshold`, the dealer rolls `Config.FleeChance` on the configured interval
- If arrest is not completed in time, the dealer can break out, rearm, and become hostile

### Dispatch alerts

`Config.DispatchAlerts` defines two alert paths:

- `transaction`: possible alert when a player buys or sells
- `proximity`: possible alert when police get near the dealer

The resource uses `o-link` dispatch integration rather than talking to dispatch resources directly.

## Dealer Death and Hit Squad

Dealer death is handled server-side with anti-abuse checks.

### Death validation

- The client that owns the ped at the moment of death detects it (`IsEntityDead` / `GetEntityHealth <= 0`) and reports to the server
- The reporting player must be within 200 meters of the death location
- The server dedupes simultaneous reports via a `ProcessingDeath` flag
- The likely killer is identified server-side via `weaponDamageEvent`; falls back to the reporter when weapon damage wasn't tracked (vehicle, fire, melee)

### Kill consequences

- The killer loses rep if tiers are enabled
- Nearby players above `Config.DeathNotifyMinTier` can receive the death notification if they are within `Config.DeathNotifyRadius`
- The dealer respawns after `Config.DeathRespawnDelay`

### Hit squad

The hit squad targets the confirmed killer when possible, otherwise the valid death reporter.

- Four NPCs spawn in a sedan
- Weapons and combat ability come from the selected difficulty preset
- Spawn distance is controlled by `Config.HitSquadSpawnDistMin` and `Config.HitSquadSpawnDistMax`. The spawner picks a random angle, projects to the configured distance, snaps to the nearest road node, and validates the drive-path detour ratio so the squad spawns somewhere it can actually reach the player from
- Chase/combat refresh is controlled by `Config.HitSquadTaskRefreshInterval`
- The player escapes by exceeding `Config.HitSquadEscapeDistance`
- The squad is also released after `Config.HitSquadMaxChaseDuration` ms in vehicle mode without engaging on foot (safety net for bad pathing)

## Loot Bags

Dealer death can create a loot bag at the death location.

### Loot generation

- Cash range comes from `Config.LootCashMin` and `Config.LootCashMax`
- Items are pulled from remaining dealer stock
- Up to `Config.LootMaxItems` item types are selected
- Each selected item drops `ceil(stock * Config.LootStockPercent)`

### Security model

- Loot contents are stored server-side in `ActiveLootDrops`
- The client only receives the spawn coordinates and loot ID
- Collection requires a valid loot ID and a 5 meter proximity check
- Loot is first-come-first-served

## Discovery Tools

### Flash blips

Players near the dealer can receive a temporary blip.

- Detection range uses `Config.BlipDetectionRange`
- Duration scales by tier using `Config.BlipDuration`
- Repeat flashes are rate-limited by `Config.BlipCooldown`

### Pager

The `blackmarket_pager` item asks contacts for dealer intel.

Requirements:

- the player has the item
- the dealer is active
- the player is Tier 2 or above
- pager cooldown has expired

Success rates:

| Tier | Success |
|---|---|
| `2` | `40%` |
| `3` | `70%` |
| `4` | `100%` |

Behavior:

- Tier 2 and 3 receive area intel based on the dealer's spawn location
- Tier 4 receives exact GPS intel, a waypoint, and a phone/email message through `olink.phone` when available
- If phone delivery fails at Tier 4, the waypoint and fallback GPS message still work

## Next Steps

- `INSTALLATION.md`
- `CONFIGURATION.md`
- `ADMIN.md`
- `EXPORTS.md`
