# Troubleshooting

Common issues and current fixes for `oxide-blackmarket`.

## Dealer Not Spawning

Symptoms:

- no dealer exists in the world
- `/dealerstatus` reports no active dealer

Checks:

1. Verify load order:

```cfg
ensure ox_lib
ensure o-link
ensure oxide-blackmarket
```

2. Verify OneSync is enabled:

```cfg
set onesync on
```

3. Enable debug logging and watch for:

```text
[oxide-blackmarket] Resource starting...
[oxide-blackmarket] Initializing dealer...
[oxide-blackmarket] ERROR: Failed to create dealer ped
```

4. Use `/relocatedealer` after fixing config or dependency issues.

## Dealer Exists but Players Cannot See It

Checks:

1. Confirm the server logged the spawn (look for `dealerSpawned` in oxide-logger output, or `Spawned dealer at location N` in debug).
2. Confirm no other resource is interfering with culling or deleting the ped.
3. Re-stream the area by moving away and back.
4. Restart the resource after confirming OneSync is actually on.

The dealer is identified by a replicated entity state bag (`oxide-blackmarket:dealer`). Clients pick the dealer up the moment the entity streams into their scope, so out-of-scope-at-spawn players are handled correctly. If a player can see the ped but the target option doesn't appear, the state bag isn't replicating - check for resource conflicts that override entity state bags.

## Shop Will Not Open

Checks:

1. Confirm your `o-link` target integration is working elsewhere on the server.
2. Confirm the dealer has not been damaged, killed, arrested, or relocated mid-test.
3. Confirm the player is close enough to the dealer.
4. Check F8 for NUI errors and make sure `html/index.html`, `html/js/app.js`, and `html/css/style.css` are present.

## Purchases or Sales Fail

Checks:

1. Verify dirty-money setup:

- account mode requires a valid account in `Config.DirtyMoney.account`
- item mode requires a valid item in `Config.DirtyMoney.item`
- metadata mode (`useMetadata = true`) requires `Config.DirtyMoney.metadataKey` to match the metadata field your bill item actually uses. If displayed cash is `$0` despite bills in the inventory, the key is almost certainly wrong (common alternatives: `worth`, `value`, `amount`, `cash`). Inspect a bill item in the inventory and use the exact field name.

2. Verify the player has enough money or enough items.
3. Verify the inventory can accept purchased items or cash items in item mode.
4. Verify the item exists in your inventory resource and, for sales, in `Config.SellableItems`.
5. Verify the dealer still exists and the player remains within range.
6. In metadata mode, bills missing the configured `metadataKey` (or with non-numeric values) are treated as `$0` and ignored on payout. Older bills created before enabling this option may need to be regenerated.

## Wrong Items Show in the Shop

Checks:

1. Verify the player's current rep:

```text
/checkblackmarketrep [playerId]
```

2. Verify `Config.EnableTiers`.
3. Verify the item list in `shared/items.lua` matches the actual items installed on your server.
4. Remember that disabling tiers exposes all buy tiers to everyone.

## Pager Does Not Work

Checks:

1. Verify `blackmarket_pager` exists in your inventory item registry.
2. Verify the dealer is active.
3. Verify the player is Tier 2 or higher unless you changed the logic in code.
4. Verify the pager is not still on cooldown.

If the item exists but using it does nothing, your `o-link` framework adapter may not be registering usable items correctly.

## Tier 4 Pager Gives GPS but No Phone Message

This is usually an `olink.phone` issue, not a blackmarket issue.

Checks:

1. Confirm your `o-link` phone module is configured for the phone resource your server runs.
2. Confirm the player is actually Tier 4.
3. Check server logs for phone integration errors.

This path is wrapped in `pcall`, so even if phone delivery fails the waypoint and fallback GPS notification should still work.

## Police Cannot Surrender or Arrest the Dealer

Checks:

1. Verify the officer's job name is included in `Config.PoliceJobs`.
2. Verify the officer is aiming within `Config.AimSurrenderDistance`.
3. Verify the dealer has not already broken out or become hostile.
4. For arrests, verify the officer is close enough and the target is still the active dealer.

The server validates job, dealer net ID, dealer state, and proximity, so client-side prompts alone are not enough.

## Hit Squad Does Not Spawn

Checks:

1. Verify `Config.HitSquadEnabled = true`.
2. Verify the dealer death was valid and not rejected by server-side checks.
3. Verify the player reporting the death was actually close enough to the dealer.
4. Enable debug mode and look for dealer death processing logs.

The resource tries to target the last player tracked by `weaponDamageEvent`. If that data is missing, it falls back to the valid death reporter.

## Loot Bag Does Not Appear or Cannot Be Collected

Checks:

1. Verify `Config.LootDropEnabled = true`.
2. Verify the death was processed successfully on the server.
3. Verify the player is within 5 meters when collecting.
4. Verify another player did not collect it first.

Loot contents are stored server-side, so a visible bag with no reward usually means collection failed validation or the loot was already consumed.

## Banking Deposits Do Not Happen

Officer arrest cash uses `olink.money`, but department deposits use `olink.banking`.

Checks:

1. Confirm your `o-link` banking module supports `AddAccountMoney`.
2. Confirm the target account name exists for your police department.
3. Check server logs for the warning about failed police society deposits.

The arrest still completes even if department deposit fails.

## High Log Volume or Performance Concerns

Checks:

1. Turn off debug mode in production:

```lua
Config.Debug = false
```

2. Reduce `Config.BlipDetectionRange` if discovery checks feel noisy.
3. Increase `Config.FleeCheckInterval` or `Config.HitSquadCheckInterval` if you want less frequent AI checks.
4. Review large custom `Config.Locations` sets for bad pathing spots that create AI churn.

## Debug Logging

Debug prefix:

```text
[oxide-blackmarket]
```

Useful areas covered by debug logs:

- resource startup
- dealer spawn and despawn
- pager use and result flow
- shop requests and transactions
- stock changes
- rep changes
- loot generation and collection
- dealer death handling

## Next Steps

- `INSTALLATION.md`
- `CONFIGURATION.md`
- `FEATURES.md`
